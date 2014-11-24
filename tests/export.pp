#On all backend nodes we export some variable such as ip and port. 
#I use defined resource from catalog/manifests/init.pp, but you can define your resources with your list of variable
#Also I use tag for split platform that managed with one puppet server.
class backend {
	@@catalog::host { "backends": host => "$fqdn", protocol => "https", port => "8080", url => '/oneapi'tag => "$environment"}
}
