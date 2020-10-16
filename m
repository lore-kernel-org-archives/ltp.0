From: Michal =?unknown-8bit?q?Koutn=C3=BD?= <mkoutny@suse.com>
Date: Fri, 16 Oct 2020 19:15:02 +0200
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201016145308.GA312010@cmpxchg.org>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
Message-ID: <20201016171502.GA102311@blackbook>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> The central try_charge() function charges recursively all the way up
> to and including the root.
Except for use_hiearchy=0 (which is the case here as Richard
wrote). The reparenting is hence somewhat incompatible with
new_parent.use_hiearchy=0 :-/

> We should clean this up one way or another: either charge the root or
> don't, but do it consistently.
I agree this'd be good to unify. One upside of excluding root memcg from
charging is that users are spared from the charging overhead when memcg
tree is not created.  (Actually, I thought that was the reason for this
exception.)

Michal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201016/5a06c060/attachment.sig>
