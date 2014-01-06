Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W08Zf-00059a-Gc
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 11:42:27 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W08Ze-00087U-6I
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 11:42:27 +0000
Date: Mon, 6 Jan 2014 06:42:16 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1506781139.11098041.1389008536856.JavaMail.root@redhat.com>
In-Reply-To: <52BBCB45.2000502@cn.fujitsu.com>
References: <52BBCB45.2000502@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] semop/semop02.c: add ERANGE error value test
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 26 December, 2013 7:23:01 AM
> Subject: [LTP] [PATCH 2/2] semop/semop02.c: add ERANGE error value test
> 
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Looks good to me:
  Reviewed-by: Jan Stancek <jstancek@redhat.com>

I also ran it on RHEL 5.3/6.5/7 Beta and didn't see any issues.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/ipc/semop/semop02.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c
> b/testcases/kernel/syscalls/ipc/semop/semop02.c
> index 08fc43c..b2ed38c 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop02.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
> @@ -19,7 +19,7 @@
>  
>  /*
>   * DESCRIPTION
> - *	semop02 - test for E2BIG, EACCES, EFAULT and EINVAL errors
> + *	semop02 - test for E2BIG, EACCES, EFAULT, EINVAL and ERANGE errors
>   *
>   * HISTORY
>   *	03/2001 - Written by Wayne Boyer
> @@ -29,6 +29,7 @@
>   *        conflict with the key from another task.
>   */
>  
> +#define _GNU_SOURCE
>  #include <pwd.h>
>  #include "test.h"
>  #include "safe_macros.h"
> @@ -38,7 +39,7 @@ char *TCID = "semop02";
>  
>  static void semop_verify(int i);
>  
> -static int exp_enos[] = { E2BIG, EACCES, EFAULT, EINVAL, 0 };
> +static int exp_enos[] = { E2BIG, EACCES, EFAULT, EINVAL, ERANGE, 0 };
>  int sem_id_1 = -1;	/* a semaphore set with read & alter permissions */
>  int sem_id_2 = -1;	/* a semaphore set without read & alter permissions */
>  int bad_id = -1;
> @@ -50,7 +51,6 @@ int badbuf = -1;
>  #define NSOPS	5		/* a resonable number of operations */
>  #define	BIGOPS	1024		/* a value that is too large for the number */
>  				/* of semop operations that are permitted   */
> -
>  struct test_case_t {
>  	int *semid;
>  	struct sembuf *t_sbuf;
> @@ -61,7 +61,8 @@ struct test_case_t {
>  	{&sem_id_2, (struct sembuf *)&s_buf, NSOPS, EACCES},
>  	{&sem_id_1, (struct sembuf *)-1, NSOPS, EFAULT},
>  	{&sem_id_1, (struct sembuf *)&s_buf, 0, EINVAL},
> -	{&bad_id, (struct sembuf *)&s_buf, NSOPS, EINVAL}
> +	{&bad_id, (struct sembuf *)&s_buf, NSOPS, EINVAL},
> +	{&sem_id_1, (struct sembuf *)&s_buf, 1, ERANGE}
>  };
>  
>  int TST_TOTAL = ARRAY_SIZE(TC);
> @@ -94,6 +95,8 @@ void setup(void)
>  	char nobody_uid[] = "nobody";
>  	struct passwd *ltpuser;
>  	key_t semkey2;
> +	struct seminfo ipc_buf;
> +	union semun arr;
>  
>  	tst_require_root(NULL);
>  
> @@ -127,6 +130,16 @@ void setup(void)
>  		tst_brkm(TBROK | TERRNO, cleanup,
>  			 "couldn't create semaphore in setup");
>  	}
> +
> +	arr.ipc_buf = &ipc_buf;
> +	if (semctl(sem_id_1, 0, IPC_INFO, arr) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "semctl() IPC_INFO failed");
> +
> +	/* for ERANGE errno test */
> +	arr.val = 1;
> +	s_buf[0].sem_op = ipc_buf.semvmx;
> +	if (semctl(sem_id_1, 0, SETVAL, arr) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "semctl() SETVAL failed");
>  }
>  
>  static void semop_verify(int i)
> --
> 1.8.2.1
> 
> 
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics
> Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
