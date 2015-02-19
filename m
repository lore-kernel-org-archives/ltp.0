Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YOSeS-0006eh-S1
	for ltp-list@lists.sourceforge.net; Thu, 19 Feb 2015 15:04:28 +0000
Date: Thu, 19 Feb 2015 16:04:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150219150413.GA23831@rei>
References: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
	<54E4C3C3.6080407@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54E4C3C3.6080407@redhat.com>
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > As network namespaces tests (ltp/testcases/kernel/containers/netns) code is
> > a bit messy and it's hard to figure out how return values are passed in the code
> > I propose to remove all test cases and leave only the ones specified below.
> 
> Just few notes about history / backwards compatibility; the proposed
> replacements are not exactly true replacements for the original code
> regarding kernel/userspace requirements.
> 
> 2002: (pre-git) Linux namespaces support in the kernel
> 2007/09: kernel supports moving interfaces between network namespaces
> 2008/06: 'ip link .. netns <pid>' support in iproute2
> 2010/03: /proc/<pid>/ns/* support in the kernel
> 2011/05: /proc/<pid>/ns/* usable as file descriptors (mountable)
> 2011/07: 'ip netns' support in iproute2, incl. 'ip link .. netns <file>'
> 
> The point being how far are you willing to go to preserve the
> functionality on older kernels/userspace.
> 
> The proposed code uses /proc/<pid>/ns/* as file descriptors, so it needs
> at least 2.6.39 kernel and related iproute version or /usr/include
> recent enough to have IFLA_NET_NS_FD (so you can write your own netlink
> setup utility).

Does not seem to be the case for SLES11 SP3 nor SP4. The kernel should
be new enough since SP2 though.

> The original code uses only fork/clone as far as I see, so it goes much
> more "back" in terms of compatibility, quite likely at the cost of
> readability, though. The bash portions of the original code use iproute2
> with 'netns <pid>' only, so their compatibility goes as back as 2008.
>
> The ultimate question is therefore "are we willing to TCONF the new
> tests on anything older than (upstream) 2.6.39?".

Well that may be one possibility. Unfortunatelly 2.6.39 is quite new, if
it were at least ten years old I would not hesitate. On the other hand
the old testcases are messy and basically unmaintainable and they tend
to fail if some subtle details in kernel change or even randomly from
time to time.

Ideal solution would be to fix the new testcases to work even on older
kernels but if that is too much work I would rather see us concentrate
on more recent code.

> Some (most?) enterprise distributions may have the functionality
> backported, for example RHEL-6.6 fully supports mounting
> /proc/<pid>/ns/* and even has util-linux support (like nsenter(1)) for
> the mounted file descriptors. It is, however, missing any 'ip netns'
> support as well as 'ip link .. netns <file>' (supports only pid).
> 
> What about others?
> 
> # kernel fd (setns(2)) + util-linux support
> touch netnstest
> unshare --net mount --bind /proc/self/ns/net netnstest
> nsenter --net=netnstest ip link show

SLES11 unshare does not support --bind and does not have nsenter likely
util-linux is too old (2.19.1).

> # iproute pid support (possible bashisms follow)
> ip link add dummy123 type dummy
> nsenter --net=netnstest sleep 10 &
> ip link set dummy123 netns $!
> wait
> nsenter --net=netnstest ip link show

Same here no nesenter.

-- 
Cyril Hrubis
chrubis@suse.cz

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
