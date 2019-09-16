From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 16 Sep 2019 20:07:16 +0800
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fix test_5 possible
 mount failure because of cgroup hierarchy
In-Reply-To: <20190912122948.GB7714@rei.lan>
References: <1560250815-2308-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5D2D681D.1050909@cn.fujitsu.com> <5D440CAA.9080701@cn.fujitsu.com>
 <5D6CC86E.5020009@cn.fujitsu.com> <20190911133315.GA21378@rei.lan>
 <5b2b7314-5d0a-1bc6-11ff-7088171b86e6@cn.fujitsu.com>
 <20190912122948.GB7714@rei.lan>
Message-ID: <7779df48-5b2e-4c4b-d5c8-081bb7fd3257@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/09/12 20:29, Cyril Hrubis wrote:

> Hi!
>>> I'm looking at the original reproducer at:
>>>
>>> https://lists.openvz.org/pipermail/devel/2009-January/016345.html
>>>
>>> And as far as I can tell the test_5() was never actually doing what it
>>> takes to reproduce the bug, as far as I can tell the test was bogus to
>>> begin with. The main point of the reproducer is that the cgroup is
>>> unmounted while there is task in the group, then remounted again. As we
>>> cannot unmount the cgroup these days I would just go for removing the
>>> test instead of applying band aid over the code.
>> Hi Cyril
>>
>> why we can't unmount the cgroup these days?
> It's a bit more complicated, you can't decide on which controllers to
> put into your hierarchy as it's mounted already (by a systemd). You can
> mount them exactly the way systemd mounts them (a few controllers are
> put into combined hierarchies but most of them are separated) but to a
> different mount point. Also once controller is in use in v2 it cannot be
> used by v1, which is going to be problem soon. As we are in transition
> period between v1 and v2 doing anything portable with cgroups is going
> to be nightmare.

Thanks. I understand it..

>
>>   From kernel commit 839ec545("cgroup: fix root_count when mount fails due to busy subsystem"),
>> it should be reproduced as the following step
>> 1)mount two subsystem(A and B) mntpoint
>> 2)mount one subsystem(A) mntpoint, it will get EBUSY error
>> 3)without kernel commit, kill this process and task is still in cgroup, kernel will call cgroup_kill_sb()
>> to decrement root_count, then kernel crashes.
>>
>> Is it right?
> This does not seem to match the original reproducer but it may be
> another way how to reproduce the bug. Also I'm not sure that this
> reproducer makes sense, since the code in kernel has been rewritten
> completely since the 2.6 days. Generally I would say that we may need
> completely new tests for cgroups, but I doubt that we should make much
> effort for the v1 anyways. In the v2 you get all controllers in an
> unified hierachy and you can't mount them in a different way.

Yes. cgroup v2 has only a single hierarchy, not promise to mount them in
a different way.

And test_5 is a very old regresstion test and kernel code has been rewritten completely since 2.6.
No user will use such old kernel code to test. I agree with you that we should remove this test_5.

>
> If the only point is to get EBUSY on mount, then have a process exit
> while in the cgroup we should as well simplify the test. There is no
> point in mounting the subsystems together in the first step, as a matter
> of fact on modern distributions the test just checks that the two
> subsystems are mounted already then attempts to mount them combined,
> which fails. Why can't we mount the two controllers seperatelly in the
> case that nothing is mounted as well.

It sounds reasonable, mount them seperatelly in the case should also be a right way to reproduce this bug.
But I run this test_5 and I nerver meet this crash on my machines with cgroup v1 (kernel with 2.6.32 3.10 and 4.18 kernel).
I think this test is too old that we shoud remove it.
  

>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190916/bcf7963d/attachment-0001.htm>
