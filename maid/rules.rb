Maid.rules do
  rule 'Mac OS X applications in disk images' do
    trash dir('~/Downloads/*.dmg').select { |p| 2.days.since? accessed_at(p) }
  end

  rule 'Mac OS X applications in zip files' do
    zips = dir('~/Downloads/*.zip').select do |path|
      zipfile_contents(path).any? { |c| c.match(/\.app$/) } && 2.days.since?(accessed_at(path))
    end

    trash zips
  end

  rule 'Duplicate files' do
    trash verbose_dupes_in('~/{Desktop,Downloads,stuff}/*')
  end

  rule "CIBC statements" do
    statements = dir_safe('~/Downloads').select do |path|
      downloaded_from(path).any? { |u| u.match('cibc.com') }
    end

    move statements, '~/Dropbox/Finances/CIBC'
    # TODO - separate accounts
  end

  # TODO - other financial statements.
end
