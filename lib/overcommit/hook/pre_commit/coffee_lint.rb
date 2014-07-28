module Overcommit::Hook::PreCommit
  # Runs `coffeelint` against any modified CoffeeScript files.
  class CoffeeLint < Base
    def run
      unless in_path?('coffeelint')
        return :warn, 'Run `npm install -g coffeelint`'
      end

      result = execute(%w[coffeelint --quiet] + applicable_files)
      return :pass if result.success?

      [:fail, result.stdout]
    end
  end
end
