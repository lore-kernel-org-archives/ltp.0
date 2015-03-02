Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSRfK-0008Ta-VJ
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 14:49:50 +0000
Date: Mon, 2 Mar 2015 15:49:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302144908.GA27832@rei>
References: <1425024732-30751-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1425024732-30751-3-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1425024732-30751-3-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 3/9] power_management: split runpwtests.sh into
 separate testcases
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
> --- /dev/null
> +++ b/testcases/kernel/power_management/runpwtests01.sh
> @@ -0,0 +1,49 @@
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
> +# Checking test environment
> +check_kervel_arch
> +
> +# Checking sched_mc sysfs interface
> +multi_socket=$(is_multi_socket)
> +multi_core=$(is_multi_core)
> +if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> +	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
> +		"NOT set"
> +else
> +	if [ $multi_socket -ne 0 -a $multi_core -ne 0 ] ; then
> +		tst_brkm TCONF "sched_mc_power_savings interface in system" \
> +			"which is not a multi socket &(/) multi core"
> +	fi
> +fi
> +
> +if test_sched_mc.sh ; then

This script seems to be called only from this script. What is the point
of having it in a separate file?

And the same for the rest of the testcses.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
