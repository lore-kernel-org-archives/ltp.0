From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 16 Nov 2020 14:46:35 +0000
Subject: [LTP] [PATCH] cpuset_regression_test: Fix for already existing
 cpusets
In-Reply-To: <a42725d1-1469-e71f-e28d-1eff42e3e86d@jv-coder.de>
References: <20191115101039.43386-1-lkml@jv-coder.de>
 <a42725d1-1469-e71f-e28d-1eff42e3e86d@jv-coder.de>
Message-ID: <87blfxpdf8.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
> a ping for this patch? Is something like that (workaround environment 
> issues) not wanted in ltp?

Generally speaking, yes, again you are right to bump it and these tests
are in need of more attention. However I have a couple of concerns about
this.

>
> Greets
> J?rg
>
> On 11/15/2019 11:10 AM, Joerg Vehlow wrote:
>> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>>
>> If there are already cpusets defined on the system, that use cpu 0-1,
>> the test fails, because it tries to exclusively use cpu 0-1 for the
>> testcase.
>>
>> The fix sets the cpuset for all cgroups to 0 and disables exclusive
>> cpu usage for the duration of the test and restores it on cleanup.
>> For the test only cpu 1 is set as exclusive. This is enough to
>> trigger the bug this regression test was designed for.
>> This was tested by reverting the commit mentioned in the testcase.

If the system has already set exclusive cpus then it is unlikely this
regression effects it. Either the kernel has been patched or the system
manager configures the cpus first before setting the exclusive knob.

Normally I would say the test should try to run anyway, but you are
having to make some intrusive changes to the cgroup setup which could
lead to other problems.

So why not just call 'tst_brk TCONF' if the system already has exclusive
cpus configured?

-- 
Thank you,
Richard.
