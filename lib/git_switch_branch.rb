require 'rubygems'
require 'colored'
require 'highline/import'

gsb_app_root = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH.unshift(gsb_app_root + '/lib')

require 'git_switch_branch/version'
require 'git_switch_branch/changes'

module GitSwitchBranch

  GSB_APP_DATA_DIR = '.git-switch-branch'

  attr_accessor :git, :repo_changes_path, :patch_path

  def self.initialize
    @git = Git.open(Dir.pwd)
    current_dir = File.basename(Dir.getwd)
    @repo_changes_path = File.join(ENV['HOME'], GSB_APP_DATA_DIR, current_dir)
    @patch_path = File.join(@repo_changes_path, @git.current_branch)
  end

  def self.find_and_checkout_branch(string)
    initialize
    checkout select_branch(string)
  end

  def self.show_version
    puts GitSwitchBranch::VERSION
  end

  def self.show_usage
    puts "git_switch_branch #{GitSwitchBranch::VERSION}\n\n"
    puts "Usage: gsb <branchname_or_part_of_branchname>"
  end

  private

  def self.select_branch(string)
    matching_branches = find_matching_branches(string)
    if matching_branches.count > 0
      choose_branch(matching_branches)
    else
      choose_branch(local_branches)
    end
  end

  def self.find_matching_branches(string)
    extract_branch_names(`git branch | grep -v '*' | grep '#{string}'`)
  end

  def self.checkout(branch)
    abort "Already on #{branch}" if @git.current_branch == branch
    save_changes
    puts "Checking out #{branch}...".green
    puts `git checkout #{branch}`
    restore_changes
  end

  def self.local_branches
    extract_branch_names(`git branch`)
  end

  def self.extract_branch_names(output)
    output.split("\n").map do |line|
      line.strip.sub('*','').strip.sub('remotes/','').sub('origin/','')
    end.uniq
  end

  def self.choose_branch(branches)
    if branches.count == 0
      abort "No branches found."
    end

    if branches.count == 1
      puts "Matching branch found: #{branches.first}".green
      return branches.first
    end

    puts "Branches found:".magenta.underline
    choose do |menu|
      menu.prompt = "\nChoose a branch to switch to: ".cyan
      branches.each do |branch|
        menu.choice(branch) { return branch }
      end
    end
  end

end



