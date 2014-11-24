$: << File.expand_path(File.join(File.dirname(__FILE__), '.'))
module Puppet::Parser::Functions

        newfunction(:catalogfield,
        :type => :rvalue) do |args|

                field   = args[0]
                type    = args[1]
                title   = args[2]
                tag     = args[3]
                Puppet::Parser::Functions.autoloader.loadall
                v = function_catalog([type, title, tag])
                if (v.is_a?(Array)) then
                        ret = []
                        v.each{|i|
                                ret.push(i[field])
                        }
                        return ret.sort_by {|i| i.to_s}
                else
                        return v[field].sort_by{|i| i.to_s}
                end
        end
end

