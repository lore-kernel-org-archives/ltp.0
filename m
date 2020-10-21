From: Roman Gushchin <guro@fb.com>
Date: Wed, 21 Oct 2020 13:32:31 -0700
Subject: [LTP] [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <CALvZod45mAzyo9LNR4YtX_3J0gZJDagYTNv8NbJAuXzwK5A2DA@mail.gmail.com>
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de> <87eeltvwg4.fsf@suse.de>
 <CALvZod45mAzyo9LNR4YtX_3J0gZJDagYTNv8NbJAuXzwK5A2DA@mail.gmail.com>
Message-ID: <20201021203231.GB300658@carbon.dhcp.thefacebook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 20, 2020 at 09:56:51AM -0700, Shakeel Butt wrote:
> On Tue, Oct 20, 2020 at 6:49 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >
> > Hello,
> >
> > Richard Palethorpe <rpalethorpe@suse.de> writes:
> >
> > > Hello Shakeel,
> > >
> > > Shakeel Butt <shakeelb@google.com> writes:
> > >>>
> > >>> V3: Handle common case where use_hierarchy=1 and update description.
> > >>>
> > >>>  mm/memcontrol.c | 7 +++++--
> > >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >>> index 6877c765b8d0..34b8c4a66853 100644
> > >>> --- a/mm/memcontrol.c
> > >>> +++ b/mm/memcontrol.c
> > >>> @@ -291,7 +291,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> > >>>
> > >>>         spin_lock_irqsave(&css_set_lock, flags);
> > >>>         memcg = obj_cgroup_memcg(objcg);
> > >>> -       if (nr_pages)
> > >>> +       if (nr_pages && (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy))
> > >>
> > >> If we have non-root memcg with use_hierarchy as 0 and this objcg was
> > >> reparented then this __memcg_kmem_uncharge() can potentially underflow
> > >> the page counter and give the same warning.
> > >
> > > Yes, although the kernel considers such a config to be broken, and
> > > prints a warning to the log, it does allow it.
> >
> > Actually this can not happen because if use_hierarchy=0 then the objcg
> > will be reparented to root.
> >
> 
> Yup, you are right. I do wonder if we should completely deprecate
> use_hierarchy=0.

+1

Until that happy time maybe we can just link all page counters
to root page counters if use_hierarchy == false?
That would solve the original problem without complicating the code
in the main use_hierarchy == true mode.

Are there any bad consequences, which I miss?

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..fbbc74b82e1a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5339,17 +5339,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
                memcg->swappiness = mem_cgroup_swappiness(parent);
                memcg->oom_kill_disable = parent->oom_kill_disable;
        }
-       if (parent && parent->use_hierarchy) {
+       if (!parent) {
+               page_counter_init(&memcg->memory, NULL);
+               page_counter_init(&memcg->swap, NULL);
+               page_counter_init(&memcg->kmem, NULL);
+               page_counter_init(&memcg->tcpmem, NULL);
+       } else if (parent->use_hierarchy) {
                memcg->use_hierarchy = true;
                page_counter_init(&memcg->memory, &parent->memory);
                page_counter_init(&memcg->swap, &parent->swap);
                page_counter_init(&memcg->kmem, &parent->kmem);
                page_counter_init(&memcg->tcpmem, &parent->tcpmem);
        } else {
-               page_counter_init(&memcg->memory, NULL);
-               page_counter_init(&memcg->swap, NULL);
-               page_counter_init(&memcg->kmem, NULL);
-               page_counter_init(&memcg->tcpmem, NULL);
+               page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
+               page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
+               page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
+               page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
                /*
                 * Deeper hierachy with use_hierarchy == false doesn't make
                 * much sense so let cgroup subsystem know about this

