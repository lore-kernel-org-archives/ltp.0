From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2021 13:25:05 +0100
Subject: [LTP] [PATCH 5/5] syscalls/ipc: semctl07: Convert to new API
 and cleanup
In-Reply-To: <1609918063-15810-5-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1609918063-15810-5-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <YBFboS09Wgc9F7TF@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - * ALGORITHM
> + * DESCRIPTION
>   *	Get and manipulate a set of semaphores.
>   *
> - * RESTRICTIONS
> - *
>   * HISTORY
> - *      10/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
> - *      - Fix concurrency issue. A statically defined key was used. Leading
> - *        to conflict with other instances of the same test.
> + *	06/30/2001   Port to Linux   nsharoff@us.ibm.com
> + *	10/30/2002   Port to LTP     dbarrera@us.ibm.com
> + *	10/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
> + *	- Fix concurrency issue. A statically defined key was used. Leading
> + *	  to conflict with other instances of the same test.
>   */

The description should be changed into the docparser format and also bit
more verbose something as:

/*\
 * [DESCRIPTION]
 *
 * Basic tests for semctl().
 *
 * - semctl() with IPC_STAT where we check the semid_ds buf content
 * - semctl() with SETVAL and GETVAL
 * - semctl() with GETPID
 * - semctl() with GETNCNT and GETZCNT
\*/


> -#include <sys/types.h>
> -#include <sys/ipc.h>
>  #include <sys/sem.h>
> -#include <signal.h>
>  #include <errno.h>
>  #include <stdio.h>
>  #include <sys/wait.h>
> -#include "ipcsem.h"
> -#include "test.h"
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char *TCID = "semctl07";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
> +#include "lapi/sem.h"
>  
> -key_t key;
> -int semid = -1, nsems;
> +static int semid = -1;
> +static unsigned long nsems;
>  
> -int main(int argc, char *argv[])
> +static void verify_semctl(void)
>  {
>  	int status;
>  	struct semid_ds buf_ds;
>  	union semun arg;
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
>  	arg.buf = &buf_ds;
> -	if ((status = semctl(semid, 0, IPC_STAT, arg)) == -1) {
> -		tst_resm(TFAIL, "semctl() failed errno = %d", errno);
> -		semctl(semid, 1, IPC_RMID, arg);
> -
> -	}
> -
> -	/*
> -	 * Check contents of semid_ds structure.
> -	 */
> +	status = SAFE_SEMCTL(semid, 0, IPC_STAT, arg);
>  
>  	if (arg.buf->sem_nsems != nsems) {
> -		tst_resm(TFAIL, "error: unexpected number of sems %lu",
> +		tst_res(TFAIL, "error: unexpected number of sems %lu",
>  			 arg.buf->sem_nsems);
> -
>  	}
> +
>  	if (arg.buf->sem_perm.uid != getuid()) {
> -		tst_resm(TFAIL, "error: unexpected uid %d",
> +		tst_res(TFAIL, "error: unexpected uid %d",
>  			 arg.buf->sem_perm.uid);
> -
>  	}
> +
>  	if (arg.buf->sem_perm.gid != getgid()) {
> -		tst_resm(TFAIL, "error: unexpected gid %d",
> +		tst_res(TFAIL, "error: unexpected gid %d",
>  			 arg.buf->sem_perm.gid);
> -
>  	}
> +
>  	if (arg.buf->sem_perm.cuid != getuid()) {
> -		tst_resm(TFAIL, "error: unexpected cuid %d",
> +		tst_res(TFAIL, "error: unexpected cuid %d",
>  			 arg.buf->sem_perm.cuid);
> -
>  	}
> +
>  	if (arg.buf->sem_perm.cgid != getgid()) {
> -		tst_resm(TFAIL, "error: unexpected cgid %d",
> +		tst_res(TFAIL, "error: unexpected cgid %d",
>  			 arg.buf->sem_perm.cgid);
> -
>  	}
> -	if ((status = semctl(semid, 0, GETVAL, arg)) == -1) {
> -		tst_resm(TFAIL, "semctl(GETVAL) failed errno = %d", errno);
>  
> -	}
> +	if ((status = semctl(semid, 0, GETVAL, arg)) == -1)
> +		tst_res(TFAIL, "semctl(GETVAL) failed errno = %d", errno);
> +
>  	arg.val = 1;
> -	if ((status = semctl(semid, 0, SETVAL, arg)) == -1) {
> -		tst_resm(TFAIL, "SEMCTL(SETVAL) failed errno = %d", errno);
> +	if ((status = semctl(semid, 0, SETVAL, arg)) == -1)
> +		tst_res(TFAIL, "SEMCTL(SETVAL) failed errno = %d", errno);
>  
> -	}
> -	if ((status = semctl(semid, 0, GETVAL, arg)) == -1) {
> -		tst_resm(TFAIL, "semctl(GETVAL) failed errno = %d", errno);
> +	if ((status = semctl(semid, 0, GETVAL, arg)) == -1)
> +		tst_res(TFAIL, "semctl(GETVAL) failed errno = %d", errno);
>  
> -	}
> -	if (status != arg.val) {
> -		tst_resm(TFAIL, "error: unexpected value %d", status);
> +	if (status != arg.val)
> +		tst_res(TFAIL, "error: unexpected value %d", status);
>  
> -	}
> -	if ((status = semctl(semid, 0, GETPID, arg)) == -1) {
> -		tst_resm(TFAIL, "semctl(GETPID) failed errno = %d", errno);
> +	if ((status = semctl(semid, 0, GETPID, arg)) == -1)
> +		tst_res(TFAIL, "semctl(GETPID) failed errno = %d", errno);
>  
> -	}
>  	status = getpid();
> -	if (status == 0) {
> -		tst_resm(TFAIL, "error: unexpected pid %d", status);
> +	if (status == 0)
> +		tst_res(TFAIL, "error: unexpected pid %d", status);

This seems to be completely bogus, we should actually check here that
the value of status is equal to getpid().

Also this and a few other operations do not need arg to be passed as
last argument. Basically all the GET operations that return the value
directly in the return value does not need arg to be passed.

> -	}
> -	if ((status = semctl(semid, 0, GETNCNT, arg)) == -1) {
> -		tst_resm(TFAIL, "semctl(GETNCNT) failed errno = %d", errno);
> +	if ((status = semctl(semid, 0, GETNCNT, arg)) == -1)
> +		tst_res(TFAIL, "semctl(GETNCNT) failed errno = %d", errno);
>  
> -	}
> -	if (status != 0) {
> -		tst_resm(TFAIL, "error: unexpected semncnt %d", status);
> +	if (status != 0)
> +		tst_res(TFAIL, "error: unexpected semncnt %d", status);
>  
> -	}
> -	if ((status = semctl(semid, 0, GETZCNT, arg)) == -1) {
> -		tst_resm(TFAIL, "semctl(GETZCNT) failed errno = %d", errno);
> -
> -	}
> -	if (status != 0) {
> -		tst_resm(TFAIL, "error: unexpected semzcnt %d", status);
> -
> -	}
> +	if ((status = semctl(semid, 0, GETZCNT, arg)) == -1)
> +		tst_res(TFAIL, "semctl(GETZCNT) failed errno = %d", errno);
>  
> -	tst_resm(TPASS, "semctl07 ran successfully!");
> +	if (status != 0)
> +		tst_res(TFAIL, "error: unexpected semzcnt %d", status);
>  
> -	cleanup();
> -	tst_exit();
> +	tst_res(TPASS, "semctl07 ran successfully!");

This part is broken. We do issue the TPASS here even if one of the above
statement issued TFAIL.

So we either change the code to produce TPASS/TFAIL pair on each check
e.g.

	if (status != arg.val) {
		tst_res(TFAIL, "semctl(GETVAL) returned %d expected %d",
		        arg.val, status);
	} else {
		tst_res(TPASS, "semctl(GETVAL) returned %d", arg.val);
	}

Or we have to maintain flag that is set to non-zero on any failure and
then we can, at the end of the test do:

	if (!flag)
		tst_res(TPASS, "everything is fine");

>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	/* get an IPC resource key */
> -	key = getipckey();
> +	key_t key = GETIPCKEY();
>  	nsems = 1;
>  
> -	if ((semid = semget(key, nsems, SEM_RA | IPC_CREAT)) == -1) {
> -		tst_brkm(TFAIL, NULL, "semget() failed errno = %d", errno);
> -	}
> +	semid = SAFE_SEMGET(key, nsems, SEM_RA | IPC_CREAT);
>  }
>  
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	rm_sema(semid);
> -	tst_rmdir();
> +	if (semid != -1)
> +		SAFE_SEMCTL(semid, 0, IPC_RMID);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.test_all = verify_semctl,
> +};
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
