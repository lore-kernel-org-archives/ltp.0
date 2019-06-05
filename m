From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Jun 2019 19:55:22 +0200
Subject: [LTP] [PATCH] commands: add test for chrt
In-Reply-To: <3e2f5f1b-3fb8-8c16-5c04-383221c175ed@linux.alibaba.com>
References: <3e2f5f1b-3fb8-8c16-5c04-383221c175ed@linux.alibaba.com>
Message-ID: <20190605175522.GA3188@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yihao,

thanks for your patch.

First question: shouldn't this test go to upstream, i.e. libcg [1]?

BTW there are cgroup related tests which needs to get updated and rewritten to
new API (testcases/kernel/controllers/cgroup*/).

> This test checks check whether chrt works properly

...
> +++ b/testcases/commands/chrt/Makefile
> @@ -0,0 +1,21 @@
> +#
> +# Copyright (c) 2019 Alibaba Inc
> +# Author: Yihao Wu <wuyihao@linux.alibaba.com>

> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +# the GNU General Public License for more details.
Remove this GNU license text and use just
# SPDX-License-Identifier: GPL-2.0-or-later

...
> +++ b/testcases/commands/chrt/chrt01.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +# Copyright (c) 2019 Alibaba Inc
> +# Author: Yihao Wu <wuyihao@linux.alibaba.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +# the GNU General Public License for more details.
The same here.

> +#
> +# Test the basic functionality of chrt command.
> +#
> +TST_TESTFUNC=chrt_test
> +TST_SETUP=setup
> +TST_CLEANUP=cleanup
> +TST_NEEDS_CMDS="chrt cgexec cgset cgget"
> +TST_NEEDS_ROOT=1
> +. tst_test.sh
> +
> +setup()
> +{
> +	old_rt_runtime_us=$(cgget -r cpu.rt_runtime_us / -vn)
> +	old_rt_period_us=$(cgget -r cpu.rt_period_us / -vn)
> +
> +	cgset -r cpu.rt_runtime_us=10000 /
> +	cgset -r cpu.rt_period_us=1000000 /
> +}
> +
> +chrt_test()
> +{
> +	cgexec -g cpu:/ -g cpuset:/ sleep 4 &
> +	PID=$!
> +	cgexec -g cpu:/ -g cpuset:/ chrt -arp 50 ${PID}
> +	SCHEDULER=$(chrt -p ${PID} | awk 'NR==1{print $6}')
> +	if [ x"${SCHEDULER}" == x"SCHED_RR" ]; then
Some basic rules for shell tests [2] are to check code on checkbashism.pl script or
on /bin/sh linked as dash.
=> if [ "$scheduler"  = "$sched_rr" ]; then

> +		tst_res TPASS "'chrt' passed."
> +	else
> +		tst_res TFAIL "'chrt' failed to set scheduling policy."
> +	fi
> +}

Then, using local for local variables and lower case for local variables
(preferably also for global variables, upper case are usually variables from
shell libraries) =>
local pid
local scheduler

> +
> +cleanup()
> +{
> +	cgset -r cpu.rt_runtime_us=${old_rt_runtime_us} /
> +	cgset -r cpu.rt_period_us=${old_rt_period_us} /
I get
cgset: wrong parameter of option -r: cpu.rt_runtime_us
cgset: wrong parameter of option -r: cpu.rt_period_us

Kind regards,
Petr

> +}
> +
> +tst_run

[1] http://libcg.sourceforge.net/
[2] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell
