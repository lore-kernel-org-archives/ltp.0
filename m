Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QNO8k-0007cD-FR
	for ltp-list@lists.sourceforge.net; Fri, 20 May 2011 11:45:10 +0000
Date: Fri, 20 May 2011 13:41:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110520114100.GA13413@saboteur.suse.cz>
References: <a893e731f5998485ba2b9309e0c909b933c40479.1305519242.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a893e731f5998485ba2b9309e0c909b933c40479.1305519242.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] [syscalls] mmap11: fix broken testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
>  modify_ldt01 modify_ldt01
>  modify_ldt02 modify_ldt02
> diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
> index 786724b..4cbad58 100644
> --- a/testcases/kernel/syscalls/mmap/mmap11.c
> +++ b/testcases/kernel/syscalls/mmap/mmap11.c
> @@ -58,7 +58,7 @@
>  char *TCID = "mmap11";
>  int TST_TOTAL = 1;
>  
> -#define MAL_SIZE (100*1024)
> +#define MAL_SIZE (8*1024*1024)
>  
>  static void *wait_thread(void *args);
>  static void *wait_thread2(void *args);
> @@ -112,13 +112,15 @@ void check(void)
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  		Tst_count = 0;
>  		ret = pthread_create(&th, &attr, wait_thread, NULL);
> -		if (ret) {
> +		if (ret && errno != ENOMEM && errno != EAGAIN) {
>  			tst_resm(TINFO, "[%d] ", count);
>  			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
>  		}
> +		if (count % 100 == 0)
> +			usleep(10000);

Hmm throwing in random sleeps often makes it work only on certain
systems. What are you trying to assert? That wait_thread() last long
enough so that wait_thread2 is executed meanwhile? You should use proper
locks for that otherwise it will start failing again sooner or later.

>  		count++;
>  		ret = pthread_create(&thread[lc], &attr, wait_thread2, NULL);
> -		if (ret) {
> +		if (ret && errno != ENOMEM && errno != EAGAIN) {
>  			tst_resm(TINFO, "[%d] ", count);
>  			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
>  		}
> @@ -133,13 +135,13 @@ void *wait_thread(void *args)
>  	void *addr;
>  
>  	addr = malloc(MAL_SIZE);
> -	if (addr)
> -		memset(addr, 1, MAL_SIZE);
> -	sleep(1);
> +	sleep(10);
> +
>  	return NULL;
>  }
>  
>  void *wait_thread2(void *args)
>  {
> +	sleep(60);
>  	return NULL;
>  }


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
