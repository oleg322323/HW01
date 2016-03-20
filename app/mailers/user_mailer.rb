class UserMailer < ApplicationMailer
  def petition_created(petition)
    @petition = petition
    mail to: @petition.user.email, subject: "Петиция \"#{@petition.title}\" создана"
  end

  def petition_complete(petition)
    @petition = petition
    mail to: @petition.user.email, subject: "Петиция \"#{@petition.title}\" будет рассмотрена"
  end

  def petition_fail(petition)
    @petition = petition
    mail to: @petition.user.email, subject: "Петиция \"#{@petition.title}\" отвергнута"
  end
end
