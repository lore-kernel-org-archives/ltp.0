Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vvcok-0001Ze-H5
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 00:59:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vvcoj-0001Ks-Oa
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 00:59:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBP0xEEh004360
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 08:59:14 +0800
Message-ID: <52BA2DD5.9030509@cn.fujitsu.com>
Date: Wed, 25 Dec 2013 08:59:01 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <52B960D4.5050506@cn.fujitsu.com>
In-Reply-To: <52B960D4.5050506@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] semop/semop04.c: fix a bug when running with -i
 option
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 12/24/2013 06:24 PM, Xiaoguang Wang wrote:
> If we run semop04 like this: ./semop04 -i 2,
> its output will be:
> 
> semop04     1  TPASS  :  expected failure - errno = 11 : Resource temporarily unavailable
> semop04     2  TPASS  :  expected failure - errno = 11 : Resource temporarily unavailable
> semop04     1  TBROK  :  semctl() failed
> semop04     2  TBROK  :  Remaining cases broken.
> 
> Actually in the second iteration, semctl will return ERANGE. This is
> because the val variable will be less than zero in the sceond iteration.
> 
> Variable val should be reset to 1 before this actual errno test.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ipc/semop/semop04.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
