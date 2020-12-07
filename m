From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 07 Dec 2020 10:41:33 +0000
Subject: [LTP] [PATCH] cpuset_regression_test: Fix for already existing
 cpusets
In-Reply-To: <c9d59aa0-3589-0dff-8dc1-b4792b1bfaa6@jv-coder.de>
References: <20191115101039.43386-1-lkml@jv-coder.de>
 <a42725d1-1469-e71f-e28d-1eff42e3e86d@jv-coder.de>
 <87blfxpdf8.fsf@suse.de>
 <c9d59aa0-3589-0dff-8dc1-b4792b1bfaa6@jv-coder.de>
Message-ID: <877dptj3tu.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
> On 11/16/2020 3:46 PM, Richard Palethorpe wrote:
>> If the system has already set exclusive cpus then it is unlikely this
>> regression effects it. Either the kernel has been patched or the system
>> manager configures the cpus first before setting the exclusive knob.
> Yes "either or". If the system manager or whatever configured the
> cgroups did it in the
> "right" order, that cannot trigger the bug, we do not know, if the bug
> still exists.

Yes and this is why I would normally say we should still try to find the
bug.

>
>> Normally I would say the test should try to run anyway, but you are
>> having to make some intrusive changes to the cgroup setup which could
>> lead to other problems.
>>
>> So why not just call 'tst_brk TCONF' if the system already has exclusive
>> cpus configured?
> The question is, should ltp try hard to run a test or not. You may be right,
> that this could have other effects, but ltp tests can crash a system anyway,
> so I wouldn't worry about that. Of course TCONF would be simpler, but
> it would
> also skip the test...

In general we have the rule that tests should try to leave the system in
a working state. Sometimes that is not possible, but that is usually
only if a test triggers a serious issue.

>
> Do you have a scenario in mind, where changing the cpusets could potentially
> cause problems? This would require a system, where something meaningful is
> running, that requires specific cpu time or a specific cpu. But if
> that would
> be the case, all ltp tests could interfere with it right?
>
> J?rg

If we assume there is a good reason for having exclusive cpusets, even
if we don't know that reason, then we can't just remove them and expect
the system to continue working. Possibly it will even cause errors in
later unrelated tests and it will take some time for somebody to figure
out that it is due to a process running on the wrong CPU.

I assume that if a particular CGroup has exclusive CPU access then
processes in the root CGroup will not run in it. However if they do then
the user may run LTP tests in a leaf CGroup. So you can't assume all
tests would break such a system.

OTOH TCONF is often ignored, but this seems like quite a small and
tricky corner case that we are adding complexity for.

-- 
Thank you,
Richard.
