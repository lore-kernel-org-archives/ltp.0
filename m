Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XmKDM-0006N5-Ry
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 10:22:52 +0000
Date: Thu, 6 Nov 2014 11:22:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141106102218.GA2179@rei.nue.novell.com>
References: <1414035112-28248-1-git-send-email-liwan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1414035112-28248-1-git-send-email-liwan@redhat.com>
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
To: Li Wang <liwan@redhat.com>
Cc: ltp-list@lists.sourceforge.net, wangli.ahau@gmail.com

Hi!
> NOTE: It's wise NOT to use safe macros in test cleanup(). This is because
>       all safe macros call tst_brkm(), which exits the test immediately, making
>       the cleanup() exit prematurely. (Actually, this is hacked around in
>       the test library at the moment so that the cleanup() will finish, but
>       the hack will be removed in the future).
> 
> Signed-off-by: Li Wang <liwan@redhat.com>
> ---
>  testcases/kernel/mem/thp/thp05.c | 69 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/mem/thp/thp05.c b/testcases/kernel/mem/thp/thp05.c
> index 8b595ca..92d9610 100644
> --- a/testcases/kernel/mem/thp/thp05.c
> +++ b/testcases/kernel/mem/thp/thp05.c
> @@ -66,6 +66,7 @@ option_t thp_options[] = {
>  static int pre_thp_scan_sleep_millisecs;
>  static int pre_thp_alloc_sleep_millisecs;
>  static char pre_thp_enabled[BUFSIZ];
> +static char buf[BUFSIZ], path[BUFSIZ];
>  
>  int main(int argc, char *argv[])
>  {
> @@ -129,19 +130,61 @@ void setup(void)
>  
>  void cleanup(void)
>  {
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs",
> -			 "%d", pre_thp_scan_sleep_millisecs);
> -
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs",
> -			 "%d", pre_thp_alloc_sleep_millisecs);
> -
> -	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "always");
> -	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "madvise");
> -	else
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "never");
> -
> +	int fd;
> +
> +	/* restore the scan_sleep_millisecs to original value */
> +	snprintf(buf, BUFSIZ, "%d", pre_thp_scan_sleep_millisecs);
> +	fd = open(PATH_KHPD "scan_sleep_millisecs", O_WRONLY);
> +	if (fd == -1)
> +		tst_resm(TWARN | TERRNO, "open");
> +	tst_resm(TINFO, "restore scan_sleep_millisecs to %d",
> +			pre_thp_scan_sleep_millisecs);
> +	if (write(fd, buf, strlen(buf)) != strlen(buf))
> +		tst_resm(TWARN | TERRNO, "write");
> +	close(fd);
> +
> +	/* restore the alloc_sleep_millisecs to original value */
> +	snprintf(buf, BUFSIZ, "%d", pre_thp_alloc_sleep_millisecs);
> +	fd = open(PATH_KHPD "alloc_sleep_millisecs", O_WRONLY);
> +	if (fd == -1)
> +		tst_resm(TWARN | TERRNO, "open");
> +	tst_resm(TINFO, "restore alloc_sleep_millisecs to %d",
> +			pre_thp_alloc_sleep_millisecs);
> +	if (write(fd, buf, strlen(buf)) != strlen(buf))
> +		tst_resm(TWARN | TERRNO, "write");
> +	close(fd);
> +
> +	/* restore the transparent_hugepage options to original state */
> +	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0){
> +		snprintf(path, BUFSIZ, "always");
> +		fd = open(PATH_THP "enabled", O_WRONLY);
> +		if (fd == -1)
> +			tst_resm(TWARN | TERRNO, "open");
> +		tst_resm(TINFO, "restore transparent_hugepage to %s", path);
> +		if (write(fd, path, strlen(path)) != strlen(path))
> +			tst_resm(TWARN | TERRNO, "write");
> +		close(fd);
> +	}
> +	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0){
> +		snprintf(path, BUFSIZ, "madvise");
> +		fd = open(PATH_THP "enabled", O_WRONLY);
> +		if (fd == -1)
> +			tst_resm(TWARN | TERRNO, "open");
> +		tst_resm(TINFO, "restore transparent_hugepage to %s", path);
> +		if (write(fd, path, strlen(path)) != strlen(path))
> +			tst_resm(TWARN | TERRNO, "write");
> +		close(fd);
> +	}
> +	else{
> +		snprintf(path, BUFSIZ, "never");
> +		fd = open(PATH_THP "enabled", O_WRONLY);
> +		if (fd == -1)
> +			tst_resm(TWARN | TERRNO, "open");
> +		tst_resm(TINFO, "restore transparent_hugepage to %s", path);
> +		if (write(fd, path, strlen(path)) != strlen(path))
> +			tst_resm(TWARN | TERRNO, "write");
> +		close(fd);
> +	}

While generally avoiding the safe macros in cleanup is fine, in this
case you have replaced about ten lines of code with about hundred lines
of copy & pasted code and even the coding style is wrong.

What should be done in this case is to create an equivalent to the
SAFE_FILE_PRINTF() function that is not calling the tst_brkm() and
issues only a warning. Or modify SAFE_FILE_PRINTF() to have additional
parameter that selects if on failure tst_brkm() or tst_resm(TWARN, ...)
is called.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
