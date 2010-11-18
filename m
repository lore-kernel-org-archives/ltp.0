Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJ8QQ-0008EL-E1
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 17:37:34 +0000
Date: Thu, 18 Nov 2010 18:49:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101118174923.GB19296@saboteur.suse.cz>
References: <4CE4CD9D.4040406@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CE4CD9D.4040406@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]Destroy mutex an mutex_attr object at end
 of test
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
> Destroy mutex an mutex_attr object at end of test.
> 
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> 
> ---
>  .../interfaces/pthread_mutex_getprioceiling/3-1.c  |    2 ++
>  .../interfaces/pthread_mutex_getprioceiling/3-2.c  |    3 +++
>  .../interfaces/pthread_mutex_getprioceiling/3-3.c  |    3 +++
>  3 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c
> index d96ae43..5267b63 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c
> @@ -62,6 +62,8 @@ main(void)
>  	} else
>  		printf("pthread_mutex_getprioceiling passed unexpectedly\n");
>  
> +	(void) pthread_mutex_destroy(&mutex);
> +

Please never use useless cast like this.

>  	return (error == EINVAL ? PTS_PASS : PTS_FAIL);
>  #else
>  	printf("pthread_mutex_getprioceiling not supported");
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c
> index 843c048..afa12c1 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c
> @@ -75,6 +75,9 @@ main(void)
>  	} else
>  		printf("pthread_mutex_getprioceiling passed unexpectedly\n");
>  
> +	(void) pthread_mutexattr_destroy(&mutex_attr);
> +	(void) pthread_mutex_destroy(&mutex);
> +

And here.

>  	return (error == EINVAL ? PTS_PASS : PTS_FAIL);
>  #else
>  	printf("pthread_mutex_getprioceiling not supported");
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
> index cf46f77..4aa6b1c 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
> @@ -76,6 +76,9 @@ main(void)
>  	} else
>  		printf("pthread_mutex_getprioceiling passed unexpectedly\n");
>  
> +	(void) pthread_mutexattr_destroy(&mutex_attr);
> +	(void) pthread_mutex_destroy(&mutex);
> +

And here.

>  	return (error == EINVAL ? PTS_PASS : PTS_UNRESOLVED);
>  #else
>  	printf("pthread_mutex_getprioceiling not supported");
> -- 
> 1.7.0.4

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
