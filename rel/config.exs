use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"b2*S(%S:NADu>~2l[AwMEAN0Lt1AH_c42=H/_.x6G.SHUus$JLo$p6B3`t];P*N|"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"lL5<[xHYr1HFP0wc]2WKQb&<sx$tLVp}07`(zG@[a/U;hx_ZunJ(`RJL9=y6Q|sn"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :emperor do
  set version: current_version(:emperor)
end
