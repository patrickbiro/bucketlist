# create an admin User and a registered User.
admin = User.create!      email: 'patrick@epfl.ch',
                          password: 'password',
                          name: 'Patrick Biro',
                          role: 'admin'

registered = User.create! email: 'visitor@extensionschool.ch',
                          password: 'password',
                          name: 'Visitor'

registered = User.create! email: 'visitor2@extensionschool.ch',
                          password: 'password',
                          name: 'Visitor2'

registered = User.create! email: 'visitor3@extensionschool.ch',
                          password: 'password',
                          name: 'Visitor3'


5.times do |i|
  Idea.create! user: admin,
  title: "Neill's idea #{i}"
end

5.times do |i|
  Idea.create! user: registered,
  title: "Visitor's idea #{i}"
end
