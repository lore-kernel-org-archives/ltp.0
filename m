From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 14 Mar 2018 09:26:29 +0800
Subject: [LTP] [PATCH v2] commands/sysctl: Add new regression test for
 invalid sched_time_avg
In-Reply-To: <1520397350-28216-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180306124242.GC16934@rei.lan>
 <1520397350-28216-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <5AA87A45.6070201@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Could you help me review the v2 patch? :-)

Thanks,
Xiao Yang
On 2018/03/07 12:35, Xiao Yang wrote:
> The kernel bug has been fixed in kernel:
> '5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  runtest/commands                      |  1 +
>  testcases/commands/sysctl/Makefile    | 25 +++++++++++++++
>  testcases/commands/sysctl/sysctl01.sh | 58 +++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)
>  create mode 100644 testcases/commands/sysctl/Makefile
>  create mode 100755 testcases/commands/sysctl/sysctl01.sh
>
> diff --git a/runtest/commands b/runtest/commands
> index 92df3af..fde8063 100644
> --- a/runtest/commands
> +++ b/runtest/commands
> @@ -44,3 +44,4 @@ wc01 wc01.sh
>  keyctl01 keyctl01.sh
>  gdb01 gdb01.sh
>  unshare01 unshare01.sh
> +sysctl01 sysctl01.sh
> diff --git a/testcases/commands/sysctl/Makefile b/testcases/commands/sysctl/Makefile
> new file mode 100644
> index 0000000..61ff705
> --- /dev/null
> +++ b/testcases/commands/sysctl/Makefile
> @@ -0,0 +1,25 @@
> +#
> +# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
> +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> +# General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS		:= *.sh
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
> new file mode 100755
> index 0000000..6fa5a02
> --- /dev/null
> +++ b/testcases/commands/sysctl/sysctl01.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
> +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +#
> +# Description:
> +# This is a regression test for invalid value of sysctl_sched_time_avg.
> +# System will hang if user set sysctl_sched_time_avg to 0 on buggy kernel.
> +#
> +# The kernel bug has been fixed in kernel:
> +# '5ccba44ba118("sched/sysctl: Check user input value of sysctl_sched_time_avg")'
> +
> +TST_TESTFUNC=sysctl_test
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="sysctl"
> +
> +. tst_test.sh
> +
> +sysctl_test()
> +{
> +	# With commit d00535d, sched_time_avg was renamed as sched_time_avg_ms
> +	local dir="/proc/sys/kernel/"
> +	[ -e "$dir""sched_time_avg_ms" ] && local name="sched_time_avg_ms"
> +	[ -e "$dir""sched_time_avg" ] && local name="sched_time_avg"
> +	[ -z "$name" ] && tst_brk TCONF \
> +		"sched_time_avg(_ms) was not supported"
> +
> +	local orig_value=$(cat "$dir""$name")
> +
> +	sysctl -w "kernel.""$name"=0 >/dev/null 2>&1
> +
> +	# Increase the chance of exposing the problem on RHEL6
> +	sleep 3
> +
> +	local test_value=$(cat "$dir""$name")
> +
> +	if [ ${test_value} -eq ${orig_value} ]; then
> +		tst_res TPASS "Setting $name failed"
> +	else
> +		tst_res TFAIL "Setting $name succeeded"
> +		sysctl -w "kernel.""$name"=${orig_value} >/dev/null 2>&1
> +	fi
> +}
> +
> +tst_run



