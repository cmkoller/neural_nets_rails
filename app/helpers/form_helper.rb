# Instructions from SitePoint tutorial:
# http://www.sitepoint.com/complex-rails-forms-with-nested-attributes/

module FormHelper
  def setup_preset_input(preset_input)
    preset_input.desired_output ||= DesiredOutput.new
    preset_input
  end
end
