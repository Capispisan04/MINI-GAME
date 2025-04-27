// Function to toggle sidebar visibility
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar.style.left === "0px") {
        sidebar.style.left = "-250px";
    } else {
        sidebar.style.left = "0px";
    }
}

// Function to show specific pages in the app
function showPage(pageId) {
    const pages = document.querySelectorAll(".page-content, .form-container");
    pages.forEach((page) => {
        page.style.display = "none";
    });
    
    const pageToShow = document.getElementById(pageId);
    if (pageToShow) {
        pageToShow.style.display = "block";
    }

    // Hide the authentication screen and show the main app if logged in
    if (pageId === 'main-app') {
        document.getElementById('auth-container').style.display = "none";
    }
}

// Function for going back to the main app from a specific page
function goBack() {
    showPage('main-app');
}

// Function for signing up
function signup() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    if (username && password) {
        alert("Signed up successfully!");
        showPage('main-app');
    } else {
        alert("Please fill in both fields.");
    }
}

// Switch to the login form (for demo purpose, you can replace this with actual login functionality)
function switchToLogin() {
    document.getElementById("auth-title").textContent = "Login";
    document.getElementById("signup-button").style.display = "none";
    document.getElementById("login-button").style.display = "block";
    document.getElementById("auth-container").style.display = "block";
}

// Function for logging out (for demo purpose, you can replace this with actual logout functionality)
function logout() {
    alert("Logged out successfully.");
    showPage('auth-container');
}

// Ensure that when the page loads, the first page to display is the login/signup form
document.addEventListener('DOMContentLoaded', function() {
    showPage('auth-container');
});