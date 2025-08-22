# Use the latest Alpine image
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    go \
    nodejs \
    npm \
    libwebp-dev \
    build-base

# Set Go environment variables
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Clone the Pixlet repository
RUN git clone https://github.com/tidbyt/pixlet.git /pixlet

# Set the working directory
WORKDIR /pixlet

# Build the frontend
RUN npm install && npm run build

# Build the Pixlet binary
RUN make build

# Install Pixlet binary to /usr/local/bin
RUN install -m 755 pixlet /usr/local/bin/pixlet

# Set the working directory for app development
WORKDIR /app

COPY layoffs.star .

CMD ["sh", "-c", "pixlet render /app/layoffs.star && pixlet push $TIDBYT_DEVICE_ID /app/layoffs.webp --api-token $TIDBYT_API_TOKEN"]


