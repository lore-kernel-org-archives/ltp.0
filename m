Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VbLsV-0003a7-Bw
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 02:51:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbLsT-0001YT-QK
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 02:51:27 +0000
Message-ID: <52707414.9040504@cn.fujitsu.com>
Date: Wed, 30 Oct 2013 10:51:00 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383055470-18080-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1383055470-18080-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] device-drivers: pci: check memory region for
 flag IORESOURCE_PREFETCH
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>, ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

On 10/29/2013 10:04 PM, Alexey Kodanev wrote:
> This is done to make sure there will be no side effects if we change it somehow
> in the test (e.g. we're not changing I/O ports implemented as memory regions).
> Remove annoying printk messages.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Thank you for investigating this out, applied.

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
