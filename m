Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XmKE2-0001b6-Ou
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 10:23:34 +0000
Date: Thu, 6 Nov 2014 11:23:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141106102301.GB2179@rei.nue.novell.com>
References: <1414049085-29422-1-git-send-email-liwan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1414049085-29422-1-git-send-email-liwan@redhat.com>
Subject: Re: [LTP] [PATCH] mem/thp04: rebuild the cleanup without using safe
 macros
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> mem/lib: recall write_file & read_file functions
> 
> mem/thp04: rebuild the cleanup() by those two functions to avoid safe macros
> being abused.
> 
> Signed-off-by: Li Wang <liwan@redhat.com>
> ---
>  testcases/kernel/mem/include/mem.h |  2 ++
>  testcases/kernel/mem/lib/mem.c     | 25 +++++++++++++++++++++++++
>  testcases/kernel/mem/thp/thp04.c   | 27 +++++++++++++++++----------
>  3 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index 8fa2094..3cb3580 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -96,6 +96,8 @@ int  path_exist(const char *path, ...);
>  long read_meminfo(char *item);
>  void set_sys_tune(char *sys_file, long tune, int check);
>  long get_sys_tune(char *sys_file);
> +void write_file(char *filename, char *buf);
> +void read_file(char *filename, char *retbuf);
>  void cleanup(void);
>  void setup(void);
>  
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index d3fc19d..3bd9f65 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -1065,6 +1065,31 @@ long get_sys_tune(char *sys_file)
>  	return tune;
>  }
>  
> +void write_file(char *filename, char *buf)
> +{
> +	int fd;
> +
> +	fd = open(filename, O_WRONLY);
> +	if (fd == -1)
> +		tst_resm(TWARN | TERRNO, "open");
> +	tst_resm(TINFO, "set %s value to %s", filename, buf);
> +	if (write(fd, buf, strlen(buf)) != strlen(buf))
> +		tst_resm(TWARN | TERRNO, "write");
> +	close(fd);
> +}
> +
> +void read_file(char *filename, char *retbuf)
> +{
> +	int fd;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd == -1)
> +		tst_resm(TWARN | TERRNO, "open");
> +	if (read(fd, retbuf, BUFSIZ) < 0)
> +		tst_resm(TWARN | TERRNO, "read");
> +	close(fd);
> +}
> +
>  void update_shm_size(size_t * shm_size)
>  {
>  	size_t shmmax;
> diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
> index 0b6baeb..4e9aa87 100644
> --- a/testcases/kernel/mem/thp/thp04.c
> +++ b/testcases/kernel/mem/thp/thp04.c
> @@ -61,6 +61,7 @@ option_t thp_options[] = {
>  
>  static int pre_thp_scan_sleep_millisecs;
>  static int pre_thp_alloc_sleep_millisecs;
> +static char buf[BUFSIZ], path[BUFSIZ];
>  static char pre_thp_enabled[BUFSIZ];
>  
>  int main(int argc, char *argv[])
> @@ -120,23 +121,29 @@ void setup(void)
>  
>  void cleanup(void)
>  {
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs",
> -			 "%d", pre_thp_scan_sleep_millisecs);
> +	snprintf(buf, BUFSIZ, "%d", pre_thp_scan_sleep_millisecs);
> +	write_file(PATH_KHPD "scan_sleep_millisecs", buf);
>  
> -	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs",
> -			 "%d", pre_thp_alloc_sleep_millisecs);
> +	snprintf(buf, BUFSIZ, "%d", pre_thp_alloc_sleep_millisecs);
> +	write_file(PATH_KHPD "alloc_sleep_millisecs", buf);
>  
>  	/*
>  	 * The value of transparent_hugepage/enabled is speical,
>  	 * we need to recover the previous value one by one for
>  	 * the three mode: always, madvise, never.
>  	 */
> -	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "always");
> -	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "madvise");
> -	else
> -		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "never");
> +	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0){
> +		snprintf(path, BUFSIZ, "always");
> +		write_file(PATH_THP "enabled", path);
> +	}
> +	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0){
> +		snprintf(path, BUFSIZ, "madvise");
> +		write_file(PATH_THP "enabled", path);
> +	}
> +	else{
> +		snprintf(path, BUFSIZ, "never");
> +		write_file(PATH_THP "enabled", path);
> +	}
>  
>  	TEST_CLEANUP;
>  }

This is a bit better but suffers from the same issues as the previous
one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
