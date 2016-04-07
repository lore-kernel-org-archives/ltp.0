From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Apr 2016 14:38:16 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/fcntl: add new test for open file
 description locks
In-Reply-To: <1460016651-24181-2-git-send-email-alexey.kodanev@oracle.com>
References: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
 <1460016651-24181-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160407123816.GB16682@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <pthread.h>
> +
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +static int thread_cnt;
> +static const int max_thread_cnt = 32;
> +static const char fname[] = "tst_ofd_locks";
> +const int writes_num = 100;
> +const int write_size = 4096;
> +
> +static void setup(void)
> +{
> +	thread_cnt = tst_ncpus_conf() * 3;
> +	if (thread_cnt > max_thread_cnt)
> +		thread_cnt = max_thread_cnt;
> +}
> +
> +static void spawn_threads(pthread_t *id, void *(*thread_fn)(void *))
> +{
> +	intptr_t i;
> +
> +	tst_res(TINFO, "spawning '%d' threads", thread_cnt);
> +	for (i = 0; i < thread_cnt; ++i)
> +		SAFE_PTHREAD_CREATE(id + i, NULL, thread_fn, (void *)i);
> +}
> +
> +static void wait_threads(pthread_t *id)
> +{
> +	int i;
> +
> +	tst_res(TINFO, "waiting for '%d' threads", thread_cnt);
> +	for (i = 0; i < thread_cnt; ++i)
> +		SAFE_PTHREAD_JOIN(id[i], NULL);
> +}
> +
> +void *thread_fn_01(void *arg)
> +{
> +	int i;
> +	char buf[write_size];
> +	int fd = SAFE_OPEN(fname, O_RDWR);
> +
> +	memset(buf, (intptr_t)arg, write_size);
> +
> +	struct flock lck = {
> +		.l_whence = SEEK_SET,
> +		.l_start  = 0,
> +		.l_len    = 1,
> +	};
> +
> +	for (i = 0; i < writes_num; ++i) {
> +		lck.l_type = F_WRLCK;
> +		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
> +			tst_brk(TBROK | TERRNO, "fcntl() failed");
> +
> +		SAFE_LSEEK(fd, 0, SEEK_END);
> +		SAFE_WRITE(1, fd, buf, write_size);
> +
> +		lck.l_type = F_UNLCK;
> +		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
> +			tst_brk(TBROK | TERRNO, "fcntl() failed");
> +
> +		pthread_yield();
> +	}
> +
> +	SAFE_CLOSE(fd);
> +
> +	return NULL;
> +}
> +
> +static void test01(void)
> +{
> +	intptr_t i;
> +	int k;
> +	pthread_t id[thread_cnt];
> +	int res[thread_cnt];
> +	char buf[write_size];
> +
> +	tst_res(TINFO, "write to a file inside threads with OFD locks");
> +
> +	int fd = SAFE_OPEN(fname, O_CREAT | O_TRUNC | O_RDONLY, 0600);

I'm not sure that O_TRUNC | O_RDONLY would work. The manual says that
the result is unspecified.

We should either change the O_RDONLY for O_RDWR or simply unlink() the
file before we open it.

Otherwise (with the unsigned char buffer) it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
