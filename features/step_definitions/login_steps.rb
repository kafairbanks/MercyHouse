# Login step definitions
def setup_admin_omniauth_mock
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:facebook, {
      :provider => "facebook",
      :uid => '110786523432741',
      info: {
          name: 'Jeff Test Admin Huang'
      },
      credentials: {
          :token => 'EAAmB5vZAZAZB9MBALJZCDZAkvMJZBKCdBkZCkOA6cMH0kIbvJNzJAb2u5wpw8oGY3G2p05VpFIo33QeNB1phYeMx5JZBadIZB86cL49jhy4hK3ift9N8YZC71Mk4dgJ1F1BC2Y9uu97xEsZCuSZCMDANppnx3DindLeDJ7EApqG7c09RyVYotouJf07rCNWoKPu8GISYTjxoceMShETXZB49Jz3sm',
          :expires_at => Time.now + 1.week
      }

  })
end

def setup_applicant_omniauth_mock
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:facebook, {
      :provider => "facebook",
      :uid => '107809997065654',
      info: {
          name: 'Yi Reg Wei'
      },
      credentials: {
          :token => 'EAAmB5vZAZAZB9MBAIO2CZCJGUQZAw44Bw1wBMWP15lqkytHpq8lcxThAYlyZBBDeozq9SKagTA5wVDwmKeBo3fU2mGojq5cXtX3zmwoz4cuhdk6Hz63nDmeixBbJ7gmJznlBbpB2FDZCjYN3BcxcSk7dcQTTFZACO6ijgdNn1W3mfNYGotikXAfqnMBKApuh6ZAvcsuZCvROQoXp6ZBHZAkJ0E9P',
          :expires_at => Time.now + 1.week
      }
  })
end

def setup_newapplicant_omniauth_mock
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:facebook, {
      :provider => "facebook",
      :uid => '107809997065869',
      info: {
          name: 'New Baddie'
      },
      credentials: {
          :token => 'EAAmB5vZAZAZB9EMBRYOCZCJGUQZAw44Bw1wBMWP15lqkytHpq8lcxThAYlyZBBDeozq9SKagTA5wVDwmKeBo3fU2mGojq5cXtX3zmwoz4cuhdk6Hz63nDmeixBbJ7gmJznlBbpB2FDZCjYN3BcxcSk7dcQTTFZACO6ijgdNn1W3mfNYGotikXAfqnMBKApuh6ZAvcsuZCvROQoXp6ZBHZAkJ0E9P',
          :expires_at => Time.now + 1.week
      }
  })
end


# Scenario: Login
Given (/^I am logged in as an admin$/) do
  setup_admin_omniauth_mock
  visit('/login')
  click_link('Sign in with Facebook')
end

Given (/^I am logged in as an applicant$/) do
  setup_applicant_omniauth_mock
  visit('/login')
  click_link('Sign in with Facebook')
end

Given (/^I am logged in as a new applicant$/) do
  setup_newapplicant_omniauth_mock
  visit('/login')
  click_link('Sign in with Facebook')
end

When (/^I login as an applicant$/) do
  setup_applicant_omniauth_mock
  visit('/login')
  click_link('Sign in with Facebook')
end

When (/^I login as a new applicant$/) do
  setup_newapplicant_omniauth_mock
  visit('/login')
  click_link('Sign in with Facebook')
end

