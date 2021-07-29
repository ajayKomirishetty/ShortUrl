class UrlsController < ApplicationController
	before_action :set_hostname, only: [:create]
	before_action :set_url_by_token, only: [:edit,:update, :destroy]
	# before_action :set_url, only: [:update, :destroy]


 def new 
	 @url = Url.new
 end

 def set_hostname
	@hostname = request.base_url+"/" || "http://localhost:3000/"
 end

def edit
end
 

def tiny_url(token = "")
	@url = Url.find_by_token(params[:token])   # get token from query parameter 
	if !@url.nil?
		@url.viewCount = @url.viewCount+ 1         # increase view count by one for every new visit
		@url.save
		@visitor = @url.visitors.create(ip: request.remote_ip)  # store the ip address in visitor table
		@visitor.save
		redirect_to @url.link
	else
		redirect_to urls_path, notice: 'There is no matching URL found with that token' 
	end
 end

 def url_info
  @url = Url.find_by_token(params[:token])
  if !@url.nil?
	@url
  else
	redirect_to urls_path, notice: 'There is no matching URL found with that token' 
  end
 end

 def generate_token
	token_range = [*'0'..'9',*'A'..'Z',*'a'..'z'] #setting up this array to generate alphanumeric number
	token = Array.new(7){ token_range.sample }.join  #generates a 7 digit alphanumeric number   
 end

 def index
	redirect_to urls_create_path
 end

 def create
	@url = Url.new(url_params)    # create object from trusted params
	token = generate_token        
	if(Url.find_by_token(token))  # Verify if this token is already present in db. if present, create another
		token = generate_token
	end
	@url.token = token  # saving token in this field
	@url.tiny_url = @hostname + @url.token  # saving complete tiny url in this field
	respond_to do |format|
	  if @url.save
		 format.html { redirect_to url_info_path(:token => @url.token), notice: 'Url was successfully created.' }
	  else
		 format.html { render :new }
	  end
	end
 end

 def update
	respond_to do |format|
	  if @url.update(url_params)

		 format.html { redirect_to url_info_path(:token => @url.token), notice: 'Url was successfully updated.' }
	  else
		 format.html { render :edit }
	  end
	end
 end


 def destroy
	@url.destroy
	respond_to do |format|
	  format.html { redirect_to urls_create_path, notice: 'Url was successfully destroyed.' }
	end
 end


 private

 def set_url_by_token
	@url = Url.find_by_token(params[:token]) 
	@url = Url.find(params[:id])  if @url.nil?
 end

 # Never trust parameters from the scary internet, only allow the white list through.
 def url_params
	params.require(:url).permit(:link,:id)
 end

end