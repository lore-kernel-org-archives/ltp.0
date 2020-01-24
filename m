From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jan 2020 11:23:23 +0100
Subject: [LTP] [PATCH v3 1/3] Add tst_purge_dir() helper function
In-Reply-To: <20200123162019.18958-2-mdoucha@suse.cz>
References: <20200123162019.18958-1-mdoucha@suse.cz>
 <20200123162019.18958-2-mdoucha@suse.cz>
Message-ID: <20200124102323.GB28992@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This function deletes the contents of the given directory while leaving
> the directory itself intact. Useful for purging the mountpoint between test
> iterations or test cases.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_device.h |   5 ++
>  lib/tst_tmpdir.c     | 106 +++++++++++++++++++++++++++----------------
>  2 files changed, 73 insertions(+), 38 deletions(-)
> 
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 3db5275c9..d2e4ad5be 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -88,4 +88,9 @@ static inline int tst_dev_sync(int fd)
>   */
>  unsigned long tst_dev_bytes_written(const char *dev);
>  
> +/*
> + *Wipe the contents of given directory but keep the directory itself
> + */
> +void tst_purge_dir(const char *path);

I'm not sure that it belongs to tst_device.h.

We do have functions such as tst_dir_is_empty() in tst_fs.h so maybe
that would be a slightly better fit.

>  #endif	/* TST_DEVICE_H__ */
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 09b7b6e22..4b21dfad6 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -99,6 +99,8 @@ static char test_start_work_dir[PATH_MAX];
>  /* lib/tst_checkpoint.c */
>  extern futex_t *tst_futexes;
>  
> +static int rmobj(const char *obj, char **errmsg);
> +
>  int tst_tmpdir_created(void)
>  {
>  	return TESTDIR != NULL;
> @@ -119,60 +121,80 @@ const char *tst_get_startwd(void)
>  	return test_start_work_dir;
>  }
>  
> -static int rmobj(char *obj, char **errmsg)
> +static int purge_dir(const char *path, char **errptr)
>  {
>  	int ret_val = 0;
>  	DIR *dir;
>  	struct dirent *dir_ent;
>  	char dirobj[PATH_MAX];
> -	struct stat statbuf;
>  	static char err_msg[1024];
>  	int fd;
>  
> -	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
> -	if (fd != -1) {
> -		close(fd);
> +	errno = 0;
> +	fd = open(path, O_DIRECTORY | O_NOFOLLOW);
>  
> -		/* Do NOT perform the request if the directory is "/" */
> -		if (!strcmp(obj, "/")) {
> -			if (errmsg != NULL) {
> -				sprintf(err_msg, "Cannot remove /");
> -				*errmsg = err_msg;
> -			}
> -			return -1;
> +	if (fd < 0) {
> +		if (errptr) {
> +			sprintf(err_msg,
> +				"Cannot open directory %s; errno=%d: %s",
> +				path, errno, tst_strerrno(errno));
> +			*errptr = err_msg;
>  		}

Isn't this check useless here? Or are we trying to avoid escaping the
directory via symlink?

If that's so maybe we should make it more obvious with stat() and
S_ISLNK(), or at least add a comment.

Also it would be nice to add an paragraph describing this function into
the doc/test-writing-guidelines.txt

-- 
Cyril Hrubis
chrubis@suse.cz
