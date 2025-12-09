FROM n8nio/runners

USER root

# 1. Install System Tools, Build Dependencies & Package Managers
# Added 'nodejs' and 'npm' explicitly so we can install global packages.
# Added 'python3' and 'py3-pip' to ensure pip is available for step 3.
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
    tesseract-ocr-data-spa \
    nodejs \
    npm \
    python3 \
    py3-pip

# 2. Install NPM packages globally
RUN npm install -g pdf-lib pdf-img-convert pdf-parse tesseract.js

# 3. Install the Python Libraries
# using pip3 to match the apk installed python
RUN pip3 install markitdown --break-system-packages

# Switch back to node user
USER node
