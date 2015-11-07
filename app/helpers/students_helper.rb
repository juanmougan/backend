module StudentsHelper
  def get_career_data_nil_safe(career)
    "#{career.code} - #{career.name}" unless career.nil?
  end

  def retrieve_regid_status(regid)
    if regid.to_s == ''
      "NO"
    else
    "YES"
    end
  end
end
