From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jun 2017 16:54:18 +0200
Subject: [LTP] [PATCH v3] syscalls/shmat0*: cleanup && convert to new API
In-Reply-To: <1498789859-6553-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170629161411.GD3233@rei.suse.de>
 <1498789859-6553-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170630145418.GE18305@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * 1) shmat() fails and set errno to EINVAL when shmid is invalid.
> + * 2) shmat() fails and set errno to EINVAL when shmaddr is not page
> + *    aligned and SHM_RND is not given
> + * 3) shmat() fails and set errno to EACCES when the shm resource has
> + *    no read/write permission.

Sorry for not catching it earlier, it took me some time to figure out
that this case (3) is just the same as test 4. It does not matter if you
set the permissions 0600 or 0000 the nobody user will be rejected with
EACCESS either way.

So can we get rid of the rw_flag in the test structure and keep only one
EACESS test here? Then we would only need two shm ids, one valid and one
invalid...

> + * 4) shmat() fails and set errno to EACCES when non-root user access
> + *    shm created by root.
>   */
>  
> -#include "ipcshm.h"
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
>  #include <pwd.h>
> -#include "shmat_common.h"
> -
> -char *TCID = "shmat02";
> -char nobody_uid[] = "nobody";
> -struct passwd *ltpuser;
>  
> -int shm_id_1 = -1;
> -int shm_id_2 = -1;
> -int shm_id_3 = -1;
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
>  
> -void *base_addr;		/* By probing this address first, we can make
> -				 * non-aligned addresses from it for different
> -				 * architectures without explicitly code it.
> -				 */
> +static int shm_id1 = -1;
> +static int shm_id2 = -1;
> +static int shm_id3 = -1;
> +static void *aligned_addr;
> +static void *unaligned_addr;
> +static key_t shm_key1, shm_key2;
> +static struct passwd *pw;
>  
> -void *addr;			/* for result of shmat-call */
> -
> -struct test_case_t {
> +static struct test_case_t {
>  	int *shmid;
> -	int offset;
> -	int error;
> +	void **shmaddr;
> +	int rw_flag;
> +	int exp_err;
> +	int exp_user;
> +} tcases[] = {
> +	{&shm_id1, &aligned_addr, 1, EINVAL, 0},
> +	{&shm_id2, &unaligned_addr, 1, EINVAL, 0},
> +	{&shm_id2, &aligned_addr, 1, EACCES, 1},
> +	{&shm_id3, &aligned_addr, 0, EACCES, 1}
>  };
>  
> -int TST_TOTAL = 3;
> -
> -static void setup_tc(int i, struct test_case_t *tc)
> +static void verify_shmat(struct test_case_t *tc)
>  {
> +	void *addr;
>  
> -	struct test_case_t TC[] = {
> -		/* EINVAL - the shared memory ID is not valid */
> -		{&shm_id_1, 0, EINVAL},
> -		/* EINVAL - the address is not page aligned and SHM_RND is not given */
> -		{&shm_id_2, SHMLBA - 1, EINVAL},
> -		/* EACCES - the shared memory resource has no read/write permission */
> -		{&shm_id_3, 0, EACCES}
> -	};
> +	if (!tc->rw_flag)
> +		shm_id3 = SAFE_SHMGET(shm_key2, INT_SIZE, IPC_CREAT | IPC_EXCL);
>  
> -	if (i > TST_TOTAL || i < 0)
> +	addr = shmat(*tc->shmid, *tc->shmaddr, 0);
> +	if (addr != (void *)-1) {
> +		tst_res(TFAIL, "shmat() succeeded unexpectedly");
>  		return;
> +	}
> +
> +	if (errno == tc->exp_err) {
> +		tst_res(TPASS | TERRNO, "shmat() failed as expected");
> +	} else {
> +		tst_res(TFAIL | TERRNO, "shmat() failed unexpectedly,"
> +			 "expected: %s", tst_strerrno(tc->exp_err));
> +	}
>  
> -	*tc = TC[i];
> +	if (shm_id3 != -1)
> +		SAFE_SHMCTL(shm_id3, IPC_RMID, NULL);
>  }
>  
> -int main(int ac, char **av)
> +static void do_shmat(unsigned int n)
>  {
> -	int lc;
> -	int i;
> -	struct test_case_t *tc;
> -
> -	tc = NULL;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	tc = malloc(sizeof(struct test_case_t));
> -	if (tc == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc failed");
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			setup_tc(i, tc);
> -
> -			base_addr = probe_free_addr();
> -			errno = 0;
> -			addr = shmat(*(tc->shmid), base_addr + tc->offset, 0);
> -
> -			if (addr != (void *)-1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (errno == tc->error)
> -				tst_resm(TPASS | TERRNO,
> -					 "shmat failed as expected");
> -			else
> -				tst_resm(TFAIL,
> -					 "shmat failed unexpectedly; expected: "
> -					 "%d - %s", tc->error,
> -					 strerror(tc->error));
> +	pid_t pid;
> +
> +	struct test_case_t *tc = &tcases[n];
> +
> +	if (tc->exp_user == 0) {
> +		verify_shmat(tc);
> +	} else {
> +		pid = SAFE_FORK();
> +		if (pid) {
> +			tst_reap_children();
> +		} else {
> +			SAFE_SETUID(pw->pw_uid);
> +			verify_shmat(tc);
> +			exit(0);
>  		}
>  	}
> -
> -	cleanup();
> -
> -	tst_exit();
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> -	key_t shmkey2;
> -
> -	tst_require_root();
> -	ltpuser = getpwnam(nobody_uid);
> -	if (ltpuser == NULL)
> -		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
> -	if (setuid(ltpuser->pw_uid) == -1)
> -		tst_brkm(TBROK | TERRNO, NULL, "setuid failed");
> +	aligned_addr = PROBE_FREE_ADDR();
> +	unaligned_addr = aligned_addr + SHMLBA - 1;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	shm_key1 = GETIPCKEY();
> +	shm_key2 = GETIPCKEY();
>  
> -	TEST_PAUSE;
> +	shm_id2 = SAFE_SHMGET(shm_key1, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
>  
> -	tst_tmpdir();
> -
> -	shmkey = getipckey();
> -
> -	shm_id_2 = shmget(shmkey, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
> -	if (shm_id_2 == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "shmget #1 failed");
> -
> -	/* Get an new IPC resource key. */
> -	shmkey2 = getipckey();
> -
> -	/* create a shared memory resource without read and write permissions */
> -	shm_id_3 = shmget(shmkey2, INT_SIZE, IPC_CREAT | IPC_EXCL);
> -	if (shm_id_3 == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "shmget #2 failed");
> +	pw = SAFE_GETPWNAM("nobody");
>  }
>  
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	/* if they exist, remove the shared memory resources */
> -	rm_shm(shm_id_2);
> -	rm_shm(shm_id_3);
> -
> -	tst_rmdir();
> -
> +	if (shm_id2 != -1)
> +		SAFE_SHMCTL(shm_id2, IPC_RMID, NULL);
>  }
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.test = do_shmat,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup
> +};
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
> deleted file mode 100644
> index 266ea1c..0000000
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
> +++ /dev/null
> @@ -1,184 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -/*
> - * NAME
> - *	shmat03.c
> - *
> - * DESCRIPTION
> - *	shmat03 - test for EACCES error
> - *
> - * ALGORITHM
> - *	create a shared memory segment with root only read & write permissions
> - *	fork a child process
> - *	if child
> - *	  set the ID of the child process to that of "nobody"
> - *	  loop if that option was specified
> - *	    call shmat() using the TEST() macro
> - *	    check the errno value
> - *	      issue a PASS message if we get EACCES
> - *	    otherwise, the tests fails
> - *	      issue a FAIL message
> - *	  call cleanup
> - *	if parent
> - *	  wait for child to exit
> - *	  remove the shared memory segment
> - *
> - * USAGE:  <for command-line>
> - *  shmat03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	test must be run at root
> - */
> -
> -#include "ipcshm.h"
> -
> -char *TCID = "shmat03";
> -int TST_TOTAL = 1;
> -
> -int shm_id_1 = -1;
> -
> -void *addr;			/* for result of shmat-call */
> -
> -uid_t ltp_uid;
> -char *ltp_user = "nobody";
> -
> -static void do_child(void);
> -
> -int main(int ac, char **av)
> -{
> -	int pid;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup */
> -
> -	pid = FORK_OR_VFORK();
> -	if (pid == -1)
> -		tst_brkm(TBROK, cleanup, "could not fork");
> -
> -	if (pid == 0) {		/* child */
> -		/* set the user ID of the child to the non root user */
> -		if (setuid(ltp_uid) == -1) {
> -			perror("setuid() failed");
> -			exit(1);
> -		}
> -
> -		do_child();
> -
> -	} else {		/* parent */
> -		/* wait for the child to return */
> -		if (waitpid(pid, NULL, 0) == -1)
> -			tst_brkm(TBROK, cleanup, "waitpid failed");
> -
> -		/* if it exists, remove the shared memory resource */
> -		rm_shm(shm_id_1);
> -
> -		tst_rmdir();
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -/*
> - * do_child - make the TEST call as the child process
> - */
> -static void do_child(void)
> -{
> -	int lc;
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/*
> -		 * use TEST macro to make the call
> -		 */
> -		errno = 0;
> -		addr = shmat(shm_id_1, NULL, 0);
> -		TEST_ERRNO = errno;
> -
> -		if (addr != (char *)-1) {
> -			tst_resm(TFAIL, "call succeeded unexpectedly");
> -			continue;
> -		}
> -
> -		switch (TEST_ERRNO) {
> -		case EACCES:
> -			tst_resm(TPASS | TTERRNO, "expected failure");
> -			break;
> -		default:
> -			tst_resm(TFAIL | TTERRNO,
> -				 "call failed with an unexpected error");
> -			break;
> -		}
> -	}
> -}
> -
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> -	tst_require_root();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See ../lib/libipc.c for more information.
> -	 */
> -	tst_tmpdir();
> -
> -	/* get an IPC resource key */
> -	shmkey = getipckey();
> -
> -	/* create a shared memory segment with read and write permissions */
> -	shm_id_1 = shmget(shmkey, SHM_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
> -	if (shm_id_1 == -1)
> -		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
> -			 "segment in setup");
> -
> -	/* get the userid for a non root user */
> -	ltp_uid = getuserid(ltp_user);
> -}
> -
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - *		or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat_common.h b/testcases/kernel/syscalls/ipc/shmat/shmat_common.h
> deleted file mode 100644
> index 06cf5ab..0000000
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat_common.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -static key_t probe_key;
> -
> -void *probe_free_addr(void)
> -{
> -	void *p;
> -	int ret;
> -	int shm_id = -1;
> -
> -	if (probe_key == 0)
> -		probe_key = getipckey();
> -
> -	/* create a shared memory resource with read and write permissions
> -	 * We align this to SHMLBA so we should allocate at least
> -	 * SHMLBA*2 in case SHMLBA > page_size. */
> -	shm_id = shmget(probe_key, SHMLBA*2, SHM_RW | IPC_CREAT | IPC_EXCL);
> -	if (shm_id == -1)
> -		tst_brkm(TBROK, cleanup, "probe: shmget failed");
> -
> -	/* Probe an available linear address for attachment */
> -	p = shmat(shm_id, NULL, 0);
> -	if (p == (void *)-1)
> -		tst_brkm(TBROK, cleanup, "probe: shmat failed");
> -	ret = shmdt(p);
> -	if (ret == -1)
> -		tst_brkm(TBROK, cleanup, "probe: shmdt failed");
> -
> -	rm_shm(shm_id);
> -
> -	/* some architectures (e.g. parisc) are strange, so better always
> -	 * align to next SHMLBA address. */
> -	p = (void *)(((unsigned long)(p) + (SHMLBA - 1)) & ~(SHMLBA - 1));
> -	return p;
> -}
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
