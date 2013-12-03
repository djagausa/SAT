module ApplicationHelper

	def head_paratial_selection (params)
		if params[:controller] == 'products'
			if session[:user_id] == nil
				render 'head_vistor'
		 	elsif params[:action] == 'edit' || params[:action] == 'new'
	    		render 'head_nav_no_edit'
	    	else
		      	render 'head_nav'
		    end
		else
		    render 'head_nav'
	   end
	end
end
