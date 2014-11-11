Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XoB6D-0002v3-55
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 13:03:09 +0000
Date: Tue, 11 Nov 2014 14:02:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111130228.GC29189@rei>
References: <1415251889-10596-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1415687896-19753-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415687896-19753-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] containers: fix three cases' exit status
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
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/containers/netns/netns_devices.sh |  5 +++
>  .../kernel/containers/netns/netns_devices2.sh      |  5 +++
>  testcases/kernel/containers/netns/netns_helper.sh  | 45 ++++++++++++++++++++++
>  .../kernel/containers/netns/netns_isolation.sh     |  5 +++
>  4 files changed, 60 insertions(+)
>  create mode 100755 testcases/kernel/containers/netns/netns_helper.sh
> 
> diff --git a/testcases/kernel/containers/netns/netns_devices.sh b/testcases/kernel/containers/netns/netns_devices.sh
> index 7126267..01f7056 100755
> --- a/testcases/kernel/containers/netns/netns_devices.sh
> +++ b/testcases/kernel/containers/netns/netns_devices.sh
> @@ -29,6 +29,7 @@
>  TCID=netns_devices
>  TST_TOTAL=3
>  . test.sh
> +. netns_helper.sh
>  IP0=192.168.0.1
>  IP1=192.168.0.2
>  
> @@ -46,6 +47,10 @@ cleanup()
>  # SETUP
>  tst_require_root
>  tst_check_cmds ip
> +tst_check_iproute 111010
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF "ip command does not support netns object"
> +fi
>  TST_CLEANUP=cleanup
>  
>  # creates a new network namespace "myns0" (man 8 ip-netns)
> diff --git a/testcases/kernel/containers/netns/netns_devices2.sh b/testcases/kernel/containers/netns/netns_devices2.sh
> index f0d0651..3fc38b5 100755
> --- a/testcases/kernel/containers/netns/netns_devices2.sh
> +++ b/testcases/kernel/containers/netns/netns_devices2.sh
> @@ -29,6 +29,7 @@
>  TCID=netns_devices2
>  TST_TOTAL=3
>  . test.sh
> +. netns_helper.sh
>  IP0=192.168.0.1
>  IP1=192.168.0.2
>  
> @@ -46,6 +47,10 @@ cleanup()
>  # SETUP
>  tst_require_root
>  tst_check_cmds ip ifconfig
> +tst_check_iproute 111010
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF "ip command does not support netns object"
> +fi
>  TST_CLEANUP=cleanup
>  
>  # creates a new network namespace "myns0" (man 8 ip-netns)
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> new file mode 100755
> index 0000000..401b795
> --- /dev/null
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +#
> +# Copyright (c) Linux Test Project, 2014
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# This is a LTP shell test library for iproute.
> +#
> +
> +. test.sh
> +
> +# Check whether the current iproute version matches specified
> +# iproute. It returns 0, 1, or 2 if cur_ipver is found, to be
> +# less than, to match, or be greater than spe_ipver.
> +tst_check_iproute()
> +{

Hmm, we may also want to move the tst_check_cmds ip here
so we don't have to do that in all of the testcases.

> +	local cur_ipver=`ip -V`
> +	local spe_ipver=$1
> +
> +	cur_ipver=${cur_ipver##*s}
> +
> +	if [ -z $cur_ipver ] || [ -z $spe_ipver ]; then
> +		tst_brkm TBROK "don't obtain valid iproute version"
> +	fi
> +
> +	if [ $cur_ipver -lt $spe_ipver ]; then

Why don't we just do:

	tst_brkm TCONF "ip command does not support netns object"

here instead of returning some exit value?

Then we could just do:

	tst_check_iproute 111010

in the testcases.

> +		return 0;
> +	elif [ $cur_ipver -eq $spe_ipver ]; then
> +		return 1;
> +	else
> +		return 2;
> +	fi
> +}
> diff --git a/testcases/kernel/containers/netns/netns_isolation.sh b/testcases/kernel/containers/netns/netns_isolation.sh
> index f1ddf2c..06e91db 100755
> --- a/testcases/kernel/containers/netns/netns_isolation.sh
> +++ b/testcases/kernel/containers/netns/netns_isolation.sh
> @@ -24,6 +24,7 @@
>  TCID=netns_isolation
>  TST_TOTAL=3
>  . test.sh
> +. netns_helper.sh
>  IP=192.168.0.2
>  
>  
> @@ -40,6 +41,10 @@ cleanup()
>  # SETUP
>  tst_require_root
>  tst_check_cmds ip
> +tst_check_iproute 111010
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF "ip command does not support netns object"
> +fi
>  TST_CLEANUP=cleanup
>  
>  
> -- 
> 1.9.3
> 
> 
> ------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
