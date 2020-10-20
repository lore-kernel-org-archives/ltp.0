From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 20 Oct 2020 15:48:11 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
Message-ID: <87blgxvtqs.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Roman,

Roman Gushchin <guro@fb.com> writes:

> On Fri, Oct 16, 2020 at 07:15:02PM +0200, Michal Koutny wrote:
>
> From f50ea74d8f118b9121da3754acdde630ddc060a7 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Mon, 19 Oct 2020 14:37:35 -0700
> Subject: [PATCH RFC] mm: memcontrol: do not charge the root memory cgroup
>
> Currently the root memory cgroup is never charged directly, but
> if an ancestor cgroup is charged, the charge is propagated up to the
> root memory cgroup. The root memory cgroup doesn't show the charge
> to a user, neither it does allow to set any limits/protections.
> So the information about the current charge is completely useless.
>
> Avoiding to charge the root memory cgroup allows to:
> 1) simplify the model and the code, so, hopefully, fewer bugs will
>    be introduced in the future;
> 2) avoid unnecessary atomic operations, which are used to (un)charge
>    corresponding root page counters.
>
> In the default hierarchy case or if use_hiearchy == true, it's very
> straightforward: when the page counters tree is traversed to the root,
> the root page counter (the one with parent == NULL), should be
> skipped. To avoid multiple identical checks over the page counters
> code, for_each_nonroot_ancestor() macro is introduced.
>
> To handle the use_hierarchy == false case without adding custom
> checks, let's make page counters of all non-root memory cgroup
> direct ascendants of the corresponding root memory cgroup's page
> counters. In this case for_each_nonroot_ancestor() will work correctly
> as well.
>
> Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> However, it's not based on page counters (refer to mem_cgroup_usage()).
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c   | 21 ++++++++++++++++-----
>  mm/page_counter.c | 21 ++++++++++++---------
>  2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2636f8bad908..34cac7522e74 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5339,17 +5339,28 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
>  		memcg->oom_kill_disable = parent->oom_kill_disable;
>  	}
> -	if (parent && parent->use_hierarchy) {
> +	if (!parent) {
> +		/* root memory cgroup */
> +		page_counter_init(&memcg->memory, NULL);
> +		page_counter_init(&memcg->swap, NULL);
> +		page_counter_init(&memcg->kmem, NULL);
> +		page_counter_init(&memcg->tcpmem, NULL);
> +	} else if (parent->use_hierarchy) {
>  		memcg->use_hierarchy = true;
>  		page_counter_init(&memcg->memory, &parent->memory);
>  		page_counter_init(&memcg->swap, &parent->swap);
>  		page_counter_init(&memcg->kmem, &parent->kmem);
>  		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
>  	} else {
> -		page_counter_init(&memcg->memory, NULL);
> -		page_counter_init(&memcg->swap, NULL);
> -		page_counter_init(&memcg->kmem, NULL);
> -		page_counter_init(&memcg->tcpmem, NULL);
> +		/*
> +		 * If use_hierarchy == false, consider all page counters direct
> +		 * descendants of the corresponding root level counters.
> +		 */
> +		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
> +		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
> +		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
> +		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
> +
>  		/*
>  		 * Deeper hierachy with use_hierarchy == false doesn't make
>  		 * much sense so let cgroup subsystem know about this
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index b24a60b28bb0..8901b184b9d5 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -13,6 +13,9 @@
>  #include <linux/bug.h>
>  #include <asm/page.h>
>  
> +#define for_each_nonroot_ancestor(c, counter) \
> +	for ((c) = (counter); ((c) && ((c)->parent)); (c) = (c)->parent)
> +
>  static void propagate_protected_usage(struct page_counter *c,
>  				      unsigned long usage)
>  {
> @@ -20,9 +23,6 @@ static void propagate_protected_usage(struct page_counter *c,
>  	unsigned long low, min;
>  	long delta;
>  
> -	if (!c->parent)
> -		return;
> -
>  	min = READ_ONCE(c->min);
>  	if (min || atomic_long_read(&c->min_usage)) {
>  		protected = min(usage, min);
> @@ -68,7 +68,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  {
>  	struct page_counter *c;
>  
> -	for (c = counter; c; c = c->parent) {
> +	for_each_nonroot_ancestor(c, counter) {
>  		long new;
>  
>  		new = atomic_long_add_return(nr_pages, &c->usage);
> @@ -97,7 +97,7 @@ bool page_counter_try_charge(struct page_counter *counter,
>  {
>  	struct page_counter *c;
>  
> -	for (c = counter; c; c = c->parent) {
> +	for_each_nonroot_ancestor(c, counter) {
>  		long new;
>  		/*
>  		 * Charge speculatively to avoid an expensive CAS.  If
> @@ -137,8 +137,11 @@ bool page_counter_try_charge(struct page_counter *counter,
>  	return true;
>  
>  failed:
> -	for (c = counter; c != *fail; c = c->parent)
> +	for_each_nonroot_ancestor(c, counter) {
> +		if (c == *fail)
> +			break;
>  		page_counter_cancel(c, nr_pages);
> +	}
>  
>  	return false;
>  }
> @@ -152,7 +155,7 @@ void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
>  {
>  	struct page_counter *c;
>  
> -	for (c = counter; c; c = c->parent)
> +	for_each_nonroot_ancestor(c, counter)
>  		page_counter_cancel(c, nr_pages);
>  }
>  
> @@ -211,7 +214,7 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
>  
>  	WRITE_ONCE(counter->min, nr_pages);
>  
> -	for (c = counter; c; c = c->parent)
> +	for_each_nonroot_ancestor(c, counter)
>  		propagate_protected_usage(c, atomic_long_read(&c->usage));
>  }
>  
> @@ -228,7 +231,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
>  
>  	WRITE_ONCE(counter->low, nr_pages);
>  
> -	for (c = counter; c; c = c->parent)
> +	for_each_nonroot_ancestor(c, counter)
>  		propagate_protected_usage(c, atomic_long_read(&c->usage));
>  }

This for sure prevents the counter underflow reported by madvise06 and
makes my patch redundant. Although perhaps this is significantly more
intrusive, so not suitable for the 5.9 stable branch?

Tested-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.
