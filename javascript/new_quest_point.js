const form = document.querySelector('form');
const content = document.querySelector('#quest_point_content');

const controls = document.querySelector('.controls');

const add_image_btn = document.querySelector('#add_image_btn');
const add_text_btn = document.querySelector('#add_text_btn');

add_image_btn.addEventListener('click', () => {
    const html = `
    <div class="with_btn row response">
        <input type="checkbox">
        <label>
            Картиночка:&nbsp;<span class="file_title">-</span>
            <input type="file" accept="image/*" class="hidden" name="quest_point[images][]">
        </label>
        <button type="button" class="remove_question">-</button>
    </div>
    `;

    controls.insertAdjacentHTML('afterend', html);
    document.querySelector('input[type=file]').addEventListener('change', function(ev) {
        this.closest('label').querySelector('.file_title').textContent = this.files[0].name;
    });
});

add_text_btn.addEventListener('click', () => {
    const html = `
        <div class="with_btn row response">
            <input type="checkbox">
            <input type="text" placeholder="Ответ">

            <button type="button" class="remove_question">-</button>
        </div>
    `;

    controls.insertAdjacentHTML('afterend', html);
});

const form_div = document.querySelector(".form_auth_block_content");
form_div.addEventListener('click', (ev) => {
    if (ev.target.closest('.remove_question')) {
        ev.target.closest('.response').remove();
    }
})


form.addEventListener('submit', (ev) => {
    // ev.preventDefault();
    const responses = Array.from(document.querySelectorAll('.response'));

    let res = responses.map(el => {
        const inp = el.querySelector('input:not([type=checkbox])');
        let cont = {};
        if (inp.matches('[type=file]')) {
            cont.type = "image";
            cont.value = inp.files[0].name;
        } else {
            cont.type = "text";
            cont.value = inp.value;
        }

        return {
            truthful: el.querySelector("input[type=checkbox]").checked,
            content: cont
        };
    });

    content.textContent = JSON.stringify(res);
});
