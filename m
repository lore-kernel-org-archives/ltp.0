Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Yuzcg-0004qr-WA
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 08:45:07 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yuzcg-0003X2-3R
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 08:45:06 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4K8j076028990
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 May 2015 08:45:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4K8ixWv026651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 May 2015 08:44:59 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4K8ixqO006553
	for <ltp-list@lists.sourceforge.net>; Wed, 20 May 2015 08:44:59 GMT
Message-ID: <555C4A3E.9020406@oracle.com>
Date: Wed, 20 May 2015 11:47:58 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422972883-12173-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/6] network/stress/http: rename http4-stress
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
Cc: vasily.isaenko@oracle.com

Hi,
On 02/03/2015 05:14 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   testcases/network/stress/http/http-stress  |  357 ++++++++++++++++++++++++++++
>   testcases/network/stress/http/http4-stress |  357 ----------------------------
>   2 files changed, 357 insertions(+), 357 deletions(-)
>   create mode 100644 testcases/network/stress/http/http-stress
>   delete mode 100644 testcases/network/stress/http/http4-stress
>

Patch-set applied.

Thanks,
Alexey

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
