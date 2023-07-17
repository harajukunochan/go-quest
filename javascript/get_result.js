document.querySelector('#get_result').addEventListener('click', () => {
    Array.from(document.querySelectorAll('.variant')).forEach(el => {
        const checkbox = el.querySelector('input');
        const checked = checkbox.checked;
        const truthful = checkbox.dataset.true;

        console.log(checked.toString(), truthful)

        if (checked && checked.toString() === truthful) {
            el.classList.add('true');
        } else if (checked && checked.toString() !== truthful) {
            el.classList.add('false');
        }
    });
});
