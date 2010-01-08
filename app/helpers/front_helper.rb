module FrontHelper
  # build links to previous and next note when viewing an individual note archive
	def previous_next(current_note, span = 'item_hierarchy', title = 'Hierarchy: ')
		links = ''
		# run the queries
		@previous = Note.find_previous(current_note)
		@next = Note.find_next(current_note)
		if @previous.length > 0 or @next.length > 0
		# we've got something either before or after us
		  # start building the links
			links += '<span class="' + span + '">' + title
			for note in @previous
			  # grab the previous link if we've got one
				links += link_to('previous', Note.id(note), :title => 'Previous note')
			end
			for note in @next
			  # grab the next link if we've got one
			  # if there was a previous link, we should add a space and such first
				links += (@previous.length > 0 ? ', ' : '') + link_to('next', Note.id(note), :title => 'Next note')
			end
			# all done!
			return links + '</span>'
		else
		# no previous or next links
			return 'None'
		end
	rescue
	# whoops!
		return 'Reject'
	end
  
end
