From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Jul 2020 16:21:53 +0200
Subject: [LTP] [PATCH] cpuset_hotplug_test.sh: Fix a race condition
In-Reply-To: <20200716134939.tqxswbdd2lcpcwp3@e107158-lin.cambridge.arm.com>
References: <20200714152510.13470-1-qais.yousef@arm.com>
 <20200716060710.GA3812@dell5510>
 <20200716093316.re67arcm3tbxtwas@e107158-lin.cambridge.arm.com>
 <20200716095738.GA9395@dell5510>
 <20200716101250.vd7nan2u2nydzbnf@e107158-lin.cambridge.arm.com>
 <20200716120852.GA22657@dell5510>
 <20200716134939.tqxswbdd2lcpcwp3@e107158-lin.cambridge.arm.com>
Message-ID: <20200716142153.GA15980@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qais,

> > > Let me know what would be the preferred approach.
> > Just please try to send a patch using TST_RETRY_FUNC (thus you need to figure
> > out the verifier), or let us know and we either figure that or just simply use
> > your original patch.

> So I have cooked something quick but I either get

> 	/root/arm64-ltp/testcases/bin/cpuset_hotplug_test.sh: line 159: TST_RETRY_FUNC: command not found
I'm sorry, I have forgotten that the tests haven't been ported to the new API
yet (tst_test.sh). Thus, I'm ok to take the original patch, unless anybody
objects.

Why? Rewriting is going to be bigger task, as shell scripts has interdependencies,
thus turning cpuset_funcs.sh to use new API requires turning the other tests
which use it (it's not acceptable to load both legacy and new API in a test).
Besides new API needs to rename some functions (s/tst_resm/tst_res/, ... that's
easy task), but also works differently, so it's more work that renaming these
functions. Also tests need heavy cleanup (style is not optimal, using full path
like /bin/kill is ugly).

Although this should be done, the bigger problem is that these tests test just
cgroup v1 (and only early implementations, see notes about 2.6.29 in the code),
has other bugs than just one you spotted. There might be similar approach we
took with NUMA tests: shell tests are in maintenance mode and new tests are
written from the scratch in C.

BTW there is some support for cgroup in lib/tst_cgroup.c.

> or

> 	cpuset_hotplug_test 1 TBROK: Test /root/arm64-ltp/testcases/bin/cpuset_hotplug_test.sh must call tst_run!

> Depending whether I impost test.sh or tst_test.sh.

> It seems there's a dependency on the overall test construction depending on
> what file is imported. And one can import one or the other. It seems
> tst_test.sh is the legacy approach?
No, test.sh is the legacy one.
There is a docs for new API (C and shell), if you're interested.
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

> My WIP patch is attached in case there's somethign obvious to be done here that
> I missed.

> It looks like the current patch is the simplest thing to do otherwise? :-/
yes :).

Kind regards,
Petr
