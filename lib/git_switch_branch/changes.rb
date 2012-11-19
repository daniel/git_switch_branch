require 'git'
require 'colored'

module GitSwitchBranch

  def self.save_changes
    if saved_changes?
      puts "This branch already has saved changes.".red
    elsif uncommitted_changes?
      stash_uncommitted_changes
      save_stash_to_patch
    else
      puts "No uncommitted changes to save.".green
    end
  end

  def self.restore_changes
    return unless saved_changes?
    puts "Restoring changes...".green
    if apply_patch
      File.delete(patch_path)
      @git.reset
    else
      puts "Failed to restore saved changes!"
      puts "Please check #{patch_path}"
    end
  end

  def self.check_changes
    if saved_changes?
      puts "This branch has saved changes.".green
    else
      puts "This branch has no saved changes.".green
    end
  end

  def self.show_changes
    if saved_changes?
      system "cat #{patch_path} | less"
    else
      puts "No saved changes found for this branch at #{patch_path})"
    end
  end

  private

  def self.stash_uncommitted_changes
    puts "Saving uncommitted changes...".green
    system "mkdir -p #{@repo_changes_path}"
    @git.add('.')
    system "git stash save"
  end

  def self.save_stash_to_patch
    puts "Saving stash to #{patch_path}"
    system "git stash show -p > #{patch_path}"
    system "git stash drop"
  end

  def self.saved_changes?
    File.exists?(patch_path)
  end

  def self.uncommitted_changes?
    `git status -s` != ''
  end

  def self.apply_patch
    system "patch -p1 < #{patch_path}"
  end

end
