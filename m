Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W8pHc-0001X0-Fy
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 10:55:44 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W8pHZ-0004FZ-Q4
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 10:55:44 +0000
Date: Thu, 30 Jan 2014 05:55:35 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <882926271.1663183.1391079335500.JavaMail.root@redhat.com>
In-Reply-To: <52DDD0BA.4070906@oracle.com>
References: <1386729875-487-1-git-send-email-xu.simon@oracle.com>
	<52BA384B.3070308@oracle.com> <52DDD0BA.4070906@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] xinetd_tests.sh: explicitly enable IPv6
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Simon Xu" <xu.simon@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 21 January, 2014 2:43:22 AM
> Subject: Re: [LTP] [PATCH] xinetd_tests.sh: explicitly enable IPv6
> 
> Could anyone help to review this?
> 
> Thanks
> Simon
> 
> On 2013/12/25 9:43, Simon Xu wrote:
> > Could anyone help to review this?
> >
> > Thanks
> > Simon
> >
> > On 2013/12/11 10:44, Simon Xu wrote:
> >> Explicitly enable IPv6 because on older systems xinetd only listens
> >> on IPv4 by default.
> >>
> >> Signed-off-by: Simon Xu <xu.simon@oracle.com>

Hi,

Looks good to me. According to [1] it's supported since around 1.8.9,
which appears to be older than anything I could find in RHEL distros.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

[1] http://www.tldp.org/HOWTO/Linux%2BIPv6-HOWTO/hints-daemons-xinetd.html

Regards,
Jan

> >> ---
> >>    testcases/network/xinetd/xinetd_tests.sh | 1 +
> >>    1 file changed, 1 insertion(+)
> >>
> >> diff --git a/testcases/network/xinetd/xinetd_tests.sh
> >> b/testcases/network/xinetd/xinetd_tests.sh
> >> index 5024280..dac23a8 100755
> >> --- a/testcases/network/xinetd/xinetd_tests.sh
> >> +++ b/testcases/network/xinetd/xinetd_tests.sh
> >> @@ -134,6 +134,7 @@ service telnet
> >>        server          = /usr/sbin/in.telnetd
> >>        server_args     = -n
> >>        no_access       =
> >> +    flags           = IPv6
> >>    }
> >>    EOF
> >>    RC=$?
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
