From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jan 2020 17:27:26 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/fcntl37: add error test for fcntl
 with F_SETPIPE_SZ
In-Reply-To: <1579686442-24689-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1579686442-24689-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1579686442-24689-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200127162726.GE30831@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int fds[2];
> +static unsigned int orig_value, invalid_value, half_value, sys_value;
> +static char *wrbuf;
> +
> +static struct tcase {
> +	unsigned int *setvalue;
> +	int exp_err;
> +	char *message;
> +} tcases[] = {
> +	{&invalid_value, EINVAL,
> +	"cmd is F_SETPIPE_SZ and the arg is beyond 1<<31"},
> +
> +	{&half_value, EBUSY,
> +	"cmd is F_SETPIPE_SZ and the arg is smaller than the amount of the current used buffer space"},

Ah the EBUSY is handled here.


Also these descriptions are way too long, ideally these should be
shorter and to the point. Something as:

"F_SETPIPE_SZ and size < data stored in pipe"

> +	{&sys_value, EPERM,
> +	"cmd is F_SETPIPE_SZ and the arg is over /proc/sys/fs/pipe-max-size limit under unprivileged users"},

Here something as:

"F_SETPIPE_SZ and size is over limit for unpriviledged user"

> +};
> +
> +static void verify_fcntl(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	tst_res(TINFO, "%s", tc->message);
> +
> +	TEST(fcntl(fds[1], F_SETPIPE_SZ, *(tc->setvalue)));
> +	if (TST_RET != -1)
> +		tst_res(TFAIL, "F_SETPIPE_SZ succeed");

Maybe we should print the TST_RET here as well, it may return completely
random number that != -1.

> +	if (TST_ERR == tc->exp_err)
> +		tst_res(TPASS | TTERRNO, "F_SETPIPE_SZ failed as expected");
> +	else
> +		tst_res(TFAIL | TTERRNO, "F_SETPIPE_SZ failed expected %s bu got",
                                                                          ^
									  but?

I guess that we can completely drop the "but" here and just keep it
"... expected %s got"

> +				tst_strerrno(tc->exp_err));
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_PIPE(fds);
> +
> +	TEST(fcntl(fds[1], F_GETPIPE_SZ));
> +	if (TST_ERR == EINVAL)
> +		tst_brk(TCONF, "kernel doesn't support F_GET/SETPIPE_SZ");
> +
> +	orig_value = TST_RET;
> +
> +	wrbuf = SAFE_MALLOC(orig_value);
> +	memset(wrbuf, 'x', orig_value);
> +	SAFE_WRITE(1, fds[1], wrbuf, orig_value);
> +
> +	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &sys_value);
> +	sys_value++;
> +
> +	half_value = orig_value / 2;
> +	invalid_value = (1U << 31) + 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FCNTL(fds[1], F_SETPIPE_SZ, orig_value);

Again there is no point in restoring the value if we close the pipe
right after.

> +	if (fds[0] > 0)
> +		SAFE_CLOSE(fds[0]);
> +	if (fds[1] > 0)
> +		SAFE_CLOSE(fds[1]);
> +	if (wrbuf)
> +		free(wrbuf);

Why don't we free the buffer right in the test setup? There is no point
in keeping it allocated.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_fcntl,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_DROP, CAP_SYS_RESOURCE),
> +		{}
> +	},
> +};

Other than the minor things the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
