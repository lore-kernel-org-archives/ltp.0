From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Mon, 21 Jun 2021 09:48:57 +0000
Subject: [LTP] [PATCH v1 2/4] syscalls/shmget*: Convert into new api
In-Reply-To: <YMytkmBZb5zDBLGi@yuki>
References: <1620809541-6891-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1620809541-6891-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YMytkmBZb5zDBLGi@yuki>
Message-ID: <60D060A9.6080905@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
Thanks for your review, will fix these comments on v2.
> Hi!
>> 1) merge shmget05.c into shmget02.c
>> 2) Use SHMMIN -1 and SHMMAX + 1 to trigger EINVAL error
>> 3) Use SHM_RD, SHM_WR, SHM_RW to trigger EACCES error under unpriviledged user
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/shm.h                            |  14 +
>>   runtest/syscalls                              |   1 -
>>   runtest/syscalls-ipc                          |   1 -
>>   .../kernel/syscalls/ipc/shmget/.gitignore     |   1 -
>>   testcases/kernel/syscalls/ipc/shmget/Makefile |   4 +-
>>   .../kernel/syscalls/ipc/shmget/shmget02.c     | 243 +++++++-----------
>>   .../kernel/syscalls/ipc/shmget/shmget03.c     | 199 ++++----------
>>   .../kernel/syscalls/ipc/shmget/shmget04.c     | 193 +++++---------
>>   .../kernel/syscalls/ipc/shmget/shmget05.c     | 185 -------------
>>   9 files changed, 209 insertions(+), 632 deletions(-)
>>   delete mode 100644 testcases/kernel/syscalls/ipc/shmget/shmget05.c
>>
>> diff --git a/include/lapi/shm.h b/include/lapi/shm.h
>> index 61c4e37bf..bb280fc44 100644
>> --- a/include/lapi/shm.h
>> +++ b/include/lapi/shm.h
>> @@ -6,8 +6,22 @@
>>   #ifndef LAPI_SHM_H__
>>   #define LAPI_SHM_H__
>>
>> +#include<limits.h>
>> +
>>   #ifndef SHM_STAT_ANY
>>   # define SHM_STAT_ANY 15
>>   #endif
>>
>> +#ifndef SHMMIN
>> +# define SHMMIN 1
>> +#endif
>> +
>> +#ifndef SHMMAX
>> +# define SHMMAX (ULONG_MAX - (1UL<<  24))
>> +#endif
>> +
>> +#ifndef SHMMNI
>> +# define SHMMNI 4096
>> +#endif
>> +
>>   #endif /* LAPI_SHM_H__ */
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 63d821e53..2dff25984 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1402,7 +1402,6 @@ shmdt02 shmdt02
>>   shmget02 shmget02
>>   shmget03 shmget03
>>   shmget04 shmget04
>> -shmget05 shmget05
>>
>>   sigaction01 sigaction01
>>   sigaction02 sigaction02
>> diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
>> index ff0364704..b3bd37923 100644
>> --- a/runtest/syscalls-ipc
>> +++ b/runtest/syscalls-ipc
>> @@ -67,4 +67,3 @@ shmdt02 shmdt02
>>   shmget02 shmget02
>>   shmget03 shmget03
>>   shmget04 shmget04
>> -shmget05 shmget05
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
>> index 6f08529f8..c57df68f5 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/.gitignore
>> +++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
>> @@ -1,4 +1,3 @@
>>   /shmget02
>>   /shmget03
>>   /shmget04
>> -/shmget05
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/ipc/shmget/Makefile
>> index 26b9f264d..b1201281d 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/Makefile
>> +++ b/testcases/kernel/syscalls/ipc/shmget/Makefile
>> @@ -3,10 +3,10 @@
>>
>>   top_srcdir              ?= ../../../../..
>>
>> -LTPLIBS = ltpipc
>> +LTPLIBS = ltpnewipc
>>
>>   include $(top_srcdir)/include/mk/testcases.mk
>>
>> -LTPLDLIBS  = -lltpipc
>> +LTPLDLIBS = -lltpnewipc
>>
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
>> index 4436ca7f8..a57904ce9 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
>> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
>> @@ -1,184 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> + * Copyright (c) International Business Machines  Corp., 2001
>> + *  03/2001 - Written by Wayne Boyer
>>    *
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
>> + * Copyright (c) 2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
>>    */
>>
>> -/*
>> - * NAME
>> - *	shmget02.c
>> - *
>> - * DESCRIPTION
>> - *	shmget02 - check for ENOENT, EEXIST and EINVAL errors
>> +/*\
>> + * [Description]
>>    *
>> - * ALGORITHM
>> - *	create a shared memory segment with read&  write permissions
>> - *	loop if that option was specified
>> - *	  call shmget() using five different invalid cases
>> - *	  check the errno value
>> - *	    issue a PASS message if we get ENOENT, EEXIST or EINVAL
>> - *	  otherwise, the tests fails
>> - *	    issue a FAIL message
>> - *	call cleanup
>> + * Test for ENOENT, EEXIST, EINVAL, EACCES errors.
>>    *
>> - * USAGE:<for command-line>
>> - *  shmget02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
>> - *      06/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
>> - *      - Fix concurrency issue. The second key used for this test could
>> - *        conflict with the key from another task.
>> - *
>> - * RESTRICTIONS
>> - *	none
>> + * ENOENT - No segment exists for the given key and IPC_CREAT was not specified.
>> + * EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given.
>> + * EINVAL - A new segment was to be created and size is less than SHMMIN or
>> + * greater than SHMMAX. Or a segment for the given key exists, but size is
>> + * greater than the size of that segment.
>> + * EACCES - The user does not have permission to access the shared memory segment.
>>    */
>> -
>> -#include "ipcshm.h"
>> -
>> -char *TCID = "shmget02";
>> -int TST_TOTAL = 4;
>> -
>> -int shm_id_1 = -1;
>> -int shm_nonexisting_key = -1;
>> -key_t shmkey2;
>> -
>> -struct test_case_t {
>> -	int *skey;
>> -	int size;
>> +#include<errno.h>
>> +#include<sys/types.h>
>> +#include<sys/ipc.h>
>> +#include<stdlib.h>
>> +#include<pwd.h>
>> +#include<sys/shm.h>
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "tst_test.h"
>> +#include "libnewipc.h"
>> +#include "lapi/shm.h"
>> +
>> +static int shm_id = -1;
>> +static key_t shmkey, shmkey1;
>> +static struct passwd *pw;
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
>
> Can we please add the zero size EINVAL test as well?
SHMMIN is equal to 1, so we have tested zero size EINVAL test.
>
>> +	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, EINVAL},
>> +	{&shmkey, SHM_SIZE, SHM_RD, 1, EACCES},
>>   };
>
> ...
>
>> +static void do_test(unsigned int n)
>>   {
>> +	struct tcase *tc =&tcases[n];
>> +	pid_t pid;
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
>> +	if (tc->exp_user == 0) {
>> +		verify_shmget(tc);
>
> Just use the TST_EXP_FAIL() macro here instead, no need to reinvent the
> wheel.
Yes, use TST_EXP_FAIL(shmget(*tc->shmkey, tc->size, tc->flags), 
tc->exp_err, "shmget(%i, %lu, %i)",*tc->shmkey, tc->size, tc->flags) to 
replace.
>
>> +		return;
>>   	}
>>
>> -	/* Make sure shm_nonexisting_key is a nonexisting key */
>> -	while (1) {
>> -		while (-1 != shmget(shm_nonexisting_key, 1, SHM_RD)) {
>> -			shm_nonexisting_key--;
>> -		}
>> -		if (errno == ENOENT)
>> -			break;
>> +	pid = SAFE_FORK();
>> +	if (pid == 0) {
>> +		SAFE_SETUID(pw->pw_uid);
>> +		verify_shmget(tc);
>
> And here as well.
OK.
>
>> +		exit(0);
>>   	}
>> +	tst_reap_children();
>>   }
>>
>> -/*
>> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
>> - * 	       or premature exit.
>> - */
>> -void cleanup(void)
>> +static void setup(void)
>>   {
>> -	/* if it exists, remove the shared memory resource */
>> -	rm_shm(shm_id_1);
>> +	shmkey = GETIPCKEY();
>> +	shmkey1 = GETIPCKEY();
>>
>> -	tst_rmdir();
>> +	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	tst_res(TINFO, "%d %d", shmkey, shmkey1);
>
> I'm not sure if this message is useful.
It is debug message, will remove it.
>
>> +}
>>
>> +static void cleanup(void)
>> +{
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
>> +};
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> index 96ebf3608..c74fe241d 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> @@ -1,171 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>
> ...
>
>> +static int shm_id_arr[SHMMNI] = {-1};
>
> The SHMMNI is just default value, it could be adjusted at runtime by
> setting /proc/sys/kernel/shmmni
>
> So we should ideally fix the test to read that value in the test setup
> and allocate the array based on the value.
Agree.
>
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
>> +	TEST(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW));
>> +	if (TST_RET != -1) {
>> +		tst_res(TFAIL, "shmget() returned %li", TST_RET);
>> +		return;
>>   	}
>> -
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	if (TST_ERR == ENOSPC)
>> +		tst_res(TPASS | TTERRNO, "shmget() failed as expected");
>> +	else
>> +		tst_res(TFAIL | TTERRNO, "shmget() failed unexpectedly, expected ENOSPC, bug got");
>
> This should be TST_EXP_FAIL() as well.
Will do it.
>
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
>> +	for (num = 0; num<  SHMMNI; num++) {
>> +		res = shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
>> +		if (res != -1)
>> +			shm_id_arr[num] = res;
>>   	}
>
> So we attempt to allocate SHMMNI shared memory segemnts and the last
> call will fail.
>
> I guess that we can as well attempt to allocate SHMMNI-1 segemnts and
> expect them to all pass. I do not like ignore any failures that may
> happen here and cary on with the test. It would be better to TBROK here
> instead.
>
Sounds reansonable. Will do it.
>> +	tst_res(TINFO, "The maximum number(%d) of memory ID's has been reached",
>> +		SHMMNI);
>>   }
>>
>> -/*
>> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
>> - * 	       or premature exit.
>> - */
>> -void cleanup(void)
>> +
>> +static void cleanup(void)
>>   {
>>   	int i;
>>
>> -	/* remove the shared memory resources that were created */
>> -	for (i = 0; i<  num_shms; i++) {
>> -		rm_shm(shm_id_arr[i]);
>> +	for (i = 0; i<  SHMMNI; i++) {
>> +		if (shm_id_arr[i]>= 0)
>
> This is actually not correct, since there are possibly zeros in the
> array (just because it's global variable and only first position is
> intialized wiht -1) and we could incorrectly attempt to remove sement
> with id 0.
>
> I guess that the cleanest way how to handle this would be having global
> counter for the number of created semgents:
>
>
> static key_t *keys;
> static unsigned int max_key;
>
> setup()
> {
> 	...
> 	keys = SAFE_MALLOC(sizeof(key_t) * shmmni);
> 	...
>
> 	for (;;) {
> 		if (max_key>= shmni)
> 			break;
>
>
> 		keys[max_key] = shmget(...);
>
> 		if (keys[max_key]<  0)
> 			tst_brk(TBROK, ...);
>
> 		max_key++;
> 	}
> }
>
> cleanup()
> {
> 	key_t key;
>
> 	for (key = 0; key<  max_key; key++)
> 		SAFE_SHMCTL(keys[key], IPC_RMID, NULL);
> }
>
>
>
Yes, Will do it in v2.
>> +			SAFE_SHMCTL(shm_id_arr[i], IPC_RMID, NULL);
>>   	}
>> -
>> -	tst_rmdir();
>> -
>>   }
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = verify_shmget,
>> +};
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
>> index 60a263c77..fe611b306 100644
>
> ...
>
>> +	tst_res(TINFO, "%s", tc->message);
>> +	TEST(shmget(shmkey, SHM_SIZE, tc->flag));
>> +	if (TST_RET != -1) {
>> +		tst_res(TFAIL, "shmget() returned %li", TST_RET);
>> +		return;
>>   	}
>> -
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	if (TST_ERR == EACCES)
>> +		tst_res(TPASS | TTERRNO, "shmget() failed as expected");
>> +	else
>> +		tst_res(TFAIL | TTERRNO, "shmget() failed unexpectedly, expected EACCES, bug got");
>
> TST_EXP_FAIL() here as well.
Will do it.

Best Regards
Yang Xu
>
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
>> -
>> -	/* Switch to nobody user for correct error code collection */
>> -	ltpuser = getpwnam(nobody_uid);
>> -	if (setuid(ltpuser->pw_uid) == -1) {
>> -		tst_resm(TINFO, "setuid failed to "
>> -			 "to set the effective uid to %d", ltpuser->pw_uid);
>> -		perror("setuid");
>> -	}
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	SAFE_SETUID(pw->pw_uid);
>> +	shmkey = GETIPCKEY();
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
