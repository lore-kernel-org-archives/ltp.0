Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YO7tV-0002jB-5X
	for ltp-list@lists.sourceforge.net; Wed, 18 Feb 2015 16:54:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YO7tU-00073g-1V
	for ltp-list@lists.sourceforge.net; Wed, 18 Feb 2015 16:54:37 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1IGsTRb019800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 11:54:29 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t1IGsSGC020763
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 11:54:28 -0500
Message-ID: <54E4C3C3.6080407@redhat.com>
Date: Wed, 18 Feb 2015 17:54:27 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
In-Reply-To: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] network namespaces tests cleanup
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
To: ltp-list@lists.sourceforge.net

On 02/10/2015 04:17 PM, Matus Marhefka wrote:
> As network namespaces tests (ltp/testcases/kernel/containers/netns) code is
> a bit messy and it's hard to figure out how return values are passed in the code
> I propose to remove all test cases and leave only the ones specified below.

Just few notes about history / backwards compatibility; the proposed
replacements are not exactly true replacements for the original code
regarding kernel/userspace requirements.

2002: (pre-git) Linux namespaces support in the kernel
2007/09: kernel supports moving interfaces between network namespaces
2008/06: 'ip link .. netns <pid>' support in iproute2
2010/03: /proc/<pid>/ns/* support in the kernel
2011/05: /proc/<pid>/ns/* usable as file descriptors (mountable)
2011/07: 'ip netns' support in iproute2, incl. 'ip link .. netns <file>'

The point being how far are you willing to go to preserve the
functionality on older kernels/userspace.

The proposed code uses /proc/<pid>/ns/* as file descriptors, so it needs
at least 2.6.39 kernel and related iproute version or /usr/include
recent enough to have IFLA_NET_NS_FD (so you can write your own netlink
setup utility).

The original code uses only fork/clone as far as I see, so it goes much
more "back" in terms of compatibility, quite likely at the cost of
readability, though. The bash portions of the original code use iproute2
with 'netns <pid>' only, so their compatibility goes as back as 2008.

The ultimate question is therefore "are we willing to TCONF the new
tests on anything older than (upstream) 2.6.39?".

Some (most?) enterprise distributions may have the functionality
backported, for example RHEL-6.6 fully supports mounting
/proc/<pid>/ns/* and even has util-linux support (like nsenter(1)) for
the mounted file descriptors. It is, however, missing any 'ip netns'
support as well as 'ip link .. netns <file>' (supports only pid).

What about others?

# kernel fd (setns(2)) + util-linux support
touch netnstest
unshare --net mount --bind /proc/self/ns/net netnstest
nsenter --net=netnstest ip link show

# iproute pid support (possible bashisms follow)
ip link add dummy123 type dummy
nsenter --net=netnstest sleep 10 &
ip link set dummy123 netns $!
wait
nsenter --net=netnstest ip link show

# iproute fd support
ip link add dummy234 type dummy
ip link set dummy234 netns ./netnstest
nsenter --net=netnstest ip link show

# iproute 'ip netns' support
ip netns help

# cleanup
ip link del dummy123
ip link del dummy234
umount netnstest
rm -f netnstest


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
