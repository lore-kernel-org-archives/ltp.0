From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 16 Oct 2020 06:40:57 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201014200833.GA19363@carbon.lan>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201014200833.GA19363@carbon.lan>
Message-ID: <87v9fasp7a.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Roman,

Roman Gushchin <guro@fb.com> writes:

> Hi Richard!
>
>> SLAB objects which outlive their memcg are moved to their parent
>> memcg where they may be uncharged. However if they are moved to the
>> root memcg, uncharging will result in negative page counter values as
>> root has no page counters.
>> 
>> To prevent this, we check whether we are about to uncharge the root
>> memcg and skip it if we are. Possibly instead; the obj_cgroups should
>> be removed from their slabs and any per cpu stocks instead of
>> reparenting them to root?
>
> It would be really complex. I think your fix is totally fine.
> We have similar checks in cancel_charge(), uncharge_batch(),
> mem_cgroup_swapout(), mem_cgroup_uncharge_swap() etc.
>
>
> Acked-by: Roman Gushchin <guro@fb.com>
>
> Thanks!

Great I will respin.

-- 
Thank you,
Richard.
