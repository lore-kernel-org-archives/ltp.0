From: Roman Gushchin <guro@fb.com>
Date: Tue, 20 Oct 2020 10:07:17 -0700
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201020162714.GC46039@blackbook>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
Message-ID: <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 20, 2020 at 06:27:14PM +0200, Michal Koutny wrote:
> Hi.
> 
> On Mon, Oct 19, 2020 at 03:28:45PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > Currently the root memory cgroup is never charged directly, but
> > if an ancestor cgroup is charged, the charge is propagated up to the
> s/ancestor/descendant/

Oops, will fix, thanks!

> 
> > The root memory cgroup doesn't show the charge to a user, neither it
> > does allow to set any limits/protections.
> An appealing claim, I'd like this to be true...
> 
> > Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> > However, it's not based on page counters (refer to mem_cgroup_usage()).
> ...and it almost is. But there are still exposed kmem and tcpmem counters.

Hm, I wonder what do they show given that we never set sk->sk_memcg
to the root_mem_cgroup (see mem_cgroup_sk_alloc()) and we never charge
the root_mem_cgroup for !slab kmem allocations (see __memcg_kmem_charge_page()).

So yeah, it's quite a mess now, and it looks like it has been broken
in multiple places and for a while.

If we want these counter to function properly, then we should go into the opposite
direction and remove the special handling of the root memory cgroup in many places.

> > To avoid multiple identical checks over the page counters
> > code, for_each_nonroot_ancestor() macro is introduced.
> If the assumptions behind this patch's idea were true, I think the
> implementation would be simpler by merely (not)connecting the root
> counters and keep the traversal as is.

We use some fields in root page counters to calculate protections:
see propagate_protected_usage().

Thanks!
