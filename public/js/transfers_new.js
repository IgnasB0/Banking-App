import { api, showAlert } from '/js/api.js';

const card = document.getElementById('transfer-card');
const fromId = new URLSearchParams(location.search).get('from') ?? '';

async function load() {
  const { ok, data } = await api('/accounts.json');

  if (!ok) {
    card.innerHTML = '<div class="alert alert-error">Failed to load accounts.</div>';
    return;
  }

  const options = data.map(a =>
    `<option value="${a.id}" ${String(a.id) === fromId ? 'selected' : ''}>${a.first_name} ${a.last_name} — ${a.iban}</option>`
  ).join('');

  card.innerHTML = `
    <form id="transfer-form">
      <div class="form-group">
        <label>From Account</label>
        <select name="from_account_id" required>${options}</select>
      </div>
      <div class="form-group">
        <label>Recipient IBAN</label>
        <input name="to_iban" type="text" required placeholder="e.g. GB29NWBK60161331926819" autocomplete="off">
      </div>
      <div class="form-group">
        <label>Amount</label>
        <input name="amount" type="number" min="0.01" step="0.01" required placeholder="0.00">
      </div>
      <button type="submit" class="btn btn-primary">Send Transfer</button>
    </form>`;

  document.getElementById('transfer-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const btn = form.querySelector('button');

    btn.disabled = true;
    btn.textContent = 'Sending…';

    const { ok, data: res } = await api('/transfers', {
      method: 'POST',
      body: JSON.stringify({ transfer: {
        from_account_id: form.from_account_id.value,
        to_iban: form.to_iban.value,
        amount: form.amount.value,
      }}),
    });

    if (ok) {
      window.location.href = `/accounts/show.html?id=${form.from_account_id.value}`;
    } else {
      btn.disabled = false;
      btn.textContent = 'Send Transfer';
      showAlert(card, res.errors ?? 'Transfer failed.');
    }
  });
}

load();
