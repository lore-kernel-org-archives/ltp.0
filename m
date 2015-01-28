Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YGUc2-00067p-Kv
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 15:33:02 +0000
Date: Wed, 28 Jan 2015 16:32:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150128153253.GA26681@rei.suse.de>
References: <1418377899-10697-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418377899-10697-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] power_management: add it into default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> * Modify Makefile.
> 
> * Split runpwtests.sh into separate testcases,
>   eg. runpwtests01.sh.
> 
> * Use functions in test.sh, eg. tst_brkm.
> 
> * Fix error of change_govr.sh, change_freq.sh, etc.
> 
> * Since I don't have suitable machines and can't test
>   some testcases' correctness, currently these cases
>   are disabled.

This patch does much more than just add these to default.

Can you please split it into several smaller changes? One would be the
change in the build system. One change to split the tests into several
testcases. And split the functional changes to the testcases to
separate patches with a clear description of the change.

> diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
> new file mode 100755
> index 0000000..0e5dd1c
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests01.sh
> @@ -0,0 +1,60 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management01"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_include.sh
> +
> +# Checking required kernel version and architecture
> +tst_kvercmp 2 6 21; rc=$?
> +if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> +	tst_brkm TCONF "Kernel version not supported; not running testcases"
> +else
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running testcases"
> +		;;
> +	esac
> +fi

This piece of code is copypasted into all the of the scripts, it should
be in a common library instead.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
