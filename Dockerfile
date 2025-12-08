FROM docker.n8n.io/n8nio/n8n:latest

USER root

# 1. Install System Tools, Build Dependencies & Python
# Added 'py3-pillow' to the end of the list:
# This installs the pre-compiled image library so Python doesn't fail building it.
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
    python3 \
    py3-pip \
    py3-pillow \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-spa

# 2. Install NPM packages globally
# This keeps your Javascript tools available
RUN npm install -g pdf-lib pdf-img-convert pdf-parse tesseract.js

# 3. Install the Python Libraries
# We use --break-system-packages to allow installing globally
RUN pip3 install markitdown --break-system-packages

# Switch back to node user
USER node
