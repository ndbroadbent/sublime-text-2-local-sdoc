# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever
#
# Install this crontab with: whenever -f schedule.rb -w
#
# This task requires SCM Breeze: https://github.com/ndbroadbent/scm_breeze
# You'll need to either install SCM Breeze or roll your own 'git_index' function.

every :hour do
  # Generate sdoc documentation. Only run one sdoc generation at a time.
  # The initial run for all your projects will take a really long time (a few hours),
  # but subsequent runs will only take seconds if nothing has changed.
  # We need to use a lock file called 'GENERATING' to ensure that cron tasks don't overlap.
  generate_sdoc_bin = File.expand_path('../bin/generate_sdoc', __FILE__)
  command <<-CMD.gsub(/\s{2,}/, ' ').strip
    mkdir -p $HOME/.sdoc &&
    ! [ -e $HOME/.sdoc/GENERATING ] &&
    touch $HOME/.sdoc/GENERATING &&
    git_index --batch-cmd #{generate_sdoc_bin};
    rm -f $HOME/.sdoc/GENERATING
  CMD
end