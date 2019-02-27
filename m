From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Feb 2019 12:10:55 +0100
Subject: [LTP] [PATCH 1/1] cgroup_regression_test.sh: Fix TWARN usage
In-Reply-To: <20f5a19b-dffc-d01f-0e57-36c01cad7fa8@arm.com>
References: <20190215145239.51806-1-cristian.marussi@arm.com>
 <20190215145239.51806-2-cristian.marussi@arm.com>
 <20190226184228.GA1113@dell5510>
 <20f5a19b-dffc-d01f-0e57-36c01cad7fa8@arm.com>
Message-ID: <20190227111055.GA19218@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

...
> >> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> >> @@ -408,7 +408,7 @@ test_7_2()

> >>  	grep -q -w "cpu" /proc/cgroups
> >>  	if [ $? -ne 0 -o ! -e /proc/sched_debug ]; then
> >> -		tst_res TWARN "skip rest of testing due possible oops triggered by reading /proc/sched_debug"
> >> +		tst_res TCONF "skip rest of testing due possible oops triggered by reading /proc/sched_debug"
> > Right, TWARN is not good (IMHO TWARN is not popular in LTP testsuites due marking test failing),
> > but if you don't mind I'd merge it with TBROK (more appropriate in this case).

> mmm...I'm NOT so sure that a FAIL should be the outcome here ... we are skipping
> if cpu is not amongst cgroups or sched_debug is NOT available...BUT at this
> point we have run (or skipped) 7 tests so far and there are 3 more to go...so
> why can't we just TCONF ?
OK I got that :) /proc/sched_debug is enabled by CONFIG_SCHED_DEBUG, os it's
kind of configuration issue. Before I thought that failing "grep -q -w "cpu"
/proc/cgroups" means failure/bug found by test, but it's not.

So I'm ok with this change.
Acked-by: Petr Vorel <pvorel@suse.cz>

> (beside the fact that as I said in the cover-letter one TCONF will lead to the
> whole 10-subtest croup suite to be reported as TCONF...)
IMHO that's not true (see my reply to cover letter).

Kind regards,
Petr
