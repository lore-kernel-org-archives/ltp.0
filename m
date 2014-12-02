Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xvm8U-0006NO-TE
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 12:00:54 +0000
Date: Tue, 2 Dec 2014 13:00:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202120036.GA16539@rei.suse.de>
References: <1417512939-6435-1-git-send-email-liwang@redhat.com>
	<2046852420.5414979.1417513768451.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2046852420.5414979.1417513768451.JavaMail.zimbra@redhat.com>
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
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/safe_file_ops.h          |  5 ++-
>  lib/safe_file_ops.c              | 92 ++++++++++++++++++++++++++++++++--------
>  testcases/kernel/mem/thp/thp04.c | 10 ++---
>  testcases/kernel/mem/thp/thp05.c | 10 ++---
>  4 files changed, 88 insertions(+), 29 deletions(-)
> 
> diff --git a/include/safe_file_ops.h b/include/safe_file_ops.h
> index 1815984..17d009e 100644
> --- a/include/safe_file_ops.h
> +++ b/include/safe_file_ops.h
> @@ -42,6 +42,8 @@
>  /*
>   * All-in-one function to scanf value(s) from a file.
>   */
> +int file_scanf(const char *file, const char *fmt, va_list va);

This prototype is wrong, the last one should be ... not va_list.

>  void safe_file_scanf(const char *file, const int lineno,
>                       void (*cleanup_fn)(void),
>  		     const char *path, const char *fmt, ...)
> @@ -50,10 +52,11 @@ void safe_file_scanf(const char *file, const int lineno,
>  #define SAFE_FILE_SCANF(cleanup_fn, path, fmt, ...) \
>  	safe_file_scanf(__FILE__, __LINE__, (cleanup_fn), \
>  	                (path), (fmt), ## __VA_ARGS__)
> -
>  /*
>   * All-in-one function that lets you printf directly into a file.
>   */
> +int file_printf(const char *file, const char *fmt, va_list va);

Here as well.

Have you complied the code? It should have produced quite a lot of
warnings.

>  void safe_file_printf(const char *file, const int lineno,
>                        void (*cleanup_fn)(void),
>                        const char *path, const char *fmt, ...)
> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index 0325ce2..3ce53ff 100644
> --- a/lib/safe_file_ops.c
> +++ b/lib/safe_file_ops.c
> @@ -73,28 +73,54 @@ static int count_scanf_conversions(const char *fmt)
>  	return cnt;
>  }
>  
> +int file_vscanf(const char *file, const char *fmt, va_list va)

This function is not part of the public interface, therefore it would be
better to declare it as static.

> +{
> +	FILE *f;
> +	int ret;
> +
> +	f = fopen(file, "r");
> +
> +	if (f == NULL) {
> +		return -2;
> +	}

LKML coding style preffers not to include curly braces around single
line statements.

> +	ret = vfscanf(f, fmt, va);

Close the file here, otherwise you leak memory.

> +	return ret;
> +}
> +
> +/* Add file_scanf() to replace SAFE_FILE_SCANF() which used in cleanup()*/

Please do not add useless comments like this.

> +int file_scanf(const char *file, const char *fmt, ...)
> +{
> +	va_list va;
> +	int ret;
> +
> +	va_start(va, fmt);
> +	ret = file_vscanf(file, fmt, va);
> +	va_end(va);
> +
> +	return ret;
> +}
> +
>  void safe_file_scanf(const char *file, const int lineno,
>  		     void (*cleanup_fn) (void),
>  		     const char *path, const char *fmt, ...)
>  {
>  	va_list va;
> -	FILE *f;
>  	int exp_convs, ret;
>  
> -	f = fopen(path, "r");
> +	exp_convs = count_scanf_conversions(fmt);
>  
> -	if (f == NULL) {
> +	va_start(va, fmt);
> +	ret = file_vscanf(path, fmt, va);
> +	va_end(va);
> +
> +	if (ret == -2) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  			 "Failed to open FILE '%s' for reading at %s:%d",
>  			 path, file, lineno);
>  	}
>  
> -	exp_convs = count_scanf_conversions(fmt);
> -
> -	va_start(va, fmt);
> -	ret = vfscanf(f, fmt, va);
> -	va_end(va);
> -
>  	if (ret == EOF) {
>  		tst_brkm(TBROK, cleanup_fn,
>  			 "The FILE '%s' ended prematurely at %s:%d",
> @@ -109,32 +135,62 @@ void safe_file_scanf(const char *file, const int lineno,
>  
>  }
>  
> +int file_vprintf(const char *file, const char *fmt, va_list va)
> +{

Should be static function as well.

> +	FILE *f;
> +
> +	f = fopen(file, "w");
> +
> +	if (f == NULL) {
> +		return -2;
> +	}
> +
> +	if (vfprintf(f, fmt, va) < 0) {
> +		return -3;
> +	}
> +
> +	if (fclose(f)) {
> +		return -4;
> +	}

Useless curly braces as well.

> +}
> +
> +/* Add file_printf() to replace SAFE_FILE_PRINTF() which used in cleanup()*/

Useless comment as well.

> +int file_printf(const char *file, const char *fmt, ...)
> +{
> +	va_list va;
> +	int ret;
> +
> +	va_start(va, fmt);
> +	ret = file_vprintf(file, fmt, va);
> +	va_end(va);
> +
> +	return ret;
> +}
> +
>  void safe_file_printf(const char *file, const int lineno,
>  		      void (*cleanup_fn) (void),
>  		      const char *path, const char *fmt, ...)
>  {
>  	va_list va;
> -	FILE *f;
> +	int ret;
>  
> -	f = fopen(path, "w");
> +	va_start(va, fmt);
> +	ret = file_vprintf(path, fmt, va);
> +	va_end(va);
>  
> -	if (f == NULL) {
> +	if (ret == -2) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  			 "Failed to open FILE '%s' for writing at %s:%d",
>  			 path, file, lineno);
>  	}
>  
> -	va_start(va, fmt);
> -
> -	if (vfprintf(f, fmt, va) < 0) {
> +	if (ret == -3) {
>  		tst_brkm(TBROK, cleanup_fn,
>  			 "Failed to print to FILE '%s' at %s:%d",
>  			 path, file, lineno);
>  	}
>  
> -	va_end(va);
> -
> -	if (fclose(f)) {
> +	if (ret == -4) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  			 "Failed to close FILE '%s' at %s:%d",
>  			 path, file, lineno);
> diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
> index 0b6baeb..db9defc 100644
> --- a/testcases/kernel/mem/thp/thp04.c
> +++ b/testcases/kernel/mem/thp/thp04.c
> @@ -120,10 +120,10 @@ void setup(void)
>  
>  void cleanup(void)
>  {
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs",
> +	file_printf(PATH_KHPD "scan_sleep_millisecs",
>  			 "%d", pre_thp_scan_sleep_millisecs);
>  
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs",
> +	file_printf(PATH_KHPD "alloc_sleep_millisecs",
>  			 "%d", pre_thp_alloc_sleep_millisecs);
>  
>  	/*
> @@ -132,11 +132,11 @@ void cleanup(void)
>  	 * the three mode: always, madvise, never.
>  	 */
>  	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "always");
> +		file_printf(PATH_THP "enabled", "always");
>  	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "madvise");
> +		file_printf(PATH_THP "enabled", "madvise");
>  	else
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "never");
> +		file_printf(PATH_THP "enabled", "never");
>  
>  	TEST_CLEANUP;
>  }
> diff --git a/testcases/kernel/mem/thp/thp05.c b/testcases/kernel/mem/thp/thp05.c
> index 8b595ca..b20d9bd 100644
> --- a/testcases/kernel/mem/thp/thp05.c
> +++ b/testcases/kernel/mem/thp/thp05.c
> @@ -129,18 +129,18 @@ void setup(void)
>  
>  void cleanup(void)
>  {
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs",
> +	file_printf(PATH_KHPD "scan_sleep_millisecs",
>  			 "%d", pre_thp_scan_sleep_millisecs);
>  
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs",
> +	file_printf(PATH_KHPD "alloc_sleep_millisecs",
>  			 "%d", pre_thp_alloc_sleep_millisecs);
>  
>  	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "always");
> +		file_printf(PATH_THP "enabled", "always");
>  	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "madvise");
> +		file_printf(PATH_THP "enabled", "madvise");
>  	else
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "never");
> +		file_printf(PATH_THP "enabled", "never");

Looking at the change here, it would be better if file_printf() will
issue tst_resm(TWARN, "xyz has failed") in case that the file_printf()
will fail. Because otherwise it would be close to impossible to track
down the failure. Maybe it would be even better to create FILE_PRINTF()
macro similary to the SAFE_FILE_PRINTF(), what do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
