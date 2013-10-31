Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VbnrO-0004db-9f
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:44:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbnrM-0004f9-Tq
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:44:10 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9V8hx4I022104
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 16:43:59 +0800
Message-ID: <52721840.1030206@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 16:43:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5271BD29.6080701@cn.fujitsu.com>
In-Reply-To: <5271BD29.6080701@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] chroot/chroot03.c: add ELOOP error value test for
 chroot(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

On 10/31/2013 10:15 AM, Xiaoguang Wang wrote:
> Subject: [PATCH] chroot/chroot03.c: add ELOOP error value test for chroot(2)
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/chroot/chroot03.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Applied, thank you.

Wanlong gao


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
