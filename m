From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 21 Dec 2018 18:23:54 +0000
Subject: [LTP] [PATCH v2 0/4]  cgroup tests newlib-porting
In-Reply-To: <20181221154744.GA13971@dell5510>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
 <20181221133904.GA27446@dell5510>
 <6645abe6-4ab0-a1b2-6351-41325eff720b@arm.com>
 <20181221154744.GA13971@dell5510>
Message-ID: <2c88fa9c-c98a-557f-e5f1-5a84b7f7fdfd@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 21/12/2018 15:47, Petr Vorel wrote:
> Hi Cristian,
> 
>>> You left big copyright in cpuacct.sh.
>> In this patch I have NOT touched anything else than the content of
>> testcases/kernel/controllers/cgroup which are files related to the
>> cgroup_regression_test.sh testcase; the file you mentioned is in
>> testcases/kernel/controllers/cpuacct/ ... am I missing something ?
> Sorry, I was wrong.
> 
> 
>>> Can you please squash it into single commit?
>>> Or in two (first cleanup & rewrite of group_regression_test.sh, second for
>>> helpers). It does not bring much to split it like this.
> 
>> Ok I'll squash..I splitted thinking it could have been complained of being not
>> splitted :D
> For small changes we like to have it atomic (split), but rewrite is IMHO better
> do it in one commit or two (group_regression_test.sh and then the rest - that's
> up to you). I focus too much on details for tests which are for very old kernel.
> 
> 
>>> I guess fork_processes.c and getdelays.c can be using new C API as well.
>>> You don't have to do it, but it can bring benefits (using tst_res(), info about
>>> command).
> 
>> I'll review those too...I focused only on the shell-scripts logic ... not sure
>> why in fact.
> I'd prefer to convert it to new C API or leave it as they are.

I removed usage/references of the old API from fork_processes while getdelay it
was completely unrelated from LTP API; in fact both are helpers launched by the
LTP test scripts merely as background processes without any direct feedback
reported to the testcase caller.

How could I use the new C API in this case ?

Regards

Cristian

> 
> 
> Kind regards,
> Petr
> 

