execute "plenv init" do
  user node.plenv.user
  group "plenv"
  command "source #{node.plenv.profile_path}/plenv.sh; plenv rehash"
  action :run
end

node.plenv.build.each do |version|
  execute "perl install #{version}" do
    user node.plenv.user
    group "plenv"
    command "source #{node.plenv.profile_path}/plenv.sh;plenv install #{version}"
    not_if "source #{node.plenv.profile_path}/plenv.sh; plenv versions | grep #{version}"
    action :run
  end
end

execute "global perl change" do
  user node.plenv.user
  group "plenv"
  command "source #{node.plenv.profile_path}/plenv.sh; plenv global #{node.plenv.global}; plenv rehash"
  action :run
end

execute "cpanm install" do
  user node.plenv.user
  group "plenv"
  command "source #{node.plenv.profile_path}/plenv.sh; plenv install-cpanm; plenv rehash"
  action :run
end
