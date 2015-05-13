Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YsVXJ-0000zq-PW
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 12:13:17 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YsVXH-0000Q3-Ab
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 12:13:17 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4DCD84E024719
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 12:13:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4DCD8qV007689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 12:13:08 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4DCD8RF015702
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 12:13:08 GMT
Message-ID: <55534086.2020105@oracle.com>
Date: Wed, 13 May 2015 15:16:06 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/4] network/stress/ssh: rename ssh4-stress
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
On 01/19/2015 05:49 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   testcases/network/stress/ssh/ssh-stress  |  461 ++++++++++++++++++++++++++++++
>   testcases/network/stress/ssh/ssh4-stress |  461 ------------------------------
>   testcases/network/stress/ssh/ssh6-stress |   47 ---
>   3 files changed, 461 insertions(+), 508 deletions(-)
>   create mode 100644 testcases/network/stress/ssh/ssh-stress
>   delete mode 100644 testcases/network/stress/ssh/ssh4-stress
>   delete mode 100644 testcases/network/stress/ssh/ssh6-stress
>

Patch-set applied.

Best regards,
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
