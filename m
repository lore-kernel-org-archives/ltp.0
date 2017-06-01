From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 1 Jun 2017 17:03:53 +0800
Subject: [LTP] [PATCH 2/3] syscalls/shmat0*: cleanup && convert to new
 API
In-Reply-To: <20170529141124.GA6618@rei.lan>
References: <1492164917-9329-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1492164917-9329-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170529141124.GA6618@rei.lan>
Message-ID: <592FD879.8050208@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/05/29 22:11, Cyril Hrubis wrote:
Hi Cyril

Thanks for your comments.
I will send v2 patches as you said.
> Hi!
>> --- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
>> +++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
>> @@ -50,4 +50,7 @@ int get_used_queues(const char *file, const int lineno);
>>   #define GET_USED_QUEUES() \
>>   	get_used_queues(__FILE__, __LINE__)
>>
>> +void *probe_free_addr(void);
>> +#define PROBE_FREE_ADDR() probe_free_addr()
> Defining macro with the same name as function is pointless if we are not
> passing down __FILE__ and __LINE__ parameters as we do in SAFE_MACROS().
>
>> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
>> index 6de1872..9b9390f 100644
>> --- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
>> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
>> @@ -17,225 +17,111 @@
>>    */
>>
>>   /*
>> - * NAME
>> - *	shmat01.c
>> - *
>>    * DESCRIPTION
>> - *	shmat01 - test that shmat() works correctly
>>    *
>> - * ALGORITHM
>> - *	create a shared memory resouce with read/write permissions
>> - *	loop if that option was specified
>> - *	call shmat() with the TEST() macro using three valid conditions
>> - *	check the return code
>> - *	  if failure, issue a FAIL message.
>> - *	otherwise,
>> - *	  if doing functionality testing
>> - *		check for the correct conditions after the call
>> - *		if correct,
>> - *			issue a PASS message
>> - *		otherwise
>> - *			issue a FAIL message
>> - *	call cleanup
>> + * 1) shmat() chooses a suitable (unused) address when shmaddr is NULL.
>> + * 2) shmat() attaches shm segment to the shmaddr when shmaddr is a
>> + *    page-aligned address.
>> + * 3) shmat() attaches shm segment to the address equal to shmaddr rounded
>> + *    down to the nearest multiple of SHMLBA when shmaddr is not a
>> + *    page-unaligned address and shmflg is set to SHM_RND.
> "not a page-unaligned"  == "page-aligned" as far as I can tell
>
> You should drop one of the negations and use either "not page-aligned"
> or "page-unaligned".
>
>> + * 4) shmat() attaches shm segment to the shmaddr for reading when shmflg
>> + *    is set to SHM_RDONLY.
>>    */
>>
>> -#include "ipcshm.h"
>> -#include "shmat_common.h"
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<sys/ipc.h>
>> +#include<sys/shm.h>
>>
>> -#define CASE0		10
>> -#define CASE1		20
>> +#include "tst_test.h"
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "libnewipc.h"
>>
>> -char *TCID = "shmat01";
>> -int TST_TOTAL = 4;
>> +#define CONTENT	10
>>
>> -int shm_id_1 = -1;
>> -
>> -/*
>> - * By probing this address first, we can make
>> - * non-aligned addresses from it for different
>> - * architectures without explicitly code it.
>> - */
>> -void *base_addr;
>> -void *addr;
>> +static int shm_id = -1;
>> +static key_t shm_key;
>> +static void *null_addr;
>> +static void *aligned_addr;
>> +static void *unaligned_addr;
>>
>>   static struct test_case_t {
>> -	int *shmid;
>> -	int offset;
>> -	int flags;
>> -	int getbase;
>> -} *TC;
>> -
>> -static void check_functionality(int);
>> -
>> -int main(int argc, char *argv[])
>> +	void **shmaddr;
>> +	int flag;
>> +} tcases[] = {
>> +	{&null_addr, 0},
>> +	{&aligned_addr, 0},
>> +	{&unaligned_addr, SHM_RND},
>> +	{&aligned_addr, SHM_RDONLY}
>> +};
>> +
>> +static void verify_shmat(unsigned int n)
>>   {
>> -	int lc, i;
>> -	void *attchaddr;
>> -
>> -	tst_parse_opts(argc, argv, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		for (i = 0; i<  TST_TOTAL; i++) {
>> -
>> -			if (TC[i].getbase) {
>> -				base_addr = probe_free_addr();
>> -				attchaddr = base_addr + TC[i].offset;
>> -			} else {
>> -				attchaddr = NULL;
>> -			}
>> -
>> -			addr = shmat(*(TC[i].shmid), attchaddr, TC[i].flags);
>> +	int *addr;
>> +	struct shmid_ds buf;
>>
>> -			TEST_ERRNO = errno;
>> -			if (addr == (void *)-1) {
>> -				tst_brkm(TFAIL | TTERRNO, cleanup,
>> -					 "shmat call failed");
>> -			} else {
>> -				check_functionality(i);
>> -			}
>> +	struct test_case_t *tc =&tcases[n];
>>
>> -			if (shmdt(addr) == -1)
>> -				tst_brkm(TBROK, cleanup,
>> -					 "Couldn't detach shared memory");
>> -		}
>> +	addr = shmat(shm_id, *tc->shmaddr, tc->flag);
>> +	TEST_ERRNO = errno;
> Just use TERRNO below instead of TTERRNO.
>
>> +	if (addr == (void *)-1) {
>> +		tst_res(TFAIL | TTERRNO, "shmat() failed");
>> +		return;
>>   	}
>>
>> -	cleanup();
>> -
>> -	tst_exit();
>> -}
>> +	SAFE_SHMCTL(shm_id, IPC_STAT,&buf);
>>
>> -/*
>> - * check_functionality - check various conditions to make sure they
>> - *			 are correct.
>> - */
>> -static void check_functionality(int i)
>> -{
>> -	void *orig_add;
>> -	int *shared;
>> -	int fail = 0;
>> -	struct shmid_ds buf;
>> -
>> -	shared = (int *)addr;
>> -
>> -	/* stat the shared memory ID */
>> -	if (shmctl(shm_id_1, IPC_STAT,&buf) == -1)
>> -		tst_brkm(TBROK, cleanup, "couldn't stat shared memory");
>> -
>> -	/* check the number of attaches */
>>   	if (buf.shm_nattch != 1) {
>> -		tst_resm(TFAIL, "# of attaches is incorrect");
>> +		tst_res(TFAIL, "number of attaches was incorrect");
>>   		return;
>>   	}
>>
>> -	/* check the size of the segment */
>>   	if (buf.shm_segsz != INT_SIZE) {
>> -		tst_resm(TFAIL, "segment size is incorrect");
>> +		tst_res(TFAIL, "segment size was incorrect");
>>   		return;
>>   	}
>>
>> -	/* check for specific conditions depending on the type of attach */
>> -	switch (i) {
>> -	case 0:
>> -	case 1:
>> -		/*
>> -		 * Check the functionality of shmat by simply "writing"
>> -		 * a value to the shared memory space.
>> -		 * If this fails the program will get a SIGSEGV, dump
>> -		 * core and exit.
>> -		 */
>> -
>> -		*shared = CASE0;
>> -		break;
>> -	case 2:
>> -		/*
>> -		 * Check the functionality of shmat by writing a value
>> -		 * to the shared memory space and then checking that
>> -		 * the original address given was rounded down as
>> -		 * specified in the man page.
>> -		 */
>> -
>> -		*shared = CASE1;
>> -		orig_add = addr + ((unsigned long)TC[2].offset % SHMLBA);
>> -		if (orig_add != base_addr + TC[2].offset) {
>> -			tst_resm(TFAIL, "shared memory address is not "
>> -				 "correct");
>> -			fail = 1;
>> -		}
>> -		break;
>> -	case 3:
>> -		/*
>> -		 * This time the shared memory is read only.  Read the value
>> -		 * and check that it is equal to the value set in last case,
>> -		 * because shared memory is persistent.
>> -		 */
>> -
>> -		if (*shared != CASE1) {
>> -			tst_resm(TFAIL, "shared memory value isn't correct");
>> -			fail = 1;
>> +	if ((tc->flag&  SHM_RND)&&  addr != aligned_addr) {
>> +		tst_res(TFAIL, "shared memory address was not correct");
>> +		return;
>> +	}
> We do check here that the address was aligned in a case that we passed
> unaligned one, but we do not check that the aligned addres we supplied
> was used.
>
> What about introducing a function to check the address, something as:
>
> #define ALIGN_DOWN ((void*)(((intptr_t)in_addr / SHMLBA) * SHMLBA))
>
> void *expected_addr(void *in_addr, void *out_addr)
> {
> 	if (!in_addr)
> 		return out_addr;
>
> 	return ALIGN_DOWN(in_addr);
> }
>
> ....
> 	if (expected_addr(*tc->addr, addr) != addr) {
> 		tst_res(TFAIL, "shmat() returned %p expected %p",
> 			addr, expected_addr(*tc->addr, addr));
> 		return;
> 	}
> ...
>
>
>> +	if (tc->flag&  SHM_RDONLY) {
>> +		if (*addr != CONTENT) {
>> +			tst_res(TFAIL, "shared memory value wasn't correct");
>> +			return;
>>   		}
>> -		break;
>> +	} else {
>> +		*addr = CONTENT;
>>   	}
>
> Hmm, if we really wanted to test the RDONLY case we would run this part
> of the test in a child, tried to access the address and parent would
> expect that it gets killed with SIGSEGV.
>
> Or we may setup a signal handler for SIGSEGV and check that flag was set
> after we tried to access read only memory.
>
>> -	if (!fail)
>> -		tst_resm(TPASS, "conditions and functionality are correct");
>> -}
>> +	tst_res(TPASS, "shmat() succeeded");
>>
>> -void setup(void)
>> -{
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -	TC = malloc(TST_TOTAL * sizeof(struct test_case_t));
>> -	if (TC == NULL)
>> -		tst_brkm(TFAIL | TERRNO, cleanup, "failed to allocate memory");
>> -
>> -	/* set NULL as attaching address*/
>> -	TC[0].shmid =&shm_id_1;
>> -	TC[0].offset = 0;
>> -	TC[0].flags = 0;
>> -	TC[0].getbase = 0;
>> -
>> -	/* a straight forward read/write attach */
>> -	TC[1].shmid =&shm_id_1;
>> -	TC[1].offset = 0;
>> -	TC[1].flags = 0;
>> -	TC[1].getbase = 1;
>> -
>> -	/* an attach using unaligned memory */
>> -	TC[2].shmid =&shm_id_1;
>> -	TC[2].offset = SHMLBA - 1;
>> -	TC[2].flags = SHM_RND;
>> -	TC[2].getbase = 1;
>> -
>> -	/* a read only attach */
>> -	TC[3].shmid =&shm_id_1;
>> -	TC[3].offset = 0;
>> -	TC[3].flags = SHM_RDONLY;
>> -	TC[3].getbase = 1;
>> -
>> -	tst_tmpdir();
>> -
>> -	shmkey = getipckey();
>> -
>> -	shm_id_1 = shmget(shmkey++, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
>> -	if (shm_id_1 == -1)
>> -		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
>> -			 "resource 1 in setup()");
>> +	SAFE_SHMDT(addr);
>>   }
>>
>> -void cleanup(void)
>> +static void setup(void)
>>   {
>> -	rm_shm(shm_id_1);
>> +	aligned_addr = PROBE_FREE_ADDR();
>> +	unaligned_addr = aligned_addr + SHMLBA - 1;
>>
>> -	if (TC != NULL)
>> -		free(TC);
>> +	shm_key = GETIPCKEY();
>>
>> -	tst_rmdir();
>> +	shm_id = SAFE_SHMGET(shm_key, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
>>   }
>> +
>> +static void cleanup(void)
>> +{
>> +	if (shm_id != -1)
>> +		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tid = "shmat01",
>> +	.needs_root = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = verify_shmat,
>> +	.tcnt = ARRAY_SIZE(tcases)
>> +};
>> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
>> index d6355f7..4302043 100644
>> --- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
>> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
>> @@ -1,189 +1,133 @@
>>   /*
>> + * Copyright (c) International Business Machines  Corp., 2001
>>    *
>> - *   Copyright (c) International Business Machines  Corp., 2001
>> + * This program is free software;  you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>>    *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> + * the GNU General Public License for more details.
>>    *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> - *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.
>>    */
>>
>>   /*
>> - * NAME
>> - *	shmat02.c
>> - *
>>    * DESCRIPTION
>> - *	shmat02 - check for EINVAL and EACCES errors
>> - *
>> - * ALGORITHM
>> - *	loop if that option was specified
>> - *	  call shmat() using three invalid test cases
>> - *	  check the errno value
>> - *	    issue a PASS message if we get EINVAL or EACCES
>> - *	  otherwise, the tests fails
>> - *	    issue a FAIL message
>> - *	call cleanup
>> - *
>> - * USAGE:<for command-line>
>> - *  shmat02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
>> - *     where,  -c n : Run n copies concurrently.
>> - *             -e   : Turn on errno logging.
>> - *	       -i n : Execute test n times.
>> - *	       -I x : Execute test for x seconds.
>> - *	       -P x : Pause for x seconds between iterations.
>> - *	       -t   : Turn on syscall timing.
>> - *
>> - * HISTORY
>> - *	03/2001 - Written by Wayne Boyer
>>    *
>> - *      27/02/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
>> - *      - Fix concurrency issue. The second key used for this test could
>> - *        conflict with the key from another task.
>> - *
>> - * RESTRICTIONS
>> - *	Must be ran as non-root
>> + * 1) shmat() fails and set errno to EINVAL when shmid is invalid.
>> + * 2) shmat() fails and set errno to EINVAL when shmaddr is not page
>> + *    aligned and SHM_RND is not given
>> + * 3) shmat() fails and set errno to EACCES when the shm resource has
>> + *    no read/write permission.
>> + * 4) shmat() fails and set errno to EACCES when non-root user access
>> + *    shm created by root.
>>    */
>>
>> -#include "ipcshm.h"
>> +#include<errno.h>
>> +#include<stdlib.h>
>> +#include<sys/types.h>
>> +#include<sys/ipc.h>
>> +#include<sys/shm.h>
>>   #include<pwd.h>
>> -#include "shmat_common.h"
>> -
>> -char *TCID = "shmat02";
>> -char nobody_uid[] = "nobody";
>> -struct passwd *ltpuser;
>>
>> -int shm_id_1 = -1;
>> -int shm_id_2 = -1;
>> -int shm_id_3 = -1;
>> +#include "tst_test.h"
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "libnewipc.h"
>>
>> -void *base_addr;		/* By probing this address first, we can make
>> -				 * non-aligned addresses from it for different
>> -				 * architectures without explicitly code it.
>> -				 */
>> +static int shm_id1 = -1;
>> +static int shm_id2 = -1;
>> +static int shm_id3 = -1;
>> +static void *aligned_addr;
>> +static void *unaligned_addr;
>> +static key_t shm_key1, shm_key2;
>>
>> -void *addr;			/* for result of shmat-call */
>> -
>> -struct test_case_t {
>> +static struct test_case_t {
>>   	int *shmid;
>> -	int offset;
>> -	int error;
>> +	void **shmaddr;
>> +	int rw_flag;
>> +	int exp_err;
>> +	int exp_user;
>> +} tcases[] = {
>> +	{&shm_id1,&aligned_addr, 1, EINVAL, 0},
>> +	{&shm_id2,&unaligned_addr, 1, EINVAL, 0},
>> +	{&shm_id2,&aligned_addr, 1, EACCES, 1},
>> +	{&shm_id3,&aligned_addr, 0, EACCES, 1}
>>   };
>>
>> -int TST_TOTAL = 3;
>> -
>> -static void setup_tc(int i, struct test_case_t *tc)
>> +static void verify_shmat(struct test_case_t *tc)
>>   {
>> +	void *addr;
>>
>> -	struct test_case_t TC[] = {
>> -		/* EINVAL - the shared memory ID is not valid */
>> -		{&shm_id_1, 0, EINVAL},
>> -		/* EINVAL - the address is not page aligned and SHM_RND is not given */
>> -		{&shm_id_2, SHMLBA - 1, EINVAL},
>> -		/* EACCES - the shared memory resource has no read/write permission */
>> -		{&shm_id_3, 0, EACCES}
>> -	};
>> +	if (!tc->rw_flag)
>> +		shm_id3 = SAFE_SHMGET(shm_key2, INT_SIZE, IPC_CREAT | IPC_EXCL);
> Is there a reason for not initializing shm_id3 in the setup once?

shm_id3 should be initialized without read/write permission by non-root 
user as what old shmat02 did.

Thanks,
Xiao Yang.
>> -	if (i>  TST_TOTAL || i<  0)
>> +	addr = shmat(*tc->shmid, *tc->shmaddr, 0);
>> +	TEST_ERRNO = errno;
> Here as well, no need to save errno into TEST_ERRNO, you can just use
> errno and TERRNO in the code below.
>
>> +	if (addr != (void *)-1) {
>> +		tst_res(TFAIL, "shmat() succeeded unexpectedly");
>>   		return;
>> +	}
>> +
>> +	if (TEST_ERRNO == tc->exp_err) {
>> +		tst_res(TPASS | TTERRNO, "shmat() failed as expected");
>> +	} else {
>> +		tst_res(TFAIL | TTERRNO, "shmat() failed unexpectedly,"
>> +			 "expected: %s", tst_strerrno(tc->exp_err));
>> +	}
>>
>> -	*tc = TC[i];
>> +	if (shm_id3 != -1)
>> +		SAFE_SHMCTL(shm_id3, IPC_RMID, NULL);
>>   }
>>
>> -int main(int ac, char **av)
>> +static void do_shmat(unsigned int n)
>>   {
>> -	int lc;
>> -	int i;
>> -	struct test_case_t *tc;
>> -
>> -	tc = NULL;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	tc = malloc(sizeof(struct test_case_t));
>> -	if (tc == NULL)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc failed");
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -
>> -		for (i = 0; i<  TST_TOTAL; i++) {
>> -
>> -			setup_tc(i, tc);
>> -
>> -			base_addr = probe_free_addr();
>> -			errno = 0;
>> -			addr = shmat(*(tc->shmid), base_addr + tc->offset, 0);
>> -
>> -			if (addr != (void *)-1) {
>> -				tst_resm(TFAIL, "call succeeded unexpectedly");
>> -				continue;
>> -			}
>> -
>> -			if (errno == tc->error)
>> -				tst_resm(TPASS | TERRNO,
>> -					 "shmat failed as expected");
>> -			else
>> -				tst_resm(TFAIL,
>> -					 "shmat failed unexpectedly; expected: "
>> -					 "%d - %s", tc->error,
>> -					 strerror(tc->error));
>> +	pid_t pid;
>> +	struct passwd *pw;
>> +
>> +	struct test_case_t *tc =&tcases[n];
>> +
>> +	if (tc->exp_user == 0) {
>> +		verify_shmat(tc);
>> +	} else {
>> +		pid = SAFE_FORK();
>> +		if (pid) {
>> +			tst_reap_children();
>> +		} else {
>> +			pw = SAFE_GETPWNAM("nobody");
> The getpwnam should be done once in the test setup.
>
>> +			SAFE_SETUID(pw->pw_uid);
>> +			verify_shmat(tc);
>> +			exit(0);
>>   		}
>>   	}
>> -
>> -	cleanup();
>> -
>> -	tst_exit();
>>   }
>>
>> -void setup(void)
>> +static void setup(void)
>>   {
>> -	key_t shmkey2;
>> -
>> -	tst_require_root();
>> -	ltpuser = getpwnam(nobody_uid);
>> -	if (ltpuser == NULL)
>> -		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
>> -	if (setuid(ltpuser->pw_uid) == -1)
>> -		tst_brkm(TBROK | TERRNO, NULL, "setuid failed");
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +	aligned_addr = PROBE_FREE_ADDR();
>> +	unaligned_addr = aligned_addr + SHMLBA - 1;
>>
>> -	TEST_PAUSE;
>> +	shm_key1 = GETIPCKEY();
>> +	shm_key2 = GETIPCKEY();
>>
>> -	tst_tmpdir();
>> -
>> -	shmkey = getipckey();
>> -
>> -	shm_id_2 = shmget(shmkey, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
>> -	if (shm_id_2 == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "shmget #1 failed");
>> -
>> -	/* Get an new IPC resource key. */
>> -	shmkey2 = getipckey();
>> -
>> -	/* create a shared memory resource without read and write permissions */
>> -	shm_id_3 = shmget(shmkey2, INT_SIZE, IPC_CREAT | IPC_EXCL);
>> -	if (shm_id_3 == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "shmget #2 failed");
>> +	shm_id2 = SAFE_SHMGET(shm_key1, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
>>   }
>>
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>> -	/* if they exist, remove the shared memory resources */
>> -	rm_shm(shm_id_2);
>> -	rm_shm(shm_id_3);
>> -
>> -	tst_rmdir();
>> -
>> +	if (shm_id2 != -1)
>> +		SAFE_SHMCTL(shm_id2, IPC_RMID, NULL);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.tid = "shmat02",
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.test = do_shmat,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.setup = setup,
>> +	.cleanup = cleanup
>> +};
> Otherwise it looks fine.
>



