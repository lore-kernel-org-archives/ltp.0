Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vbns0-00047o-Mk
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:44:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vbnrz-0003ke-NB
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:44:48 +0000
Message-ID: <52721861.2080508@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 16:44:17 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383200018-1207-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1383200018-1207-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] iptables_tests.sh: nat table can have 4 chains
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
To: Simon Xu <xu.simon@oracle.com>, ltp-list@lists.sourceforge.net

On 10/31/2013 02:13 PM, Simon Xu wrote:
> It is considered by iptables_tests.sh a failure When nat table chain count is
> not 3, while recent kernels can have 4 built-in chains in nat table, namely
> PREROUTING, OUTPUT, POSTROUTING and INPUT.
> ---
>  testcases/network/iptables/iptables_tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


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
