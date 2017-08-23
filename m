From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Aug 2017 15:35:12 +0200
Subject: [LTP] [PATCH v5] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <1503494101-27530-1-git-send-email-xzhou@redhat.com>
References: <20170823095312.GB17676@rei.lan>
 <1503494101-27530-1-git-send-email-xzhou@redhat.com>
Message-ID: <20170823133512.GA20766@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +	while (loop_flag) {
> +
> +		memset(buf, wt, write_size);
> +
> +		lck.l_type = F_WRLCK;
> +		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
> +
> +		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
> +		SAFE_WRITE(1, fd, buf, pa->length);

Just a minor note, we use both write_size and pa->length randomly here
and in all of the test functions. It would be a much cleaner to use only
pa->lenght instead.

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
> +	if (tst_fill_file(fname, 1, write_size, thread_cnt))
> +		tst_brk(TBROK, "Failed to create tst file");
> +
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

We should reset the fail_cnt here. And it would be safer to rename it to
fail_flag and set it to 1 on a failure because if we are terribly
unlucky the incements can overflow and we may as well end up with a
zero.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
