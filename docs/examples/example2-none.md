Probably not. A rewrite is a big bet on a diagnosis you haven't confirmed yet.

**50 req/s at 900ms p95 is almost never a language problem.** Django handles that load comfortably. At that latency, the time usually goes to:

- **Database:** N+1 queries, missing indexes, unbounded querysets, or loading whole tables into memory.
- **Synchronous external calls:** payment APIs, email, S3, or internal HTTP made inline in the request.
- **Serialization overhead:** DRF serializers with nested relations can be very slow.
- **Worker setup:** too few gunicorn workers, or a sync worker blocked on I/O.
- **No caching** on expensive, rarely changing data.

If the slow part is a 600ms query, Go will run that same query and still be slow. Microservices also add network hops, so p95 can get worse.

**The rewrite risks are real for a team of 3:**
- Six months is optimistic. Rewrites usually run 2–3× over, and feature work stops meanwhile.
- You'd be running and debugging distributed systems (service discovery, tracing, partial failures, data consistency) without the headcount to spare.
- You'll lose years of edge-case fixes built into the current code.

**What I'd do instead (about 2–4 weeks):**
1. **Measure.** Add APM (Sentry, Datadog, New Relic, or OpenTelemetry) and find which endpoints drive the p95 and where their time goes.
2. **Fix the top offenders.** Use `select_related`/`prefetch_related`, add indexes, move slow side effects to Celery, add caching, and tune workers. Gains of 5–10× are common.
3. **Re-evaluate with data.** If one hot path is still CPU-bound after that, extract that single service into Go. That's a targeted move, not a rewrite.

Your team's excitement is worth keeping. You can channel it into a performance sprint with a clear target, like "p95 under 200ms in 4 weeks," and possibly one Go service later if the profiling supports it.

If you point me at the codebase or share a profile or slow query log, I can help find the bottlenecks.
