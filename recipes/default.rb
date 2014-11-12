#
# Cookbook Name:: bashprompt
# Recipe:: default
# Description:: add customer specific attributes to default prompt for root 
#

bashprompt = '/tmp/bashprompt.mod'
template bashprompt do
  source 'bashprompt.mod.erb'
  user 'root'
  mode '640'
  variables({
    :bashprompt_customer => node[:bashprompt][:customer]
    })
end

bash 'add to bashrc' do
  user 'root'
  code <<-EOF
    cat /tmp/bashprompt.mod >> /root/.bashrc
    rm /tmp/bashprompt.mod
  EOF
    #not_if 'grep -q bashprompt /root/.bashrc'
    not_if "grep -q '033.*0;0m' /root/.bashrc"
end
