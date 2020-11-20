From: Michal =?unknown-8bit?q?Koutn=C3=BD?= <mkoutny@suse.com>
Date: Fri, 20 Nov 2020 18:46:16 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <CALvZod7GrYayHjYsqtF2AfcvkbTHCyWQJW4oXoO3fSGJeotDpQ@mail.gmail.com>
References: <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
 <20201023163053.GB535375@cmpxchg.org>
 <20201110012758.GA2612097@carbon.dhcp.thefacebook.com>
 <CALvZod7GrYayHjYsqtF2AfcvkbTHCyWQJW4oXoO3fSGJeotDpQ@mail.gmail.com>
Message-ID: <20201120174616.GA94676@blackbook>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.

On Tue, Nov 10, 2020 at 07:11:28AM -0800, Shakeel Butt <shakeelb@google.com> wrote:
> > The problem is that cgroup_subsys_on_dfl(memory_cgrp_subsys)'s return value
> > can change at any particular moment.
The switch can happen only when singular (i.e. root-only) hierarchy
exists. (Or it could if rebind_subsystems() waited until all memcgs are
completely free'd.)

> Since the commit 0158115f702b0 ("memcg, kmem: deprecate
> kmem.limit_in_bytes"), we are in the process of deprecating the limit
> on kmem. If we decide that now is the time to deprecate it, we can
> convert the kmem page counter to a memcg stat, update it for both v1
> and v2 and serve v1's kmem.usage_in_bytes from that memcg stat.
So with the single memcg, it may be possible to reconstruct the
necessary counters in both directions using the statistics (or some
complementarity, without fine grained counters removal).

I didn't check all the charging/uncharging places, these are just my 2
cents to the issue.

Michal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201120/4299de3b/attachment.sig>
