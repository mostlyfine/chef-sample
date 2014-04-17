execute "ruby install" do
  not_if "source /etc/profile.d/rbenv.sh; rbenv versions | grep #{node.rbenv.build}"
  command "source /etc/profile.d/rbenv.sh; rbenv install #{node.rbenv.build}"
  action :run
end

#globalの切り替え
execute "ruby change" do
  command "source /etc/profile.d/rbenv.sh; rbenv global #{node.rbenv.build};rbenv rehash"
  action :run
end

