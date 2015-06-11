Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z30Tu-0007mp-7q
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 11:17:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z30Tt-0006D9-4b
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 11:17:10 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5BBH3qA020872
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Jun 2015 11:17:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t5BBH2o1016253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Jun 2015 11:17:03 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t5BBH2CZ017407
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Jun 2015 11:17:02 GMT
Message-ID: <55796EF2.4030202@oracle.com>
Date: Thu, 11 Jun 2015 14:20:18 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/11] network/stress/interface: rename if4-* tests
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
On 02/13/2015 03:06 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   testcases/network/stress/interface/if-addr-adddel  |  326 +++++++++++++
>   .../network/stress/interface/if-addr-addlarge      |  481 ++++++++++++++++++++
>   testcases/network/stress/interface/if-mtu-change   |  264 +++++++++++
>   testcases/network/stress/interface/if-route-adddel |  293 ++++++++++++
>   .../network/stress/interface/if-route-addlarge     |  292 ++++++++++++
>   testcases/network/stress/interface/if-updown       |  258 +++++++++++
>   .../network/stress/interface/if4-alias-adddel      |  326 -------------
>   .../network/stress/interface/if4-alias-addlarge    |  481 --------------------
>   testcases/network/stress/interface/if4-mtu-change  |  264 -----------
>   .../network/stress/interface/if4-route-adddel      |  293 ------------
>   .../network/stress/interface/if4-route-addlarge    |  292 ------------
>   testcases/network/stress/interface/if4-updown      |  258 -----------
>   12 files changed, 1914 insertions(+), 1914 deletions(-)
>   create mode 100644 testcases/network/stress/interface/if-addr-adddel
>   create mode 100644 testcases/network/stress/interface/if-addr-addlarge
>   create mode 100644 testcases/network/stress/interface/if-mtu-change
>   create mode 100644 testcases/network/stress/interface/if-route-adddel
>   create mode 100644 testcases/network/stress/interface/if-route-addlarge
>   create mode 100644 testcases/network/stress/interface/if-updown
>   delete mode 100644 testcases/network/stress/interface/if4-alias-adddel
>   delete mode 100644 testcases/network/stress/interface/if4-alias-addlarge
>   delete mode 100644 testcases/network/stress/interface/if4-mtu-change
>   delete mode 100644 testcases/network/stress/interface/if4-route-adddel
>   delete mode 100644 testcases/network/stress/interface/if4-route-addlarge
>   delete mode 100644 testcases/network/stress/interface/if4-updown

Patch-set applied.

Best regards,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
