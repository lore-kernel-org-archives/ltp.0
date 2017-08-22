From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Aug 2017 16:23:57 +0200
Subject: [LTP] [PATCH v3] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <1503390908-13620-1-git-send-email-xzhou@redhat.com>
References: <20170821160047.GB6479@rei.lan>
 <1503390908-13620-1-git-send-email-xzhou@redhat.com>
Message-ID: <20170822142356.GB23381@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  runtest/syscalls                          |   2 +
>  testcases/kernel/syscalls/fcntl/Makefile  |   3 +
>  testcases/kernel/syscalls/fcntl/fcntl36.c | 386 ++++++++++++++++++++++++++++++

Don't forget about .gitignore entry as well.

...

> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <errno.h>
> +
> +#include "lapi/fcntl.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
> +
> +static int thread_cnt;
> +static volatile int loop_flag;
> +static const int max_thread_cnt = 32;
> +static const char fname[] = "tst_ofd_posix_locks";
> +static const long write_size = 4096;
> +
> +struct param {
> +	long offset;
> +	long length;
> +	long cnt;
> +};
> +
> +static void setup(void)
> +{
> +	thread_cnt = tst_ncpus_conf() * 3;
> +	if (thread_cnt > max_thread_cnt)
> +		thread_cnt = max_thread_cnt;
> +}
> +
> +#define debug
             ^
Forget to remove this

> +/* OFD write lock writing data*/
> +static void *fn_ofd_w(void *arg)
> +{
> +	unsigned char buf[write_size];
> +	struct param *pa = (struct param *)arg;
> +	int fd = SAFE_OPEN(fname, O_RDWR);
> +	long wt = pa->cnt;
> +
> +	struct flock64 lck = {
> +		.l_whence = SEEK_SET,
> +		.l_start  = pa->offset,
> +		.l_len    = pa->length,
> +		.l_pid    = 0,
> +	};
> +
> +	while (1) {
> +
> +		if (loop_flag == 1)
> +			break;

Common, why not just while (loop_flag) ?

And we set the loop_flag to 1 before we spawn the threads and then reset
it to 0 after we do the sleep.

> +		memset(buf, wt, write_size);
> +
> +		lck.l_type = F_WRLCK;
> +		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
> +
> +		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
> +		SAFE_WRITE(1, fd, buf, pa->length);
> +
> +		lck.l_type = F_UNLCK;
> +		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
> +
> +		wt++;
> +		if (wt >= 255)
> +			wt = pa->cnt;
> +
> +		sched_yield();
> +	}
> +
> +	SAFE_CLOSE(fd);
> +	return NULL;
> +}
> +
> +/* POSIX write lock writing data*/
> +static void *fn_posix_w(void *arg)
> +{
> +	unsigned char buf[write_size];
> +	struct param *pa = (struct param *)arg;
> +	int fd = SAFE_OPEN(fname, O_RDWR);
> +	long wt = pa->cnt;
> +
> +	struct flock64 lck = {
> +		.l_whence = SEEK_SET,
> +		.l_start  = pa->offset,
> +		.l_len    = pa->length,
> +	};
> +
> +	while (1) {
> +
> +		if (loop_flag == 1)
> +			break;

Here as well.

> +		memset(buf, wt, write_size);
> +
> +		lck.l_type = F_WRLCK;
> +		SAFE_FCNTL(fd, F_SETLKW, &lck);
> +
> +		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
> +		SAFE_WRITE(1, fd, buf, pa->length);
> +
> +		lck.l_type = F_UNLCK;
> +		SAFE_FCNTL(fd, F_SETLKW, &lck);
> +
> +		wt++;
> +		if (wt >= 255)
> +			wt = pa->cnt;
> +
> +		sched_yield();
> +	}
> +
> +	SAFE_CLOSE(fd);
> +	return NULL;
> +}
> +
> +/* OFD read lock reading data*/
> +static void *fn_ofd_r(void *arg)
> +{
> +	unsigned char buf[write_size];
> +	struct param *pa = (struct param *)arg;
> +	int i;
> +	int fd = SAFE_OPEN(fname, O_RDWR);
> +
> +	struct flock64 lck = {
> +		.l_whence = SEEK_SET,
> +		.l_start  = pa->offset,
> +		.l_len    = pa->length,
> +		.l_pid    = 0,
> +	};
> +
> +	while (1) {
> +
> +		if (loop_flag == 1)
> +			break;

And here as well.

> +		memset(buf, 0, write_size);
> +
> +		lck.l_type = F_RDLCK;
> +		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
> +
> +		/* rlock acquired */
> +		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
> +		SAFE_READ(1, fd, buf, pa->length);
> +
> +		/* Verifying data read */
> +		for (i = 0; i < pa->length; i++) {
> +
> +			if (buf[i] < 1 || buf[i] > 254) {
> +
> +				tst_res(TFAIL, "Unexpected data "
> +					"offset %ld value %d",
> +					pa->offset + i, buf[i]);
> +				break;
> +			}
> +
> +			long tmp = pa->length / 2;

We can simplify this with:
			int j = i / (pa->length/2);

			if (buf[i] != buf[j]) {
				...
			}

> +			if ((i < tmp && buf[i] != buf[0]) ||
> +			    (i >= tmp && buf[i] != buf[tmp])) {
> +
> +				tst_res(TFAIL, "Unexpected data "
> +					"offset %ld value %d",
> +					pa->offset + i, buf[i]);
> +				break;
> +			}
> +		}
> +
> +		lck.l_type = F_UNLCK;
> +		SAFE_FCNTL(fd, F_OFD_SETLK, &lck);
> +
> +		sched_yield();
> +	}
> +
> +	SAFE_CLOSE(fd);
> +	return NULL;
> +}
> +
> +/* POSIX read lock reading data */
> +static void *fn_posix_r(void *arg)
> +{
> +	unsigned char buf[write_size];
> +	struct param *pa = (struct param *)arg;
> +	int i;
> +	int fd = SAFE_OPEN(fname, O_RDWR);
> +
> +	struct flock64 lck = {
> +		.l_whence = SEEK_SET,
> +		.l_start  = pa->offset,
> +		.l_len    = pa->length,
> +	};
> +
> +	while (1) {
> +
> +		if (loop_flag == 1)
> +			break;

Here as well.

> +		memset(buf, 0, write_size);
> +
> +		lck.l_type = F_RDLCK;
> +		SAFE_FCNTL(fd, F_SETLKW, &lck);
> +
> +		/* rlock acquired */
> +		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
> +		SAFE_READ(1, fd, buf, pa->length);
> +
> +		/* Verifying data read */
> +		for (i = 0; i < pa->length; i++) {
> +
> +			if (buf[i] < 1 || buf[i] > 254) {
> +
> +				tst_res(TFAIL, "Unexpected data, "
> +					"offset %ld value %d",
> +					pa->offset + i, buf[i]);
> +				break;
> +			}
> +
> +			long tmp = pa->length / 2;

And here as well.

> +			if ((i < tmp && buf[i] != buf[0]) ||
> +			    (i >= tmp && buf[i] != buf[tmp])) {
> +
> +				tst_res(TFAIL, "Unexpected data, "
> +					"offset %ld value %d",
> +					pa->offset + i, buf[i]);
> +				break;
> +			}
> +		}
> +
> +		lck.l_type = F_UNLCK;
> +		SAFE_FCNTL(fd, F_SETLK, &lck);
> +
> +		sched_yield();
> +	}
> +
> +	SAFE_CLOSE(fd);
> +	return NULL;
> +}
> +
> +/* Test different functions and verify data */
> +static void test_fn(void *f0(void *), void *f1(void *), const char *msg)
> +{
> +	int i, k, fd;
> +	pthread_t id0[thread_cnt];
> +	pthread_t id1[thread_cnt];
> +	struct param p0[thread_cnt];
> +	struct param p1[thread_cnt];
> +	unsigned char buf[write_size];
> +
> +	if (tst_fill_file(fname, 1, write_size, thread_cnt)) {
> +		tst_brk(TBROK, "Failed to create tst file");
> +	}

No need for the curly braces around single line statement here.

> +	tst_res(TINFO, msg);
> +
> +	for (i = 0; i < thread_cnt; i++) {
> +
> +		p0[i].offset = i * write_size;
> +		p0[i].length = write_size;
> +		p0[i].cnt = i + 2;
> +
> +		p1[i].offset = i * write_size;
> +		p1[i].offset += write_size / 2;
> +		p1[i].length = write_size;
> +		p1[i].cnt = i + 2;
> +	}
> +
> +	loop_flag = 0;
> +	for (i = 0; i < thread_cnt; i++) {
> +		SAFE_PTHREAD_CREATE(id0 + i, NULL, f0, (void *)&p0[i]);
> +		SAFE_PTHREAD_CREATE(id1 + i, NULL, f1, (void *)&p1[i]);
> +	}
> +
> +	sleep(3);

I would go fo 1s for default run, but that is very minor.

> +	loop_flag = 1;
> +	for (i = 0; i < thread_cnt; i++) {
> +		SAFE_PTHREAD_JOIN(id0[i], NULL);
> +		SAFE_PTHREAD_JOIN(id1[i], NULL);
> +	}
> +
> +	tst_res(TINFO, "Verifying file's data");
> +	fd = SAFE_OPEN(fname, O_RDWR);
> +	SAFE_LSEEK(fd, 0, SEEK_SET);

We do not write to the file, so we may as well open it RDONLY and since
we are opening it we don't have to seek it to the start.

> +	for (i = 0; i < thread_cnt * 2; i++) {
> +
> +		SAFE_READ(1, fd, buf, write_size/2);
> +
> +		for (k = 0; k < write_size/2; k++) {
> +
> +			if (buf[k] < 2 || buf[k] > 254) {
> +
> +				if (i == 0 && buf[k] == 1)
> +					continue;
> +				tst_res(TFAIL, "Unexpected data, "
> +					"offset %ld value %d",
> +					i * write_size / 2 + k, buf[k]);
> +				return;
> +			}
> +		}
> +
> +		for (k = 1; k < write_size/2; k++) {
> +
> +			if (buf[k] != buf[0]) {
> +				tst_res(TFAIL, "Unexpected block read");
> +				return;
> +			}
> +		}
> +	}

We should close the fd before the return here.

> +	SAFE_CLOSE(fd);
> +	tst_res(TPASS, "Access between threads synchronized");

And here we would print TPASS even if reader thread failed the test. So
we should either change tst_res() to tst_brk() in the reader thread
functions so that we exit the test if we read back wrong data. Or setup
a global failure counter and print TPASS only if the counter was not set
from one of the reader threads. Or propagate the failure from the tread
return value (the one you get from SAFE_JOIN()).

> +}
> +
> +static struct tcase {
> +
> +	void *(*fn0)(void *);
> +	void *(*fn1)(void *);
> +	const char *desc;
> +
> +} tcases[] = {
> +
> +	{fn_ofd_r,   fn_ofd_w,   "OFD read locks vs OFD write locks"},
> +	{fn_ofd_w,   fn_posix_w, "OFD write locks vs POSIX write locks"},
> +	{fn_ofd_r,   fn_posix_w, "OFD read locks vs POSIX write locks"},
> +	{fn_posix_r, fn_ofd_w,   "OFD write locks vs POSIX read locks"},
> +	{fn_ofd_w,   fn_ofd_w,   "OFD write locks vs OFD write locks"},
> +};
> +
> +static void tests(unsigned int i)
> +{
> +	test_fn(tcases[i].fn0, tcases[i].fn1, tcases[i].desc);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "3.15",
> +	.needs_tmpdir = 1,
> +	.test = tests,
> +	.tcnt = 5,
                ^
		ARRAY_SIZE(tcases) is safer here, that way it will be
		correct even if we add/remove tests in the array.
> +	.setup = setup
> +};
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
