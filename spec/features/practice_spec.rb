# require "rails_helper"
#
#   feature 'making practice video', type: :feature do
#     context 'Trainee submits a video' do
#       let! (:user) {FactoryBot.create(:user)}
#       let! (:course) {FactoryBot.create(:course, user: user)}
#       let! (:topic) {FactoryBot.create(:topic, course: course)}
#       let! (:lesson) {FactoryBot.create_list(:lesson, 3, topic: topic)}
#       let! (:trainee) {FactoryBot.create(:user)}
#
#
#       it 'trainee work thru', js: true do
#         visit new_user_session_path
#         fill_in 'Email', with: trainee.email
#         fill_in 'Password', with: trainee.password
#         click_on 'Log in'
#
#         expect(page).to have_content 'Signed in successfully'
#         visit lessons_path
#         click_on 'Show', match: :first
#         expect(page).to have_content lesson.first.lesson_title
#         click_on 'submit your practice practice'
#         expect(page).to have_content 'New Practice'
#         fill_in 'Token', with: 'dsaonviniavbibvalvjbabsdl'
#         fill_in 'Video token', with: 'sdfsdfsdfssdvavfdfs'
#         click_on 'Create Practice'
#
#         expect(page).to have_content 'Practice was successfully created'
#         visit lessons_path
#         click_on 'Show', match: :first
#         click_on 'submit your practice practice'
#
#         expect(page).to have_content 'New Practice'
#
#
#       end
#     end
#   end
