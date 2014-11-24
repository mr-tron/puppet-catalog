class frontend {
	#get list all exported variables as list of hashes
	$backend_urls = catalog("catalog::host", "backends","$environment")
	
	#and use them in template.erb
	file {'/etc/frontend/config.cfg':
		content => template('config.cfg.erb')
	}

	#or we can import only one field 
	$allow_hosts = catalogfield("hosts","catalog::host", "backends","$environment")
	$allow_hosts.each |i| {
		::iptables {"allow$i": source => $i, policy => "allow"}
	}
}
