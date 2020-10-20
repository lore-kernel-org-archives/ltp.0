From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 20 Oct 2020 14:49:47 +0100
Subject: [LTP] [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <87mu0hwik7.fsf@suse.de>
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de>
Message-ID: <87eeltvwg4.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Shakeel,
>
> Shakeel Butt <shakeelb@google.com> writes:
>>>
>>> V3: Handle common case where use_hierarchy=1 and update description.
>>>
>>>  mm/memcontrol.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 6877c765b8d0..34b8c4a66853 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -291,7 +291,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>>>
>>>         spin_lock_irqsave(&css_set_lock, flags);
>>>         memcg = obj_cgroup_memcg(objcg);
>>> -       if (nr_pages)
>>> +       if (nr_pages && (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy))
>>
>> If we have non-root memcg with use_hierarchy as 0 and this objcg was
>> reparented then this __memcg_kmem_uncharge() can potentially underflow
>> the page counter and give the same warning.
>
> Yes, although the kernel considers such a config to be broken, and
> prints a warning to the log, it does allow it.

Actually this can not happen because if use_hierarchy=0 then the objcg
will be reparented to root.

>
>>
>> We never set root_mem_cgroup->objcg, so, no need to check for root
>
> I don't think that is relevant as we get the memcg from objcg->memcg
> which is set during reparenting. I suppose however, we can determine if
> the objcg was reparented by inspecting memcg->objcg.
>
>> here. I think checking just memcg->use_hierarchy should be sufficient.
>
> If we just check use_hierarchy then objects directly charged to the
> memcg where use_hierarchy=0 will not be uncharged. However, maybe it is
> better to check if it was reparented and if use_hierarchy=0.

-- 
Thank you,
Richard.
