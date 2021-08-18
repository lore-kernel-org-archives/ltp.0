From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 18 Aug 2021 11:32:59 +0200
Subject: [LTP] [PATCH 3/3] commands: Drop which01.sh
In-Reply-To: <20210818091224.27578-4-pvorel@suse.cz>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-4-pvorel@suse.cz>
Message-ID: <8589e81b-4c45-e62e-297a-ef6a3cd548dc@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 8/18/2021 11:12 AM, Petr Vorel wrote:
> "which" has been discontinued after 2.21 release in 2015 due this (git
> repository is empty [1]).
I am a bit against dropping this. which is widely used and I think as 
long as it is available, it should behave as expected.

Joerg

>
> [1] https://git.savannah.gnu.org/cgit/which.git
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   runtest/commands                    |   1 -
>   testcases/commands/which/Makefile   |  11 ---
>   testcases/commands/which/which01.sh | 107 ----------------------------
>   3 files changed, 119 deletions(-)
>   delete mode 100644 testcases/commands/which/Makefile
>   delete mode 100755 testcases/commands/which/which01.sh
>
> diff --git a/runtest/commands b/runtest/commands
> index 8cfad0449..fc5c86684 100644
> --- a/runtest/commands
> +++ b/runtest/commands
> @@ -32,7 +32,6 @@ mkfs01_msdos_sh mkfs01.sh -f msdos
>   mkfs01_vfat_sh mkfs01.sh -f vfat
>   mkfs01_ntfs_sh mkfs01.sh -f ntfs
>   mkswap01_sh mkswap01.sh
> -which01_sh which01.sh
>   lsmod01_sh lsmod01.sh
>   insmod01_sh insmod01.sh
>   wc01_sh wc01.sh
> diff --git a/testcases/commands/which/Makefile b/testcases/commands/which/Makefile
> deleted file mode 100644
> index 1be02f7d7..000000000
> --- a/testcases/commands/which/Makefile
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2015 Fujitsu Ltd.
> -# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> -
> -top_srcdir		?= ../../..
> -
> -include $(top_srcdir)/include/mk/env_pre.mk
> -
> -INSTALL_TARGETS		:= which01.sh
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
> deleted file mode 100755
> index dd6659ea0..000000000
> --- a/testcases/commands/which/which01.sh
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2015 Fujitsu Ltd.
> -# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> -#
> -# Test which command with some basic options.
> -
> -TST_CNT=10
> -TST_SETUP=setup
> -TST_TESTFUNC=do_test
> -TST_NEEDS_TMPDIR=1
> -TST_NEEDS_CMDS="which"
> -. tst_test.sh
> -
> -setup()
> -{
> -	touch pname
> -	chmod +x pname
> -	PATH=$PATH:.
> -
> -	mkdir bin
> -	touch bin/pname
> -	chmod +x bin/pname
> -	PATH=$PATH:./bin
> -
> -	alias pname='pname -i'
> -}
> -
> -which_verify()
> -{
> -	local IFS i j
> -	IFS="$IFS_FIRST_LEVEL"
> -	for i in $1; do
> -		found="no"
> -		IFS="$IFS_SECOND_LEVEL"
> -		for j in $i; do
> -			if grep -F -q "$j" temp; then
> -				found="yes"
> -			fi
> -		done
> -		if [ "$found" != "yes" ]; then
> -			echo "'$i' not found in:"
> -			cat temp
> -			echo
> -			return 1
> -		fi
> -	done
> -}
> -
> -which_test()
> -{
> -	local which_op=$1
> -	local prog_name=$2
> -
> -	local which_cmd="which $which_op $prog_name"
> -
> -	if [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ] || \
> -		[ "$which_op" = "--skip-alias" ]; then
> -		which_cmd="alias | $which_cmd"
> -	fi
> -
> -	eval ${which_cmd} >temp 2>&1
> -	if [ $? -ne 0 ]; then
> -		grep -q -E "unknown option|invalid option|Usage" temp
> -		if [ $? -eq 0 ]; then
> -			tst_res TCONF "'${which_cmd}' not supported."
> -			return
> -		fi
> -
> -		tst_res TFAIL "'${which_cmd}' failed."
> -		cat temp
> -		return
> -	fi
> -
> -	if [ $# -gt 2 ]; then
> -		shift 2
> -		which_verify "$@"
> -		if [ $? -ne 0 ]; then
> -			tst_res TFAIL "'${which_cmd}' failed, not expected."
> -			return
> -		fi
> -	fi
> -
> -	tst_res TPASS "'${which_cmd}' passed."
> -}
> -
> -IFS_FIRST_LEVEL='^'
> -IFS_SECOND_LEVEL='|'
> -do_test()
> -{
> -	case $1 in
> -	1) which_test "" "pname" "$PWD/pname|./pname";;
> -	2) which_test "-all" "pname" "$PWD/bin/pname|./bin/pname^$PWD/pname|./pname";;
> -	3) which_test "-a" "pname" "$PWD/bin/pname|./bin/pname^$PWD/pname|./pname";;
> -	4) which_test "--read-alias" "pname" "pname='pname -i'^$PWD/pname";;
> -	5) which_test "-i" "pname" "pname='pname -i'^$PWD/pname";;
> -	6) alias which='which --read-alias';
> -	   which_test "--skip-alias" "pname" "$PWD/pname";
> -	   unalias which;;
> -	7) which_test "--version";;
> -	8) which_test "-v";;
> -	9) which_test "-V";;
> -	10) which_test "--help";;
> -	esac
> -}
> -
> -tst_run

