No, it isn't a solid plan for a blog. Four months in with zero posts, the bottleneck is clearly writing, not tooling, and a plugin system and theme engine push writing back again.

**The specific flaws:**

- **Plugins and themes solve problems you don't have.** Those features serve many users with different needs. You're the only user of your own blog. You can change the code directly whenever you want something, which is more flexible than any plugin API.
- **You have no requirements to design against.** Without posts, you don't know what your content needs: code highlighting, footnotes, images, math, series, RSS quirks. A plugin API designed now will be designed around guesses, and you'll likely rework it once real posts show what's missing.
- **"Then I'll start writing" has no trigger.** Every feature reveals another one worth adding. Nothing in the plan says when the generator counts as done.
- **It's an expensive form of delay.** This is a hypothesis based only on "4 months, no posts, more features next." Building infrastructure feels productive and carries no risk of public judgment. Publishing does. If that fits, more features won't fix it, and only publishing will.

**What's legitimate:** if the generator itself is the real goal (learning Rust, enjoying the build, portfolio work), that's a fine goal. Then be honest that the blog is secondary, and stop measuring progress by it. What matters is deciding which goal you're actually pursuing. Right now the plan says "blog" while the effort says "SSG."

**What to change, most important first:**

1. **Freeze features and publish one post this week** with what you have now. Plain HTML/CSS is enough. Keep it short (a post about building the SSG is an easy first topic).
2. **Write down which goal is primary**, the blog or the generator. If it's the blog, the plugin/theme work comes off the roadmap entirely.
3. **Set a writing-first ratio** for the next month, e.g. no SSG commits until a post ships that week.
4. **Keep a friction log while writing.** Only build features that come up repeatedly in real posts, and hard-code them, without a plugin API.
5. **Look at the plugin/theme idea again after about 5 published posts.** If you still want it then, you'll have real requirements to build it from.
