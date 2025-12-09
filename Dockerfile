# Change the base image to the Task Runner
FROM n8nio/n8n-task-runners:beta

USER root

# 1. Install System Tools & Build Dependencies
# Removed 'python3', 'py3-pip' as the runner image provides these.
# Kept 'py3-pillow' as it often relies on system-level jpeg/zlib libraries.
RUN apk add --no-cache \
    curl \
    poppler-utils \
    graphicsmagick \
    build-base \
    g++ \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    giflib-dev \
    py3-pillow \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-spa

# 2. Install NPM packages globally
# The runner handles Node execution, so these must be installed here.
RUN npm install -g pdf-lib pdf-img-convert pdf-parse tesseract.js

# 3. Install Python Libraries
# Use the pip provided by the runner environment
RUN pip install markitdown --break-system-packages

# Switch back to the limited user
USER node
