# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.

from odoo import fields, models, api


class CustodyConfig(models.TransientModel):
    _inherit = ['res.config.settings']

    # notice_period = fields.Boolean(string='Notice Period')
    # no_of_days = fields.Integer()
    stock_operation_type = fields.Many2one('stock.picking.type', config_parameter="stock_operation_type")
    it_operation_type = fields.Many2one('stock.picking.type', config_parameter="it_operation_type")
    stock_source_location = fields.Many2one('stock.location', config_parameter="stock_source_location")
    it_source_location = fields.Many2one('stock.location', config_parameter="it_source_location")
    destination_location = fields.Many2one('stock.location', config_parameter="destination_location")
    portal_allow_api_keys = fields.Char()

