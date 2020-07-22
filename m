From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 22 Jul 2020 16:50:00 +0200
Subject: [LTP] [PATCH 9/9] syscalls/ipc: Rewrite shmctl01
In-Reply-To: <20200717163453.9587-10-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-10-chrubis@suse.cz>
Message-ID: <f467fe4f-6ede-dd8c-35a2-a580517f9a85@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
redesigned test scenario looks good so the only thing blocking merge
here are the bugs in preceding patches.

On 17. 07. 20 18:34, Cyril Hrubis wrote:
> This commit rewrites the shmctl01 and only keep testcases not covered
> by the rest of the testcases.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

> ---
>  testcases/kernel/syscalls/ipc/shmctl/Makefile |   1 -
>  .../kernel/syscalls/ipc/shmctl/shmctl01.c     | 586 ++++++------------
>  2 files changed, 178 insertions(+), 409 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
> index a004084ad..64d76112a 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
> +++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
> @@ -10,7 +10,6 @@ shmctl05: LDLIBS += -lrt
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> -shmctl01: LDLIBS += -lltpipc
>  shmctl02 shmctl04 shmctl06: LDLIBS += -lltpnewipc
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> index 52bf23a40..3a39a4d74 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> @@ -1,499 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
>   */
> -
>  /*
> - * NAME
> - *	shmctl01.c
> + * Verify that shmctl() IPC_STAT and SHM_STAT reports correct data.
> + *
> + * The shm_nattach is excercised by:
>   *
> - * DESCRIPTION
> - *	shmctl01 - test the IPC_STAT, IPC_SET and IPC_RMID commands as
> - *		   they are used with shmctl()
> + * 1. forking() children that attach and detach SHM
> + * 2. attaching the SHM before fork and letting the children detach it
>   *
> - * ALGORITHM
> - *	loop if that option was specified
> - *	create a shared memory segment with read and write permission
> - *	set up any test case specific conditions
> - *	call shmctl() using the TEST macro
> - *	check the return code
> - *	  if failure, issue a FAIL message.
> - *	otherwise,
> - *	  if doing functionality testing
> - *		call the correct test function
> - *		if the conditions are correct,
> - *			issue a PASS message
> - *		otherwise
> - *			issue a FAIL message
> - *	  otherwise
> - *	    issue a PASS message
> - *	call cleanup
> + * We check that the number shm_nattach is correct after each step we do.
>   */
>  
> -#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> -#endif
> -#include "ipcshm.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "shmctl01";
> -
> -static int shm_id_1 = -1;
> -static int shm_index;
> -static struct shmid_ds buf;
> -static struct shminfo info;
> -static long save_time;
> -
> -#define FIRST	0
> -#define SECOND	1
> -static int stat_time;
> -
> -static void *set_shared;
> -
> -#define N_ATTACH	4
> -
> -static pid_t pid_arr[N_ATTACH];
> -
> -/* Setup, cleanup and check routines for IPC_STAT */
> -static void stat_setup(void), func_istat(int ret);
> -static void stat_cleanup(void);
> -
> -/* Setup and check routines for IPC_SET */
> -static void set_setup(void), func_set(int ret);
> -
> -/* Check routine for IPC_INFO */
> -static void func_info(int ret);
> -
> -/* Check routine for SHM_STAT */
> -static void func_sstat(int ret);
> -static void func_sstat_setup(void);
> -
> -/* Check routine for SHM_LOCK */
> -static void func_lock(int ret);
> -
> -/* Check routine for SHM_UNLOCK */
> -static void func_unlock(int ret);
> -
> -/* Check routine for IPC_RMID */
> -static void func_rmid(int ret);
> -
> -/* Child function */
> -static void do_child(void);
> -
> -static struct test_case_t {
> -	int *shmid;
> -	int cmd;
> -	struct shmid_ds *arg;
> -	void (*func_test) (int);
> -	void (*func_setup) (void);
> -} TC[] = {
> -	{&shm_id_1, IPC_STAT, &buf, func_istat, stat_setup},
> -#ifndef UCLINUX
> -	    /*
> -	     * The second test is not applicable to uClinux;
> -	     * shared memory segments are detached on exec(),
> -	     * so cannot be passed to uClinux children.
> -	     */
> -	{&shm_id_1, IPC_STAT, &buf, func_istat, stat_setup},
> -#endif
> -	{&shm_id_1, IPC_SET, &buf, func_set, set_setup},
> -	{&shm_id_1, IPC_INFO, (struct shmid_ds *) &info, func_info, NULL},
> -	{&shm_index, SHM_STAT, &buf, func_sstat, func_sstat_setup},
> -	{&shm_id_1, SHM_LOCK, NULL, func_lock, NULL},
> -	{&shm_id_1, SHM_UNLOCK, NULL, func_unlock, NULL},
> -	{&shm_id_1, IPC_RMID, NULL, func_rmid, NULL},
> -};
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
>  
> -static int TST_TOTAL = ARRAY_SIZE(TC);
> +#define NCHILD 20
>  
> -#define NEWMODE	0066
> +static pid_t children[NCHILD];
>  
> -#ifdef UCLINUX
> -#define PIPE_NAME	"shmctl01"
> -static char *argv0;
> -#endif
> +static int shm_id;
> +static int shm_idx;
> +static time_t ctime_min, ctime_max;
>  
> -static int stat_i;
> +static void *addr;
>  
> -int main(int argc, char *argv[])
> +static void attach_child(void)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -#ifdef UCLINUX
> -	argv0 = argv[0];
> -	maybe_run_child(do_child, "ddd", &stat_i, &stat_time, &shm_id_1);
> -#endif
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		stat_time = FIRST;
> -
> -		/*
> -		 * Create a shared memory segment with read and write
> -		 * permissions.  Do this here instead of in setup()
> -		 * so that looping (-i) will work correctly.
> -		 */
> -		shm_id_1 = shmget(shmkey, SHM_SIZE,
> -				  IPC_CREAT | IPC_EXCL | SHM_RW);
> -		if (shm_id_1 == -1)
> -			tst_brkm(TBROK, cleanup, "couldn't create the shared"
> -				 " memory segment");
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			/*
> -			 * if needed, set up any required conditions by
> -			 * calling the appropriate setup function
> -			 */
> -			if (TC[i].func_setup != NULL)
> -				(*TC[i].func_setup) ();
> -
> -			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].arg));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "%s call failed - errno "
> -					 "= %d : %s", TCID, TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -				continue;
> -			}
> -			(*TC[i].func_test) (TEST_RETURN);
> -		}
> -	}
> +	pause();
> +
> +	addr = SAFE_SHMAT(shm_id, NULL, 0);
> +
> +	pause();
>  
> -	cleanup();
> -	tst_exit();
> +	SAFE_SHMDT(addr);
> +
> +	pause();
> +
> +	exit(0);
>  }
>  
> -/*
> - * set_shmat() - Attach the shared memory and return the pointer.  Use
> - *		 this seperate routine to avoid code duplication in
> - *		 stat_setup() below.
> - */
> -void *set_shmat(void)
> +static void detach_child(void)
>  {
> -	void *rval;
> -
> -	/* attach the shared memory */
> -	rval = shmat(shm_id_1, 0, 0);
> -
> -	/*
> -	 * if shmat() fails, the only thing we can do is
> -	 * print a message to that effect.
> -	 */
> -	if (rval == (void *)-1) {
> -		tst_resm(TBROK, "shmat() failed - %s", strerror(errno));
> -		cleanup();
> -	}
> +	pause();
> +
> +	SAFE_SHMDT(addr);
>  
> -	return rval;
> +	pause();
> +
> +	exit(0);
>  }
>  
> -/*
> - * stat_setup() - Set up for the IPC_STAT command with shmctl().
> - *		  Make things interesting by forking some children
> - *		  that will either attach or inherit the shared memory.
> - */
> -void stat_setup(void)
> +static void fork_children(void (*child_func)(void))
>  {
> -	void *set_shmat();
> -	pid_t pid;
> -
> -	/*
> -	 * The first time through, let the children attach the memory.
> -	 * The second time through, attach the memory first and let
> -	 * the children inherit the memory.
> -	 */
> -
> -	if (stat_time == SECOND)
> -		/*
> -		 * use the global "set_shared" variable here so that
> -		 * it can be removed in the stat_func() routine.
> -		 */
> -		set_shared = set_shmat();
> -
> -	tst_old_flush();
> -	for (stat_i = 0; stat_i < N_ATTACH; stat_i++) {
> -		pid = FORK_OR_VFORK();
> -		if (pid == -1)
> -			tst_brkm(TBROK, cleanup, "could not fork");
> -
> -		if (pid == 0) {
> -#ifdef UCLINUX
> -			if (self_exec(argv0, "ddd", stat_i, stat_time,
> -				      shm_id_1) < 0)
> -				tst_brkm(TBROK, cleanup, "could not self_exec");
> -#else
> -			do_child();
> -#endif
> -
> -		} else {
> -			/* save the child's pid for cleanup later */
> -			pid_arr[stat_i] = pid;
> -			TST_PROCESS_STATE_WAIT(cleanup, pid, 'S');
> -		}
> +	unsigned int i;
> +
> +	for (i = 0; i < NCHILD; i++) {
> +		pid_t pid = SAFE_FORK();
> +
> +		if (!pid)
> +			child_func();
> +
> +		children[i] = pid;
>  	}
>  }
>  
> -void do_child(void)
> +static void wait_for_children(void)
>  {
> -	void *test;
> +	unsigned int i;
>  
> -	if (stat_time == FIRST)
> -		test = set_shmat();
> -	else
> -		test = set_shared;
> +	for (i = 0; i < NCHILD; i++)
> +		TST_PROCESS_STATE_WAIT(children[i], 'S', 0);
> +}
>  
> -	memcpy(test, &stat_i, sizeof(stat_i));
> +static void signal_children(void)
> +{
> +	unsigned int i;
>  
> -	/* pause until we get a signal from stat_cleanup() */
> -	pause();
> +	for (i = 0; i < NCHILD; i++)
> +		SAFE_KILL(children[i], SIGUSR1);
> +}
>  
> -	/* now we're back - detach the memory and exit */
> -	if (shmdt(test) == -1)
> -		tst_resm(TBROK, "shmdt() failed - %d", errno);
> +static void reap_children(void)
> +{
> +	unsigned int i;
>  
> -	tst_exit();
> +	for (i = 0; i < NCHILD; i++)
> +		SAFE_WAITPID(children[i], NULL, 0);
>  }
>  
> -/*
> - * func_istat() - check the functionality of the IPC_STAT command with shmctl()
> - *		 by looking at the pid of the creator, the segement size,
> - *		 the number of attaches and the mode.
> - */
> -void func_istat(int ret)
> +static void check_nattch(int exp_nattch, const char *msg)
>  {
> -	int fail = 0;
> -	pid_t pid;
> +	struct shmid_ds ds1;
> +	struct shmid_ds ds2;
>  
> -	/* check perm, pid, nattach and size */
> +	SAFE_SHMCTL(shm_id, IPC_STAT, &ds1);
> +	SAFE_SHMCTL(shm_idx, SHM_STAT, &ds2);
>  
> -	pid = getpid();
> -
> -	if (buf.shm_cpid != pid) {
> -		tst_resm(TFAIL, "creator pid is incorrect");
> -		fail = 1;
> +	if (ds1.shm_nattch != ds2.shm_nattch) {
> +		tst_res(TFAIL, "IPC_STAT nattch=%li SHM_STAT nattch=%li",
> +			(long)ds1.shm_nattch, (long)ds2.shm_nattch);
> +		return;
>  	}
>  
> -	if (!fail && buf.shm_segsz != SHM_SIZE) {
> -		tst_resm(TFAIL, "segment size is incorrect");
> -		fail = 1;
> +	if ((int)ds1.shm_nattch == exp_nattch) {
> +		tst_res(TPASS, "%s shm_nattch=%i", msg, exp_nattch);
> +		return;
>  	}
>  
> -	/*
> -	 * The first time through, only the children attach the memory, so
> -	 * the attaches equal N_ATTACH + stat_time (0).  The second time
> -	 * through, the parent attaches the memory and the children inherit
> -	 * that memory so the attaches equal N_ATTACH + stat_time (1).
> -	 */
> -	if (!fail && buf.shm_nattch != N_ATTACH + stat_time) {
> -		tst_resm(TFAIL, "# of attaches is incorrect - %ld",
> -			 buf.shm_nattch);
> -		fail = 1;
> -	}
> +	tst_res(TFAIL, "%s shm_nattcg=%li expected %i",
> +	        msg, (long)ds1.shm_nattch, exp_nattch);
> +}
>  
> -	/* use MODE_MASK to make sure we are comparing the last 9 bits */
> -	if (!fail && (buf.shm_perm.mode & MODE_MASK) !=
> -			((SHM_RW) & MODE_MASK)) {
> -		tst_resm(TFAIL, "segment mode is incorrect");
> -		fail = 1;
> -	}
> +static void verify_shmstat_attach(void)
> +{
> +	fork_children(attach_child);
> +	wait_for_children();
>  
> -	stat_cleanup();
> +	check_nattch(0, "before child shmat()");
>  
> -	/* save the change time for use in the next test */
> -	save_time = buf.shm_ctime;
> +	signal_children();
> +	wait_for_children();
>  
> -	if (fail)
> -		return;
> +	check_nattch(NCHILD, "after child shmat()");
> +
> +	signal_children();
> +	wait_for_children();
> +
> +	check_nattch(0, "after child shmdt()");
>  
> -	tst_resm(TPASS, "pid, size, # of attaches and mode are correct "
> -		 "- pass #%d", stat_time);
> +	signal_children();
> +	reap_children();
>  }
>  
> -/*
> - * stat_cleanup() - signal the children to clean up after themselves and
> - *		    have the parent make dessert, er, um, make that remove
> - *		    the shared memory that is no longer needed.
> - */
> -void stat_cleanup(void)
> +static void verify_shmstat_inherit(void)
>  {
> -	int i;
> +	addr = SAFE_SHMAT(shm_id, NULL, 0);
>  
> -	/* wake up the childern so they can detach the memory and exit */
> -	for (i = 0; i < N_ATTACH; i++) {
> -		SAFE_KILL(cleanup, pid_arr[i], SIGUSR1);
> -	}
> +	fork_children(detach_child);
> +	wait_for_children();
>  
> -	/* remove the parent's shared memory the second time through */
> -	if (stat_time == SECOND) {
> -		if (shmdt(set_shared) == -1)
> -			tst_resm(TINFO, "shmdt() failed");
> -	}
> +	check_nattch(NCHILD+1, "inherited after fork()");
>  
> -	for (i = 0; i < N_ATTACH; i++) {
> -		SAFE_WAITPID(cleanup, pid_arr[i], NULL, 0);
> -	}
> +	signal_children();
> +	wait_for_children();
>  
> -	stat_time++;
> -}
> +	check_nattch(1, "after child shmdt()");
>  
> -/*
> - * set_setup() - set up for the IPC_SET command with shmctl()
> - */
> -void set_setup(void)
> -{
> -	/* set up a new mode for the shared memory segment */
> -	buf.shm_perm.mode = SHM_RW | NEWMODE;
> +	SAFE_SHMDT(addr);
>  
> -	/* sleep for one second to get a different shm_ctime value */
> -	sleep(1);
> +	check_nattch(0, "after parent shmdt()");
> +
> +	signal_children();
> +	reap_children();
>  }
>  
> -/*
> - * func_set() - check the functionality of the IPC_SET command with shmctl()
> - */
> -void func_set(int ret)
> +static void check_ds(struct shmid_ds *ds, const char *desc)
>  {
> -	int fail = 0;
> +	pid_t pid = getpid();
>  
> -	/* first stat the shared memory to get the new data */
> -	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> -		tst_resm(TBROK, "stat failed in func_set()");
> -		return;
> +	if (ds->shm_segsz != SHM_SIZE) {
> +		tst_res(TFAIL, "%s: shm_segsz=%zu, expected %i",
> +		        desc, ds->shm_segsz, SHM_SIZE);
> +	} else {
> +		tst_res(TPASS, "%s: shm_segsz=%i", desc, SHM_SIZE);
>  	}
>  
> -	if ((buf.shm_perm.mode & MODE_MASK) !=
> -			((SHM_RW | NEWMODE) & MODE_MASK)) {
> -		tst_resm(TFAIL, "new mode is incorrect");
> -		fail = 1;
> +	if (ds->shm_cpid != pid) {
> +		tst_res(TFAIL, "%s: shm_cpid=%i, expected %i",
> +		        desc, ds->shm_cpid, pid);
> +	} else {
> +		tst_res(TPASS, "%s: shm_cpid=%i", desc, pid);
>  	}
>  
> -	if (!fail && save_time >= buf.shm_ctime) {
> -		tst_resm(TFAIL, "change time is incorrect");
> -		fail = 1;
> +	if (ds->shm_ctime < ctime_min || ds->shm_ctime > ctime_max) {
> +		tst_res(TFAIL, "%s: shm_ctime=%li, expected <%li,%li>",
> +			desc, ds->shm_ctime, ctime_min, ctime_max);
> +	} else {
> +		tst_res(TPASS, "%s: shm_ctime=%li in range <%li,%li>",
> +			desc, ds->shm_ctime, ctime_min, ctime_max);
>  	}
> -
> -	if (fail)
> -		return;
> -
> -	tst_resm(TPASS, "new mode and change time are correct");
>  }
>  
> -static void func_info(int ret)
> +static void shmstat_basic_check(void)
>  {
> -	if (info.shmmin != 1)
> -		tst_resm(TFAIL, "value of shmmin is incorrect");
> -	else
> -		tst_resm(TPASS, "get correct shared memory limits");
> -}
> +	struct shmid_ds ds;
>  
> -static void func_sstat(int ret)
> -{
> -	if (ret >= 0)
> -		tst_resm(TPASS, "get correct shared memory id for index: %d",
> -			shm_index);
> -	else
> -		tst_resm(TFAIL, "shared memory id is incorrect, index: %d",
> -			shm_index);
> -}
> +	memset(&ds, 0, sizeof(ds));
> +	SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
>  
> -static void func_sstat_setup(void)
> -{
> -	struct shm_info tmp;
> -	int ret;
> -
> -	ret = shmctl(shm_id_1, SHM_INFO, (void *)&tmp);
> -	if (ret < 0)
> -		tst_resm(TFAIL|TERRNO, "shmctl(SHM_INFO)");
> -	else
> -		shm_index = ret;
> -}
> +	check_ds(&ds, "IPC_STAT");
>  
> -static void func_lock(int ret)
> -{
> -	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> -		tst_resm(TBROK, "stat failed in func_lock()");
> -		return;
> -	}
> +	memset(&ds, 0, sizeof(ds));
> +	SAFE_SHMCTL(shm_idx, SHM_STAT, &ds);
>  
> -	if (buf.shm_perm.mode & SHM_LOCKED)
> -		tst_resm(TPASS, "SHM_LOCK is set");
> -	else
> -		tst_resm(TFAIL, "SHM_LOCK is cleared");
> +	check_ds(&ds, "SHM_STAT");
>  }
>  
> -static void func_unlock(int ret)
> -{
> -	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
> -		tst_resm(TBROK, "stat failed in func_unlock()");
> -		return;
> -	}
> +static struct tcase {
> +	void (*func)(void);
> +	const char *desc;
> +} tcases[] = {
> +	{shmstat_basic_check, "Basic checks"},
> +	{verify_shmstat_attach, "Children attach SHM"},
> +	{verify_shmstat_inherit, "Chidlren inherit SHM"},
> +};
>  
> -	if (buf.shm_perm.mode & SHM_LOCKED)
> -		tst_resm(TFAIL, "SHM_LOCK is set");
> -	else
> -		tst_resm(TPASS, "SHM_LOCK is cleared");
> +static void verify_shmstat(unsigned int n)
> +{
> +	tst_res(TINFO, "%s", tcases[n].desc);
> +	tcases[n].func();
>  }
>  
> +static void dummy_sighandler(int sig)
> +{
> +	(void)sig;
> +}
>  
> -/*
> - * func_rmid() - check the functionality of the IPC_RMID command with shmctl()
> - */
> -void func_rmid(int ret)
> +static int get_shm_idx_from_id(int shm_id)
>  {
> -	/* Do another shmctl() - we should get EINVAL */
> -	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1)
> -		tst_brkm(TBROK, cleanup, "shmctl succeeded on expected fail");
> +	struct shm_info dummy;
> +	struct shmid_ds dummy_ds;
> +	int max_idx, i;
>  
> -	if (errno != EINVAL)
> -		tst_resm(TFAIL, "returned unexpected errno %d", errno);
> -	else
> -		tst_resm(TPASS, "shared memory appears to be removed");
> +	max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void*)&dummy);
>  
> -	shm_id_1 = -1;
> -}
> +	for (i = 0; i <= max_idx; i++) {
> +		if (shmctl(i, SHM_STAT, &dummy_ds) == shm_id)
> +			return i;
> +	}
>  
> -/*
> - * sighandler() - handle signals, in this case SIGUSR1 is the only one expected
> - */
> -void sighandler(int sig)
> -{
> -	if (sig != SIGUSR1)
> -		tst_resm(TBROK, "received unexpected signal %d", sig);
> +	return -1;
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> -	tst_sig(FORK, sighandler, cleanup);
> +	ctime_min = time(NULL);
> +	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
> +	ctime_max = time(NULL);
> +
> +	shm_idx = get_shm_idx_from_id(shm_id);
>  
> -	TEST_PAUSE;
> +	if (shm_idx < 0)
> +		tst_brk(TBROK, "Failed to get shm_id to idx mapping");
>  
> -	tst_tmpdir();
> +	tst_res(TINFO, "shm_id=%i maps to kernel index=%i", shm_id, shm_idx);
>  
> -	shmkey = getipckey();
> +	SAFE_SIGNAL(SIGUSR1, dummy_sighandler);
>  }
>  
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	rm_shm(shm_id_1);
> -
> -	tst_rmdir();
> +	if (shm_id >= 0)
> +		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.test = verify_shmstat,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
