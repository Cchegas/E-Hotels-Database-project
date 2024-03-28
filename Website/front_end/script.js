document.addEventListener('DOMContentLoaded', function() {
    // Simulate fetching gallery images and displaying rooms on page load
    loadGalleryImages();
    fetchAvailableRooms({ /* criteria can be expanded */ }).then(displayRooms);

    // Add click event listener for gallery images
    document.querySelector('.gallery').addEventListener('click', function(event) {
        if (event.target.tagName === 'IMG') {
            event.target.classList.toggle('selected'); // Toggle 'selected' class on images
        }
    });
});

// Simulated function to fetch available rooms based on criteria
async function fetchAvailableRooms(criteria) {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve([
                { id: 1, name: "Room 101", capacity: 2, price: 120, area: "Ottawa" },
                // More mock data can be added here
            ]);
        }, 1000);
    });
}

// Function to display fetched rooms in the gallery section dynamically
function displayRooms(rooms) {
    const galleryDiv = document.querySelector('.gallery');
    galleryDiv.innerHTML = ''; // Clear existing content before displaying new rooms
    rooms.forEach(room => {
        const roomElement = document.createElement('div');
        roomElement.innerHTML = `
            <h3>${room.name}</h3>
            <p>Capacity: ${room.capacity}</p>
            <p>Price: $${room.price} per night</p>
            <p>Area: ${room.area}</p>
        `;
        galleryDiv.appendChild(roomElement);
    });
}

// Function to load mock gallery images
function loadGalleryImages() {
    const galleryDiv = document.querySelector('.gallery');
    // Mock image data, replace URLs with your actual image paths
    const images = [
        '/Users/stoneterrysheldor/Desktop/Uottawa/2023-2024/WInter/CSI2132/Project/front_end/img/king.jpg',
        '/Users/stoneterrysheldor/Desktop/Uottawa/2023-2024/WInter/CSI2132/Project/front_end/img/king.jpg',
        '/Users/stoneterrysheldor/Desktop/Uottawa/2023-2024/WInter/CSI2132/Project/front_end/img/king.jpg'
    ];

    images.forEach(src => {
        const imgElement = document.createElement('img');
        imgElement.src = src;
        imgElement.alt = 'Gallery Image';
        imgElement.style.cursor = 'pointer';
        galleryDiv.appendChild(imgElement);
    });
}

// Inject CSS styles for the 'selected' class and gallery image hover effects
const style = document.createElement('style');
style.innerHTML = `
    .selected {
        filter: brightness(60%);
        transform: scale(1.1);
        transition: transform 0.3s ease, filter 0.3s ease;
    }
    .gallery img {
        transition: transform 0.3s ease, filter 0.3s ease;
        margin: 10px;
        border: 3px solid transparent;
    }
    .gallery img:hover {
        transform: scale(1.05);
    }
`;
document.head.appendChild(style);
