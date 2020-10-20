From: Michal =?unknown-8bit?q?Koutn=C3=BD?= <mkoutny@suse.com>
Date: Tue, 20 Oct 2020 18:27:14 +0200
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
Message-ID: <20201020162714.GC46039@blackbook>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.

On Mon, Oct 19, 2020 at 03:28:45PM -0700, Roman Gushchin <guro@fb.com> wrote:
> Currently the root memory cgroup is never charged directly, but
> if an ancestor cgroup is charged, the charge is propagated up to the
s/ancestor/descendant/

> The root memory cgroup doesn't show the charge to a user, neither it
> does allow to set any limits/protections.
An appealing claim, I'd like this to be true...

> Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> However, it's not based on page counters (refer to mem_cgroup_usage()).
...and it almost is. But there are still exposed kmem and tcpmem counters.


> To avoid multiple identical checks over the page counters
> code, for_each_nonroot_ancestor() macro is introduced.
If the assumptions behind this patch's idea were true, I think the
implementation would be simpler by merely (not)connecting the root
counters and keep the traversal as is.

> direct ascendants of the corresponding root memory cgroup's page
s/asc/desc/ ;-)

Michal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201020/03f6bfb4/attachment.sig>
