
function chargerTheme() {
    const theme = localStorage.getItem('theme') || 'dark';
    if (theme === 'light') {
        document.body.classList.add('light-mode');
        const btn = document.getElementById('theme-toggle');
        if (btn) {
            btn.innerHTML = '🌙 Mode sombre';
        }
    } else {
        document.body.classList.remove('light-mode');
        const btn = document.getElementById('theme-toggle');
        if (btn) {
            btn.innerHTML = '☀️ Mode clair';
        }
    }
}

function changerTheme() {
    document.body.classList.toggle('light-mode');
    const estLight = document.body.classList.contains('light-mode');
    const nouveauTheme = estLight ? 'light' : 'dark';
    localStorage.setItem('theme', nouveauTheme);
    
    const btn = document.getElementById('theme-toggle');
    if (btn) {
        if (estLight) {
            btn.innerHTML = '🌙 Mode sombre';
        } else {
            btn.innerHTML = '☀️ Mode clair';
        }
    }
}

document.addEventListener('DOMContentLoaded', chargerTheme);