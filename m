From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 20 Oct 2020 13:02:35 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <87k0vlwhzt.fsf@suse.de>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <87k0vlwhzt.fsf@suse.de>
Message-ID: <87h7qpw1es.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Roman,
>
> Roman Gushchin <guro@fb.com> writes:
>
>> -		page_counter_init(&memcg->memory, NULL);
>> -		page_counter_init(&memcg->swap, NULL);
>> -		page_counter_init(&memcg->kmem, NULL);
>> -		page_counter_init(&memcg->tcpmem, NULL);
>> +		/*
>> +		 * If use_hierarchy == false, consider all page counters direct
>> +		 * descendants of the corresponding root level counters.
>> +		 */
>> +		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
>> +		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
>> +		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
>> +		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
>> +
>>  		/*
>>  		 * Deeper hierachy with use_hierarchy == false doesn't make
>>  		 * much sense so let cgroup subsystem know about this
>
> Perhaps in this case, where the hierarchy is broken, objcgs should also
> be reparented directly to root? Otherwise it will still be possible to
> underflow the counter in a descendant of root which has use_hierarchy=0,
> but also has children.

Sorry ignore me, parent_mem_cgroup already selects root. So in the case
of a broken hierarchy objcgs are reparented directly to root.

-- 
Thank you,
Richard.
