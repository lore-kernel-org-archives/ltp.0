From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 27 Jun 2018 23:46:12 -0700
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
 use-after-free bug
In-Reply-To: <20180627135903.GB32300@rei>
References: <20180513012325.877-1-ebiggers3@gmail.com>
 <20180518132536.GB32299@rei> <20180626113547.GG24288@rei>
 <20180627061815.GA9171@sol.localdomain>
 <20180627135903.GB32300@rei>
Message-ID: <20180628064612.GA719@sol.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 27, 2018 at 03:59:03PM +0200, Cyril Hrubis wrote:
> Hi!
> Looks like if we drop the callibration from the test and use the fuzzy
> sync library only as a spinlocks to synchronize the IPC_RMID against the
> remap_file_pages the bug gets triggered very reliably for me.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
>
> /*
>  * Copyright (c) 2018 Google, Inc.
>  *
>  * This program is free software: you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation, either version 2 of the License, or
>  * (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program, if not, see <http://www.gnu.org/licenses/>.
>  */
> 
> /*
>  * Regression test for commit 3f05317d9889 ("ipc/shm: fix use-after-free of shm
>  * file via remap_file_pages()").  This bug allowed the remap_file_pages()
>  * syscall to use the file of a System V shared memory segment after its ID had
>  * been reallocated and the file freed.  This test reproduces the bug as a NULL
>  * pointer dereference in touch_atime(), although it's a race condition so it's
>  * not guaranteed to work.  This test is based on the reproducer provided in the
>  * fix's commit message.
>  */
> 
> #include "tst_test.h"
> #include "tst_safe_sysv_ipc.h"
> #include "lapi/syscalls.h"
> #include "tst_fuzzy_sync.h"
> #include "tst_safe_pthread.h"
> #include "tst_timer.h"
> 
> #include <stdio.h>
> 
> static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
> 
> static pthread_t thrd;
> 
> /*
>  * Thread 2: repeatedly remove the shm ID and reallocate it again for a
>  * new shm segment.
>  */
> static void *thrproc(void *unused)
> {
> 	int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
> 
> 	for (;;) {
> 		if (!tst_fzsync_wait_b(&fzsync_pair))
> 	       		break;
> 		SAFE_SHMCTL(id, IPC_RMID, NULL);
> 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
> 		if (!tst_fzsync_wait_b(&fzsync_pair))
> 			break;
> 	}
> 	return unused;
> }
> 
> static void setup(void)
> {
> 	/* Skip test if either remap_file_pages() or SysV IPC is unavailable */
> 	tst_syscall(__NR_remap_file_pages, NULL, 0, 0, 0, 0);
> 	tst_syscall(__NR_shmctl, 0xF00F, IPC_RMID, NULL);
> 
> 	SAFE_PTHREAD_CREATE(&thrd, NULL, thrproc, NULL);
> }
> 
> static void do_test(void)
> {
> 	tst_timer_start(CLOCK_MONOTONIC);
> 
> 	/*
> 	 * Thread 1: repeatedly attach a shm segment, then remap it until the ID
> 	 * seems to have been removed by the other process.
> 	 */
> 	while (tst_timer_elapsed_ms() < 5000) {
> 		int id;
> 		void *addr;
> 
> 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
> 		addr = shmat(id, NULL, 0);
> 		if (addr == (void *)-1L)
> 			tst_brk(TBROK | TERRNO, "Unexpected shmat() error");
> 		tst_fzsync_wait_a(&fzsync_pair);
> 		do {
> 			/* This is the system call that crashed */
> 			TEST(syscall(__NR_remap_file_pages, addr, 4096,
> 				     0, 0, 0));
> 		} while (TEST_RETURN == 0);
> 
> 		if (TEST_ERRNO != EIDRM && TEST_ERRNO != EINVAL) {
> 			tst_brk(TBROK | TTERRNO,
> 				"Unexpected remap_file_pages() error");
> 		}
> 		tst_fzsync_wait_a(&fzsync_pair);
> 	}
> 
> 	tst_res(TPASS, "didn't crash");
> }
> 
> static void cleanup(void)
> {
> 	if (thrd) {
> 		tst_fzsync_pair_exit(&fzsync_pair);
> 		SAFE_PTHREAD_JOIN(thrd, NULL);
> 	}
> 	shmctl(0xF00F, IPC_RMID, NULL);
> }
> 
> static struct tst_test test = {
> 	.timeout = 20,
> 	.setup = setup,
> 	.test_all = do_test,
> 	.cleanup = cleanup,
> };

Hi, this works well for me too -- thanks!  Though, IIUC it relies on scheduling
nondeterminism to hit the race.  It might help reproducing bugs like this if
tst_fzsync_wait_*() cycled through different delay deltas between the two
threads.

Also with a fixed kernel, to make the test pass rather than timing out, I had to
change

	while (tst_timer_elapsed_ms() < 5000)

to

	while (tst_timer_stop(), tst_timer_elapsed_ms() < 5000)

It would be nice if there was a simpler supported way to implement time-based
tests like this.  E.g. the test framework could just save the start time
automatically for all tests, and then a single function call could return the
time elapsed so far.

Anyway, should I go ahead and send a formal v2 patch?

Thanks,

Eric
