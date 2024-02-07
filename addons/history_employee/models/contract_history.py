# -- coding: utf-8 --
###################################################################################
#    A part of Open HRMS Project <https://www.openhrms.com>
#
#    Cybrosys Technologies Pvt. Ltd.
#    Copyright (C) 2023-TODAY Cybrosys Technologies (<https://www.cybrosys.com>).
#    Author: Cybrosys (<https://www.cybrosys.com>)
#
#    This program is free software: you can modify
#    it under the terms of the GNU Affero General Public License (AGPL) as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
###################################################################################
from odoo import fields, models


class ContractHistory(models.Model):
    """Model for tracking contract history information.
    This model is used to store historical contract details, including employee information, the date of the update,
    the changed field, and the current contract value."""
    _name = 'contract.history'
    _description = 'Contract History'
    _rec_name = 'employee_name'

    employee = fields.Char(string='Employee ID',
                           help="ID of the employee associated with the "
                                "contract history record.")
    employee_name = fields.Char(string='Employee Name',
                                help="Name of the employee whose contract "
                                     "history is being updated.")
    updated_date = fields.Date(string='Updated On',
                               help="Date when the contract details was "
                                    "last updated.")
    changed_field = fields.Char(string='Changed Field',
                                help="The updated field  of the contract.")
    current_value = fields.Char(string='Current Value',
                                help="Updated value of the contract.")
