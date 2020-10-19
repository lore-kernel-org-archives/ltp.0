From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 19 Oct 2020 09:45:32 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201016171502.GA102311@blackbook>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
Message-ID: <87lfg2ob83.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Michal Koutn? <mkoutny@suse.com> writes:

> On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> The central try_charge() function charges recursively all the way up
>> to and including the root.
> Except for use_hiearchy=0 (which is the case here as Richard
> wrote). The reparenting is hence somewhat incompatible with
> new_parent.use_hiearchy=0 :-/
>

Yes and it also seems

new_parent.use_hierarch=0 -> new_child.use_hierarchy=0

and

new_parent.use_hierarch=0 -> new_child.use_hierarchy=1

are considered valid on cgroupsV1. The kernel will also allow more
descendants on new_child.use_hierarchy=0, but sets
broken_hierarchy=1. However this will not stop the stack trace occuring
(AFAICT) when the reparenting happens between two descendants.

>> We should clean this up one way or another: either charge the root or
>> don't, but do it consistently.
> I agree this'd be good to unify. One upside of excluding root memcg from
> charging is that users are spared from the charging overhead when memcg
> tree is not created.  (Actually, I thought that was the reason for this
> exception.)
>
> Michal


-- 
Thank you,
Richard.
