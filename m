From: Roman Gushchin <guro@fb.com>
Date: Thu, 29 Oct 2020 10:05:23 -0700
Subject: [LTP] [PATCH v2] mm: memcg: link page counters to root if
 use_hierarchy is false
In-Reply-To: <20201029153921.GC9928@blackbook>
References: <20201026231326.3212225-1-guro@fb.com>
 <20201029153921.GC9928@blackbook>
Message-ID: <20201029170523.GH827280@carbon.dhcp.thefacebook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 29, 2020 at 04:39:21PM +0100, Michal Koutny wrote:
> Hi.
> 
> On Mon, Oct 26, 2020 at 04:13:26PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > Please note, that in the non-hierarchical mode all objcgs are always
> > reparented to the root memory cgroup, even if the hierarchy has more
> > than 1 level. This patch doesn't change it.
> > 
> > The patch also doesn't affect how the hierarchical mode is working,
> > which is the only sane and truly supported mode now.
> I agree with the patch and you can add
> Reviewed-by: Michal Koutn? <mkoutny@suse.com>
> 
> However, it effectively switches any users of root.use_hierarchy=0 (if there
> are any, watching the counters of root memcg) into root.use_hierarchy=1.
> So I'd show them the warning even with a single level of cgroups, i.e.
> add this hunk

It's only partially true. The main difference between the hierarchical and
non-hierarchical mode on the following simple example

    /
    |
    A
   / \
  B   C

is whether A's memory limits are applied to B, and this is not gonna change.
However you're right, it will change some root cgroup's numbers.

> 
> @@ -5356,12 +5356,11 @@
>  		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
>  		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
>  		/*
> -		 * Deeper hierachy with use_hierarchy == false doesn't make
> +		 * Hierachy with use_hierarchy == false doesn't make
>  		 * much sense so let cgroup subsystem know about this
>  		 * unfortunate state in our controller.
>  		 */
> -		if (parent != root_mem_cgroup)
> -			memory_cgrp_subsys.broken_hierarchy = true;
> +		memory_cgrp_subsys.broken_hierarchy = true;
>  	}
>  
>  	/* The following stuff does not apply to the root */
> 
> What do you think?

I think it's in a good direction of deprecating the non-hierarchical mode.
Shakeel did propose it too.

I'd also change the displayed message to something similar to we print
for kmem.limit_in_bytes:
    pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
    		 "Please report your usecase to linux-mm@kvack.org if you "
		 "depend on this functionality.\n");

Thanks!
