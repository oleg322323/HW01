class AdminMailer < ApplicationMailer
  MAIL = "mail@example.com"

  def petition_complete(petition)
    @petition = petition
    mail to: self.class::MAIL, subject: "Петиция \"#{@petition.title}\" готова к рассмотрению"
  end
end
