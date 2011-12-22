Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rdlbm-0007C5-78
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 16:35:06 +0000
Date: Thu, 22 Dec 2011 17:44:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222164448.GA3466@saboteur.suse.cz>
References: <1321609032-16026-1-git-send-email-caspar@casparzhang.com>
	<1321609032-16026-3-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1321609032-16026-3-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v5 2/7] mm/zram01: errno not captured
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Sometimes `if (access(...) && errno == ENOENT)' doesn't work due to
> errno not captures correctly from access() exection. This patch put them
> into 2 nested if-condition statements.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/zram/zram01.c |   20 ++++++++++++++------
>  1 files changed, 14 insertions(+), 6 deletions(-)
> 

> diff --git a/testcases/kernel/mem/zram/zram01.c b/testcases/kernel/mem/zram/zram01.c
> index 63437c1..c382525 100644
> --- a/testcases/kernel/mem/zram/zram01.c
> +++ b/testcases/kernel/mem/zram/zram01.c
> @@ -106,16 +106,24 @@ int main(int argc, char *argv[])
>  
>  void setup(void)
>  {
> +	int retried = 0;
> +
>  	tst_require_root(NULL);
>  
> -	if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT) {

This one keeps me wondering. What exactly is wrong with this line?


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
