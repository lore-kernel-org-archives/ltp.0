From: Roman Gushchin <guro@fb.com>
Date: Tue, 20 Oct 2020 10:17:14 -0700
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <CALvZod66ETQR2rKhZQfEZwdovuF0AaVTZ1g1JNjkLgLGgMKY8g@mail.gmail.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <CALvZod66ETQR2rKhZQfEZwdovuF0AaVTZ1g1JNjkLgLGgMKY8g@mail.gmail.com>
Message-ID: <20201020171714.GB153102@carbon.DHCP.thefacebook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 20, 2020 at 09:55:38AM -0700, Shakeel Butt wrote:
> On Mon, Oct 19, 2020 at 3:28 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 07:15:02PM +0200, Michal Koutny wrote:
> > > On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > The central try_charge() function charges recursively all the way up
> > > > to and including the root.
> > > Except for use_hiearchy=0 (which is the case here as Richard
> > > wrote). The reparenting is hence somewhat incompatible with
> > > new_parent.use_hiearchy=0 :-/
> > >
> > > > We should clean this up one way or another: either charge the root or
> > > > don't, but do it consistently.
> > > I agree this'd be good to unify. One upside of excluding root memcg from
> > > charging is that users are spared from the charging overhead when memcg
> > > tree is not created.  (Actually, I thought that was the reason for this
> > > exception.)
> >
> > Yeah, I'm completely on the same page. Moving a process to the root memory
> > cgroup is currently a good way to estimate the memory cgroup overhead.
> >
> > How about the patch below, which consistently avoids charging the root
> > memory cgroup? It seems like it doesn't add too many checks.
> >
> > Thanks!
> >
> > --
> >
> > From f50ea74d8f118b9121da3754acdde630ddc060a7 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Mon, 19 Oct 2020 14:37:35 -0700
> > Subject: [PATCH RFC] mm: memcontrol: do not charge the root memory cgroup
> >
> > Currently the root memory cgroup is never charged directly, but
> > if an ancestor cgroup is charged, the charge is propagated up to the
> > root memory cgroup. The root memory cgroup doesn't show the charge
> > to a user, neither it does allow to set any limits/protections.
> > So the information about the current charge is completely useless.
> >
> > Avoiding to charge the root memory cgroup allows to:
> > 1) simplify the model and the code, so, hopefully, fewer bugs will
> >    be introduced in the future;
> > 2) avoid unnecessary atomic operations, which are used to (un)charge
> >    corresponding root page counters.
> >
> > In the default hierarchy case or if use_hiearchy == true, it's very
> > straightforward: when the page counters tree is traversed to the root,
> > the root page counter (the one with parent == NULL), should be
> > skipped. To avoid multiple identical checks over the page counters
> > code, for_each_nonroot_ancestor() macro is introduced.
> >
> > To handle the use_hierarchy == false case without adding custom
> > checks, let's make page counters of all non-root memory cgroup
> > direct ascendants of the corresponding root memory cgroup's page
> > counters. In this case for_each_nonroot_ancestor() will work correctly
> > as well.
> >
> > Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> > However, it's not based on page counters (refer to mem_cgroup_usage()).
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> This patch is only doing the page counter part of the cleanup (i.e. to
> not update root's page counters when descendent's page counter is
> updated) but not the stats part.
> 
> For the user memory, we do update the stats for the root memcg and do
> set page->mem_cgroup = root_mem_cgroup. However this is not done for
> the kmem/obj. I thought this is what Johannes was asking for the
> cleanup.

Yes, it's not the whole story, of course.

Actually I missed that we do export root kmem and tcpmem counters
on cgroup v1 (thanks Michal to pointing at it!). If we want them to function
properly, we have to go into the opposite direction and start charging
the root cgroup for all kinds of kernel memory allocations.

We also have the same problem with root MEMCG_SOCK stats, which seems
to be broken now.

I'll master a patch.

Thanks!
