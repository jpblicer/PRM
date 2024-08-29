# app/views/pages/search.json.jbuilder
if @results.any?
  json.search_results render(partial: "shared/search_results", formats: :html, locals: { results: @results })
else
  json.search_results "<ul class='search-results' id='search' data-navigation-target='searchResults'><h2 class='no-results'>No results found.</h2></ul>"
end
