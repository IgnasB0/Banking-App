import { api, fmt } from '/js/api.js';

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
    </div>

    <h2>Transfers</h2>
    <div class="card" id="transfers-list"><div class="loading">Loading transfers…</div></div>`;

  loadTransfers();
}

async function loadTransfers() {
  const { ok, data } = await api(`/transfers.json?account_id=${id}`);
  const container = document.getElementById('transfers-list');

  if (!ok) {
    container.innerHTML = '<div class="alert alert-error">Failed to load transfers.</div>';
    return;
  }

  if (data.length === 0) {
    container.innerHTML = '<div class="empty">No transfers yet.</div>';
    return;
  }

  container.innerHTML = `
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>From</th>
          <th>To</th>
          <th class="text-right">Amount</th>
        </tr>
      </thead>
      <tbody>
        ${data.map(t => {
          const sent = String(t.from_account_id) === id;
          return `
          <tr>
            <td>${new Date(t.created_at).toLocaleDateString()}</td>
            <td><span class="iban">${t.sender_iban}</span></td>
            <td><span class="iban">${t.receiver_iban}</span></td>
            <td class="text-right ${sent ? 'text-red' : 'text-green'}">
              ${sent ? '−' : '+'}${fmt(t.amount)}
            </td>
          </tr>`;
        }).join('')}
      </tbody>
    </table>`;
}
