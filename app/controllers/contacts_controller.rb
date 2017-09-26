class ContactsController < ApplicationController
  
  # GET request to '/contact-us'
  # Present a new Contact form.
  def new
    @contact = Contact.new
  end
  
  # POST request to '/contacts'
  # 
  def create
    
    # Mass assignment of form fields into Contact object.
    @contact = Contact.new(contact_params)
    
    # Save the contact details into the Database.
    if @contact.save
      # If successful, save into local variables to allow
      # further processing, email.
      name  = params[:contact][:name]
      email = params[:contact][:email]
      body  = params[:contact][:comments]
      # Plug in the data into the mail message and send
      ContactMailer.contact_email(name, email, body).deliver
      
      # Store success message in flash hash and reset
      # new Contact screen.
      flash[:success] = "Contact saved."
      redirect_to new_contact_path
    else
      # else if contact fails to save,
      # Store reported errors in flash hash and reset
      # new contact screen.
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
  
  # To collect data from forms we need to use strong
  # parameters and whitelist the form fields.
  #
  def contact_params
    params.require(:contact).permit(:name, :email, :comments)
  end
  
end
