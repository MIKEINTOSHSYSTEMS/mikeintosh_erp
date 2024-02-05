# Use the official Odoo 17 image as base
FROM odoo:17

# Set the Odoo addons directory as a volume
VOLUME ["/mnt/extra-addons"]

# Copy custom configuration file
COPY ./etc/odoo.conf /etc/odoo/odoo.conf

# Install additional Python packages
COPY ./etc/requirements.txt /etc/odoo/requirements.txt
RUN pip3 install --no-cache-dir -r /etc/odoo/requirements.txt \
    && pip3 install --upgrade pdfminer-six

# Set permissions for Odoo configuration file
USER root
RUN chown odoo:odoo /etc/odoo/odoo.conf && chmod 640 /etc/odoo/odoo.conf

# Create a temporary directory and copy entrypoint script
RUN mkdir -p /docker-entrypoint-init
COPY entrypoint.sh /docker-entrypoint-init/entrypoint.sh

# Set execute permission for entrypoint script
RUN chmod +x /docker-entrypoint-init/entrypoint.sh

# Switch back to the odoo user
USER odoo

# Expose Odoo service ports
EXPOSE 8069 8079

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint-init/entrypoint.sh"]
