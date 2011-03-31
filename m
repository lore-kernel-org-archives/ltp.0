Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q5Ka7-0003R2-TA
	for ltp-list@lists.sourceforge.net; Thu, 31 Mar 2011 16:18:47 +0000
Date: Thu, 31 Mar 2011 18:41:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110331164159.GA11109@saboteur.suse.cz>
References: <4D8AB7FB.6030108@cn.fujitsu.com>
	<20110324190228.GA4003@hannu-debian.elisa-laajakaista.fi>
	<4D8BF42D.4010709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D8BF42D.4010709@cn.fujitsu.com>
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
>  static pthread_rwlock_t rwlock;
>  static int thread_state;
> -static int currsec1, currsec2;
>  static int expired;
>  
>  /* thread_state indicates child thread state:
> @@ -50,12 +51,14 @@ static int expired;
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
> +	gettimeofday(&curt, NULL);

The time passed to the pthread_rwlock_timedwrlock() should be based on
clock_gettime(CLOKC_REALTIME, ...).

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
