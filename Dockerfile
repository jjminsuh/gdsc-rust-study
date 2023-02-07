# Builder stage
FROM rust:1.67.0 AS builder

WORKDIR /app
RUN apt update && apt install lld clang -y
COPY . .
ENV SQLX_OFFLINE true
RUN cargo build --release

# Runtime stage
FROM rust:1.67.0 AS Runtime

WORKDIR /app
COPY --from=builder /app/target/release/gsdc_rust_study gsdc_rust_study
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT [ "./gsdc_rust_study" ]