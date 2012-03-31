require 'rake'
unless Rake::Task.tasks.any?
  Compusec::Application.load_tasks
end

