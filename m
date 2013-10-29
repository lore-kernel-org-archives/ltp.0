Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vb2R9-0004CH-Ae
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 06:05:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vb2R7-0002k5-Es
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 06:05:55 +0000
Message-ID: <526F502C.1010700@cn.fujitsu.com>
Date: Tue, 29 Oct 2013 14:05:32 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <00e501ced38a$b4b19e90$1e14dbb0$@gyu.kim@lge.com>
In-Reply-To: <00e501ced38a$b4b19e90$1e14dbb0$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH] ext4-new-features: fix syntax error in configure
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
To: Honggyu Kim <hong.gyu.kim@lge.com>
Cc: ltp-list@lists.sourceforge.net

On 10/28/2013 11:06 AM, Honggyu Kim wrote:
> In configure, string comparison is done using double assignment.
> /bin/sh doesn't allow to compare strings using "==".
> So "==" is modified to "=".
> 
> Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>

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
