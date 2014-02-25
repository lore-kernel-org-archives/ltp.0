Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WIB2V-0000Y7-0t
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 05:58:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIB2T-0004Ca-Cu
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 05:58:46 +0000
Message-ID: <530C27BC.7010805@cn.fujitsu.com>
Date: Tue, 25 Feb 2014 13:18:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1393302676-23194-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1393302676-23194-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] lib/tst_mkfs: append -f option when creating btrfs
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sf.net

On 02/25/2014 12:31 PM, Eryu Guan wrote:
> mkfs.btrfs needs -f option to force the mkfs process too.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  lib/tst_mkfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Good catch, applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
