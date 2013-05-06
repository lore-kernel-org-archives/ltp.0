Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UZKRu-0008Pg-Bh
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 12:23:22 +0000
Date: Mon, 6 May 2013 14:24:21 +0200
From: chrubis@suse.cz
Message-ID: <20130506122421.GD4388@rei>
References: <5183B105.8030106@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5183B105.8030106@oracle.com>
Subject: Re: [LTP] [PATCH] Fix retval parameter to pthread_join()
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
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
> index f845290..52dae70 100644
> --- a/testcases/kernel/mem/mtest05/mmstress.c
> +++ b/testcases/kernel/mem/mtest05/mmstress.c
> @@ -361,7 +361,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
>  	int fd = 0;		/* file descriptor of the file created       */
>  	int thrd_ndx = 0;	/* index to the number of threads created    */
>  	int map_type = 0;	/* specifies the type of the mapped object   */
> -	int *th_status = 0;	/* status of the thread when it is finished  */
> +	int **th_status;	/* status of the thread when it is finished  */
>  	long th_args[5];	/* argument list passed to  thread_fault()   */
>  	char *empty_buf = NULL;	/* empty buffer used to fill temp file       */
>  	long pagesize		/* contains page size at runtime             */
> @@ -489,7 +489,7 @@ RETINFO_t *map_and_thread(char *tmpfile,	/* name of temporary file to be created
>  			retinfo->status = FAILED;
>  			return retinfo;
>  		} else {
> -			if ((int)*th_status == 1) {
> +			if ((long)*th_status == 1) {
>  				tst_resm(TINFO,
>  					 "thread [%ld] - process exited with errors",
>  					 (long)pthread_ids[thrd_ndx]);

This is far to complicated as it is. What about removing the malloc and
using void * variable and cast to long as it is in the rest of the
testcases?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
