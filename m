From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 11 Aug 2017 07:25:18 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] ltp: Add the ability to specify the
	latency	constraint
In-Reply-To: <1502352088-10136-1-git-send-email-daniel.lezcano@linaro.org>
References: <1502352088-10136-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The ltp test suites provides a set of tests. Some of them are checking the
> test
> happens in a specified amount of time.
> 
> Unfortunately, some platforms have slow power management routines adding more
> than 1.5ms to wakeup from a deep idle state. This duration is far too long to
> be acceptable when we are trying the measure a speficied routine with a
> timeout
> reasonably delayed. For example, the testcases/kernel/syscalls/pselect_01 is
> failing for this reason.
> 
> This patch gives the opportunity to the testcase to specify the latency
> constraint when running. This option must be used with the needs_root in
> order
> to have the right privileges.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/tst_test.h |  4 ++++
>  lib/tst_test.c     | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index e90312a..519fd4c 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -124,6 +124,7 @@ struct tst_test {
>  	int needs_checkpoints:1;
>  	int format_device:1;
>  	int mount_device:1;
> +	int needs_latency:1;
>  
>  	/* Minimal device size in megabytes */
>  	unsigned int dev_min_size;
> @@ -154,6 +155,9 @@ struct tst_test {
>  
>  	/* NULL terminated array of resource file names */
>  	const char *const *resource_files;
> +
> +	/* Latency constraint to be set for the test */
> +	int latency;
>  };
>  
>  /*
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 4c30eda..485515e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -619,6 +619,21 @@ static void copy_resources(void)
>  		TST_RESOURCE_COPY(NULL, tst_test->resource_files[i], NULL);
>  }
>  
> +static int set_latency(void)
> +{
> +	int fd, ret;
> +
> +	fd = open("/dev/cpu_dma_latency", O_WRONLY);
> +	if (fd < 0)
> +		return fd;

Hi,

so any kind of failure to open/write to this node will end test
with TCONF. I'd rather not hide problems with open/write and
instead report any trouble via TBROK:

- if node doesn't exist (for example because kernels is too old),
  we'll run the test anyway
- if node exists but can't be opened -> TBROK
- if node can be opened, but write fails -> TBROK

Regards,
Jan
