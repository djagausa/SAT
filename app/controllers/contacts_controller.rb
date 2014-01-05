class ContactsController < ApplicationController

  def new
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
    if @contact.valid?
      UserMailer.contact_us(@contact).deliver
      redirect_to root_url, :notice => "Contact request sent."
    else
      render :new
    end
	  	
  end

  private

  def contact_params
  	params.require(:contact).permit(:name,:email,:message)
  end

end
