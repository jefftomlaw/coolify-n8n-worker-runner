# 1. Use 'next' to match your Beta Worker (v2.0 Protocol)
FROM n8nio/runners:stable

USER root

# 2. Install System Dependencies
# - tesseract-ocr: Required for OCR
# - poppler-utils: Required for pdf2image
# - build-base/python3-dev: Required if any pip packages need compiling
RUN apk add --no-cache \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    poppler-utils \
    jpeg-dev \
    zlib-dev \
    build-base \
    python3-dev

# 3. Install JavaScript Packages (Nodes)
# We cd into the JS runner directory so pnpm updates the correct package.json
RUN cd /opt/runners/task-runner-javascript \
    && pnpm add \
       pdf-lib \
       pdf-img-convert \
       pdf-parse

# 4. Install Python Libraries (Code Node)
# We cd into the Python runner directory so 'uv' updates the correct venv
RUN cd /opt/runners/task-runner-python \
    && uv pip install \
       pytesseract \
       pdf2image \
       Pillow

# 5. Fix Permissions
# Crucial because we installed everything as root
RUN chown -R runner:runner /opt/runners

# 6. Switch back to restricted user
USER runner
