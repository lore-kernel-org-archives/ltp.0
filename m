From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Jun 2018 13:11:58 +0200
Subject: [LTP] [bug?] mutual exclusion between posix and OFD locks
Message-ID: <20180615111158.GA536@dustball.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Attached is simplified reproducer (LTP fcntl36), where
2 threads try to lock same region in a file. One is
using posix write lock, the other OFD read lock.

Observed problem: 2 threads obtain lock simultaneously.

--- strace excerpt ---
[pid 16853] 06:57:11 openat(AT_FDCWD, "tst_ofd_posix_locks", O_RDWR) = 3
[pid 16854] 06:57:11 openat(AT_FDCWD, "tst_ofd_posix_locks", O_RDWR) = 4
...
[pid 16853] 06:57:12 fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=4096} <unfinished ...>
[pid 16854] 06:57:12 fcntl(4, F_OFD_SETLKW, {l_type=F_RDLCK, l_whence=SEEK_SET, l_start=0, l_len=4096} <unfinished ...>
[pid 16853] 06:57:12 <... fcntl resumed> ) = 0
[pid 16853] 06:57:12 nanosleep({tv_sec=0, tv_nsec=100000},  <unfinished ...>
[pid 16854] 06:57:12 <... fcntl resumed> ) = 0
--- /strace excerpt ---

fcntl(2) says:
  Conflicting lock combinations (i.e., a read lock and a write
  lock or two write locks) where one lock is an open file
  description lock and the other is a traditional record lock
  conflict even when they are acquired by the same process on
  the same file descriptor.

Reproducible on x86_64 VM, with v4.17-11782-gbe779f03d563.

Thanks for having a look,
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
 *   t1[0]             t1[1]      ...
 *   t2[0]             t2[1]      ...
 *   mutex[0]          mutex[1]   ...
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
#include <syscall.h>
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
			printf("(%d) Why is mutex %d locked?\n", syscall(__NR_gettid), pa->id);
			fflush(stdout);
			_exit(1);
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
	int fd = SAFE_FUNC(open(fname, O_CREAT|O_WRONLY, S_IRWXU));

	SAFE_FUNC(write(fd, buf, sizeof(buf)));
	close(fd);

	do_threads();

	return 0;
}

