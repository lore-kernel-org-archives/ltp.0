Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UfV9l-00010W-7g
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 13:02:09 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UfV9h-0007tk-HU
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 13:02:09 +0000
Date: Thu, 23 May 2013 09:01:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <734570027.6575727.1369314116995.JavaMail.root@redhat.com>
In-Reply-To: <519DD5C0.107@cn.fujitsu.com>
References: <519DD4ED.3090907@cn.fujitsu.com> <519DD5C0.107@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] shmctl/shmctl01.c: Test features IPC_INFO,
 SHM_STAT, SHM_LOCK and SHM_UNLOCK.
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "DAN LI" <li.dan@cn.fujitsu.com>
> To: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 23 May, 2013 10:39:28 AM
> Subject: [LTP]  [PATCH 2/2] shmctl/shmctl01.c: Test features IPC_INFO, SHM_STAT, SHM_LOCK and SHM_UNLOCK.
> 
> 
> Additional tests for features IPC_INFO, SHM_STAT, SHM_LOCK and SHM_UNLOCK.
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Hi,

1/2 cleanup looks OK to me, comments for 2/2 are inline.

> ---
>  testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 83
>  ++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> index 34ff30c..c0f2c81 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> @@ -43,13 +43,18 @@
>   *	call cleanup
>   */
> 
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include "ipcshm.h"
>  #include "libtestsuite.h"
> 
>  char *TCID = "shmctl01";
> 
>  static int shm_id_1 = -1;
> +static int shm_index;
>  static struct shmid_ds buf;
> +static struct shminfo info;
>  static long save_time;
> 
>  #define FIRST	0
> @@ -64,12 +69,24 @@ static pid_t pid_arr[N_ATTACH];
>  static int sync_pipes[2];
> 
>  /* Setup, cleanup and check routines for IPC_STAT */
> -static void stat_setup(void), func_stat(void);
> +static void stat_setup(void), func_istat(void);
>  static void stat_cleanup(void);
> 
>  /* Setup and check routines for IPC_SET */
>  static void set_setup(void), func_set(void);
> 
> +/* Check routine for IPC_INFO */
> +static void func_info(void);
> +
> +/* Check routine for SHM_STAT */
> +static void func_sstat(void);
> +
> +/* Check routine for SHM_LOCK */
> +static void func_lock(void);
> +
> +/* Check routine for SHM_UNLOCK */
> +static void func_unlock(void);
> +
>  /* Check routine for IPC_RMID */
>  static void func_rmid(void);
> 
> @@ -77,21 +94,27 @@ static void func_rmid(void);
>  static void do_child(void);
> 
>  static struct test_case_t {
> +	int *shmid;
>  	int cmd;
> +	struct shmid_ds *arg;
>  	void (*func_test) ();
>  	void (*func_setup) ();
>  } TC[] = {
> -	{IPC_STAT, func_stat, stat_setup},
> +	{&shm_id_1, IPC_STAT, &buf, func_istat, stat_setup},
>  #ifndef UCLINUX
>  	    /*
>  	     * The second test is not applicable to uClinux;
>  	     * shared memory segments are detached on exec(),
>  	     * so cannot be passed to uClinux children.
>  	     */
> -	{IPC_STAT, func_stat, stat_setup},
> +	{&shm_id_1, IPC_STAT, &buf, func_istat, stat_setup},
>  #endif
> -	{IPC_SET, func_set, set_setup},
> -	{IPC_RMID, func_rmid, NULL},
> +	{&shm_id_1, IPC_SET, &buf, func_set, set_setup},
> +	{&shm_id_1, IPC_INFO, (struct shmid_ds *) &info, func_info, NULL},
> +	{&shm_index, SHM_STAT, &buf, func_sstat, NULL},
> +	{&shm_id_1, SHM_LOCK, &buf, func_lock, NULL},
> +	{&shm_id_1, SHM_UNLOCK, &buf, func_unlock, NULL},
> +	{&shm_id_1, IPC_RMID, &buf, func_rmid, NULL},
>  };

Are last 3 cases actually using buf?

> 
>  static int TST_TOTAL = ARRAY_SIZE(TC);
> @@ -146,7 +169,7 @@ int main(int argc, char *argv[])
>  			if (TC[i].func_setup != NULL)
>  				(*TC[i].func_setup) ();
> 
> -			TEST(shmctl(shm_id_1, TC[i].cmd, &buf));
> +			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].arg));
> 
>  			if (TEST_RETURN == -1) {
>  				tst_resm(TFAIL, "%s call failed - errno "
> @@ -294,11 +317,11 @@ void do_child(void)
>  }
> 
>  /*
> - * func_stat() - check the functionality of the IPC_STAT command with
> shmctl()
> + * func_istat() - check the functionality of the IPC_STAT command with
> shmctl()
>   *		 by looking at the pid of the creator, the segement size,
>   *		 the number of attaches and the mode.
>   */
> -void func_stat(void)
> +void func_istat(void)
>  {
>  	int fail = 0;
>  	pid_t pid;
> @@ -419,6 +442,50 @@ void func_set(void)
>  	tst_resm(TPASS, "new mode and change time are correct");
>  }
> 
> +
> +static void func_info(void)
> +{
> +	if (info.shmmin != 1)
> +		tst_resm(TFAIL, "value of shmmin is incorrect");
> +	else
> +		tst_resm(TPASS, "get correct shared memory limits");
> +}
> +
> +static void func_sstat(void)
> +{
> +	if (buf.shm_segsz != SHM_SIZE)

I think this will work only if there are no shared memory segments before
test starts. Because shm_index == 0, this will check first one:

# ipcs -m
------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status      
0xffffffff 134971392  root       600        4          0                       

# ./shmctl01 
shmctl01    1  TPASS  :  pid, size, # of attaches and mode are correct - pass #1
shmctl01    2  TPASS  :  pid, size, # of attaches and mode are correct - pass #2
shmctl01    3  TPASS  :  new mode and change time are correct
shmctl01    4  TPASS  :  get correct shared memory limits
shmctl01    5  TFAIL  :  segment size is incorrect
shmctl01    6  TPASS  :  SHM_LOCK is setted
shmctl01    7  TPASS  :  SHM_LOCK is cleared
shmctl01    8  TPASS  :  shared memory appears to be removed

> +		tst_resm(TFAIL, "segment size is incorrect");
> +	else
> +		tst_resm(TPASS, "size of attache is correct");
> +}
> +
> +static void func_lock(void)
> +{
> +	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> +		tst_resm(TBROK, "stat failed in func_lock()");
> +		return;
> +	}
> +
> +	if (buf.shm_perm.mode & SHM_LOCKED)
> +		tst_resm(TPASS, "SHM_LOCK is setted");

Just "set", I suggest: SHM_LOCKED flag is set/cleared

Regards,
Jan

> +	else
> +		tst_resm(TFAIL, "SHM_LOCK is not setted");
> +}
> +
> +static void func_unlock(void)
> +{
> +	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> +		tst_resm(TBROK, "stat failed in func_unlock()");
> +		return;
> +	}
> +
> +	if (buf.shm_perm.mode & SHM_LOCKED)
> +		tst_resm(TFAIL, "SHM_LOCK is not cleared");
> +	else
> +		tst_resm(TPASS, "SHM_LOCK is cleared");
> +}
> +
> +
>  /*
>   * func_rmid() - check the functionality of the IPC_RMID command with
>   shmctl()
>   */
> --
> 1.8.1
> 
> ------------------------------------------------------------------------------
> Try New Relic Now & We'll Send You this Cool Shirt
> New Relic is the only SaaS-based application performance monitoring service
> that delivers powerful full stack analytics. Optimize and monitor your
> browser, app, & servers with just a few lines of code. Try New Relic
> and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
