Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Yuzbs-00024S-3w
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 08:44:16 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yuzbq-0004Wb-7F
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 08:44:16 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4K8i7Sf028074
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 May 2015 08:44:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4K8i70T025913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 May 2015 08:44:07 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4K8i7ix015118
	for <ltp-list@lists.sourceforge.net>; Wed, 20 May 2015 08:44:07 GMT
Message-ID: <555C4A0B.6050707@oracle.com>
Date: Wed, 20 May 2015 11:47:07 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422447054-9775-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/4] network/stress/ftp: rename ftp4-* scripts
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
On 01/28/2015 03:10 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   testcases/network/stress/ftp/ftp-download-stress  |  349 +++++++++++++++++++++
>   testcases/network/stress/ftp/ftp-upload-stress    |  326 +++++++++++++++++++
>   testcases/network/stress/ftp/ftp4-download-stress |  349 ---------------------
>   testcases/network/stress/ftp/ftp4-upload-stress   |  326 -------------------
>   testcases/network/stress/ftp/ftp6-download-stress |   47 ---
>   testcases/network/stress/ftp/ftp6-upload-stress   |   47 ---
>   6 files changed, 675 insertions(+), 769 deletions(-)
>   create mode 100644 testcases/network/stress/ftp/ftp-download-stress
>   create mode 100644 testcases/network/stress/ftp/ftp-upload-stress
>   delete mode 100644 testcases/network/stress/ftp/ftp4-download-stress
>   delete mode 100644 testcases/network/stress/ftp/ftp4-upload-stress
>   delete mode 100644 testcases/network/stress/ftp/ftp6-download-stress
>   delete mode 100644 testcases/network/stress/ftp/ftp6-upload-stress

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
