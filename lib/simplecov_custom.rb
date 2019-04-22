require 'simplecov'

SimpleCov.profiles.define 'simple_rails' do
    add_filter '/test/'
    add_filter '/config/'
    add_filter '/bin/'
    add_filter '/db/'
    add_filter '/spec/' # for rspec
    add_filter 'mailers'
    add_filter 'helpers'
    add_filter 'jobs'
    add_filter 'lib'
    add_filter 'features'

    add_group 'Controllers', 'app/controllers'
    add_group 'Models', 'app/models'

end