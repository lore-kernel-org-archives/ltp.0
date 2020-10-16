From: Roman Gushchin <guro@fb.com>
Date: Fri, 16 Oct 2020 10:02:45 -0700
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201016145308.GA312010@cmpxchg.org>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
Message-ID: <20201016170245.GB230727@carbon.DHCP.thefacebook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner wrote:
> On Fri, Oct 16, 2020 at 11:47:02AM +0200, Michal Koutn? wrote:
> > Hello.
> > 
> > On Wed, Oct 14, 2020 at 08:07:49PM +0100, Richard Palethorpe <rpalethorpe@suse.com> wrote:
> > > SLAB objects which outlive their memcg are moved to their parent
> > > memcg where they may be uncharged. However if they are moved to the
> > > root memcg, uncharging will result in negative page counter values as
> > > root has no page counters.
> > Why do you think those are reparented objects? If those are originally
> > charged in a non-root cgroup, then the charge value should be propagated up the
> > hierarchy, including root memcg, so if they're later uncharged in root
> > after reparenting, it should still break even. (Or did I miss some stock
> > imbalance?)
> 
> Looking a bit closer at this code, it's kind of a mess right now.
> 
> The central try_charge() function charges recursively all the way up
> to and including the root. But not if it's called directly on the
> root, in which case it bails and does nothing.
> 
> kmem and objcg use try_charge(), so they have the same
> behavior. get_obj_cgroup_from_current() does it's own redundant
> filtering for root_mem_cgroup, whereas get_mem_cgroup_from_current()
> does not, but its callsite __memcg_kmem_charge_page() does.
> 
> We should clean this up one way or another: either charge the root or
> don't, but do it consistently.

+1

> 
> Since we export memory.stat at the root now, we should probably just
> always charge the root instead of special-casing it all over the place
> and risking bugs.

Hm, we export memory.stat but not memory.current. Charging the root memcg
seems to be an extra atomic operation, which can be avoided.

I wonder if we can handle it in page_counter.c, so there will be a single
place where we do the check.

> 
> Indeed, it looks like there is at least one bug where the root-level
> memory.stat shows non-root slab objects, but not root ones, whereas it
> shows all anon and cache pages, root or no root.

I'll take a look.
