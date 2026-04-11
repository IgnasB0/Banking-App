import { api, fmtDate } from '/js/api.js';

const container = document.getElementById('accounts-table');

async function load() {
  const { ok, data } = await api('/accounts.json');

  if (!ok) {
    container.innerHTML = '<div class="alert alert-error">Failed to load accounts.</div>';
    return;
  }

  if (!data.length) {
    container.innerHTML = '<div class="empty">No accounts yet. <a href="/accounts/new.html">Create one</a>.</div>';
    return;
  }

  const rows = data.map(a => `
    <tr>
      <td><a href="/accounts/show.html?id=${a.id}" class="btn btn-ghost">${a.first_name} ${a.last_name}</a></td>
      <td><span class="iban">${a.iban ?? '—'}</span></td>
      <td>${a.country_code}</td>
      <td>${fmtDate(a.created_at)}</td>
    </tr>`).join('');

  container.innerHTML = `
    <table>
      <thead><tr><th>Name</th><th>IBAN</th><th>Country</th><th>Created</th></tr></thead>
      <tbody>${rows}</tbody>
    </table>`;
}

load();
