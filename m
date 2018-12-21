From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 21 Dec 2018 15:36:28 +0000
Subject: [LTP] [PATCH v2 0/4]  cgroup tests newlib-porting
In-Reply-To: <20181221133904.GA27446@dell5510>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181221133904.GA27446@dell5510>
Message-ID: <6645abe6-4ab0-a1b2-6351-41325eff720b@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 21/12/2018 13:39, Petr Vorel wrote:
> Hi Cristian,
> 
> thanks for your work, good work. I have some comments bellow.

Thanks for you review.

> 
>> This series converts cgroup/ regression tests to LTP newlib and performs
>> a general cleanup as follows:
> 
>> - remove bashism from all tests' scripts
>> - mostly remove usage of global vars
>> - convert to SPDX headers
> You left big copyright in cpuacct.sh.

In this patch I have NOT touched anything else than the content of
testcases/kernel/controllers/cgroup which are files related to the
cgroup_regression_test.sh testcase; the file you mentioned is in
testcases/kernel/controllers/cpuacct/ ... am I missing something ?

> 
>> - expose a controllers' common /proc/mounts parsing function
>> - rename tests' helpers prefixing them with a test-specific tag to avoid
>>   name clashes on install: I have not renamed the tests' helpers using
>>   more specific meaningful name, since all of them performs really
>>   trivial ops needed and meaningful in the context of the regression-test
>>   subcase they serve; so I thought it would have been better to keep their
>>   names as they are now, bound to the subcase they help.
> 
>> Cristian Marussi (4):
>>   [LTP] cgroup_regression_test.sh ported to newlib
>>   [LTP] cgroup_regression_test.sh cleanup
>>   [LTP] cgroup_regression_test.sh: added helper
>>   [LTP] cgroup: helpers various fixes
> 
> Can you please squash it into single commit?
> Or in two (first cleanup & rewrite of group_regression_test.sh, second for
> helpers). It does not bring much to split it like this.

Ok I'll squash..I splitted thinking it could have been complained of being not
splitted :D

> 
> I guess fork_processes.c and getdelays.c can be using new C API as well.
> You don't have to do it, but it can bring benefits (using tst_res(), info about
> command).

I'll review those too...I focused only on the shell-scripts logic ... not sure
why in fact.


> 
> During cleanup please delete useless comments (getdelays.c: Compile with ...).
> I personally take SPDX license as sign that test has been cleanup from bad code
> and useless comments and ported into new API.
> 

ok

> NOTE: you can add your copyright to the files.
> 
> Kind regards,
> Petr
> 

Regards

Cristian
