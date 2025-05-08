# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.5
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
  BUNDLE_DEPLOYMENT="1" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base as build

RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y build-essential git libvips pkg-config

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
  rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
  bundle exec bootsnap precompile --gemfile

COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets using a dummy key to avoid missing credentials
ENV SECRET_KEY_BASE=DUMMY_KEY_BASE
RUN ./bin/rails assets:precompile

# Final stage for app image
FROM base

RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built assets and gems
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Create and use non-root user
RUN useradd rails --create-home --shell /bin/bash && \
  chown -R rails:rails db log storage tmp
USER rails:rails

# Set required ENV variables
ENV SECRET_KEY_BASE=DUMMY_KEY_BASE \
  RAILS_LOG_TO_STDOUT=true

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
