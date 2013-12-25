Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VvdWE-0002nv-Ol
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 01:44:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VvdWD-0003PM-SO
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 01:44:18 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBP1iBI6030325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:44:11 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBP1iA8U015236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:44:11 GMT
Received: from ubhmt106.oracle.com (ubhmt106.oracle.com [156.151.24.11])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBP1iAgf015228
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:44:10 GMT
Message-ID: <52BA384B.3070308@oracle.com>
Date: Wed, 25 Dec 2013 09:43:39 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1386729875-487-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1386729875-487-1-git-send-email-xu.simon@oracle.com>
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
To: ltp-list@lists.sourceforge.net

Could anyone help to review this?

Thanks
Simon

On 2013/12/11 10:44, Simon Xu wrote:
> Explicitly enable IPv6 because on older systems xinetd only listens
> on IPv4 by default.
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>   testcases/network/xinetd/xinetd_tests.sh | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index 5024280..dac23a8 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -134,6 +134,7 @@ service telnet
>       server          = /usr/sbin/in.telnetd
>       server_args     = -n
>       no_access       =
> +    flags           = IPv6
>   }
>   EOF
>   RC=$?


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
