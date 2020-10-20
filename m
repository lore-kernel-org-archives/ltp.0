From: Johannes Weiner <hannes@cmpxchg.org>
Date: Tue, 20 Oct 2020 14:18:22 -0400
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
Message-ID: <20201020181822.GA397401@cmpxchg.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 20, 2020 at 10:07:17AM -0700, Roman Gushchin wrote:
> If we want these counter to function properly, then we should go into the opposite
> direction and remove the special handling of the root memory cgroup in many places.

I suspect this is also by far the most robust solution from a code and
maintenance POV.

I don't recall the page counter at the root level having been a
concern in recent years, even though it's widely used in production
environments. It's lockless and cache compact. It's also per-cpu
batched, which means it isn't actually part of the memcg hotpath.
