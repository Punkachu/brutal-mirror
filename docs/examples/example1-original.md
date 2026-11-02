No. It's not a solid plan. It's a plan to keep not writing.

## What's actually happening

You set out to have a blog. Four months later you have zero posts and you're proposing to add **two more major subsystems** before the first one. That's not a roadmap; it's avoidance with a build system.

A plugin system and a theme engine solve problems you don't have yet:

- **Plugins** exist so *other people* can extend software without touching the core. You are the only user. You can just edit the code.
- **A theme engine** exists so you can swap designs. You don't have one design in production yet, let alone a need to switch between several.

You're building for a blog with hundreds of posts and an ecosystem of users. You have zero posts and one user.

## The uncomfortable part

Building the generator feels productive. It has clear problems, compiler feedback, and visible progress. Writing has none of that. It's ambiguous, exposing, and nobody tells you when it's correct. Infrastructure work is a very comfortable place to hide from that.

So ask yourself directly: **what are you afraid will happen when you publish?** That it'll be mediocre? That nobody reads it? That someone does? Whatever the answer is, more Rust won't fix it. It only delays the moment you have to face it.

## The opportunity cost

Four months is roughly 15–30 posts at a modest pace. That's real writing practice, a body of work, maybe some readers, and, most importantly, **actual data about what your blog needs**. Right now every feature you've built is a guess, because nothing has been used for its real purpose.

## If the SSG is the real goal, say so

There's an honest version of this: "I want to build a Rust SSG as a learning project." That's legitimate. But then stop calling it a blog, and stop telling yourself writing is next. Pick which one you actually want. The trouble is pretending one is a step toward the other.

## The plan

1. **Feature freeze, today.** No plugins, no themes. If your generator can turn Markdown into HTML pages with an index, it's done.
2. **Publish one post within 7 days.** Make it short and imperfect. A good first topic: what you learned building the generator. You already have the material.
3. **Commit to a cadence.** Say one post every two weeks for three months. Track posts published, not lines of code.
4. **Keep a "friction log."** Only add a feature when actually writing a post makes something painful **three times**. Let real use drive the roadmap.
5. **Revisit in 3 months.** If you've published 6+ posts and still want plugins, build them, informed by real needs. If you haven't published, the problem was never the tooling.

The tool is good enough. You're the bottleneck. Go write the post.
