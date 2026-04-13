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
      <a href="/transfers/new.html?from=${id}" class="btn btn-primary">Send Money</a>
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
    </div>`;
}
