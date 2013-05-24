Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Ufqs5-0004rN-8A
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 12:13:21 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ufqrz-0001Jx-Qw
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 12:13:21 +0000
Date: Fri, 24 May 2013 08:13:06 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <319673616.7044029.1369397586287.JavaMail.root@redhat.com>
In-Reply-To: <519F37CF.4030209@cn.fujitsu.com>
References: <519DD4ED.3090907@cn.fujitsu.com> <519F37CF.4030209@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3 2/2] shmctl/shmctl01.c: Test features IPC_INFO,
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
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "DAN LI" <li.dan@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Friday, 24 May, 2013 11:50:07 AM
> Subject: [LTP] [PATCH V3 2/2] shmctl/shmctl01.c: Test features IPC_INFO, SHM_STAT, SHM_LOCK and SHM_UNLOCK.
> 
> 
> 
> Additional tests for features IPC_INFO, SHM_STAT, SHM_LOCK and SHM_UNLOCK.
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 96
>  +++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 15 deletions(-)
> 
> Hi,
> Jan
> 
> How about this V3?
> 
> Regards,
> DAN LI

Looks good to me.
Reviewed-by: Jan Stancek <jstancek@redhat.com>

> 
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> index 34ff30c..cba1a1d 100644
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
> @@ -64,34 +69,52 @@ static pid_t pid_arr[N_ATTACH];
>  static int sync_pipes[2];
> 
>  /* Setup, cleanup and check routines for IPC_STAT */
> -static void stat_setup(void), func_stat(void);
> +static void stat_setup(void), func_istat(int ret);
>  static void stat_cleanup(void);
> 
>  /* Setup and check routines for IPC_SET */
> -static void set_setup(void), func_set(void);
> +static void set_setup(void), func_set(int ret);
> +
> +/* Check routine for IPC_INFO */
> +static void func_info(int ret);
> +
> +/* Check routine for SHM_STAT */
> +static void func_sstat(int ret);
> +
> +/* Check routine for SHM_LOCK */
> +static void func_lock(int ret);
> +
> +/* Check routine for SHM_UNLOCK */
> +static void func_unlock(int ret);
> 
>  /* Check routine for IPC_RMID */
> -static void func_rmid(void);
> +static void func_rmid(int ret);
> 
>  /* Child function */
>  static void do_child(void);
> 
>  static struct test_case_t {
> +	int *shmid;
>  	int cmd;
> -	void (*func_test) ();
> -	void (*func_setup) ();
> +	struct shmid_ds *arg;
> +	void (*func_test) (int);
> +	void (*func_setup) (void);
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
> +	{&shm_id_1, SHM_LOCK, NULL, func_lock, NULL},
> +	{&shm_id_1, SHM_UNLOCK, NULL, func_unlock, NULL},
> +	{&shm_id_1, IPC_RMID, NULL, func_rmid, NULL},
>  };
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
> @@ -155,7 +178,7 @@ int main(int argc, char *argv[])
>  				continue;
>  			}
>  			if (STD_FUNCTIONAL_TEST) {
> -				(*TC[i].func_test) ();
> +				(*TC[i].func_test) (TEST_RETURN);
>  			} else {
>  				tst_resm(TPASS, "call succeeded");
> 
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
> +void func_istat(int ret)
>  {
>  	int fail = 0;
>  	pid_t pid;
> @@ -392,7 +415,7 @@ void set_setup(void)
>  /*
>   * func_set() - check the functionality of the IPC_SET command with shmctl()
>   */
> -void func_set(void)
> +void func_set(int ret)
>  {
>  	int fail = 0;
> 
> @@ -419,10 +442,53 @@ void func_set(void)
>  	tst_resm(TPASS, "new mode and change time are correct");
>  }
> 
> +static void func_info(int ret)
> +{
> +	if (info.shmmin != 1)
> +		tst_resm(TFAIL, "value of shmmin is incorrect");
> +	else
> +		tst_resm(TPASS, "get correct shared memory limits");
> +}
> +
> +static void func_sstat(int ret)
> +{
> +	if (ret >= 0)
> +		tst_resm(TPASS, "get correct shared memory id");
> +	else
> +		tst_resm(TFAIL, "shared memory id is incorrect");
> +}
> +
> +static void func_lock(int ret)
> +{
> +	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> +		tst_resm(TBROK, "stat failed in func_lock()");
> +		return;
> +	}
> +
> +	if (buf.shm_perm.mode & SHM_LOCKED)
> +		tst_resm(TPASS, "SHM_LOCK is set");
> +	else
> +		tst_resm(TFAIL, "SHM_LOCK is cleared");
> +}
> +
> +static void func_unlock(int ret)
> +{
> +	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> +		tst_resm(TBROK, "stat failed in func_unlock()");
> +		return;
> +	}
> +
> +	if (buf.shm_perm.mode & SHM_LOCKED)
> +		tst_resm(TFAIL, "SHM_LOCK is set");
> +	else
> +		tst_resm(TPASS, "SHM_LOCK is cleared");
> +}
> +
> +
>  /*
>   * func_rmid() - check the functionality of the IPC_RMID command with
>   shmctl()
>   */
> -void func_rmid(void)
> +void func_rmid(int ret)
>  {
>  	/* Do another shmctl() - we should get EINVAL */
>  	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1)
> --
> 1.8.1
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
