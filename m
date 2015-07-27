Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZJjiA-0003h8-Dt
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 14:49:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJji7-0002KY-WA
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 14:49:02 +0000
Date: Mon, 27 Jul 2015 16:48:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150727144844.GB15383@rei.suse.de>
References: <1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
	<1436958405-21403-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436958405-21403-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 2/2 v2] containers/netns tests rewritten
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> All original test cases in ltp/testcases/kernel/containers/netns
> were removed and replaced with the new ones. The new test cases
> cover all of the tests in the original code and everything else
> in the original code didn't exercise new code paths in the kernel.
> Mapping of old test cases to the new ones:
> 
> netns_crtchild -> netns_comm
> netns_two_children_ns -> netns_comm
> netns_crtchild_delchild -> netns_sysfs
> netns_par_chld_ipv6, netns_par_chld_ftp -> nets_comm (netns_comm
>     does not complicate it with sshd or ftp, it just tests
>     communication using ping/ping6)
> netns_devices, netns_devices2 -> netns_comm
> netns_isolation -> netns_breakns
> 
> New testcases also use the helper tools for creating and working
> with namespaces from ltp/testcases/kernel/containers/share.
> 
> diff --git a/runtest/containers b/runtest/containers
> index de4197e..2dee944 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -23,15 +23,24 @@ mqns_03_clone mqns_03 -clone
>  mqns_04 mqns_04
>  mqns_04_clone mqns_04 -clone
>  
> -netns_crtchild netns_crtchild
> -netns_two_children_ns netns_two_children_ns
> -netns_crtchild_delchild netns_crtchild_delchild
> -netns_par_chld_ipv6 netns_par_chld_ipv6
> -netns_par_chld_ftp netns_par_chld_ftp.sh
>  netns_netlink netns_netlink
> -netns_devices netns_devices.sh
> -netns_devices2 netns_devices2.sh
> -netns_isolation netns_isolation.sh
> +netns_breakns netns_breakns.sh ns_exec ipv4 netlink
> +netns_breakns netns_breakns.sh ns_exec ipv6 netlink
> +netns_breakns netns_breakns.sh ns_exec ipv4 ioctl
> +netns_breakns netns_breakns.sh ns_exec ipv6 ioctl
> +netns_breakns netns_breakns.sh ip ipv4 netlink
> +netns_breakns netns_breakns.sh ip ipv6 netlink
> +netns_breakns netns_breakns.sh ip ipv4 ioctl
> +netns_breakns netns_breakns.sh ip ipv6 ioctl
> +netns_comm netns_comm.sh ns_exec ipv4 netlink
> +netns_comm netns_comm.sh ns_exec ipv6 netlink
> +netns_comm netns_comm.sh ns_exec ipv4 ioctl
> +netns_comm netns_comm.sh ns_exec ipv6 ioctl
> +netns_comm netns_comm.sh ip ipv4 netlink
> +netns_comm netns_comm.sh ip ipv6 netlink
> +netns_comm netns_comm.sh ip ipv4 ioctl
> +netns_comm netns_comm.sh ip ipv6 ioctl
> +netns_sysfs netns_sysfs.sh

I'm really against having different testcases with the same name.

> diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
> new file mode 100755
> index 0000000..46d8ca3
> --- /dev/null
> +++ b/testcases/kernel/containers/netns/netns_breakns.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +#==============================================================================
> +# Copyright (c) 2015 Red Hat, Inc.
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of version 2 the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Written by Matus Marhefka <mmarhefk@redhat.com>
> +#
> +#==============================================================================
> +#
> +# SYNOPSIS:
> +# netns_breakns.sh <NS_EXEC_PROGRAM> <IP_VERSION> <COMM_TYPE>
> +#
> +# OPTIONS:
> +#	* NS_EXEC_PROGRAM (ns_exec|ip)
> +#		Program which will be used to enter and run other commands
> +#		inside a network namespace.
> +#	* IP_VERSION (ipv4|ipv6)
> +#		Version of IP. (ipv4|ipv6)
> +#	* COMM_TYPE (netlink|ioctl)
> +#		Communication type between kernel and user space
> +#		for basic setup: enabling and assigning IP addresses
> +#		to the virtual ethernet devices. (Uses 'ip' command for netlink
> +#		and 'ifconfig' for ioctl.)
> +#
> +# Tests communication with ip (uses netlink) and ifconfig (uses ioctl)
> +# over a device which is not visible from the current network namespace.
> +#
> +# There are two test cases which are trying to set an ip address on the veth1
> +# device which is not inside the network namespace referred to by NS_HANDLE0:
> +# 1. using netlink (ip command).
> +# 2. using ioctl (ifconfig command).
> +#==============================================================================
> +
> +TCID="netns_breakns"
> +TST_TOTAL=2
> +. netns_helper.sh
> +
> +# SETUP
> +netns_setup $1 $2 $3 "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
> +TCID="netns_breakns_$1_$2_$3"

Hmm, why don't we define the TCID="netns_breakns_$1_$2_$3" from the
start?

> +tst_resm TINFO "NS interaction: $1 | devices setup: $3"
> +
> +
> +# TEST CASE #1
> +$NS_EXEC $NS_HANDLE0 ip address add $IP1/$NETMASK dev veth1 2>/dev/null
> +if [ $? -ne 0 ]; then
> +	tst_resm TPASS "controlling device over netlink"
> +else
> +	tst_resm TFAIL "controlling device over netlink"
> +fi
> +
> +
> +# TEST CASE #2
> +tst_check_cmds ifconfig
> +$NS_EXEC $NS_HANDLE0 ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK 2>/dev/null
> +if [ $? -ne 0 ]; then
> +	tst_resm TPASS "controlling device over ioctl"
> +else
> +	tst_resm TFAIL "controlling device over ioctl"
> +fi
> +
> +
> +tst_exit

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
