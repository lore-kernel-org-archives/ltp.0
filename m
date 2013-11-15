Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vh891-0006Wh-Ex
	for ltp-list@lists.sourceforge.net; Fri, 15 Nov 2013 01:24:23 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vh88z-00038d-If
	for ltp-list@lists.sourceforge.net; Fri, 15 Nov 2013 01:24:23 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAF1OFJn018021
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Nov 2013 01:24:15 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAF1OEdC017639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Nov 2013 01:24:14 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAF1OEwE017624
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Nov 2013 01:24:14 GMT
Message-ID: <528577A1.1050601@oracle.com>
Date: Fri, 15 Nov 2013 09:23:45 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1384150091-582-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1384150091-582-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] tcpdump01: specify interface for ping
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

Could anyone help to review?

Thanks
Simon

On 2013/11/11 14:08, Simon Xu wrote:
> Always specify interface for ping because it is possible that pings to RHOST
> can go through multiple interfaces.  Also add -q to ping.
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>   testcases/network/tcp_cmds/tcpdump/tcpdump01 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> index 6d6d399..6296ad2 100755
> --- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
> +++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> @@ -51,7 +51,7 @@ do_setup()
>       # Find the first interface that can ping RHOST
>       IF=""
>       for i in $(netstat -i | tail -n+3 | sed '/^lo/d' | cut -f1 -d' '); do
> -        ping -I $i -c 3 $RHOST && { IF="$i"; break; }
> +        ping -I $i -c 3 -q $RHOST && { IF="$i"; break; }
>       done
>       test -z $IF && end_testcase "Could not find an interface that can ping remote host $RHOST"
>       IFNAME=${IF}
> @@ -62,7 +62,7 @@ do_setup()
>   
>   do_test()
>   {
> -    ping -f $RHOST > /dev/null 2>&1 &
> +    ping -I $IFNAME -f $RHOST > /dev/null 2>&1 &
>       if ! tcpdump -i $IFNAME -c $NUMLOOPS > $OUTFILE; then
>           end_testcase "Problems trying to launch tcpdump"
>       fi


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
