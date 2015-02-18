Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YO1vT-0004Dz-OT
	for ltp-list@lists.sourceforge.net; Wed, 18 Feb 2015 10:32:15 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YO1vS-0008Jc-PM
	for ltp-list@lists.sourceforge.net; Wed, 18 Feb 2015 10:32:15 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1IAW8Dj032090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 10:32:09 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1IAW8ol025176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 10:32:08 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1IAW8mC019036
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 10:32:08 GMT
Message-ID: <54E46AC3.50802@oracle.com>
Date: Wed, 18 Feb 2015 13:34:43 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1417614947-5514-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1417614947-5514-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/3] network/dhcpd: improve testcase,
	use dummy module
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
On 12/03/2014 04:55 PM, Alexey Kodanev wrote:
> Run dhcp client and check that the interface configured as expected.
>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   testcases/network/dhcpd/dhcpd_tests.sh |  148 +++++++++++++++++++++-----------
>   1 files changed, 98 insertions(+), 50 deletions(-)

network/dhcp patch-set pushed. dhcpd test, and new dnsmasq test both run 
on isolated Virtual Ethernet Tunnel pair to ensure they won't interfere 
with existed network setup.

Thanks,
Alexey


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
