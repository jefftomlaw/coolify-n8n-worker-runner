# Dockerfile.js

# 1. Use n8nio/runners as base
FROM n8nio/runners:beta

# 2. Switch to root to install dependencies [1]
USER root

# 3. Install JavaScript Packages [1], [2]
# We cd into the JS runner directory so pnpm updates the correct package.json
RUN cd /opt/runners/task-runner-javascript \
    && pnpm add \
    pdf-lib \
    pdf-img-convert \
    pdf-parse

# 4. Fix Permissions [2]
RUN chown -R runner:runner /opt/runners

# 5. Switch back to restricted user [3]
USER runner
