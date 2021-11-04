require 'rake'

namespace :reports do
  desc 'Send some tweets to a user'

  task :lol do |_t|
    puts 'LOL'
  end

  task :first_report, %i[idenify_numbers start_time end_time] => [:environment] do |_t, args|
    idenify_numbers = args[:idenify_numbers].split(' ')
    answer = Account
             .joins(:transaction_log, :user)
             .where(user: { identify_number: idenify_numbers },
                    transaction_log: { created_at: eval(args[:start_time])..eval(args[:end_time]) })
             .where('transaction_log.sum > 0')
             .group(:identify_number, :currency)
             .sum(:sum).to_a
    answer_hash = if answer.blank?
                    puts 'NO RESULTS'
                  else
                    answer.each_with_object({}) do |answer_arr, hash_answer|
                      if hash_answer[answer_arr.first.first]
                        hash_answer[answer_arr.first.first] << { answer_arr.first.second => answer_arr.second }
                      else
                        hash_answer[answer_arr.first.first] =
                          [{ answer_arr.first.second => answer_arr.second }]
                      end
                    end
                  end
    pp answer_hash
  end
end
