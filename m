Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xw7W1-0008Sq-N2
	for ltp-list@lists.sourceforge.net; Wed, 03 Dec 2014 10:50:37 +0000
Date: Wed, 3 Dec 2014 11:50:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141203105024.GA11624@rei.suse.de>
References: <1417596291-8540-1-git-send-email-liwang@redhat.com>
	<373996084.5962831.1417596425167.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <373996084.5962831.1417596425167.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] /vm/hugepage/thp/thp05: cleanup should not use
 safe macros
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi, after thinking over, I feel there is no need to create a static function 
> file_vscanf() and file_vprintf().
> 
> I'd love to create FILE_PRINTF() macro that is not calling the tst_brkm() 
> and issues only a warning. Then we can use FILE_PRINTF() to replace all 
> the safe macros in cleanup().
> 
> So, new patch like this:
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/safe_file_ops.h                            | 10 ++++
>  lib/safe_file_ops.c                                | 59 ++++++++++++++++++++++
>  .../kernel/device-drivers/acpi/ltp_acpi_cpufreq.c  |  4 +-
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  2 +-
>  testcases/kernel/mem/ksm/ksm01.c                   |  2 +-
>  testcases/kernel/mem/ksm/ksm02.c                   |  2 +-
>  testcases/kernel/mem/ksm/ksm03.c                   |  2 +-
>  testcases/kernel/mem/ksm/ksm04.c                   |  2 +-
>  testcases/kernel/mem/ksm/ksm06.c                   |  6 +--
>  testcases/kernel/mem/thp/thp04.c                   | 10 ++--
>  testcases/kernel/mem/thp/thp05.c                   | 10 ++--
>  testcases/kernel/syscalls/fork/fork13.c            |  2 +-
>  12 files changed, 90 insertions(+), 21 deletions(-)
> 
> diff --git a/include/safe_file_ops.h b/include/safe_file_ops.h
> index 1815984..865575a 100644
> --- a/include/safe_file_ops.h
> +++ b/include/safe_file_ops.h
> @@ -42,6 +42,11 @@
>  /*
>   * All-in-one function to scanf value(s) from a file.
>   */
> +void file_scanf(const char *file, const char *fmt, ...);
> +

In this case we should return some exit value. Simple 0 == ok, 1 ==
failed, would suffice. Otherwise we cannot say if the values were read or
not.

> +#define FILE_SCANF(file, fmt, ...) \
> +	file_scanf((file), (fmt), ## __VA_ARGS__)

The whole point of the macro indirection is to include the file and
lineno parameter in the tst_ messages. Please do that.

>  void safe_file_scanf(const char *file, const int lineno,
>                       void (*cleanup_fn)(void),
>  		     const char *path, const char *fmt, ...)
> @@ -54,6 +59,11 @@ void safe_file_scanf(const char *file, const int lineno,
>  /*
>   * All-in-one function that lets you printf directly into a file.
>   */
> +void file_printf(const char *file, const char *fmt, ...);
> +
> +#define FILE_PRINTF(file, fmt, ...) \
> +	file_printf((file), (fmt), ## __VA_ARGS__)

It would be better to return exit value here as well.

>  void safe_file_printf(const char *file, const int lineno,
>                        void (*cleanup_fn)(void),
>                        const char *path, const char *fmt, ...)
> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index 0325ce2..6c25ea5 100644
> --- a/lib/safe_file_ops.c
> +++ b/lib/safe_file_ops.c
> @@ -73,6 +73,37 @@ static int count_scanf_conversions(const char *fmt)
>  	return cnt;
>  }
>  
> +void file_scanf(const char *file, const char *fmt, ...)
> +{
> +	va_list va;
> +	FILE *f;
> +	int exp_convs, ret;
> +
> +	f = fopen(file, "r");
> +
> +	if (f == NULL) {
> +		tst_resm(TWARN,
> +			"Failed to open FILE '%s' for reading", file);

You have to do a return here otherwise we will continue the execution
till the vfscanf() below and segfault.

> +	}
> +
> +	exp_convs = count_scanf_conversions(fmt);
> +
> +	va_start(va, fmt);
> +	ret = vfscanf(f, fmt, va);
> +	va_end(va);
> +
> +	if (ret == EOF)
> +		tst_resm(TWARN, "The FILE '%s' ended prematurely", file);
> +
> +	if (ret != exp_convs) {
> +		tst_resm(TWARN, "Expected %i conversions got %i FILE '%s'",
> +			 exp_convs, ret, file);
> +	}
> +
> +	if (fclose(f))
> +		tst_resm(TWARN, "Failed to close FILE '%s'", file);

Missing returns here as well, but do not forget to close the file. I.e. do

	if (ret == EOF) {
		tst_resm(TWARN, ...);
		goto err;
	}

	...

	return 0;
err:
	fclose(f)
	return 1;

> +}
> +
>  void safe_file_scanf(const char *file, const int lineno,
>  		     void (*cleanup_fn) (void),
>  		     const char *path, const char *fmt, ...)
> @@ -107,6 +138,34 @@ void safe_file_scanf(const char *file, const int lineno,
>  			 exp_convs, ret, path, file, lineno);
>  	}
>  
> +	if (fclose(f)) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "Failed to close FILE '%s' at %s:%d",
> +			 path, file, lineno);
> +	}
> +}
> +
> +void file_printf(const char *file, const char *fmt, ...)
> +{
> +	va_list va;
> +	FILE *f;
> +
> +	f = fopen(file, "w");
> +
> +	if (f == NULL) {
> +		tst_resm(TWARN,
> +			"Failed to open FILE '%s' for writing", file);
> +	}
> +
> +	va_start(va, fmt);
> +
> +	if (vfprintf(f, fmt, va) < 0)
> +		tst_resm(TWARN, "Failed to print to FILE '%s'", file);
> +
> +	va_end(va);
> +
> +	if (fclose(f))
> +		tst_resm(TWARN, "Failed to close FILE '%s'", file);
>  }

Missing return statements here as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
