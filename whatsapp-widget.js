// ======================================
// WHATSAPP WIDGET ENHANCEMENTS
// ======================================

// Initialize WhatsApp widget features
function initWhatsAppWidget() {
    const whatsappBtn = document.querySelector('.whatsapp-float');
    
    if (!whatsappBtn) return;
    
    // Show button after scrolling 200px
    let isVisible = false;
    
    const showButton = () => {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop > 200 && !isVisible) {
            whatsappBtn.style.opacity = '1';
            whatsappBtn.style.transform = 'scale(1)';
            isVisible = true;
        } else if (scrollTop <= 200 && isVisible) {
            whatsappBtn.style.opacity = '0';
            whatsappBtn.style.transform = 'scale(0.8)';
            isVisible = false;
        }
    };
    
    // Initial state - hidden
    whatsappBtn.style.opacity = '0';
    whatsappBtn.style.transform = 'scale(0.8)';
    
    // Show on scroll
    window.addEventListener('scroll', showButton);
    showButton(); // Check initial position
    
    // Track clicks
    whatsappBtn.addEventListener('click', () => {
        console.log('📱 WhatsApp button clicked');
        
        // Google Analytics tracking (if available)
        if (typeof gtag !== 'undefined') {
            gtag('event', 'whatsapp_click', {
                'event_category': 'Contact',
                'event_label': 'WhatsApp Float Button'
            });
        }
        
        // Add ripple effect
        const ripple = document.createElement('div');
        ripple.style.cssText = `
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            top: 0;
            left: 0;
            transform: scale(0);
            animation: whatsapp-click-ripple 0.6s ease-out;
            pointer-events: none;
        `;
        
        whatsappBtn.appendChild(ripple);
        
        setTimeout(() => {
            ripple.remove();
        }, 600);
    });
    
    // Add click ripple animation CSS
    if (!document.getElementById('whatsapp-animations')) {
        const style = document.createElement('style');
        style.id = 'whatsapp-animations';
        style.textContent = `
            @keyframes whatsapp-click-ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    }
    
    console.log('✅ WhatsApp widget initialized');
}

// Add notification badge (optional feature)
function addWhatsAppNotification() {
    const whatsappBtn = document.querySelector('.whatsapp-float');
    
    if (!whatsappBtn) return;
    
    // Check if user hasn't contacted in this session
    const hasContacted = sessionStorage.getItem('whatsapp_contacted');
    
    if (!hasContacted) {
        const badge = document.createElement('span');
        badge.className = 'whatsapp-notification-badge';
        badge.textContent = '1';
        badge.style.cssText = `
            position: absolute;
            top: 5px;
            right: 5px;
            width: 20px;
            height: 20px;
            background: #FF3B30;
            border-radius: 50%;
            border: 2px solid #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: bold;
            color: white;
            z-index: 2;
            animation: badge-bounce 2s ease-in-out infinite;
        `;
        
        whatsappBtn.appendChild(badge);
        
        // Remove badge after first click
        whatsappBtn.addEventListener('click', () => {
            badge.remove();
            sessionStorage.setItem('whatsapp_contacted', 'true');
        }, { once: true });
        
        // Add badge animation
        if (!document.getElementById('badge-animations')) {
            const style = document.createElement('style');
            style.id = 'badge-animations';
            style.textContent = `
                @keyframes badge-bounce {
                    0%, 100% {
                        transform: scale(1);
                    }
                    50% {
                        transform: scale(1.15);
                    }
                }
            `;
            document.head.appendChild(style);
        }
    }
}

// Show welcome message tooltip after delay (optional)
function showWelcomeMessage() {
    const whatsappBtn = document.querySelector('.whatsapp-float');
    
    if (!whatsappBtn) return;
    
    // Check if message was already shown
    const messageShown = sessionStorage.getItem('whatsapp_welcome_shown');
    
    if (!messageShown) {
        setTimeout(() => {
            const tooltip = whatsappBtn.querySelector('.whatsapp-tooltip');
            
            if (tooltip) {
                // Temporarily show tooltip
                tooltip.style.opacity = '1';
                tooltip.style.transform = 'translateX(0)';
                
                // Hide after 3 seconds
                setTimeout(() => {
                    tooltip.style.opacity = '0';
                    tooltip.style.transform = 'translateX(-10px)';
                    sessionStorage.setItem('whatsapp_welcome_shown', 'true');
                }, 3000);
            }
        }, 5000); // Show after 5 seconds
    }
}

// Shake animation to grab attention (optional)
function shakeWhatsAppButton() {
    const whatsappBtn = document.querySelector('.whatsapp-float');
    
    if (!whatsappBtn) return;
    
    // Shake every 30 seconds if user hasn't scrolled much
    setInterval(() => {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop < 1000) { // Only shake if user is near top
            whatsappBtn.style.animation = 'whatsapp-shake 0.5s ease';
            
            setTimeout(() => {
                whatsappBtn.style.animation = 'whatsapp-pulse 2s ease-in-out infinite';
            }, 500);
        }
    }, 30000);
    
    // Add shake animation
    if (!document.getElementById('shake-animations')) {
        const style = document.createElement('style');
        style.id = 'shake-animations';
        style.textContent = `
            @keyframes whatsapp-shake {
                0%, 100% { transform: translateX(0) scale(1); }
                25% { transform: translateX(-5px) scale(1.05); }
                50% { transform: translateX(5px) scale(1.05); }
                75% { transform: translateX(-5px) scale(1.05); }
            }
        `;
        document.head.appendChild(style);
    }
}

// Initialize all features
document.addEventListener('DOMContentLoaded', () => {
    initWhatsAppWidget();
    
    // Optional features - uncomment to enable
    // addWhatsAppNotification();
    // showWelcomeMessage();
    // shakeWhatsAppButton();
});

// Also initialize on window load (fallback)
window.addEventListener('load', () => {
    if (!document.querySelector('.whatsapp-float').style.opacity) {
        initWhatsAppWidget();
    }
});
