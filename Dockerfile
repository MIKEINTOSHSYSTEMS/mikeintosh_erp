# Use the official Odoo 17 image as base
FROM odoo:17

# Set the Odoo addons directory as a volume
VOLUME ["/mnt/extra-addons"]

# Copy custom configuration file
COPY ./etc/odoo.conf /etc/odoo/odoo.conf

# Install additional Python packages
#RUN pip3 install --no-cache-dir <your-package-list>

# Set permissions for Odoo configuration file
RUN chown odoo:odoo /etc/odoo/odoo.conf && chmod 777 /etc/odoo/odoo.conf

# Expose Odoo service
EXPOSE 8069

# Set the user to run Odoo
USER odoo

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
