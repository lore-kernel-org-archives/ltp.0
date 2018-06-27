From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jun 2018 12:51:30 +0200
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
 use-after-free bug
In-Reply-To: <20180627061815.GA9171@sol.localdomain>
References: <20180513012325.877-1-ebiggers3@gmail.com>
 <20180518132536.GB32299@rei> <20180626113547.GG24288@rei>
 <20180627061815.GA9171@sol.localdomain>
Message-ID: <20180627105130.GA17678@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi Cyril, sorry for not responding sooner.  A few weeks ago I did try using
> fuzzy sync but I found it confusing to use, and it seemed to not provide exactly
> what is needed.  Namely, it seems to only support synchronizing the threads at a
> fixed point, but actually it's usually unknown exactly how things need to be
> timed to reproduce race conditions -- which is why sleeps of random amounts,
> though naive, can work well.

The idea behind it is that we try to synchronize two racing syscalls on
entering the kernel and we do expect the system to introduce random
delays that cause the race to be hit, which works good enough most of
the time. We are also planing to introduce random delays into the fuzzy
sync library to see if that would help to reproduce races.

As for the confusing interface, that is one of the pain points. I've
opened an issue https://github.com/linux-test-project/ltp/issues/338 and
I do hope to simplify the usage.

> Nevertheless, I did actually get the fuzzy sync version to reproduce the bug for
> me a bit more often than the random usleep version, using the following code.
> I'm not yet convinced it's really better as I think it may be more unreliable
> for some people, but you can try it and see how well it works for you.

Thanks, I will look at it.

> I'm not sure why the original test times out for you.  Is it hung in the kernel,
> or is it looping in userspace?

Looks like the child process gets stuck in call_rwsem_down_read_failed
forever, the parent then gets stuck in wait() until it's killed by the
test library.

We do check if the main test pid is killable and issue a message "kernel
bug found" message if the main test pid cannot be killed. I guess that I
can change the test library to watch for all processes in the process
group as well since as it is the test just produces "timeouted" and
leaves one process behind which is a bit confusing output.

Also we should probably set the test timeout to be twice of the expected
runtime to make it fail faster :-).

> Here's the alternate shmctl05.c to try/consider:
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
> 
> #define ATTEMPTS 0x100000
> 
> static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
> 
> static pthread_t thrd;
> 
> /*
>  * Thread 2: repeatedly remove the shm ID and reallocate it again for a
>  * new shm segment.
>  */
> static void *thrproc(void *p LTP_ATTRIBUTE_UNUSED)
> {
> 	int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
> 
> 	while (tst_fzsync_wait_update_b(&fzsync_pair)) {
> 
> 		tst_fzsync_wait_b(&fzsync_pair);
> 		tst_fzsync_delay_b(&fzsync_pair);
> 		tst_fzsync_time_b(&fzsync_pair);
> 
> 		SAFE_SHMCTL(id, IPC_RMID, NULL);
> 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
> 		tst_fzsync_wait_b(&fzsync_pair);
> 	}
> 	return NULL;
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
> 	int i;
> 
> 	/*
> 	 * Thread 1: repeatedly attach a shm segment, then remap it until the ID
> 	 * seems to have been removed by the other process.
> 	 */
> 	for (i = 0; i < ATTEMPTS; i++) {
> 		int id;
> 		void *addr;
> 
> 		tst_fzsync_wait_update_a(&fzsync_pair);
> 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
> 		addr = shmat(id, NULL, 0);
> 		if (addr == (void *)-1L)
> 			tst_brk(TBROK | TERRNO, "Unexpected shmat() error");
> 		tst_fzsync_wait_a(&fzsync_pair);
> 		tst_fzsync_delay_a(&fzsync_pair);
> 		tst_fzsync_time_a(&fzsync_pair);
> 
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
> 	.setup = setup,
> 	.test_all = do_test,
> 	.cleanup = cleanup,
> };

-- 
Cyril Hrubis
chrubis@suse.cz
