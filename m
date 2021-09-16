From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 16 Sep 2021 07:49:53 +0000
Subject: [LTP] [PATCH v2 2/4] syscalls/dup2/dup202: Convert to new API
 and merge dup204 into dup202
In-Reply-To: <6142EEB8.30409@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
 <20210915155152.8515-3-qi.fuli@fujitsu.com> <6142EEB8.30409@fujitsu.com>
Message-ID: <6142F735.4080208@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qi

Also, when I read dup2 man-page, I also find old an new fd also share
the offset as below:
   " After a successful return, the old and new file descriptors may be 
used interchangeably.  Since the two file descriptors refer to the same 
open file description, they  share  file  offset  and  file  status
        flags; for example, if the file offset is modified by using 
lseek(2) on one of the file descriptors, the offset is also changed for 
the other file descriptor."

We can add this check into here or adding a new case.

Best Regards
Yang Xu
> Hi Qi
>> From: QI Fuli<qi.fuli@fujitsu.com>
>>
>> Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
>> ---
>> testcases/kernel/syscalls/dup2/dup202.c | 190 +++++++-----------------
>> testcases/kernel/syscalls/dup2/dup204.c | 128 ----------------
>> 2 files changed, 52 insertions(+), 266 deletions(-)
>> delete mode 100644 testcases/kernel/syscalls/dup2/dup204.c
>>
>> diff --git a/testcases/kernel/syscalls/dup2/dup202.c
>> b/testcases/kernel/syscalls/dup2/dup202.c
>> index c87769fa9..fd8aeb84e 100644
>> --- a/testcases/kernel/syscalls/dup2/dup202.c
>> +++ b/testcases/kernel/syscalls/dup2/dup202.c
>> @@ -1,167 +1,81 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> /*
>> - *
>> - * Copyright (c) International Business Machines Corp., 2001
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> - * the GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> 02110-1301 USA
>> + * Copyright (c) International Business Machines Corp., 2001
>> */
>>
>> -/*
>> - * NAME
>> - * dup202.c
>> - *
>> - * DESCRIPTION
>> - * Is the access mode the same for both file descriptors?
>> - * 0: read only ? "0444"
>> - * 1: write only ? "0222"
>> - * 2: read/write ? "0666"
>> - *
>> - * ALGORITHM
>> - * Creat a file with each access mode; dup each file descriptor;
>> - * stat each file descriptor and compare modes of each pair
>> - *
>> - * USAGE:<for command-line>
>> - * dup202 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
>> - * where, -c n : Run n copies concurrently.
>> - * -f : Turn off functionality Testing.
>> - * -i n : Execute test n times.
>> - * -I x : Execute test for x seconds.
>> - * -P x : Pause for x seconds between iterations.
>> - * -t : Turn on syscall timing.
>> - *
>> - * HISTORY
>> - * 07/2001 Ported by Wayne Boyer
>> +/*\
>> + * [Description]
>> *
>> - * RESTRICTIONS
>> - * None
> Test whether the access mode and inode number are same for both file
> descriptors.
>> + * Is the access mode the same for both file descriptors?
>> + * 0: read only ? "0444"
>> + * 1: write only ? "0222"
>> + * 2: read/write ? "0666"
>> */
>>
>> -#include<sys/types.h>
>> -#include<sys/stat.h>
>> #include<errno.h>
>> -#include<fcntl.h>
>> #include<stdio.h>
>> -#include "test.h"
>> -#include "safe_macros.h"
>> +#include "tst_test.h"
>> +#include "tst_safe_macros.h"
>>
>> -char *TCID = "dup202";
>> -int TST_TOTAL = 3;
>> -
>> -void setup(void);
>> -void cleanup(void);
>> -
>> -char testfile[40];
>> -int fail;
>> -int newfd;
>> +static char testfile[40];
>>
>> /* set these to a known index into our local file descriptor table */
>> -int duprdo = 10, dupwro = 20, duprdwr = 30;
>> +static int duprdo = 10, dupwro = 20, duprdwr = 30;
>>
>> -struct test_case_t {
>> +static struct tcase {
>> int *nfd;
>> mode_t mode;
>> -} TC[] = {
>> - /* The first test creat(es) a file with mode 0444 */
>> - {
>> - &duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
>> - /* The second test creat(es) a file with mode 0222 */
>> - {
>> - &dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
>> - /* The third test creat(es) a file with mode 0666 */
>> - {
>> - &duprdwr,
>> - (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)}
>> +} tcases[]= {
>> + {&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
>> + {&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
>> + {&duprdwr, (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP |
>> S_IWOTH)},
>> };
>>
>> -int main(int ac, char **av)
>> +static void setup(void)
>> {
>> - int lc;
>> - int i, ofd;
>> - struct stat oldbuf, newbuf;
>> -
>> - tst_parse_opts(ac, av, NULL, NULL);
>> -
>> - setup();
>> -
>> - for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> - tst_count = 0;
>> -
>> - /* loop through the test cases */
>> - for (i = 0; i< TST_TOTAL; i++) {
>> -
>> - if ((ofd = creat(testfile, TC[i].mode)) == -1)
>> - tst_brkm(TBROK | TERRNO, cleanup,
>> - "creat failed");
>> -
>> - TEST(dup2(ofd, *TC[i].nfd));
>> -
>> - if (TEST_RETURN == -1) {
>> - tst_resm(TFAIL | TTERRNO,
>> - "call failed unexpectedly");
>> - continue;
>> - }
>> + umask(0);
>> + sprintf(testfile, "dup202.%d", getpid());
>> +}
>>
>> - /* stat the original file */
>> - SAFE_FSTAT(cleanup, ofd,&oldbuf);
>> +static void run(unsigned int i)
>> +{
>> + int ofd;
>> + struct stat oldbuf, newbuf;
>> + struct tcase *tc = tcases + i;
>>
>> - /* stat the duped file */
>> - SAFE_FSTAT(cleanup, *TC[i].nfd,&newbuf);
>> + ofd = SAFE_OPEN(testfile, O_CREAT, tc->mode);
>>
>> - if (oldbuf.st_mode != newbuf.st_mode)
>> - tst_resm(TFAIL, "original and dup "
>> - "modes do not match");
>> - else
>> - tst_resm(TPASS, "fstat shows new and "
>> - "old modes are the same");
>> + TEST(dup2(ofd, *tc->nfd));
>>
>> - /* remove the file so that we can use it again */
>> - if (close(*TC[i].nfd) == -1)
>> - perror("close failed");
>> - if (close(ofd) == -1)
>> - perror("close failed");
>> - if (unlink(testfile) == -1)
>> - perror("unlink failed");
>> - }
>> + if (TST_RET == -1) {
>> + tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
>> + return;
>> }
> This case fails on my machine when using -i parameters
> [root@localhost dup2]# ./dup202 -i 2
> tst_test.c:1353: TINFO: Timeout per run is 0h 05m 00s
> dup202.c:65: TPASS: original and duped modes are the same
> dup202.c:70: TPASS: original and duped inodes are the same
> dup202.c:65: TPASS: original and duped modes are the same
> dup202.c:70: TPASS: original and duped inodes are the same
> dup202.c:65: TPASS: original and duped modes are the same
> dup202.c:70: TPASS: original and duped inodes are the same
> dup202.c:52: TFAIL: call failed unexpectedly: EBADF (9)
> dup202.c:52: TFAIL: call failed unexpectedly: EBADF (9)
> dup202.c:52: TFAIL: call failed unexpectedly: EBADF (9)
>
> It seems newfd has turned into -1 and see dup2 man-page it said
> " If newfd was open, any errors that would have been reported at
> close(2) time are lost. If this is of concern, then?unless the program
> is single-threaded and does not allocate file descriptors in signal
> handlers?the correct approach is not to close newfd before calling
> dup2(), because of the race condition described above."
>
> Maybe we should remove the close for newfd, but old api case also close.
> I am not very clear for this.
>
>
> Best Regards
> Yang Xu
>>
>> - cleanup();
>> - tst_exit();
>> -}
>> -
>> -/*
>> - * setup() - performs all ONE TIME setup for this test.
>> - */
>> -void setup(void)
>> -{
>> -
>> - tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> + /* stat the original file */
>> + SAFE_FSTAT(ofd,&oldbuf);
>>
>> - TEST_PAUSE;
>> + /* stat the duped file */
>> + SAFE_FSTAT(*tc->nfd,&newbuf);
>>
>> - tst_tmpdir();
>> + if (oldbuf.st_mode != newbuf.st_mode)
>> + tst_res(TFAIL, "original and duped modes do not match");
>> + else
>> + tst_res(TPASS, "original and duped modes are the same");
>>
>> - (void)umask(0);
>> + if (oldbuf.st_ino != newbuf.st_ino)
>> + tst_res(TFAIL, "original and duped inodes do not match");
>> + else
>> + tst_res(TPASS, "original and duped inodes are the same");
>>
>> - sprintf(testfile, "dup202.%d", getpid());
>> + SAFE_CLOSE(*tc->nfd);
>> + SAFE_CLOSE(ofd);
>> }
>>
>> -/*
>> - * cleanup() - performs all ONE TIME cleanup for this test at
>> - * completion or premature exit.
>> - */
>> -void cleanup(void)
>> -{
>> - tst_rmdir();
>> -}
>> +static struct tst_test test = {
>> + .needs_tmpdir = 1,
>> + .tcnt = ARRAY_SIZE(tcases),
>> + .test = run,
>> + .setup = setup,
>> +};
>> diff --git a/testcases/kernel/syscalls/dup2/dup204.c
>> b/testcases/kernel/syscalls/dup2/dup204.c
>> deleted file mode 100644
>> index a357bc17e..000000000
>> --- a/testcases/kernel/syscalls/dup2/dup204.c
>> +++ /dev/null
>> @@ -1,128 +0,0 @@
>> -/*
>> - *
>> - * Copyright (c) International Business Machines Corp., 2001
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> - * the GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> 02110-1301 USA
>> - */
>> -
>> -/*
>> - * NAME
>> - * dup204.c
>> - *
>> - * DESCRIPTION
>> - * Testcase to check the basic functionality of dup2(2).
>> - *
>> - * ALGORITHM
>> - * attempt to call dup2() on read/write ends of a pipe
>> - *
>> - * USAGE:<for command-line>
>> - * dup204 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
>> - * where, -c n : Run n copies concurrently.
>> - * -f : Turn off functionality Testing.
>> - * -i n : Execute test n times.
>> - * -I x : Execute test for x seconds.
>> - * -P x : Pause for x seconds between iterations.
>> - * -t : Turn on syscall timing.
>> - *
>> - * RESTRICTION
>> - * NONE
>> - */
>> -
>> -#ifndef _GNU_SOURCE
>> -#define _GNU_SOURCE
>> -#endif
>> -#include<sys/types.h>
>> -#include<fcntl.h>
>> -#include<sys/stat.h>
>> -#include<errno.h>
>> -#include<signal.h>
>> -#include<string.h>
>> -#include "test.h"
>> -#include "safe_macros.h"
>> -
>> -void setup();
>> -void cleanup();
>> -
>> -char *TCID = "dup204";
>> -int TST_TOTAL = 2;
>> -
>> -int fd[2];
>> -int nfd[2];
>> -
>> -int main(int ac, char **av)
>> -{
>> - int lc;
>> - int i;
>> - struct stat oldbuf, newbuf;
>> -
>> - tst_parse_opts(ac, av, NULL, NULL);
>> -
>> - setup();
>> -
>> - for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> - tst_count = 0;
>> -
>> - /* loop through the test cases */
>> - for (i = 0; i< TST_TOTAL; i++) {
>> - TEST(dup2(fd[i], nfd[i]));
>> -
>> - if (TEST_RETURN == -1) {
>> - tst_resm(TFAIL, "call failed unexpectedly");
>> - continue;
>> - }
>> -
>> - SAFE_FSTAT(cleanup, fd[i],&oldbuf);
>> - SAFE_FSTAT(cleanup, nfd[i],&newbuf);
>> -
>> - if (oldbuf.st_ino != newbuf.st_ino)
>> - tst_resm(TFAIL, "original and duped "
>> - "inodes do not match");
>> - else
>> - tst_resm(TPASS, "original and duped "
>> - "inodes are the same");
>> -
>> - SAFE_CLOSE(cleanup, TEST_RETURN);
>> - }
>> - }
>> -
>> - cleanup();
>> - tst_exit();
>> -}
>> -
>> -void setup(void)
>> -{
>> - fd[0] = -1;
>> -
>> - tst_sig(FORK, DEF_HANDLER, cleanup);
>> -
>> - TEST_PAUSE;
>> -
>> - tst_tmpdir();
>> -
>> - SAFE_PIPE(cleanup, fd);
>> -}
>> -
>> -void cleanup(void)
>> -{
>> - int i;
>> -
>> - for (i = 0; i< (int)ARRAY_SIZE(fd); i++) {
>> - close(fd[i]);
>> - close(nfd[i]);
>> - }
>> -
>> - tst_rmdir();
>> -}
