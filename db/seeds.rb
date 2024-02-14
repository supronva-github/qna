# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Data is loading'

questions = Question.create([
                              { title: 'Как в VS Code перейти в класс или переменную?', body: 'В phpStorm или rubyMine например зажимаешь ctrl и жмёшь на класс или переменную автоматически переходит к ней, а как в vs code такое сделать?' }
                            ])

answers = Answer.create([
                          { body: 'Клавиша alt ...', question: questions[0] },
                          { body: 'Зажимаешь alt и жмёшь на класс или переменную', question: questions[0] }
                        ])
puts 'Data loaded!'
