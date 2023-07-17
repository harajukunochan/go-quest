Array.from(document.querySelectorAll(".copy_btn")).forEach(btn => {
    btn.addEventListener('click', () => {
        navigator.clipboard.writeText(btn.dataset.href);
    })
})
