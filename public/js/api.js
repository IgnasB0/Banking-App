export async function api(url, options = {}) {
  const headers = { 'Content-Type': 'application/json', 'Accept': 'application/json', ...options.headers };
  const res = await fetch(url, { ...options, headers });

  if (res.redirected && res.url.includes('/session')) {
    window.location.href = '/session/new';
    return { ok: false, data: {} };
  }

  const data = await res.json().catch(() => ({}));
  return { ok: res.ok, data };
}

export function fmt(amount) {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'EUR' }).format(amount ?? 0);
}

export function fmtDate(str) {
  return new Date(str).toLocaleString('en-US', { dateStyle: 'medium', timeStyle: 'short' });
}

export async function logout() {
  await fetch('/session', {
    method: 'DELETE',
    headers: { 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content }
  });
  window.location.href = '/session/new';
}

export function showAlert(container, msg, type = 'error') {
  const existing = container.querySelector('.alert');
  if (existing) existing.remove();
  const div = document.createElement('div');
  div.className = `alert alert-${type}`;
  div.textContent = typeof msg === 'string' ? msg : JSON.stringify(msg);
  container.insertBefore(div, container.firstChild);
}
