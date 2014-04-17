node.rbenv.build.each do |version|
  execute "ruby install" do
    not_if "source #{node.rbenv.profile_path}/rbenv.sh; rbenv versions | grep #{version}"
    command "source #{node.rbenv.profile_path}/rbenv.sh; rbenv install #{version}"
    action :run
  end
end

#globalの切り替え
execute "ruby change" do
  command "source #{node.rbenv.profile_path}/rbenv.sh; rbenv global #{node.rbenv.global};rbenv rehash"
  action :run
end

