execute "rbenv init" do
  user node.rbenv.user
  group "rbenv"
  command "source #{node.rbenv.profile_path}/rbenv.sh; rbenv rehash"
  action :run
end

node.rbenv.build.each do |version|
  execute "ruby install #{version}" do
    user node.rbenv.user
    group "rbenv"
    command "source #{node.rbenv.profile_path}/rbenv.sh; rbenv install #{version}"
    not_if "source #{node.rbenv.profile_path}/rbenv.sh; rbenv versions | grep #{version}"
    action :run
  end
end

execute "global ruby change" do
  user node.rbenv.user
  group "rbenv"
  command "source #{node.rbenv.profile_path}/rbenv.sh; rbenv global #{node.rbenv.global};rbenv rehash"
  action :run
end

