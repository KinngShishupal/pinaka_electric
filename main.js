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

document.addEventListener('DOMContentLoaded', () => {
    loadReviews();
    loadOfficeInfo();
});
