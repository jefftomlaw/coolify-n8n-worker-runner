# 1. Use the 'next' tag to match your Beta Worker
FROM n8nio/runners:next

USER root

# 2. Install System Dependencies (Runtime)
# We strictly separate build-deps (deleted later) from runtime-deps (kept)
RUN apk add --no-cache \
    python3 \
    py3-pip \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    poppler-utils \
    cairo \
    pango \
    libjpeg-turbo \
    libpng \
    giflib \
    zlib

# 3. Install Build Dependencies (Compilers)
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    gcc \
    python3-dev \
    jpeg-dev \
    zlib-dev \
    cairo-dev \
    pango-dev \
    giflib-dev

# 4. Install Python Libraries (Global Install)
# We use --break-system-packages to ensure they are available to the system python
RUN pip3 install --no-cache-dir --break-system-packages \
    pytesseract \
    pdf2image \
    Pillow \
    markitdown

# 5. Clean up Build Deps to keep image small
RUN apk del .build-deps

# 6. Setup Runner User Permissions
RUN chown -R runner:runner /opt/runners

# 7. Switch User
USER runner
