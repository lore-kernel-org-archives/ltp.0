From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 21 May 2021 10:29:29 +0100
Subject: [LTP] [PATCH 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <871ra1lrf3.fsf@suse.de>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-7-rpalethorpe@suse.com> <YKT7xfzaUD7nNPzX@yuki>
 <871ra1lrf3.fsf@suse.de>
Message-ID: <87y2c8juyu.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

>>> +
>>> +static void cleanup(void)
>>> +{
>>> +	size_t i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(cg_workers); i++) {
>>> +		if (cg_workers[i])
>>> +			cg_workers[i] = tst_cgroup_group_rm(cg_workers[i]);
>>> +	}
>>> +
>>> +	if (cg_level3a)
>>> +		cg_level3a = tst_cgroup_group_rm(cg_level3a);
>>> +	if (cg_level3b)
>>> +		cg_level3b = tst_cgroup_group_rm(cg_level3b);
>>> +	if (cg_level2)
>>> +		cg_level2 = tst_cgroup_group_rm(cg_level2);
>>
>> Hmm, I wonder if we can move this part of the cleanup to the test
>> library as well. If we add all cgroups the user has created into a FIFO
>> linked list then this could be implemented as a single loop in the
>> tst_cgroup_clean().
>>
>> We would have to loop over the list in the tst_cgroup_group_rm() in
>> order to remove the about to be removed group from the list as well, but
>> I guess that this is still worth the trouble.
>
> This sounds good. We probably need to check if the groups have processes
> in them to print a nice error message. My main concern with automatic
> cleanup is confusing errors from deep in the lib.
>

I think maybe this API makes a fundamental mistake of mixing memory/object
management with actual creation and deletion of CGroups. OTOH that is
not really clear either.

But if a child process starts deleting CGroups, which might be a
reasonable thing to do, then we will get a mismatch between child and
parent. Then the cleanup will be wrong.

Also any kind of linked list or array implementation uses more lines of
code than the cleanup function and more complex for sure... even if we
have 10 test cases like this is it really work saving a few lines in
each case?

I don't know. But I think we need to see a few more cases.

-- 
Thank you,
Richard.
