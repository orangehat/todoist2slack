require_relative 'todoist.rb'
require_relative 'slack.rb'

todoist = Todoist.new
tasks = todoist.get_tasks

today_tasks = ""
tomorrow_tasks = ""
day_after_tomorrow_tasks = ""

tasks['Items'].each do |task|
  if task['due_date']
    if Date.today === Date.parse(task['due_date'])
      today_tasks << "・#{task['content']} \n"
    end

    if Date.today + 1 === Date.parse(task['due_date'])
      tomorrow_tasks << "・#{task['content']} \n"
    end

    if Date.today + 2 === Date.parse(task['due_date'])
      day_after_tomorrow_tasks << "・#{task['content']} \n"
    end
  end
end

todoist_tasks = <<"EOS"
# *今日（#{Date.today.strftime("%Y/%m/%d")}）のタスク*
#{today_tasks.empty? ? "なし \n" : today_tasks}
# *明日（#{(Date.today + 1).strftime("%Y/%m/%d")}）のタスク*
#{tomorrow_tasks.empty? ? "なし \n" : tomorrow_tasks}
# *明後日（#{(Date.today + 2).strftime("%Y/%m/%d")}）のタスク*
#{day_after_tomorrow_tasks.empty? ? "なし" : day_after_tomorrow_tasks}
EOS

slack = Slack.new
slack.message todoist_tasks
