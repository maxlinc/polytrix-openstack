include_recipe 'drg::system'
include_recipe 'drg::admins'
include_recipe 'python'
include_recipe 'drg::ruby'
include_recipe 'drg::golang'
include_recipe "nodejs::install_from_package"
include_recipe 'drg::php'
include_recipe 'drg::java'
include_recipe 'drg::dotnet'