From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Jun 2018 23:06:49 +0200
Subject: [LTP] LTP syscall fcntl36 test is fails intermittently on arm32
 qemu and beagleboard x15
In-Reply-To: <20180611085514.GB16808@rei.lan>
Message-ID: <20180612210649.GA28514@dustball.brq.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > LTP syscall fcntl36 test is failing intermittently on arm32 qemu and
> > beagleboard x15 device. We have to find a solution to fix this test
> > case on arm32.
> 
> I've seen similar failures when 32bit fcntl36 binary is executed on
> x86_64, so far we haven't figured out what is wrong here.

Hi,

It seems easy to reproduce this way. I'm seeing 2 potential issues:

a) zero flock64.l_len
-----------------------
On x86_64 compile fcntl36.c as 32-bit (-m32) and run with strace.
fcntl64 is used by default, which is known since [1].

Posix lock calls appear as if l_len == 0:
  fcntl64(6, F_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET, l_start=5120, l_len=0}
Though it looks ok for OFD:
  fcntl64(3, F_OFD_SETLKW, {l_type=F_UNLCK, l_whence=SEEK_SET, l_start=0, l_len=4096}

"-D_FILE_OFFSET_BITS=64" appears to resolve that. Maybe we should set
that as default and drop _64 version?

[1] thread "fcntl.2: F_OFD_XXX needs flock64"


b) kernel bug?
---------------
I wrote a standalone test (attached), that is simplified version of fcntl36.
I'm using only single case: traditional record lock for writing and
OFD lock for reading.

    thread1                      thread2
  fcntl lock region          fcntl lock region
  mutex lock                 if mutex try lock
  mutex unlock                  then exit(1)
  fcntl unlock region        fcntl unlock region

Now assuming fcntl over same region should provide mutual exclusion
between 2 threads (according to fcntl.2), then thread2 should never
see mutex as locked.

But that's exactly what I see (on 64-bit / x86_64 as well):

[pid 15716] 16:38:35 fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=4096} <unfinished ...>
  thread1 is trying to get write lock
[pid 15717] 16:38:35 fcntl(4, F_OFD_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET, l_start=0, l_len=4096}) = 0
  thread2 unlocked read lock
[pid 15717] 16:38:35 fcntl(4, F_OFD_SETLKW, {l_type=F_RDLCK, l_whence=SEEK_SET, l_start=0, l_len=4096} <unfinished ...>
  thread2 is trying to get read lock
[pid 15716] 16:38:35 <... fcntl resumed> ) = 0
  thread1 has write lock
[pid 15717] 16:38:35 <... fcntl resumed> ) = 0
  thread2 has read lock

Can anyone see a problem / wrong assumption in attached file?

Regards,
Jan
-------------- next part --------------
/*
 * Based on LTP's fcntl36.
 *
 * gcc -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -pthread -g3 ofd_vs_posix.c
 *
 * Pairs of threads are trying to lock 4k regions in a file.
 * Each pair locks same region. One thread with traditional
 * record lock for writing, and other thread OFD for reading.
 *
 * According to man page:
 *   Conflicting lock combinations (i.e., a read lock and a
 *   write lock or two write locks) where one lock is an open
 *   file description lock and the other is a traditional record
 *   lock conflict even when they are acquired by the same process
 *   on the same file descriptor.
 *
 * Each thread pair shares a mutex. After fcntl() returns
 * one thread locks the mutex and the other one tries to
 * lock the mutex as well.
 *
 * Assumption is that if fcntl() provides mutual exclusion
 * to same file region, then mutex should never be observed
 * as locked by other thread.
 *
 * FILE
 * +--------+--------+-------+----...
 * |  4k    |   4k   |   4k  |    ...
 * +--------+--------+-------+----...
 *   t1[0]             t1[1]
 *   t2[0]             t2[1]
 *
 * t1 - posix write lock - fn_posix_w()
 * t2 - ofd read lock - fn_ofd_r()
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

#define SAFE_FUNC(op) \
({ \
        int ret = (op); \
        if (ret == -1) { \
                printf("Test %s unresolved: got %i (%s) on line %i\n  %s\n", \
                        __FILE__, ret, strerror(errno), __LINE__, #op); \
                fflush(stdout); \
                exit(1); \
        } \
        ret; \
})

#define SAFE_PFUNC(op) \
do {\
        int ret = (op); \
        if (ret != 0) { \
                printf("Test %s unresolved: got %i (%s) on line %i\n  %s\n", \
                        __FILE__, ret, strerror(ret), __LINE__, #op); \
                fflush(stdout); \
                exit(1); \
        } \
} while (0)

#define THREAD_PAIRS 3
#define write_size 4096

static volatile int loop_flag = 1;
static const char fname[] = "tst_ofd_posix_locks";
pthread_mutex_t mutex[THREAD_PAIRS];

struct param {
	long offset;
	long length;
	long id;
};

#define USE_SLEEP 1

/* POSIX write lock writing data*/
static void *fn_posix_w(void *arg)
{
	struct param *pa = arg;
	int fd = SAFE_FUNC(open(fname, O_RDWR));

	struct flock64 lck = {
		.l_whence = SEEK_SET,
		.l_start  = pa->offset,
		.l_len    = pa->length,
	};

	while (loop_flag) {
		lck.l_type = F_WRLCK;
		SAFE_FUNC(fcntl(fd, F_SETLKW, &lck));

		SAFE_PFUNC(pthread_mutex_lock(&mutex[pa->id]));
		usleep(100);
		SAFE_PFUNC(pthread_mutex_unlock(&mutex[pa->id]));

		lck.l_type = F_UNLCK;
		SAFE_FUNC(fcntl(fd, F_SETLK, &lck));
	}

	close(fd);
	return NULL;
}

/* OFD read lock reading data*/
static void *fn_ofd_r(void *arg)
{
	struct param *pa = arg;
	int ret;
	int fd = SAFE_FUNC(open(fname, O_RDWR));

	struct flock64 lck = {
		.l_whence = SEEK_SET,
		.l_start  = pa->offset,
		.l_len    = pa->length,
		.l_pid    = 0,
	};

	while (loop_flag) {
		lck.l_type = F_RDLCK;
		SAFE_FUNC(fcntl(fd, F_OFD_SETLKW, &lck));

		ret = pthread_mutex_trylock(&mutex[pa->id]);
		if (ret == 0) 
			SAFE_PFUNC(pthread_mutex_unlock(&mutex[pa->id]));
		if (ret == EBUSY) {
			printf("Why is mutex %d locked?\n", pa->id);
			fflush(stdout);
			exit(1);
		}

		lck.l_type = F_UNLCK;
		SAFE_FUNC(fcntl(fd, F_OFD_SETLK, &lck));
	}

	close(fd);
	return NULL;
}

void do_threads(void)
{
	pthread_t t1[THREAD_PAIRS], t2[THREAD_PAIRS];
	struct param p[THREAD_PAIRS];
	int i;


	for (i = 0; i < THREAD_PAIRS; i++) {
		p[i].id = i;
		p[i].offset = i * write_size * 2;
		p[i].length = write_size;

		SAFE_PFUNC(pthread_mutex_init(&mutex[i], NULL));

		SAFE_PFUNC(pthread_create(&t1[i], NULL, fn_posix_w, (void *)&p[i]));
		SAFE_PFUNC(pthread_create(&t2[i], NULL, fn_ofd_r, (void *)&p[i]));
	}
	
	sleep(1);
	loop_flag = 0;
	
	for (i = 0; i < THREAD_PAIRS; i++) {
		SAFE_PFUNC(pthread_join(t1[i], NULL));
		SAFE_PFUNC(pthread_join(t2[i], NULL));
	}

}

int main(void)
{
	char buf[write_size * THREAD_PAIRS * 2] = { 0x22 };
	int fd = SAFE_FUNC(open(fname, O_WRONLY));

	SAFE_FUNC(write(fd, buf, sizeof(buf)));
	close(fd);

	do_threads();

	return 0;
}
