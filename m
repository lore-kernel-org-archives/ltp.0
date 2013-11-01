Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vc5Cu-0001pY-DO
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 03:15:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vc5Cs-0004gM-3j
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 03:15:32 +0000
Message-ID: <52731CB9.3000408@cn.fujitsu.com>
Date: Fri, 01 Nov 2013 11:15:05 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383132093-4920-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1383132093-4920-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: pci: fix PCI_EXP_CAP_CONFIG
	test-case
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

On 10/30/2013 07:21 PM, Alexey Kodanev wrote:
> There is another way to check that PCI Express config space of pci devices
> can be read successfully.
> Firstly, find out if a device has a PCI Express Capability: we should get
> a correct config address offset from the dev's structure (dev->pcie_cap).
> Using the offset, read a PCI Express header. Check if we can get the right
> PCI Express CAP ID from the header (it must match the PCI_CAP_ID_EXP macro).
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  .../device-drivers/pci/tpci_kernel/ltp_tpci.c      |   54 ++++++--------------
>  .../kernel/device-drivers/pci/tpci_kernel/tpci.h   |    1 -
>  2 files changed, 15 insertions(+), 40 deletions(-)


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
