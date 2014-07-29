Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XC2PZ-00068E-RI
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 08:05:29 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XC2PY-0001pG-HS
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 08:05:29 +0000
Date: Tue, 29 Jul 2014 04:05:18 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <886732917.16243940.1406621118617.JavaMail.zimbra@redhat.com>
In-Reply-To: <1406586824-1692-1-git-send-email-gary.robertson@linaro.org>
References: <1406586824-1692-1-git-send-email-gary.robertson@linaro.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Allow mutex initialization without PI configured
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
To: "Gary S. Robertson" <gary.robertson@linaro.org>
Cc: ltp-list@lists.sourceforge.net, mike holmes <mike.holmes@linaro.org>



----- Original Message -----
> From: "Gary S. Robertson" <gary.robertson@linaro.org>
> To: ltp-list@lists.sourceforge.net
> Cc: "mike holmes" <mike.holmes@linaro.org>
> Sent: Tuesday, 29 July, 2014 12:33:44 AM
> Subject: [LTP] [PATCH] Allow mutex initialization without PI configured
> 
> From: "Gary S. Robertson" <gary.robertson@linaro.org>
> 
> LTP seems primarily intended to be built and run on the same machine,
> and thus uses autotools / autoconf to determine the features of the host
> machine's environment prior to compilation.  However, when distributing
> precompiled binaries, or when building in a cross-compilation environment,
> it is better not to disable features based on the compile-time environment.

Isn't the build going to fail then if you miss those features?

> This patch removes compile-time dependencies on priority-inheriting mutexes

Seems to me, the problem is:

-#if HAVE_DECL_PTHREAD_PRIO_INHERIT
+#if HAS_PRIORITY_INHERIT

I'm not against removing that check entirely. I'm not sure anyone is using
distro so old it's missing it. We also don't check for it in openposix testsuite.

> and allows the code to attempt initialization of PI mutexes even
> if the runtime environment lacks that feature... in which case
> the associated test(s) should fail.
> 
> Without this patch, init_pi_mutex() may be compiled as an empty function,
> allowing subsequent operations to be attempted on an un-inititalized mutex.
> Likewise, testpi-3 may fail to initialize a mutex before starting pthreads
> which attempt to use the mutex.

Then it shouldn't run at all and end with TCONF.

> 
> Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
> ---
>  testcases/realtime/lib/librttest.c            |    2 --
>  testcases/realtime/stress/pi-tests/testpi-3.c |    2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/testcases/realtime/lib/librttest.c
> b/testcases/realtime/lib/librttest.c
> index 0dd6019..9f37d08 100644
> --- a/testcases/realtime/lib/librttest.c
> +++ b/testcases/realtime/lib/librttest.c
> @@ -586,7 +586,6 @@ void *busy_work_us(int us)
>  
>  void init_pi_mutex(pthread_mutex_t * m)
>  {
> -#if HAVE_DECL_PTHREAD_PRIO_INHERIT
>  	pthread_mutexattr_t attr;
>  	int ret;
>  	int protocol;
> @@ -609,7 +608,6 @@ void init_pi_mutex(pthread_mutex_t * m)
>  	if ((ret = pthread_mutex_init(m, &attr)) != 0) {
>  		printf("Failed to init mutex: %d (%s)\n", ret, strerror(ret));
>  	}
> -#endif1G

         ^^ There's extra "1G" here

Regards,
Jan

>  
>  	/* FIXME: does any of this need to be destroyed ? */
>  }
> diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c
> b/testcases/realtime/stress/pi-tests/testpi-3.c
> index 30f38f6..807c9cc 100644
> --- a/testcases/realtime/stress/pi-tests/testpi-3.c
> +++ b/testcases/realtime/stress/pi-tests/testpi-3.c
> @@ -365,7 +365,6 @@ int main(int argc, char *argv[])
>  
>  	printf("Start %s\n", argv[0]);
>  
> -#if HAVE_DECL_PTHREAD_PRIO_INHERIT
>  	if (!nopi) {
>  		pthread_mutexattr_t mutexattr;
>  		int protocol;
> @@ -386,7 +385,6 @@ int main(int argc, char *argv[])
>  			printf("Failed to init mutex: %d\n", retc);
>  		}
>  	}
> -#endif
>  
>  	startThread(&arg1);
>  	startThread(&arg2);
> --
> 1.7.9.5
> 
> 
> ------------------------------------------------------------------------------
> Infragistics Professional
> Build stunning WinForms apps today!
> Reboot your WinForms applications with our WinForms controls.
> Build a bridge from your legacy apps to the future.
> http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
