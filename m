Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S5GK8-0000di-U5
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 12:50:32 +0000
Date: Wed, 7 Mar 2012 13:52:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120307125207.GB31640@saboteur.suse.cz>
References: <1330511000-24198-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1330511000-24198-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] lib: fix -I option to accept larger number
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
> previous discussion on this issue:
> 
>     http://marc.info/?l=ltp-list&m=129585256906986&w=2
> 
> This patch uses uint64_t to make -I option accept larger numbers to
> get rid of overflow.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  lib/parse_opts.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

> diff --git a/lib/parse_opts.c b/lib/parse_opts.c
> index fd49cfa..2159d22 100644
> --- a/lib/parse_opts.c
> +++ b/lib/parse_opts.c
> @@ -708,7 +708,7 @@ static int get_current_time()
>  int usc_test_looping(int counter)
>  {
>      static int first_time = 1;
> -    static int stop_time = 0;	/* stop time in rtc or usecs */
> +    static uint64_t stop_time;	/* stop time in rtc or usecs */
>      static int delay;		/* delay in clocks or usecs  */
>      int hertz = 0;		/* clocks per second or usecs per second */
>      int ct, end;		/* current time, end delay time */
> @@ -733,7 +733,7 @@ int usc_test_looping(int counter)
>  
>  	if (STD_LOOP_DURATION) {
>  	    ct=get_current_time();
> -	    stop_time = (int)((float)hertz * STD_LOOP_DURATION) + ct;
> +	    stop_time = (uint64_t)((float)hertz * STD_LOOP_DURATION) + ct;
>  	}

Looking at the code, there are more problems than that. The
get_current_time() return value as well as ct and end would overflow
too. I will look at the code and fix it correctly.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
