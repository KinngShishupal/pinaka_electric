// Supabase configuration
const SUPABASE_URL = 'https://zqjeoqvstvbzvikwsftv.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_xYyEJXCOfjeHHkFwY5Z5Yw_nbZmhl7V';

let supabaseClient = null;
if (typeof window.supabase !== 'undefined') {
    supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
}

function createStarRating(rating) {
    let stars = '';
    for (let i = 1; i <= 5; i++) {
        stars += i <= rating ? '<span class="star">★</span>' : '<span class="star empty">☆</span>';
    }
    return stars;
}

function createInitials(name) {
    if (!name) return 'AN';
    const words = name.trim().split(' ');
    return words.length === 1 ? words[0].substring(0, 2).toUpperCase() : (words[0][0] + words[words.length - 1][0]).toUpperCase();
}

function createTestimonialCard(review) {
    const card = document.createElement('div');
    card.className = 'testimonial-card';
    card.innerHTML = `
        <div class="rating">${createStarRating(review.stars || 5)}</div>
        <p class="testimonial-text">"${review.review || review.text || ''}"</p>
        <div class="testimonial-author">
            <div class="author-avatar">${createInitials(review.name)}</div>
            <div class="author-info">
                <h4>${review.name || 'Anonymous'}</h4>
                <p>${review.title || review.role || 'Customer'}</p>
            </div>
        </div>
    `;
    return card;
}

async function loadReviews() {
    if (!supabaseClient) {
        console.error('Supabase client not initialized');
        displayFallbackReviews();
        return;
    }
    
    try {
        const { data, error } = await supabaseClient
            .from('reviews')
            .select('*')
            .order('created_at', { ascending: false });
        
        console.log('Reviews loaded from Supabase:', data);
        
        if (error) {
            console.error('Query error:', error);
            displayFallbackReviews();
            return;
        }
        
        const slider = document.querySelector('.testimonials-slider');
        if (!slider) {
            console.error('Testimonials slider not found');
            return;
        }
        
        slider.innerHTML = '';
        
        if (!data || data.length === 0) {
            console.warn('No reviews found in database, showing fallback reviews');
            displayFallbackReviews();
            return;
        }
        
        console.log(`Rendering ${data.length} reviews`);
        data.forEach(review => slider.appendChild(createTestimonialCard(review)));
        
    } catch (err) {
        console.error('Unexpected error:', err);
        displayFallbackReviews();
    }
}

function displayFallbackReviews() {
    const fallbackReviews = [
        { name: 'John Doe', title: 'Urban Commuter', rating: 5, review_text: "This scooter has completely transformed my daily commute. It's fast, smooth, and incredibly fun to ride!" },
        { name: 'Sarah Miller', title: 'Tech Enthusiast', rating: 5, review_text: "Amazing build quality and the battery life is outstanding. I can go a week without charging!" },
        { name: 'Robert Johnson', title: 'Environmental Advocate', rating: 5, review_text: "Eco-friendly, stylish, and powerful. Pinaka Electric scooters are perfect!" }
    ];
    
    const slider = document.querySelector('.testimonials-slider');
    if (slider) {
        slider.innerHTML = '';
        fallbackReviews.forEach(review => slider.appendChild(createTestimonialCard(review)));
    }
}

// Function to load and display office information
async function loadOfficeInfo() {
    if (!supabaseClient) {
        console.error('Supabase client not initialized for office info');
        return;
    }
    
    try {
        // First query without .single() to check if data exists
        const { data, error } = await supabaseClient
            .from('visit')
            .select('*')
            .limit(1);
        
        console.log('Office info query result:', data);
        
        if (error) {
            console.error('Error fetching office info:', error);
            return;
        }
        
        if (!data || data.length === 0) {
            console.warn('⚠️ visit table is EMPTY! Add data in Supabase.');
            console.warn('💡 Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor');
            return;
        }
        
        // Use first row
        const officeData = data[0];
        console.log('Office info loaded:', officeData);
        
        // Update address
        const addressElement = document.getElementById('officeAddress');
        if (addressElement && officeData.address) {
            const addressLines = officeData.address.split('\n').map(line => 
                `<p class="address-line">${line}</p>`
            ).join('');
            addressElement.innerHTML = `<h3>Office Address</h3>${addressLines}`;
        }
        
        // Update phone
        const phoneElement = document.getElementById('officePhone');
        if (phoneElement && officeData.phone) {
            phoneElement.innerHTML = `<a href="tel:${officeData.phone}" class="contact-link">${officeData.phone}</a>`;
        }
        
        // Update email
        const emailElement = document.getElementById('officeEmail');
        if (emailElement && officeData.email) {
            emailElement.innerHTML = `<a href="mailto:${officeData.email}" class="contact-link">${officeData.email}</a>`;
        }
        
        // Update working hours
        const hoursElement = document.getElementById('workingHours');
        if (hoursElement && officeData.working_hours) {
            hoursElement.textContent = officeData.working_hours;
        }
        
        console.log('Office information updated successfully');
        
    } catch (err) {
        console.error('Unexpected error loading office info:', err);
    }
}

// Function to create a vehicle/model card
function createVehicleCard(vehicle) {
    const card = document.createElement('div');
    card.className = vehicle.is_featured ? 'model-card featured' : 'model-card';
    
    card.innerHTML = `
        <div class="model-badge ${vehicle.is_featured ? 'premium' : ''}">${vehicle.name}</div>
        <div class="model-image-real">
            <img src="${vehicle.image_url || 'images/scooter-default.png'}" alt="${vehicle.name} Electric Scooter" class="scooter-img">
        </div>
        <h3 class="model-name">${vehicle.name}</h3>
        <p class="model-desc">${vehicle.description || ''}</p>
        
        <div class="detailed-specs">
            <div class="spec-row">
                <div class="spec-column">
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">⚡</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Motor</span>
                            <span class="spec-value-small">${vehicle.motor || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">🔋</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Battery</span>
                            <span class="spec-value-small">${vehicle.battery || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">⚙️</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Controller</span>
                            <span class="spec-value-small">${vehicle.controller || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">🎯</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Tyre Size</span>
                            <span class="spec-value-small">${vehicle.tyre_size || 'N/A'}</span>
                        </div>
                    </div>
                </div>
                <div class="spec-column">
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">🚀</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Max Speed</span>
                            <span class="spec-value-small">${vehicle.max_speed || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">📏</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Net Weight</span>
                            <span class="spec-value-small">${vehicle.net_weight || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">💪</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Load Capacity</span>
                            <span class="spec-value-small">${vehicle.load_capacity || 'N/A'}</span>
                        </div>
                    </div>
                    <div class="spec-detail-item">
                        <span class="spec-icon-small">🛞</span>
                        <div class="spec-text">
                            <span class="spec-label-small">Brake</span>
                            <span class="spec-value-small">${vehicle.brake || 'N/A'}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="range-highlight">
                <span class="range-icon">🔋</span>
                <span class="range-text">Range: ${vehicle.range || 'Contact for details'}</span>
            </div>
        </div>
        
        <div class="model-price">${vehicle.price || 'Contact for Price'}</div>
        <a href="#location" class="model-btn">
            <span>Enquire Now</span>
            <span class="arrow">→</span>
        </a>
    `;
    
    return card;
}

// Function to load and display vehicles
async function loadVehicles() {
    if (!supabaseClient) {
        console.error('Supabase client not initialized for vehicles');
        return;
    }
    
    try {
        const { data, error } = await supabaseClient
            .from('vehicles')
            .select('*')
            .order('created_at', { ascending: false });
        
        console.log('Vehicles loaded from Supabase:', data);
        
        if (error) {
            console.error('Error fetching vehicles:', error);
            return;
        }
        
        const modelsShowcase = document.getElementById('modelsShowcase');
        if (!modelsShowcase) {
            console.error('Models showcase element not found');
            return;
        }
        
        if (!data || data.length === 0) {
            console.warn('No vehicles found in database. Keeping default models.');
            return;
        }
        
        // Clear existing models
        modelsShowcase.innerHTML = '';
        
        // Render each vehicle
        console.log(`Rendering ${data.length} vehicles`);
        data.forEach((vehicle, index) => {
            console.log(`  🚗 Rendering vehicle ${index + 1}:`, vehicle.name);
            const card = createVehicleCard(vehicle);
            modelsShowcase.appendChild(card);
        });
        
        console.log('✅ All vehicles rendered successfully!');
        
    } catch (err) {
        console.error('Unexpected error loading vehicles:', err);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    loadReviews();
    loadOfficeInfo();
    loadVehicles();
    
    // Smooth scroll for all anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (href && href !== '#') {
                e.preventDefault();
                const target = document.querySelector(href);
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                    console.log('Scrolling to:', href);
                }
            }
        });
    });
    console.log('✅ Smooth scroll navigation enabled for all anchor links');
});
