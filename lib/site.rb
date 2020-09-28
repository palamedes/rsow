class Site

  @@uri = "https://www.randomstringofwords.com/"
  @@author = "Jason Ellis"
  @@description = "Freelance Ruby developer, PHP guru, general software engineer, wood worker, law enforcement officer and wanna be pilot building an airplane!"

  def self.uri
    @@uri
  end

  def self.description
    @@description
  end

  def self.author
    @@author
  end

  def self.title
    "#{@@author} :: #{@@description}"
  end

  def self.url_for href
    File.join @@uri, href
  end

end