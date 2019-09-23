# create an admin User and a registered User.
admin = User.create!      email: 'patrick@extensionschool.ch',
                          password: 'password',
                          name: 'Patrick Biro',
                          role: 'admin'

registered1 = User.create! email: 'visitor1@extensionschool.ch',
                          password: 'password',
                          name: 'Visitor1'

registered2 = User.create! email: 'visitor2@extensionschool.ch',
                          password: 'password',
                          name: 'Visitor2'

registered3 = User.create! email: 'visitor3@extensionschool.ch',
                          password: 'password',
                          name: 'Visitor3'


5.times do |i|
  Idea.create! user: admin, title: "Patrick's great idea #{i}"
  Idea.create! user: registered1, title: "Visitor1's idea #{i}"
  Idea.create! user: registered2, title: "Visitor2's idea #{i}"
  Idea.create! user: registered3, title: "Visitor3's idea #{i}"
end


admin.goals << registered1.ideas.first
admin.goals << registered2.ideas.first
admin.goals << registered3.ideas.first
