From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 15 Jun 2018 14:55:12 +0200
Subject: [LTP] [PATCH] testcases: cve-2014-0196: Set attempts according
	to nb of cpus
In-Reply-To: <20180615080810.9814-1-mylene.josserand@bootlin.com>
References: <20180615080810.9814-1-mylene.josserand@bootlin.com>
Message-ID: <877en0i4zz.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

Mylène Josserand writes:

> This test tries to cause a buffer overflow by doing 0x7000
> attempts. In a slow system platform, it leads to a failure
> because of the timeout even when it is configured with
> LTP_TIMEOUT_MUL=10.
>
> This commit adds a way to configure the number of attempts
> according to the number of CPUs.
> In case of 1 CPU and a slow platform, using 0x2000 attempts
> with a LTP_TIMEOUT_MUL=2 make the test pass.
>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>
> Hello,
>
> This is a way to fix the issue I got but let me know
> what you think of it. There is maybe a better way to
> handle that.

Another way would be to measure the time a few iterations take and limit
the number of attempts based on that. We should perhaps add that as a
feature to the fuzzy sync library.

>
> Thank you,
> Mylène
>
>  testcases/cve/cve-2014-0196.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
> index d18108897..898da1073 100644
> --- a/testcases/cve/cve-2014-0196.c
> +++ b/testcases/cve/cve-2014-0196.c
> @@ -48,7 +48,7 @@
>
>  #define ONEOFF_ALLOCS 200
>  #define RUN_ALLOCS    30
> -#define ATTEMPTS      0x7000
> +#define ATTEMPTS      0x2000
>  #define BUFLEN        512
>
>  static volatile int master_fd, slave_fd;
> @@ -98,11 +98,14 @@ static void *overwrite_thread_fn(void *p LTP_ATTRIBUTE_UNUSED)
>  static void run(void)
>  {
>  	struct termios t;
> -	int i, j;
> +	int i, j, total_cpus;
>
> -	tst_res(TINFO, "Attempting to overflow into a tty_struct...");
> +	total_cpus = tst_ncpus();

This needs to be limited to about 4, otherwise systems with lots of slow
CPU's will timeout (I have seen a few machines with 100+ slow cores).

>
> -	for (i = 0; i < ATTEMPTS; i++) {
> +	tst_res(TINFO, "Attempting to overflow into a tty_struct during %x attempts...",
> +		ATTEMPTS * total_cpus);
> +
> +	for (i = 0; i < ATTEMPTS * total_cpus; i++) {
>  		create_pty((int *)&master_fd, (int *)&slave_fd);
>
>  		for (j = 0; j < RUN_ALLOCS; j++)
> --
> 2.11.0


--
Thank you,
Richard.
