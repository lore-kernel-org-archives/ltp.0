From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 4 Dec 2020 11:32:10 +0100
Subject: [LTP] [PATCH] cpuset_regression_test: Fix for already existing
 cpusets
In-Reply-To: <87blfxpdf8.fsf@suse.de>
References: <20191115101039.43386-1-lkml@jv-coder.de>
 <a42725d1-1469-e71f-e28d-1eff42e3e86d@jv-coder.de> <87blfxpdf8.fsf@suse.de>
Message-ID: <c9d59aa0-3589-0dff-8dc1-b4792b1bfaa6@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/16/2020 3:46 PM, Richard Palethorpe wrote:
> If the system has already set exclusive cpus then it is unlikely this
> regression effects it. Either the kernel has been patched or the system
> manager configures the cpus first before setting the exclusive knob.
Yes "either or". If the system manager or whatever configured the 
cgroups did it in the
"right" order, that cannot trigger the bug, we do not know, if the bug 
still exists.

> Normally I would say the test should try to run anyway, but you are
> having to make some intrusive changes to the cgroup setup which could
> lead to other problems.
>
> So why not just call 'tst_brk TCONF' if the system already has exclusive
> cpus configured?
The question is, should ltp try hard to run a test or not. You may be right,
that this could have other effects, but ltp tests can crash a system anyway,
so I wouldn't worry about that. Of course TCONF would be simpler, but it 
would
also skip the test...

Do you have a scenario in mind, where changing the cpusets could potentially
cause problems? This would require a system, where something meaningful is
running, that requires specific cpu time or a specific cpu. But if that 
would
be the case, all ltp tests could interfere with it right?

J?rg
