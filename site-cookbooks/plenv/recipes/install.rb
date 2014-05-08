node.plenv.build.each do |version|
  execute "perl install" do
    not_if "source #{node.plenv.profile_path}/plenv.sh; plenv versions | grep #{version}"
    command "sudo -u #{node.plenv.user} source #{node.plenv.profile_path}/plenv.sh; plenv install #{version}"
    action :run
  end
end

#globalの切り替え
execute "perl change" do
  command "source #{node.plenv.profile_path}/plenv.sh; plenv global #{node.plenv.global};plenv rehash"
  action :run
end

execute "install cpanm" do
  command "sudo -u #{node.plenv.user} source #{node.plenv.profile_path}/plenv.sh; plenv install-cpanm"
  action :run
end
