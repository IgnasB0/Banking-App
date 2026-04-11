import { api, fmt, showAlert } from '/js/api.js';

const id = new URLSearchParams(location.search).get('id');
const main = document.getElementById('account-detail');

if (!id) {
  main.innerHTML = '<div class="alert alert-error">No account ID provided.</div>';
} else {
  loadAccount();
}

async function loadAccount() {
  const { ok, data } = await api(`/accounts/${id}.json`);

  if (!ok) {
    main.innerHTML = '<div class="alert alert-error">Account not found.</div>';
    return;
  }

  document.title = `${data.first_name} ${data.last_name} — Banking App`;

  main.innerHTML = `
    <div class="row">
      <a href="/" class="btn btn-ghost">← All Accounts</a>
      <a href="/transactions/new.html?from=${id}" class="btn btn-primary">Send Money</a>
    </div>

    <div class="card">
      <div class="row" style="margin-bottom:0">
        <div>
          <h1 style="margin-bottom:0.5rem">${data.first_name} ${data.last_name}</h1>
          <span class="iban">${data.iban ?? '—'}</span>
        </div>
        <div class="text-right">
          <div class="balance-label">Balance</div>
          <div class="balance-amount ${data.balance >= 0 ? 'text-green' : 'text-red'}">${fmt(data.balance)}</div>
        </div>
      </div>
    </div>

    <div class="grid-2">
      <div class="card">
        <h2>Deposit</h2>
        <form id="deposit-form">
          <div class="form-group">
            <label>Amount</label>
            <input name="amount" type="number" min="0.01" step="0.01" required placeholder="0.00">
          </div>
          <div class="form-group">
            <label>Banking Facility API Key</label>
            <input name="api_key" type="password" required placeholder="API key">
          </div>
          <button type="submit" class="btn btn-success">Deposit</button>
        </form>
      </div>
      <div class="card">
        <h2>Withdraw</h2>
        <form id="withdrawal-form">
          <div class="form-group">
            <label>Amount</label>
            <input name="amount" type="number" min="0.01" step="0.01" required placeholder="0.00">
          </div>
          <div class="form-group">
            <label>Banking Facility API Key</label>
            <input name="api_key" type="password" required placeholder="API key">
          </div>
          <button type="submit" class="btn btn-danger">Withdraw</button>
        </form>
      </div>
    </div>`;

  document.getElementById('deposit-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const btn = form.querySelector('button');
    btn.disabled = true;
    btn.textContent = 'Processing…';

    const { ok, data: res } = await api('/deposits', {
      method: 'POST',
      headers: { Authorization: `Bearer ${form.api_key.value}` },
      body: JSON.stringify({ account_id: id, amount: form.amount.value }),
    });

    if (ok) {
      loadAccount();
    } else {
      btn.disabled = false;
      btn.textContent = 'Deposit';
      showAlert(form.parentElement, res.error ?? res.errors ?? 'Deposit failed.');
    }
  });

  document.getElementById('withdrawal-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const btn = form.querySelector('button');
    btn.disabled = true;
    btn.textContent = 'Processing…';

    const { ok, data: res } = await api('/withdrawals', {
      method: 'POST',
      headers: { Authorization: `Bearer ${form.api_key.value}` },
      body: JSON.stringify({ account_id: id, amount: form.amount.value }),
    });

    if (ok) {
      loadAccount();
    } else {
      btn.disabled = false;
      btn.textContent = 'Withdraw';
      showAlert(form.parentElement, res.error ?? res.errors ?? 'Withdrawal failed.');
    }
  });
}
