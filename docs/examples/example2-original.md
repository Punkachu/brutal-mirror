No. This is probably a bad call, and the team's excitement is part of the problem.

## What you're actually doing

**You're prescribing a cure without a diagnosis.** 50 req/s is a trivial load. Django handles that easily on modest hardware. A 900ms p95 at that volume almost never comes from Python being slow. It usually comes from:

- **N+1 queries.** This is the #1 Django latency killer. One view quietly fires 200 SQL queries.
- **Missing database indexes** or bad query plans.
- **Synchronous external calls** (APIs, email, S3) inside the request path.
- **No caching** on expensive, rarely-changing data.
- **Undersized or misconfigured workers**, such as too few gunicorn workers or a connection pool that's starved.

Go makes none of these go away. Port an N+1 query to Go and you get a fast-compiled N+1 query. Your p95 drops maybe from 900ms to 850ms, because the time is spent waiting on Postgres, not running Python bytecode.

**Do you know where the 900ms goes?** If you can't answer "X ms in DB, Y ms in external calls, Z ms in app code" for your slowest endpoints, you aren't ready to make an architecture decision. You're guessing, and the guess costs 6 months.

## Why the plan itself is risky, separate from the diagnosis

1. **Microservices with 3 engineers is backwards.** Microservices solve an organizational problem: many teams needing to deploy independently. You have one team. You'd take on network hops, distributed transactions, service discovery, multiple deploy pipelines, cross-service debugging, and versioned contracts. Network hops between services *add* latency. You could end up slower.

2. **"6 months" is fiction.** Full rewrites almost always run 2–3x over, because the old system holds years of undocumented edge-case behavior you'll rediscover one bug at a time. Realistically you're looking at 12–18 months.

3. **The opportunity cost is your whole roadmap.** For that entire period, three people ship zero product value. You also have to either freeze the Django app or maintain two systems in parallel. Ask yourself whether the business can afford a year of no features.

4. **Team excitement isn't evidence.** Engineers love greenfield Go work. It's fun and it looks good on a résumé. That's a real motivation and worth respecting, but it's not a technical justification. Be honest about whether "fix performance" is the reason or the rationalization.

## What I'd do instead, in priority order

1. **This week: instrument.** Add APM (Sentry Performance, Datadog, New Relic, or OpenTelemetry), plus `django-debug-toolbar` or `django-silk` locally. Find your 5 slowest endpoints by total time (p95 × volume).
2. **Weeks 1–3: fix the obvious problems.** Use `select_related`/`prefetch_related`, add indexes based on `EXPLAIN ANALYZE`, move external calls to Celery/background jobs, and add Redis caching where it's safe. In my experience this kind of pass often cuts p95 by 50–80%.
3. **Week 4: re-measure.** Set a concrete target, like p95 < 200ms, and check whether you hit it.
4. **Only if a specific hot path is still CPU-bound after all that,** extract *that one service* into Go. It's a scoped, measurable experiment, it still lets the team write Go, and it doesn't bet the company.

## The hard question

What would you have to believe for the rewrite to be right? You'd have to believe the latency is CPU-bound in Python code, not I/O, and that you've already exhausted the cheap fixes. Do you have data showing either? If not, you're about to spend a year solving a problem you haven't confirmed exists.

If you want, I can dig into the codebase here and look for N+1 patterns, missing indexes, and synchronous I/O in views, so you have actual evidence before deciding.
