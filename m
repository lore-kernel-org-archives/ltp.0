Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VdrHm-0007ns-7N
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 00:47:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdrHk-00044A-Mh
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 00:47:54 +0000
Message-ID: <52799194.3000308@cn.fujitsu.com>
Date: Wed, 06 Nov 2013 08:47:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383648696-17215-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1383648696-17215-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: pci: remove bus_slot file on exit
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

On 11/05/2013 06:51 PM, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  .../device-drivers/pci/tpci_kernel/ltp_tpci.c      |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
