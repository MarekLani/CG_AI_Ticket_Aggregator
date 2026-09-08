import http from 'node:http';

const port = Number(process.env.PORT ?? 3001);

const tickets = [
  {
    id: 101,
    title: 'Cannot export filtered customer list',
    source: 'GitHub',
    priority: 'High'
  },
  {
    id: 102,
    title: 'Missing status mapping from Teams connector',
    source: 'Azure DevOps',
    priority: 'Medium'
  },
  {
    id: 103,
    title: 'Clarify duplicate detection for imported users',
    source: 'Email',
    priority: 'Low'
  }
];

const server = http.createServer((req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  if (req.url === '/api/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }

  if (req.url === '/api/tickets') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ generatedAt: new Date().toISOString(), tickets }));
    return;
  }

  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Not found' }));
});

server.listen(port, '0.0.0.0', () => {
  console.log(`Backend API listening on port ${port}`);
});
