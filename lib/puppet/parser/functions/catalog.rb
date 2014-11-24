$: << File.expand_path(File.join(File.dirname(__FILE__), '.'))
require 'httparty'
module Puppet::Parser::Functions
	newfunction(:catalog, :type => :rvalue) do |args|
		type    = args[0]
		title   = args[1]
		tag     = args[2]

		api_version = "v3"
		server_address = Puppet::Util::Puppetdb.server	
#		need add ssl support
#		server_port = Puppet::Util::Puppetdb.port		
		if (args.length > 1)
			resources = []
			query = '["and", ["=", "exported", "true"], ["=", "type", "%s"]' % type
			if (!title.nil?)
				query = query + ',["=", "title", "%s"]' % title
			end
			if (!tag.nil?)
				query = query + ',["=", "tag", "%s"]' % tag
			end
			query = query + ']'
			uri = 'http://' + server_address + ':8080/' + api_version + '/resources/'
			response = HTTParty.get(uri, :query => {:query => query })
			if (response.success?)
				response.each do | resource |
					parameters = resource["parameters"]
						if (parameters.has_key?("tag"))
							parameters.delete("tag")
						end
					resources = resources + [parameters]
				end
			else
				raise response.response
			end
			return resources
		else 
			raise Puppet::ParseError, ("globalarray_get(): wrong number of arguments (#{args.length}; must be 1 )")
		end
	end
end

