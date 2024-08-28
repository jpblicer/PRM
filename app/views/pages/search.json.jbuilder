# app/views/pages/search.json.jbuilder
if @results.any?
  json.search_results render(partial: "shared/search_results", formats: :html, locals: { results: @results })
else
  json.search_results "<p>No results found.</p>"
end
