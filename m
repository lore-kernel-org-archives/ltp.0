From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 21 Feb 2019 11:38:40 +0000
Subject: [LTP] [PATCH v4 2/9] lib: split tst_fill_file() to create new
 tst_fill_fd()
In-Reply-To: <1550739616-24054-3-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
 <1550739616-24054-3-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190221113840.l2ffu4d22u72uakm@holly.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Feb 21, 2019 at 02:30:09PM +0530, Sumit Garg wrote:
> Split tst_fill_file() api to create new tst_fill_fd() api which could be
> used to fill file using fd and allows syscalls tests to operate on fd.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/tst_fs.h    |  9 +++++++++
>  lib/tst_fill_file.c | 40 +++++++++++++++++++++++-----------------
>  2 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index 23f139d..b2b19ad 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -139,6 +139,15 @@ int tst_dir_is_empty_(void (*cleanup)(void), const char *name, int verbose);
>  int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
>  
>  /*
> + * Fill a file with specified pattern
> + * @fd: file descriptor
> + * @pattern: pattern
> + * @bs: block size
> + * @bcount: blocks count
> + */
> +int tst_fill_fd(int fd, char pattern, size_t bs, size_t bcount);
> +
> +/*
>   * Creates/ovewrites a file with specified pattern
>   * @path: path to file
>   * @pattern: pattern
> diff --git a/lib/tst_fill_file.c b/lib/tst_fill_file.c
> index 7baead8..f2bc52d 100644
> --- a/lib/tst_fill_file.c
> +++ b/lib/tst_fill_file.c
> @@ -28,40 +28,46 @@
>  
>  #include "test.h"
>  
> -int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
> +int tst_fill_fd(int fd, char pattern, size_t bs, size_t bcount)
>  {
> -	int fd;
> -	size_t counter;
> +	size_t i;

Nitpicking perhaps but gratuitous variable renames don't make patches
containing other changes easier to read. Nor, to be honest, does 
"counter" seem any more descriptive then i (since i is more idiomatic
and therefore quicker to read).


Daniel.



>  	char *buf;
>  
> -	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
> -	if (fd < 0)
> -		return -1;
> -
>  	/* Filling a memory buffer with provided pattern */
>  	buf = malloc(bs);
> -	if (buf == NULL) {
> -		close(fd);
> -
> +	if (buf == NULL)
>  		return -1;
> -	}
>  
> -	for (counter = 0; counter < bs; counter++)
> -		buf[counter] = pattern;
> +	for (i = 0; i < bs; i++)
> +		buf[i] = pattern;
>  
>  	/* Filling the file */
> -	for (counter = 0; counter < bcount; counter++) {
> +	for (i = 0; i < bcount; i++) {
>  		if (write(fd, buf, bs) != (ssize_t)bs) {
>  			free(buf);
> -			close(fd);
> -			unlink(path);
> -
>  			return -1;
>  		}
>  	}
>  
>  	free(buf);
>  
> +	return 0;
> +}
> +
> +int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
> +{
> +	int fd;
> +
> +	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (tst_fill_fd(fd, pattern, bs, bcount)) {
> +		close(fd);
> +		unlink(path);
> +		return -1;
> +	}
> +
>  	if (close(fd) < 0) {
>  		unlink(path);
>  
> -- 
> 2.7.4
> 
