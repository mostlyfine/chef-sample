execute "ndenv init" do
  user node.ndenv.user
  group "ndenv"
  command "source #{node.ndenv.profile_path}/ndenv.sh; ndenv rehash"
  action :run
end

node.ndenv.build.each do |version|
  execute "node install #{version}" do
    not_if "source #{node.ndenv.profile_path}/ndenv.sh; ndenv versions | grep #{version}"
    command "source #{node.ndenv.profile_path}/ndenv.sh; ndenv install #{version}"
    user node.ndenv.user
    group "ndenv"
    action :run
  end
end

execute "global node change" do
  user node.ndenv.user
  group "ndenv"
  command "source #{node.ndenv.profile_path}/ndenv.sh; ndenv global #{node.ndenv.global};ndenv rehash"
  action :run
end

