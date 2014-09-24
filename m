Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWj2T-0006F8-B3
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 09:39:09 +0000
Date: Wed, 24 Sep 2014 11:38:49 +0200
From: chrubis@suse.cz
Message-ID: <20140924093849.GE10825@rei>
References: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
	<1409834607-22143-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409834607-22143-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH v3] containers: added netns/netns_devices.sh and
 netns/netns_devices2.sh
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
> +# creates a pair of virtual ethernet devices
> +ip link add veth0 type veth peer name veth1 &>/dev/null || \
> +	tst_brkm TBROK "unable to create veth pair devices"

The &> operator is bashism and the testcases should be runable with
other shells too. Generally it's a good idea to try to run them with
dash or bussy box sh before submission.

And also I'm not 100% sure that it's a good idea to hide the nature of
the problem. Are these commands too verbose by default?

> +# creates a new network namespace "myns" (man 8 ip-netns)
> +ip netns add myns &>/dev/null || \
> +	tst_brkm TBROK "unable to create a new network namespace"
> +
> +# adds device veth1 to myns namespace
> +ip link set veth1 netns myns &>/dev/null || \
> +	tst_brkm TBROK "unable to add device veth1 to the network namespace myns"
> +
> +
> +# TEST CASE #1
> +# setup for veth0 device
> +ip address add $IP0/24 dev veth0 || \
> +	tst_brkm TBROK "adding address to veth0 failed"
> +ip link set dev veth0 up || \
> +	tst_brkm TBROK "enabling veth0 device failed"
> +
> +# setup for veth1 (which is inside myns namespace)
> +ip netns exec myns ip address add $IP1/24 dev veth1 || \
> +	tst_brkm TBROK "adding address to veth1 failed"
> +ip netns exec myns ip link set dev veth1 up || \
> +	tst_brkm TBROK "enabling veth1 device failed"
> +
> +ping -q -c 2 -I veth0 $IP1 &>/dev/null
> +ret=$?
> +failed=0
> +if [ $ret -ne 0 ]; then
> +	failed=1
> +fi
> +
> +ip netns exec myns ping -q -c 2 -I veth1 $IP0 &>/dev/null
> +ret=$?
> +if [ $ret -ne 0 ]; then
> +	failed=1
> +fi

It would be cleaner to do tst_resm in both cases and declare that the
test has three testcases.

> +if [ $failed -eq 0 ]; then
> +	tst_resm TPASS "netlink configuration and communication over veth devices"
> +else
> +	tst_resm TFAIL "netlink configuration and communication over veth devices"
> +fi
> +
> +
> +# TEST CASE #2
> +# enables lo device
> +ip netns exec myns ip link set dev lo up || \
> +	tst_brkm TBROK "enabling lo device failed"
> +
> +ip netns exec myns ping -q -c 2 -I lo 127.0.0.1 &>/dev/null
> +ret=$?
> +if [ $ret -eq 0 ]; then
> +	tst_resm TPASS "netlink configuration and communication over lo device"
> +else
> +	tst_resm TFAIL "netlink configuration and communication over lo device"
> +fi
> +
> +
> +tst_exit
> diff --git a/testcases/kernel/containers/netns/netns_devices2.sh b/testcases/kernel/containers/netns/netns_devices2.sh
> new file mode 100755
> index 0000000..ed3f5eb
> --- /dev/null
> +++ b/testcases/kernel/containers/netns/netns_devices2.sh
> @@ -0,0 +1,110 @@
> +#!/bin/sh
> +#==============================================================================
> +# Copyright (c) 2014 Red Hat, Inc.
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
> +#==============================================================================
> +# File: netns_devices2.sh
> +#
> +# Tests that a separate network namespace can configure and communicate
> +# over the devices it sees. Tests are done using ifconfig command which
> +# uses ioctl(2) to control devices. There are two test cases:
> +# 1. communication over paired veth (virtual ethernet) devices
> +#    from two different network namespaces (each namespace has
> +#    one device)
> +# 2. communication over the lo (localhost) device in a separate
> +#    network namespace
> +#
> +
> +TCID=netns_devices2
> +TST_TOTAL=2
> +. test.sh
> +IP0=192.168.0.1
> +IP1=192.168.0.2
> +
> +
> +cleanup()
> +{
> +	# removes veth0 device (which also removes paired veth1 device)
> +	ip link delete veth0
> +	# removes the network namespace myns
> +	ip netns del myns
> +}
> +
> +
> +# SETUP
> +tst_require_root
> +tst_check_cmds ip ifconfig
> +TST_CLEANUP=cleanup
> +
> +# creates a pair of virtual ethernet devices
> +ip link add veth0 type veth peer name veth1 &>/dev/null || \
> +	tst_brkm TBROK "unable to create veth pair devices"
> +
> +# creates a new network namespace "myns" (man 8 ip-netns)
> +ip netns add myns &>/dev/null || \
> +	tst_brkm TBROK "unable to create a new network namespace"
> +
> +# adds device veth1 to myns namespace
> +ip link set veth1 netns myns &>/dev/null || \
> +	tst_brkm TBROK "unable to add device veth1 to the network namespace myns"

Here the &>/dev/null as well.

> +# TEST CASE #1
> +# setup for veth0 device
> +ifconfig veth0 $IP0/24 || \
> +	tst_brkm TBROK "adding address to veth0 failed"
> +ifconfig veth0 up || \
> +	tst_brkm TBROK "enabling veth0 device failed"
> +
> +# setup for veth1 (which is inside myns namespace)
> +ip netns exec myns ifconfig veth1 $IP1/24 || \
> +	tst_brkm TBROK "adding address to veth1 failed"
> +ip netns exec myns ifconfig veth1 up || \
> +	tst_brkm TBROK "enabling veth1 device failed"
> +
> +ping -q -c 2 -I veth0 $IP1 &>/dev/null
> +ret=$?
> +failed=0
> +if [ $ret -ne 0 ]; then
> +	failed=1
> +fi
> +
> +ip netns exec myns ping -q -c 2 -I veth1 $IP0 &>/dev/null
> +ret=$?
> +if [ $ret -ne 0 ]; then
> +	failed=1
> +fi
> +
> +if [ $failed -eq 0 ]; then
> +	tst_resm TPASS "ioctl configuration and communication over veth devices"
> +else
> +	tst_resm TFAIL "ioctl configuration and communication over veth devices"
> +fi

Here the same applies as well.

> +# TEST CASE #2
> +# enables lo device
> +ip netns exec myns ifconfig lo up || \
> +	tst_brkm TBROK "enabling lo device failed"
> +
> +ip netns exec myns ping -q -c 2 -I lo 127.0.0.1 &>/dev/null
> +ret=$?
> +if [ $ret -eq 0 ]; then
> +	tst_resm TPASS "ioctl configuration and communication over lo device"
> +else
> +	tst_resm TFAIL "ioctl configuration and communication over lo device"
> +fi
> +
> +
> +tst_exit

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
