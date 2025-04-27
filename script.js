// Function to toggle the sidebar visibility
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar.style.left === "0px") {
        sidebar.style.left = "-250px";
    } else {
        sidebar.style.left = "0px";
    }
}

// Function to show a specific page/content
function showPage(pageId) {
    const pages = document.querySelectorAll(".page-content");
    pages.forEach((page) => {
        page.style.display = "none";
    });

    const selectedPage = document.getElementById(pageId);
    if (selectedPage) {
        selectedPage.style.display = "block";
    }
}

// Function to go back to the main screen
function goBack() {
    const pages = document.querySelectorAll(".page-content");
    pages.forEach((page) => {
        page.style.display = "none";
    });
    showPage('main-app');
}

// Function to switch to login form
function switchToLogin() {
    const authContainer = document.getElementById("auth-container");
    authContainer.innerHTML = `
        <h2>Login</h2>
        <input type="text" id="username" placeholder="Username">
        <input type="password" id="password" placeholder="Password">
        <button onclick="login()">Login</button>
        <p style="text-align:center; margin-top:10px;">Don't have an account? <a href="javascript:void(0)" onclick="switchToSignUp()">Sign Up</a></p>
    `;
}

// Simulate Sign Up function
function signup() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if (username && password) {
        alert("Sign Up successful!");
        // Show main app after successful signup
        document.getElementById("auth-container").style.display = "none";
        document.getElementById("main-app").style.display = "block";
    } else {
        alert("Please fill in all fields!");
    }
}

// Simulate Login function
function login() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if (username && password) {
        alert("Login successful!");
        // Show main app after successful login
        document.getElementById("auth-container").style.display = "none";
        document.getElementById("main-app").style.display = "block";
    } else {
        alert("Please fill in all fields!");
    }
}

// Function to log out and return to the login/sign-up page
function logout() {
    document.getElementById("auth-container").style.display = "block";
    document.getElementById("main-app").style.display = "none";
    alert("Logged out!");
}