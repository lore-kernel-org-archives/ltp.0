Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XUtDj-0005ph-Qk
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 08:07:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUtDi-0000FX-JM
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 08:07:11 +0000
Message-ID: <541BE418.6020501@cn.fujitsu.com>
Date: Fri, 19 Sep 2014 16:06:48 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1410244166-5559-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <1410244166-5559-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] pan/ltp-pan.c: TCONF testcases should not be
 written to failcmdfile
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi,

    I introduced this patch '6f6878f4e1406d79cae53564777c5e1245d2a124', sorry. I
agree with you, patch looks good to me, thanks! Or we can also create a file to
record test cases that return TCONF.

Regards,
Xiaoguang Wang
 
On 09/09/2014 02:29 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> After commit patch 6f6878f4e1406d79cae53564777c5e1245d2a124,the
> testcases which retrun TCONF should not be written to failcmdfile.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  pan/ltp-pan.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
> index 957199a..711c16a 100644
> --- a/pan/ltp-pan.c
> +++ b/pan/ltp-pan.c
> @@ -802,7 +802,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
>  					fflush(logfile);
>  				}
>  
> -				if ((failcmdfile != NULL) && (w != 0)) {
> +				if ((failcmdfile != NULL) && (w != 0) && (w != TCONF)) {
>  					fprintf(failcmdfile, "%s %s\n",
>  						running[i].cmd->name,
>  						running[i].cmd->cmdline);
> 


------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
