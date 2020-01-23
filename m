From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jan 2020 09:17:46 -0500 (EST)
Subject: [LTP] [PATCH 2/2] syscalls/io_pgetevents
In-Reply-To: <6aae63a2e362a0f09cf35fff058e7741f0987208.1579755655.git.viresh.kumar@linaro.org>
References: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
 <6aae63a2e362a0f09cf35fff058e7741f0987208.1579755655.git.viresh.kumar@linaro.org>
Message-ID: <104918104.3505581.1579789066988.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

----- Original Message -----
> +#ifdef HAVE_LIBAIO
> +#include <libaio.h>
> +
> +#ifndef HAVE_IO_SETUP
> +int io_setup(int nr, io_context_t *ctxp)
> +{
> +	return syscall(__NR_io_setup, nr, ctxp);
> +}
> +#endif /* HAVE_IO_SETUP */
> +
> +#ifndef HAVE_IO_DESTROY
> +int io_destroy(io_context_t ctx)
> +{
> +	return syscall(__NR_io_destroy, ctx);
> +}
> +#endif /* HAVE_IO_DESTROY */
> +
> +#ifndef HAVE_IO_SUBMIT
> +int io_submit(io_context_t ctx, long nr, struct iocb **iocbpp)
> +{
> +	return syscall(__NR_io_submit, ctx, nr, iocbpp);

Can functions above also use ltp_syscall?

<snip>

> +#ifdef HAVE_LIBAIO
> +
> +static int fd = -1;
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(fd);

I'd move this to run(). It may get skipped on tst_brk(), but kernel will take
care of closing it. But if you run testcase in loop (-i) it won't run out
of file descriptors.

<snip>

> +#ifdef HAVE_LIBAIO
> +
> +static int fd = -1;
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(fd);

same here

> +}
> +
> +static void run(void)
> +{
> +	struct io_event events[1];
> +	struct iocb cb, *cbs[1];
> +	io_context_t ctx = 0;
> +	sigset_t sigmask;
> +	char data[4096];
> +	int ret;
> +
> +	sigemptyset(&sigmask);
> +
> +	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
> +
> +	ret = io_setup(1, &ctx);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "io_setup() failed");
> +
> +	io_prep_pwrite(&cb, fd, data, 4096, 0);
> +
> +	cbs[0] = &cb;
> +
> +	ret = io_submit(ctx, 1, cbs);
> +	if (ret != 1)
> +		tst_brk(TBROK | TERRNO, "io_submit() failed");
> +
> +	/* Invalid Max event count */
> +	ret = io_pgetevents(ctx, 1, 0, events, NULL, &sigmask);
> +
> +	/* Invalid events*/
> +	if (ret != 1)
> +		ret = io_pgetevents(ctx, 1, 1, NULL, NULL, &sigmask);
> +
> +	if (io_destroy(ctx) < 0)
> +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
> +
> +	/* Invalid ctx */
> +	if (ret != 1)
> +		ret = io_pgetevents(ctx, 1, 1, events, NULL, &sigmask);
> +
> +	if (ret != 1)
> +		tst_res(TPASS, "io_pgetevents() failed as expected");

If this reports FAIL, will we know what test actually failed?

Can you make this more verbose? I mean have each test report PASS/FAIL,
not just a one line summary after all tests.

> +	else
> +		tst_brk(TBROK| TERRNO, "io_pgetevents() passed unexpectedly");

TFAIL | TERRNO seems more fitting, since io_pgetevents is subject of the test.

Regards,
Jan

