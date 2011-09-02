Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QzTJj-0000ty-RT
	for ltp-list@lists.sourceforge.net; Fri, 02 Sep 2011 12:57:55 +0000
Date: Fri, 2 Sep 2011 14:58:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110902125802.GA15349@saboteur.suse.cz>
References: <4E0FE494.6040701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E0FE494.6040701@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX] [PATCH] aio_cancel/7-1: fix fail occasionally due
 to aio_error() returns EBADF
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  .../conformance/interfaces/aio_cancel/7-1.c        |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
> index c37f184..756b0af 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
> @@ -112,8 +112,6 @@ int main()
>  		return PTS_FAIL;
>  	}
>  
> -	close(fd);
> -
>  	do {
>  		in_progress = 0;
>  		for (i = 0; i < BUF_NB; i++)
> @@ -161,5 +159,7 @@ int main()
>  		}
>  	} while (in_progress);
>  
> +	close(fd);
> +
>  	return PTS_UNRESOLVED;

Yes, closing the fd before aio operation is completed is wrong. However
the fix is not 100% correct either. The file would be closed only when
you get out of the do while() loop, which has several returns there.

So we may rather:

* change the code to close the fd correctly

or

* don't close the fd at all as we don't care about the file anyway

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
