Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YYWSy-0000Fm-7Z
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 09:10:12 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YYWSx-0005Ca-BT
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 09:10:12 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t2J9A5s5021783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Mar 2015 09:10:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t2J9A5hs013404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Mar 2015 09:10:05 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t2J9A5XH031336
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Mar 2015 09:10:05 GMT
Message-ID: <550A930F.2060505@oracle.com>
Date: Thu, 19 Mar 2015 12:12:47 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1421324561-6680-1-git-send-email-alexey.kodanev@oracle.com>
	<1421324561-6680-5-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421324561-6680-5-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 4/4] runtest/network-stress.appl: fix dns test
	names
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

Hi!
On 01/15/2015 03:22 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   runtest/network_stress.appl |    8 ++------
>   1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/runtest/network_stress.appl b/runtest/network_stress.appl
> index cd2a5d9..9aee474 100644
> --- a/runtest/network_stress.appl
> +++ b/runtest/network_stress.appl
> @@ -2,19 +2,15 @@
>   # Stress test for major application protocol (ssh, dns, http, ftp)
>   #
>   
> -# ssh
>   ssh4-stress ssh4-stress
>   ssh6-stress ssh6-stress
>   
> -# dns
> -dns4-stress dns4-stress
> -dns6-stress dns6-stress
> +dns4-stress dns-stress
> +dns6-stress dns-stress -6
>   

net/dns-stress patch-set applied.

Thanks,
Alexey


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
