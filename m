Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q5dRr-0007zL-NX
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 12:27:31 +0000
Date: Fri, 1 Apr 2011 14:50:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110401125046.GF11484@saboteur.suse.cz>
References: <4D8AB7FB.6030108@cn.fujitsu.com>
	<20110324190228.GA4003@hannu-debian.elisa-laajakaista.fi>
	<4D8BF42D.4010709@cn.fujitsu.com>
	<20110331164159.GA11109@saboteur.suse.cz>
	<4D953B4E.8010408@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D953B4E.8010408@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]Fix bug of "pthread_rwlock_timedwrlock" test
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  /* thread_state indicates child thread state:
> @@ -50,12 +50,30 @@ static int expired;
>  static void* fn(void *arg)
>  {
>  	struct timespec abs_timeout;
> +	struct timeval curt;
>  	int rc;
>  	thread_state = ENTERED_THREAD;
>  
>  	/* Absolute time, not relative. */
> -	abs_timeout.tv_sec = currsec1 - TIMEOUT;
> -	abs_timeout.tv_nsec = 0;
> +#ifdef CLOCK_REALTIME
> +	rc = clock_gettime(CLOCK_REALTIME, &abs_timeout);
> +	if (rc != 0)
> +	{
> +		printf("Error in clock_gettime(), error code:%d.\n", rc);
> +		exit(PTS_UNRESOLVED);
> +	}
> +	abs_timeout.tv_sec -= TIMEOUT;
> +#else
> +	rc = gettimeofday(&curt, NULL);
> +	if (rc != 0)
> +	{
> +		printf("Error in clock_gettime(), error code:%d.\n", errno);
> +		exit(PTS_UNRESOLVED);
> +	}
> +	abs_timeout.tv_sec = curt.tv_sec - TIMEOUT;
> +	abs_timeout.tv_nsec = curt.tv_usec * 1000;
> +#endif

Hmm, POSIX says:

All implementations support a clock_id of CLOCK_REALTIME defined in <time.h>. 

So the #ifdef part shouldn't be needed. Or there are some problems with
undefined CLOCK_REALTIME on your platform?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
