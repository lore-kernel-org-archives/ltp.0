From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jul 2020 15:46:47 +0200
Subject: [LTP] [PATCH V7 15/19] syscalls/semop: Migrate to new test
 framework
In-Reply-To: <c0ffc2cd5a39add866a0d64607ed4801efe344ee.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <c0ffc2cd5a39add866a0d64607ed4801efe344ee.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200727134647.GC7863@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/syscalls/ipc/semop/Makefile  |   4 +-
>  testcases/kernel/syscalls/ipc/semop/semop01.c | 140 ++++----
>  testcases/kernel/syscalls/ipc/semop/semop02.c | 145 +++------
>  testcases/kernel/syscalls/ipc/semop/semop03.c | 150 +++------
>  testcases/kernel/syscalls/ipc/semop/semop04.c | 165 ++++------
>  testcases/kernel/syscalls/ipc/semop/semop05.c | 303 ++++++++----------

Looking at the code, is there a real reson to keep the EFBIG tests in a
separate test? Why can't we just add these to the array in semop02? I
guess that we can merge semop04 to the semop02 as well.

Also if nothing else the support for uClinux has to be removed from
semop04. We have stopped supporting it a few years ago and any test
converted to the new library must remove it.

And lastly but not least, the tests should be a cleaned up a bit more,
there is still plenty of useless comments kept in the source. E.g. we do
have:

        /* Get an new IPC resource key. */
        semkey2 = GETIPCKEY();

How is that comment helping? It's stating the obvious. So can we please
get rid of these?

As well as the useless parts in the top level comment? For that part I
would do:

diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index bcb45fa69..cbcbcea91 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -1,41 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Copyright (c) International Business Machines  Corp., 2001 */
-
-/*
- * NAME
- *     semop01.c
- *
- * DESCRIPTION
- *     semop01 - test that semop() basic functionality is correct
- *
- * ALGORITHM
- *     create a semaphore set and initialize some values
- *     loop if that option was specified
- *     call semop() to set values for the primitive semaphores
- *     check the return code
- *       if failure, issue a FAIL message.
- *     otherwise,
- *       if doing functionality testing
- *             get the semaphore values and compare with expected values
- *             if correct,
- *                     issue a PASS message
- *             otherwise
- *                     issue a FAIL message
- *       else issue a PASS message
- *     call cleanup
- *
- * HISTORY
+/* Copyright (c) International Business Machines  Corp., 2001
  *     03/2001  - Written by Wayne Boyer
  *     17/01/02 - Modified. Manoj Iyer, IBM Austin. TX. manjo@austin.ibm.com
- *                4th argument to semctl() system call was modified according
- *                to man pages.
- *                In my opinion The test should not even have compiled but
- *                it was working due to some mysterious reason.
- *
- * RESTRICTIONS
- *     none
  */
-
+/*
+ * Test that semop() basic functionality is correct
+ */



-- 
Cyril Hrubis
chrubis@suse.cz
