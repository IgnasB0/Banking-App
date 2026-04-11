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
        <label>To Account</label>
        <select name="to_account_id" required>${options}</select>
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

    if (form.from_account_id.value === form.to_account_id.value) {
      showAlert(card, 'You cannot transfer money to the same account.');
      return;
    }

    btn.disabled = true;
    btn.textContent = 'Sending…';

    const { ok, data: res } = await api('/transactions', {
      method: 'POST',
      body: JSON.stringify({ transaction: {
        from_account_id: form.from_account_id.value,
        to_account_id: form.to_account_id.value,
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
