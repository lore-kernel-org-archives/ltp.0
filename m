From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 24 Jun 2021 03:46:42 +0000
Subject: [LTP] [PATCH v2] syscalls/shmget*: Convert into new api
In-Reply-To: <YNM4rlDJLzb4xk6V@yuki>
References: <YMytkmBZb5zDBLGi@yuki>
 <1624350688-31627-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YNM4rlDJLzb4xk6V@yuki>
Message-ID: <60D40047.80801@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> +
>> +static struct tcase {
>> +	int *shmkey;
>> +	size_t size;
>>   	int flags;
>> -	int error;
>> -} TC[] = {
>> -	/* EINVAL - size is 0 */
>> -	{
>> -	&shmkey2, 0, IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
>> -	    /* EINVAL - size is negative */
>> -//      {&shmkey2, -1, IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
>> -	    /* EINVAL - size is larger than created segment */
>> -	{
>> -	&shmkey, SHM_SIZE * 2, SHM_RW, EINVAL},
>> -	    /* EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given */
>> -	{
>> -	&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW, EEXIST},
>> -	    /* ENOENT - no segment exists for the key and IPC_CREAT is not given */
>> -	    /* use shm_id_2 (-1) as the key */
>> -	{
>> -	&shm_nonexisting_key, SHM_SIZE, SHM_RW, ENOENT}
>> +	/*1: nobody expected  0: root expected */
>> +	int exp_user;
>> +	int exp_err;
>> +} tcases[] = {
>> +	{&shmkey1, SHM_SIZE, IPC_EXCL, 0, ENOENT},
>> +	{&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL, 0, EEXIST},
>> +	{&shmkey1, SHMMIN - 1, IPC_CREAT | IPC_EXCL, 0, EINVAL},
>> +	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, EINVAL},
>> +	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, EINVAL},
>> +	{&shmkey, SHM_SIZE, SHM_RD, 1, EACCES},
>> +	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 1, EPERM}
>
> This case is a bit more complicated, on my test machine with
> nr_hugepages == 0 I get ENOMEM, since there are no hugepages allocated
> in the pool.
>
> When I add .request_hugepages = 1, the the tst_test structure, the
> hugepage pool size is increased by the test library and this request
> succeds and creates a SHM segment. See description below on how this has
> to be fixed.
>
>>   };
>>
>> -int main(int ac, char **av)
>> +static void do_test(unsigned int n)
>>   {
>> -	int lc;
>> -	int i;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();		/* global setup */
>> -
>> -	/* The following loop checks looping state if -i option given */
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		/* reset tst_count in case we are looping */
>> -		tst_count = 0;
>> +	struct tcase *tc =&tcases[n];
>> +	pid_t pid;
>>
>> -		/* loop through the test cases */
>> -		for (i = 0; i<  TST_TOTAL; i++) {
>> -			/*
>> -			 * Look for a failure ...
>> -			 */
>> -
>> -			TEST(shmget(*(TC[i].skey), TC[i].size, TC[i].flags));
>> -
>> -			if (TEST_RETURN != -1) {
>> -				tst_resm(TFAIL, "call succeeded unexpectedly");
>> -				continue;
>> -			}
>> -
>> -			if (TEST_ERRNO == TC[i].error) {
>> -				tst_resm(TPASS, "expected failure - errno = "
>> -					 "%d : %s", TEST_ERRNO,
>> -					 strerror(TEST_ERRNO));
>> -			} else {
>> -				tst_resm(TFAIL, "call failed with an "
>> -					 "unexpected error - %d : %s",
>> -					 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			}
>> -		}
>> +	if (tc->exp_user == 0) {
>> +		TST_EXP_FAIL(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
>> +			"shmget(%i, %lu, %i)", *tc->shmkey, tc->size, tc->flags);
>> +		return;
>>   	}
>>
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	pid = SAFE_FORK();
>> +	if (pid == 0) {
>> +		SAFE_SETUID(pw->pw_uid);
>> +		TST_EXP_FAIL(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
>> +			"shmget(%i, %lu, %i)", *tc->shmkey, tc->size, tc->flags);
>> +		exit(0);
>> +	}
>> +	tst_reap_children();
>>   }
>>
>> -/*
>> - * setup() - performs all the ONE TIME setup for this test.
>> - */
>> -void setup(void)
>> +static void setup(void)
>>   {
>> +	shmkey = GETIPCKEY();
>> +	shmkey1 = GETIPCKEY();
>>
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -	/*
>> -	 * Create a temporary directory and cd into it.
>> -	 * This helps to ensure that a unique msgkey is created.
>> -	 * See libs/libltpipc/libipc.c for more information.
>> -	 */
>> -	tst_tmpdir();
>> -
>> -	/* get an IPC resource key */
>> -	shmkey = getipckey();
>> -
>> -	/* Get an new IPC resource key. */
>> -	shmkey2 = getipckey();
>> -
>> -	if ((shm_id_1 = shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL |
>> -			       SHM_RW)) == -1) {
>> -		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
>> -			 "segment in setup()");
>> -	}
>> -
>> -	/* Make sure shm_nonexisting_key is a nonexisting key */
>> -	while (1) {
>> -		while (-1 != shmget(shm_nonexisting_key, 1, SHM_RD)) {
>> -			shm_nonexisting_key--;
>> -		}
>> -		if (errno == ENOENT)
>> -			break;
>> -	}
>> +	SAFE_FILE_PRINTF("/proc/sys/vm/hugetlb_shm_group", "1");
>
> There is no need to change the default hugetlb group, all that has to be
> done is to strip the user of all groups as well as there is absolutely
> no guarantee that group 1 will not be in the list of supplementary
> groups for a root users.
>
> So when we change uid we as well have to do:
>
> 	setgroups(0, NULL);
> 	SAFE_SETGID(pw->pw_gid);
> 	SAFE_SETUID(pw->pw_uid);
>
> This will strip the process of all additional permissions that may have
> been passed down by the process running under root.
>
> Also ideally we should add SAFE_SETGROUPS() to the test library in a
> separate patch so that we can make use of it here.
>
Yes, your are right. my origial way is to set 1 and it doesn't work on 
your envrionment, so it doesn't meet EPERM error and meet the ENOMEM 
error in kernel hugetlb_file_setup function.

I have check the kernel code, it used  in_group_p function to check 
whether have read access. So using setgroups(0, NULL) is right. Thanks.

Also, I add a ENOMEM test error test.
>> +	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
>> +	pw = SAFE_GETPWNAM("nobody");
>>   }
>>
>> -/*
>> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
>> - * 	       or premature exit.
>> - */
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>> -	/* if it exists, remove the shared memory resource */
>> -	rm_shm(shm_id_1);
>> -
>> -	tst_rmdir();
>> -
>> +	if (shm_id>= 0)
>> +		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.needs_tmpdir = 1,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = do_test,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.save_restore = (const char * const[]) {
>> +		"?/proc/sys/vm/hugetlb_shm_group",
>> +		NULL,
>> +	}
>> +};
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> index 96ebf3608..d2e850b2a 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> @@ -1,171 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *
>> - *   Copyright (c) International Business Machines  Corp., 2001
>> - *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> - *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> - *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * Copyright (c) International Business Machines  Corp., 2001
>> + *  03/2001 - Written by Wayne Boyer
>>    */
>>
>> -/*
>> - * NAME
>> - *	shmget03.c
>> +/*\
>> + * [Description]
>>    *
>> - * DESCRIPTION
>> - *	shmget03 - test for ENOSPC error
>> + * Test for ENOSPC error.
>>    *
>> - * ALGORITHM
>> - *	create shared memory segments in a loop until reaching the system limit
>> - *	loop if that option was specified
>> - *	  attempt to create yet another shared memory segment
>> - *	  check the errno value
>> - *	    issue a PASS message if we get ENOSPC
>> - *	  otherwise, the tests fails
>> - *	    issue a FAIL message
>> - *	call cleanup
>> - *
>> - * USAGE:<for command-line>
>> - *  shmget03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
>> - *     where,  -c n : Run n copies concurrently.
>> - *             -e   : Turn on errno logging.
>> - *	       -i n : Execute test n times.
>> - *	       -I x : Execute test for x seconds.
>> - *	       -P x : Pause for x seconds between iterations.
>> - *	       -t   : Turn on syscall timing.
>> - *
>> - * HISTORY
>> - *	03/2001 - Written by Wayne Boyer
>> - *
>> - * RESTRICTIONS
>> - *	none
>> + * ENOSPC -  All possible shared memory segments have been taken (SHMMNI).
>>    */
>> -
>> -#include "ipcshm.h"
>> -
>> -char *TCID = "shmget03";
>> -int TST_TOTAL = 1;
>> -
>> -/*
>> - * The MAXIDS value is somewhat arbitrary and may need to be increased
>> - * depending on the system being tested.
>> - */
>> -#define MAXIDS	8192
>> -
>> -int shm_id_1 = -1;
>> -int num_shms = 0;
>> -
>> -int shm_id_arr[MAXIDS];
>> -
>> -int main(int ac, char **av)
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<sys/ipc.h>
>> +#include<stdlib.h>
>> +#include<pwd.h>
>> +#include<sys/shm.h>
>> +#include "tst_test.h"
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "libnewipc.h"
>> +
>> +static int *queues;
>> +static int maxshms;
>> +static key_t shmkey;
>> +
>> +static void verify_shmget(void)
>>   {
>> -	int lc;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();		/* global setup */
>> -
>> -	/* The following loop checks looping state if -i option given */
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		/* reset tst_count in case we are looping */
>> -		tst_count = 0;
>> -
>> -		/*
>> -		 * use the TEST() macro to make the call
>> -		 */
>> -
>> -		TEST(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | IPC_EXCL
>> -			    | SHM_RW));
>> -
>> -		if (TEST_RETURN != -1) {
>> -			tst_resm(TFAIL, "call succeeded when error expected");
>> -			continue;
>> -		}
>> -
>> -		switch (TEST_ERRNO) {
>> -		case ENOSPC:
>> -			tst_resm(TPASS, "expected failure - errno = "
>> -				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
>> -			break;
>> -		default:
>> -			tst_resm(TFAIL, "call failed with an "
>> -				 "unexpected error - %d : %s",
>> -				 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			break;
>> -		}
>> -	}
>> -
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	TST_EXP_FAIL(shmget(shmkey + maxshms, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW), ENOSPC,
>> +		"shmget(%i, %i, %i)", shmkey + maxshms, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
>>   }
>>
>> -/*
>> - * setup() - performs all the ONE TIME setup for this test.
>> - */
>> -void setup(void)
>> +static void setup(void)
>>   {
>> +	int res, num;
>>
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +	shmkey = GETIPCKEY();
>>
>> -	TEST_PAUSE;
>> +	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i",&maxshms);
>>
>> -	/*
>> -	 * Create a temporary directory and cd into it.
>> -	 * This helps to ensure that a unique msgkey is created.
>> -	 * See libs/libltpipc/libipc.c for more information.
>> -	 */
>> -	tst_tmpdir();
>> -
>> -	/* get an IPC resource key */
>> -	shmkey = getipckey();
>> -
>> -	/*
>> -	 * Use a while loop to create the maximum number of memory segments.
>> -	 * If the loop exceeds MAXIDS, then break the test and cleanup.
>> -	 */
>> -	while ((shm_id_1 = shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT |
>> -				  IPC_EXCL | SHM_RW)) != -1) {
>> -		shm_id_arr[num_shms++] = shm_id_1;
>> -		if (num_shms == MAXIDS) {
>> -			tst_brkm(TBROK, cleanup, "The maximum number of shared "
>> -				 "memory ID's has been\n\t reached.  Please "
>> -				 "increase the MAXIDS value in the test.");
>> -		}
>> -	}
>> -
>> -	/*
>> -	 * If the errno is other than ENOSPC, then something else is wrong.
>> -	 */
>> -	if (errno != ENOSPC) {
>> -		tst_resm(TINFO, "errno = %d : %s", errno, strerror(errno));
>> -		tst_brkm(TBROK, cleanup, "Didn't get ENOSPC in test setup");
>> +	queues = SAFE_MALLOC(maxshms * sizeof(int));
>> +	for (num = 0; num<  maxshms; num++) {
>> +		queues[num] = -1;
>> +		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
>> +		if (res != -1)
>> +			queues[num] = res;
>> +		else
>> +			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
>>   	}
>> +	tst_res(TINFO, "The maximum number of memory segments (%d) has been reached",
>> +		maxshms);
>>   }
>>
>> -/*
>> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
>> - * 	       or premature exit.
>> - */
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>> -	int i;
>> +	int num;
>>
>> -	/* remove the shared memory resources that were created */
>> -	for (i = 0; i<  num_shms; i++) {
>> -		rm_shm(shm_id_arr[i]);
>> -	}
>> +	if (!queues)
>> +		return;
>>
>> -	tst_rmdir();
>> +	for (num = 0; num<  maxshms; num++) {
>> +		if (queues[num] != -1)
>> +			SAFE_SHMCTL(queues[num], IPC_RMID, NULL);
>> +	}
>
> This is still not correct, we will pass random data to the SAFE_SHMCTL()
> in a case shmget() had failed before the loop in setup reached maximal value.
>
> We have to maintain a global variable with the number of the ids in the
> queues[] array and only remove these that have been created.
Yes, I have added a global count.

Best Regards
Yang Xu
>
> 	for (i = 0; i<  maxshms; i++) {
> 		res = shmget(...);
>
> 		if (res == -1)
> 			tst_brk(TBROK...);
>
> 		queues[queue_cnt++] = res;
> 	}
>
>
>
> 	for (i = 0; i<  queue_cnt; i++)
> 		SAFE_SHMCTL(queues[i], IPC_RMID);
>
>> +	free(queues);
>>   }

>> +
>> +static struct tst_test test = {
>> +	.needs_tmpdir = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = verify_shmget,
>> +};
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
>> index 60a263c77..d92dfe635 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
>> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
>> @@ -1,153 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *
>> - *   Copyright (c) International Business Machines  Corp., 2001
>> - *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> - *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> - *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * Copyright (c) International Business Machines  Corp., 2001
>> + *  03/2001 - Written by Wayne Boyer
>>    */
>>
>> -/*
>> - * NAME
>> - *	shmget04.c
>> - *
>> - * DESCRIPTION
>> - *	shmget04 - test for EACCES error
>> - *
>> - * ALGORITHM
>> - *	create a shared memory segment without read or write permissions
>> - *	loop if that option was specified
>> - *	  call shmget() with SHM_RW flag using TEST() macro
>> - *	  check the errno value
>> - *	    issue a PASS message if we get EACCES
>> - *	  otherwise, the tests fails
>> - *	    issue a FAIL message
>> - *	call cleanup
>> - *
>> - * USAGE:<for command-line>
>> - *  shmget04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
>> - *     where,  -c n : Run n copies concurrently.
>> - *             -e   : Turn on errno logging.
>> - *	       -i n : Execute test n times.
>> - *	       -I x : Execute test for x seconds.
>> - *	       -P x : Pause for x seconds between iterations.
>> - *	       -t   : Turn on syscall timing.
>> +/*\
>> + * [Description]
>>    *
>> - * HISTORY
>> - *	03/2001 - Written by Wayne Boyer
>> + * Test for EACCES error.
>>    *
>> - * RESTRICTIONS
>> - *	none
>> + * Create a shared memory segment without read or write permissions under
>> + * unpriviledged user and call shmget() with SHM_RD/SHM_WR/SHM_RW flag to
>> + * trigger EACCES error.
>>    */
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<sys/ipc.h>
>> +#include<stdlib.h>
>>   #include<pwd.h>
>> -#include "ipcshm.h"
>> -
>> -char *TCID = "shmget04";
>> -int TST_TOTAL = 1;
>> -
>> -char nobody_uid[] = "nobody";
>> -struct passwd *ltpuser;
>> -
>> -int shm_id_1 = -1;
>> -
>> -int main(int ac, char **av)
>> +#include<sys/shm.h>
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "tst_test.h"
>> +#include "libnewipc.h"
>> +#include "lapi/shm.h"
>> +
>> +static int shm_id = -1;
>> +static key_t shmkey;
>> +static struct tcase {
>> +	char *message;
>> +	int flag;
>> +} tcases[] = {
>> +	{"Testing SHM_RD flag", SHM_RD},
>> +	{"Testing SHM_WR flag", SHM_WR},
>> +	{"Testing SHM_RW flag", SHM_RW},
>> +};
>> +
>> +static void verify_shmget(unsigned int n)
>>   {
>> -	int lc;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();		/* global setup */
>> -
>> -	/* The following loop checks looping state if -i option given */
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		/* reset tst_count in case we are looping */
>> -		tst_count = 0;
>> +	struct tcase *tc =&tcases[n];
>>
>> -		/*
>> -		 * use the TEST() macro to make the call
>> -		 */
>> -
>> -		TEST(shmget(shmkey, SHM_SIZE, SHM_RW));
>> -
>> -		if (TEST_RETURN != -1) {
>> -			tst_resm(TFAIL, "call succeeded when error expected");
>> -			continue;
>> -		}
>> -
>> -		switch (TEST_ERRNO) {
>> -		case EACCES:
>> -			tst_resm(TPASS, "expected failure - errno = "
>> -				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
>> -			break;
>> -		default:
>> -			tst_resm(TFAIL, "call failed with an "
>> -				 "unexpected error - %d : %s",
>> -				 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			break;
>> -		}
>> -	}
>> -
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	tst_res(TINFO, "%s", tc->message);
>> +	TST_EXP_FAIL(shmget(shmkey, SHM_SIZE, tc->flag), EACCES, "shmget(%i, %i, %i)",
>> +		shmkey, SHM_SIZE, tc->flag);
>>   }
>>
>> -/*
>> - * setup() - performs all the ONE TIME setup for this test.
>> - */
>> -void setup(void)
>> +static void setup(void)
>>   {
>> -	tst_require_root();
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +	struct passwd *pw;
>>
>> -	TEST_PAUSE;
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	SAFE_SETUID(pw->pw_uid);
>> +	shmkey = GETIPCKEY();
>>
>> -	/* Switch to nobody user for correct error code collection */
>> -	ltpuser = getpwnam(nobody_uid);
>> -	if (setuid(ltpuser->pw_uid) == -1) {
>> -		tst_resm(TINFO, "setuid failed to "
>> -			 "to set the effective uid to %d", ltpuser->pw_uid);
>> -		perror("setuid");
>> -	}
>> -
>> -	/*
>> -	 * Create a temporary directory and cd into it.
>> -	 * This helps to ensure that a unique msgkey is created.
>> -	 * See libs/libltpipc/libipc.c for more information.
>> -	 */
>> -	tst_tmpdir();
>> -
>> -	/* get an IPC resource key */
>> -	shmkey = getipckey();
>> -
>> -	/* create a shared memory segment without read or access permissions */
>> -	if ((shm_id_1 = shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL)) == -1) {
>> -		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
>> -			 "segment in setup");
>> -	}
>> +	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
>>   }
>>
>> -/*
>> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
>> - * 	       or premature exit.
>> - */
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>> -	/* if it exists, remove the shared memory resource */
>> -	rm_shm(shm_id_1);
>> -
>> -	tst_rmdir();
>> -
>> +	if (shm_id>= 0)
>> +		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.needs_tmpdir = 1,
>> +	.needs_root = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = verify_shmget,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +};
>
