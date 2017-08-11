From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Aug 2017 16:09:05 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20170811140905.GB3341@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/tst_test.h |  4 ++++
>  lib/tst_test.c     | 28 ++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
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

This seems to be a bit too specific to me, I would be more happy if we
named it "measures_sleep_time" or something that describes what the
testcase does rather than calling it after specific workaround.

Also shouldn't this be set automatically for all timer related testcases
(these that make use of the sampling function) rather than just for the
pselect one? If so we should set the flag in the tst_timer_test.c
library instead. Or we can also stick the latency setup/cleanup
into the tst_timer_test.c as well and don't bother with adding more
flags into the tst_test structure (see timer_setup() and timer_cleanup()
in the tst_timer_test.c).

>  /*
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 4c30eda..717a782 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -619,6 +619,31 @@ static void copy_resources(void)
>  		TST_RESOURCE_COPY(NULL, tst_test->resource_files[i], NULL);
>  }
>  
> +static int set_latency(void)
> +{
> +	int fd, ret;
> +
> +	fd = open("/dev/cpu_dma_latency", O_WRONLY);
> +	if (fd < 0) {
> +		/*
> +		 * In case we are running on old kernel where the cpu_dma latency does
> +		 * not exist, do not fail, just inform and bail out.
> +		 */
> +		if (errno == ENOENT) {
> +			tst_res(TINFO, "/dev/cpu_dma_latency does not exists\n");
> +			return 0;
> +		}
> +
> +		return fd;
> +	}
> +
> +	ret = write(fd, &tst_test->latency, sizeof(tst_test->latency));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const char *get_tid(char *argv[])
>  {
>  	char *p;
> @@ -736,6 +761,9 @@ static void do_setup(int argc, char *argv[])
>  
>  	if (tst_test->resource_files)
>  		copy_resources();
> +
> +	if (tst_test->needs_latency && set_latency())
> +		tst_brk(TBROK, "Failed to set cpu latency");
>  }
>  
>  static void do_test_setup(void)
> -- 
> 2.1.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
