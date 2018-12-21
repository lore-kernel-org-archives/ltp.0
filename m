From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Dec 2018 14:39:04 +0100
Subject: [LTP] [PATCH v2 0/4]  cgroup tests newlib-porting
In-Reply-To: <20181220182149.48326-1-cristian.marussi@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
Message-ID: <20181221133904.GA27446@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

thanks for your work, good work. I have some comments bellow.

> This series converts cgroup/ regression tests to LTP newlib and performs
> a general cleanup as follows:

> - remove bashism from all tests' scripts
> - mostly remove usage of global vars
> - convert to SPDX headers
You left big copyright in cpuacct.sh.

> - expose a controllers' common /proc/mounts parsing function
> - rename tests' helpers prefixing them with a test-specific tag to avoid
>   name clashes on install: I have not renamed the tests' helpers using
>   more specific meaningful name, since all of them performs really
>   trivial ops needed and meaningful in the context of the regression-test
>   subcase they serve; so I thought it would have been better to keep their
>   names as they are now, bound to the subcase they help.

> Cristian Marussi (4):
>   [LTP] cgroup_regression_test.sh ported to newlib
>   [LTP] cgroup_regression_test.sh cleanup
>   [LTP] cgroup_regression_test.sh: added helper
>   [LTP] cgroup: helpers various fixes

Can you please squash it into single commit?
Or in two (first cleanup & rewrite of group_regression_test.sh, second for
helpers). It does not bring much to split it like this.

I guess fork_processes.c and getdelays.c can be using new C API as well.
You don't have to do it, but it can bring benefits (using tst_res(), info about
command).

During cleanup please delete useless comments (getdelays.c: Compile with ...).
I personally take SPDX license as sign that test has been cleanup from bad code
and useless comments and ported into new API.

NOTE: you can add your copyright to the files.

Kind regards,
Petr
