module ApplicationHelper

	def head_paratial_selection (params)
		if params[:controller] == 'products'
			if session[:user_id] == nil
				render 'head_visitor'
			elsif session[:type] == SAT_SHOPPER_TYPE
				render 'head_shopper'
			elsif session[:type] == SAT_BIZ_TYPE
				if params[:action] == 'edit' || params[:action] == 'new'
	    			render 'head_nav_no_edit'
	    		else
		      		render 'head_nav'
		    	end
		    end
	   	elsif params[:controller] == 'bizs' || params[:controller] == 'shoppers'
	   		if params[:action] == 'new'
	   			render 'head_nav_new'
	   		elsif params[:action] == 'edit'
	   			render 'head_nav_edit'
	   		else
	   			render 'head_nav'
	   		end
	   	else
	   		render 'head_nav'
	   	end
	end
end
