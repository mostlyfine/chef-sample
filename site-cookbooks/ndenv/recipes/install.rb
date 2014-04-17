node.ndenv.build.each do |version|
  execute "node install" do
    not_if "source #{node.ndenv.profile_path}/ndenv.sh; ndenv versions | grep #{version}"
    command "source #{node.ndenv.profile_path}/ndenv.sh; ndenv install #{version}"
    action :run
  end
end

#globalの切り替え
execute "node change" do
  command "source #{node.ndenv.profile_path}/ndenv.sh; ndenv global #{node.ndenv.global};ndenv rehash"
  action :run
end

