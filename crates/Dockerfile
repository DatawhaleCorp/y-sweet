FROM rust:1.83-slim-bookworm AS builder

WORKDIR /build

# 安装 OpenSSL 开发包和 pkg-config 工具
RUN apt-get update && \
    apt-get install -y pkg-config libssl-dev

COPY . .
RUN cargo build --release

FROM debian:bookworm-slim

# 设置环境变量
ARG ALI_ACCESS_KEY
ARG ALI_SECRET_KEY

ENV ALIYUN_ACCESS_KEY_ID=$ALI_ACCESS_KEY \
    ALIYUN_SECRET_ACCESS_KEY=$ALI_SECRET_KEY \
    ALIYUN_REGION="cn-hangzhou" \
    ALIYUN_ENDPOINT_URL_OSS="https://oss-cn-hangzhou.aliyuncs.com" \
    ALIYUN_OSS_USE_PATH_STYLE="false"

COPY --from=builder /build/target/release/y-sweet /usr/local/bin/y-sweet

# 使用测试用途的 OSS
# docker 内一定要设置 host 为 0.0.0.0，这样宿主机才能通过访问到
CMD ["y-sweet", "serve", "https://test-datawhale.oss-cn-hangzhou.aliyuncs.com/", "--host", "0.0.0.0"]
