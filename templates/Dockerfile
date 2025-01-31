# Start from the official Odoo 18 image
FROM odoo:18

# Copy the Enterprise .deb package into the image
COPY ./enterprise/odoo_18.0+e.latest_all.deb /tmp/enterprise.deb

# Install Enterprise and Python dependencies as root
USER root

# Install system packages and Enterprise DEB
RUN apt-get update && \
    apt-get install -y --allow-downgrades --no-install-recommends \
        /tmp/enterprise.deb \
        python3-pip \
        python3-venv \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/* /tmp/enterprise.deb

# Install Python packages system-wide (safer in Docker than on host)
RUN pip3 install --no-cache-dir --break-system-packages google-auth pyjwt

# Ensure Odoo uses the virtual environment
ENV PATH="/opt/odoo-venv/bin:$PATH"

# Copy entrypoint script and set permissions in one step
COPY --chown=odoo:odoo --chmod=0755 ./entrypoint.sh /entrypoint.sh

# Switch back to the unprivileged 'odoo' user
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]