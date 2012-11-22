module PartiesHelper
  def get_host_options
    Host.all.map{|p| ["#{p.first_name} #{p.last_name}", p.id] }
  end
end
