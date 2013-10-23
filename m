Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYxtM-0001jY-Tq
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 12:50:29 +0000
Date: Wed, 23 Oct 2013 14:50:12 +0200
From: chrubis@suse.cz
Message-ID: <20131023125012.GC24275@rei.Home>
References: <526636E4.6040504@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <526636E4.6040504@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] add some common errno values
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
To: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  lib/tst_res.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 245bd5f..f73022b 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -249,7 +249,12 @@ static const char *strerrnodef(int err)
>  		    PAIR(EPIPE)
>  		    PAIR(EDOM)
>  		    PAIR(ERANGE)
> +		    PAIR(EDEADLK)
>  		    PAIR(ENAMETOOLONG)
> +		    PAIR(ENOLCK)
> +		    PAIR(ENOSYS)
> +		    PAIR(ENOTEMPTY)
> +		    PAIR(ELOOP)
>  	};
>  	return pair_lookup(errno_pairs, err);

Applied (whith a slight change to the commit message), thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
