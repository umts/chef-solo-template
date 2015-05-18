name 'test'
description 'installs the base role and its test harness'
run_list 'role[base]'

override_attributes(
  authorization: {
    sudo: {
      users: ['vagrant'],
      passwordless: 'true'
    }
  }
)
