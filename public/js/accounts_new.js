import { api, showAlert } from '/js/api.js';

document.getElementById('account-form').addEventListener('submit', async (e) => {
  e.preventDefault();
  const form = e.target;
  const btn = form.querySelector('button[type=submit]');
  btn.disabled = true;
  btn.textContent = 'Creating…';

  const { ok, data } = await api('/accounts', {
    method: 'POST',
    body: JSON.stringify({ account: {
      first_name: form.first_name.value,
      last_name: form.last_name.value,
      country_code: form.country_code.value.toUpperCase(),
    }}),
  });

  if (ok) {
    window.location.href = `/accounts/show.html?id=${data.id}`;
  } else {
    btn.disabled = false;
    btn.textContent = 'Create Account';
    showAlert(form.parentElement, data.errors ?? 'Something went wrong.');
  }
});
