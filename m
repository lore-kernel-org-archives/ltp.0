Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vbnrb-0004Xb-Ag
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:44:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vbnra-0005bk-Ko
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:44:23 +0000
Message-ID: <52721851.7050906@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 16:44:01 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383198252-1033-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1383198252-1033-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] dhcpd_tests.sh: fix dhcpd.conf file paths
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

On 10/31/2013 01:44 PM, Simon Xu wrote:
> dhcpd_tests.sh only checks for /etc/dhcpd.conf, while in some distros the
> path is /etc/dhcp/dhcpd.conf.
> ---
>  testcases/network/dhcpd/dhcpd_tests.sh | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

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
