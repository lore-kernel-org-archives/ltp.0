From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 Jun 2019 14:06:10 +0200
Subject: [LTP] [PATCH] Add a regression test for CVE-2017-1000380
In-Reply-To: <20190614111310.30548-1-mmoese@suse.de>
References: <20190614111310.30548-1-mmoese@suse.de>
Message-ID: <20190614120610.GA8796@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void *ioctl_thread(void *unused)
> +{
> +	(void) unused;
> +	int tread_arg = 1;
> +	struct snd_timer_select ts;
> +	struct snd_timer_params tp;
> +
> +	while (tst_fzsync_run_b(&fzsync_pair)) {
> +
> +		ioctl(snd_fd, SNDRV_TIMER_IOCTL_TREAD, &tread_arg);
> +
> +		memset(&ts, 0, sizeof(ts));
> +		ts.id.dev_class = 1;
> +		ioctl(snd_fd, SNDRV_TIMER_IOCTL_SELECT, &ts);
> +
> +		memset(&tp, 0, sizeof(tp));
> +		tp.ticks = 1;
> +		tp.filter = 0xf;
> +		ioctl(snd_fd, SNDRV_TIMER_IOCTL_PARAMS, &tp);

I guess that we can do these two buffer initializations outside of the
loop, but I guess compared to the time spend in the syscall it would
neglectible.

> +		ioctl(snd_fd, SNDRV_TIMER_IOCTL_START, 0);
> +
> +		tst_fzsync_end_race_b(&fzsync_pair);
> +	}
> +	return NULL;

Hint: We can do return unused; here instead of the void cast.

> +}
> +
> +static void setup(void)
> +{
> +	tst_fzsync_pair_init(&fzsync_pair);
> +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +	snd_fd = SAFE_OPEN("/dev/snd/timer",
> +			O_RDONLY|O_CREAT|O_NOCTTY|O_SYNC|O_LARGEFILE, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_fzsync_pair_cleanup(&fzsync_pair);
> +	SAFE_CLOSE(snd_fd);
> +}
> +
> +static void run(void)
> +{
> +	size_t len;
> +	int size;
> +	struct iovec iov;
> +	pthread_t th;
> +	char read_buf[MAX_BUFSIZE];
> +	int i, nz = 0;
> +	pthread_attr_t thread_attr;
> +
> +	pthread_attr_init(&thread_attr);
> +	pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_DETACHED);
> +	SAFE_PTHREAD_CREATE(&th, &thread_attr, ioctl_thread, NULL);
> +
> +	iov.iov_base = read_buf;
> +	iov.iov_len = sizeof(read_buf);
> +
> +	while (tst_fzsync_run_a(&fzsync_pair)) {
> +		memset(read_buf, 0, sizeof(read_buf));
> +		size = readv(snd_fd, &iov, 1);
> +
> +		tst_fzsync_end_race_a(&fzsync_pair);
> +
> +		/* check if it could be a valid ioctl result */
> +		if (size == 0)
> +			continue;
> +
> +		/* check if the buffer is  */
                                          ^
					  non-empty?
> +		for (i = 0; i < size; i++) {
> +			if (read_buf[i]) {
> +				nz = 1;
> +				break;
> +			}
> +		}
> +		if (!nz)
> +			continue;

Also I do not really get this part, we do not reset the nz at all so
this is ineffective after fist non-zero buffer.

> +		len = strlen(read_buf);

Isn't there a possibility that the buffer was filled complelety with
non-zero characters? Can't we just store the position of the last
non-zereo byte in the loop above?

> +		/* the kernel's struct snd_timer_read is two unsigned integers*/
> +		if (len <= 2 * sizeof(unsigned int))
> +			continue;
> +
> +		tst_res(TFAIL, "kernel seems vulnerable");
> +		return;
> +	}
> +
> +	if (tst_taint_check() != 0)
> +		tst_res(TFAIL, "kernel seems vulnerable");
> +	else
> +		tst_res(TPASS, "kernel seems not vulnerable");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

And lastly but not least, can we name this snd_timer01 so that we don't
have to rename it in a case that someone will write sound timer tests?

Other than the minor nits it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
