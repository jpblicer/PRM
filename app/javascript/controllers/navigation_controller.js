import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ["addMenu", "icon", "navbar", 'title', "searchForm", 'searchResults', 'form']
  connect() {
  }

  toggleSearchForm(event) {
    event.preventDefault()
    this.titleTarget.classList.toggle('hidden');
    this.searchFormTarget.style.display = this.searchFormTarget.style.display === "none" ? "inline-block" : "none"
  }

  toggleMenu(event) {
    event.preventDefault();
    this.iconTarget.classList.toggle('rotate-icon');
    this.addMenuTarget.classList.toggle('show');
    this.navbarTarget.classList.toggle('no-shadow');
    this.titleTarget.classList.toggle('hidden');

    const searchIcon = document.querySelector('[data-action="click->navigation#toggleSearchForm"]');
    if (this.addMenuTarget.classList.contains('show')) {
        searchIcon.classList.add('disabled'); // Add a disabled class to style it as disabled
        searchIcon.setAttribute('aria-disabled', 'true'); // Add aria attribute for accessibility
        searchIcon.style.pointerEvents = 'none'; // Prevent click events
    } else {
        searchIcon.classList.remove('disabled'); // Remove the disabled class
        searchIcon.removeAttribute('aria-disabled'); // Remove aria attribute
        searchIcon.style.pointerEvents = ''; // Re-enable click events
    }
  }

  // Handle the keyup event
  handleKeyup(event) {
    // const query = event.target.value;
    // if (query.length > 2) { // Optional: only search if query is longer than 2 characters
      // this.sends(); // Call send method without passing the event
    // }
    this.send(event);
    // clearTimeout(this.timeout);
    // this.timeout = setTimeout(() => {
    //   this.sends(event);
    // }, 300); // Wait for 300ms before sending the request
  }

  send(event) {
    event.preventDefault();
    // Construct the URL with query parameters
    const url = new URL(this.formTarget.action);
    const params = new FormData(this.formTarget);

    // Append each form field as a query parameter
    params.forEach((value, key) => {
        url.searchParams.append(key, value);
    });

    fetch(url, {
        method: "GET", // Use GET for search functionality
        headers: { "Accept": "application/json" }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
    })
    .then((data) => {
        // Handle the JSON response, such as updating the search results
        this.searchResultsTarget.outerHTML = data.search_results;
        this.searchResultsTarget.classList.add('show-results');

        const addButton = document.querySelector('.add-btn');


    if (this.searchFormTarget.style.display !== "none") {
        addButton.classList.add('disabled'); // Add a disabled class to style it as disabled
        addButton.setAttribute('aria-disabled', 'true'); // Add aria attribute for accessibility
        addButton.style.pointerEvents = 'none'; // Prevent click events
    } else {
        addButton.classList.remove('disabled'); // Remove the disabled class
        addButton.removeAttribute('aria-disabled'); // Remove aria attribute
        addButton.style.pointerEvents = ''; // Re-enable click events
    }
    })
    .catch((error) => {
        console.error("There was a problem with the fetch operation:", error);
    });
}
}
