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


class DepartmentHistory(models.Model):
    """Model for tracking the historical changes in an employee's department or job position."""
    _name = 'department.history'
    _description = 'Department History'
    _rec_name = 'employee_name'

    employee = fields.Char(string='Employee ID',
                           help="ID of the associated Employee")
    employee_name = fields.Char(string='Employee Name',
                                help="Name of the employee whose department "
                                     "or job position has changed.")
    changed_field = fields.Char(string='Job position/Department',
                                help="Indicates the department or job position "
                                     "that was changed in the employee's "
                                     "record.")
    updated_date = fields.Date(string='Date',
                               help="Date on which department or job "
                                    "position changed")
    current_value = fields.Char(string='Designation',
                                help="Updated Designation")
