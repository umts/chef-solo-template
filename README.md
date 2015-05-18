A skeleton repository for a chef-solo based project.

Directory Structure
===================
`.chef`
-------
Contains Knife configuration. In particular, the default copyright,
email, and license for generated cookbooks.

`config`
--------
Contains configuration options for Chef Solo, and a `node.yml` file.

The `node.yml` file is used in creating the JSON file that chef-solo uses
for configuration.  The `default\_role` attribute will be used as the
runlist for chef-solo in the event that you don't specify one when you
invoke the rake task (see below).  Any other fields specified in this
file will be used as override attributes in the Chef run.

`cookbooks`
-----------
Contains the cookbooks you've authored for this application.  Generate a
new one:

```
$ knife cookbook generate <cookbook-name> -o cookbooks
```

Afterwards, it's probably safe to delete the `example` cookbook.

`roles`
-------
Contains Chef roles that you can use in your Chef run.
The `base` role is provided as an example; the `test` role is used by
test-kitchen.

`spec`
------
Contains [chefspec][chefspec] tests for the cookbooks in `cookbooks/`
There is an example spec for the `example::default` recipe for you to
base your test on.

`test`
------
Contains [test-kitchen][tk] tests for your project. There is an example
(unimplemented) [serverspec][ss] test for you to build off of.

`vendor-cookbooks`
------------------
This is where community cookbooks that are required by the project live.
Download one:

```
$ knife cookbook site download <some-cookbook>
$ tar xzvf <some-cookbook-x.y.z.tar.gz> -C vendor-cookbooks
$ rm <some-cookbook-x.y.z.tar.gz>
```

Other files
-----------
*  `.envrc` - Uses [direnv][direnv], if available, to use
   [chef-dk][chef-dk] as the your ruby and gems
*  `.kitchen.yml` - Test kitchen configuration
*  `.rubocop.yml` - Linting configuration (see below)
*  `.ruby-version` - Makes rvm, rbenv, etc. move out of the way for
   chef-dk

Rake Tasks
==========
The main mode of operation (what you should pass on to users of your
project) is via rake tasks.  Running `rake node:install` will perform
the following tasks:

*  Build a `node.json` file with a runlist of `role[<default-role>]` and
   any other attributes from `config/node.yml`
*  Invoke chef-solo (`chef-solo -j node.json -c config/solo.rb`)

Alternately, you can specify a role: `rake node:install[somerole]` to
use instead of the default role.

Testing/linting
---------------
There are also the following rake tasks defined:

*  `kitchen:all` - very similar to running `kitchen test`
*  `style:ruby` - runs the project through [rubocop][rc] for ruby
   linting
*  `style:chef` - runs the project through [foodcritic][fc] for chef
   style linting
*  `style` - runs all of the style tasks

Packaging for Users
===================
Using this repository as a skeleton, you'll want to replace this README
with one that is more project-specific.  Add the cookbooks you'll need,
modify the base role, write your tests, etc.  You might want to put some
sample configuration values into `node.yml` as well.

Next, it might be a good idea to [cut a release][release] on Github for
your project.

After that, the procedure that a user would use to install your
configurations is:

*  Get ruby on the device
*  Install chef (gem or omnibus)
*  Download and unzip your release
*  Update the `config/node.yml` file
*  Run `rake install`

[bib]: https://github.com/umts/BusInfoBoard
[tk]: http://kitchen.ci/
[chefspec]: https://github.com/sethvargo/chefspec
[ss]: http://serverspec.org/
[direnv]: http://direnv.net/
[chef-dk]: https://downloads.chef.io/chef-dk/
[rc]: http://batsov.com/rubocop/
[release]: https://help.github.com/articles/about-releases/
