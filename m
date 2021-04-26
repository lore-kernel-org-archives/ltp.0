From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 26 Apr 2021 17:44:44 +0100
Subject: [LTP] [PATCH v3 5/7] docs: Update CGroups API
In-Reply-To: <CAEemH2dkbD_-gRQeKKAh+H6vo8gb+s0dWCa1-mJ_1-eg0eLeAA@mail.gmail.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-6-rpalethorpe@suse.com>
 <CAEemH2dkbD_-gRQeKKAh+H6vo8gb+s0dWCa1-mJ_1-eg0eLeAA@mail.gmail.com>
Message-ID: <87fszdm1vn.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>> +static void run(void)
>> +{
>> +       char buf[BUFSIZ];
>> +       size_t mem = 0;
>> +
>> +       cg_child = tst_cgroup_mk(cg, "child");
>> +       SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
>> +
>> +       if (SAFE_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
>> +               SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
>> +       if (SAFE_CGROUP_VER(cg, "cpuset") != TST_CGROUP_V1)
>> +               SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+cpuset");
>>
>
> Kind reminder:
>
> If you decide to add controllers automatically (as I suggested in patch3/7)
> in
> tst_cgroup_mk(), then these lines should be removed.
>
>
>> +Another example of an edge case is the following.
>> +
>> +[source,c]
>>
>> +-------------------------------------------------------------------------------
>> +       if (tst_cgroup_ver(cg, "memory") == TST_CGROUP_V1)
>> +               SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", ~0UL);
>> +       else
>> +               SAFE_CGROUP_PRINT(cg, "memory.swap.max", "max");
>>
>
> typo PRINT --> PRINTF ^.

This function actually exists :-p

>
> Btw, these documented works are quite awesome!

Thanks!

-- 
Thank you,
Richard.
