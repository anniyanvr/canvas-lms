#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

module Canvas::Plugins::Validators::BigBlueButtonValidator
  def self.validate(settings, plugin_setting)
    if settings.map(&:last).all?(&:blank?)
      {}
    else
      expected_settings = [:domain, :secret, :recording_enabled, :force_publish, :force_recording]
      if settings.size != expected_settings.size || settings.map(&:last).any?(&:blank?)
        plugin_setting.errors.add(:base, I18n.t('canvas.plugins.errors.all_fields_required', 'All fields are required'))
        false
      else
        settings.slice!(*expected_settings)
        settings[:recording_enabled] = Canvas::Plugin.value_to_boolean(settings[:recording_enabled])
        settings[:force_publish] = Canvas::Plugin.value_to_boolean(settings[:force_publish])
        settings[:force_recording] = Canvas::Plugin.value_to_boolean(settings[:force_recording])
        settings
      end
    end
  end
end
