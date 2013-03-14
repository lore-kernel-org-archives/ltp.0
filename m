Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGBqU-0006HU-VT
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 17:21:39 +0000
Date: Thu, 14 Mar 2013 18:22:17 +0100
From: chrubis@suse.cz
Message-ID: <20130314172217.GE8894@rei.suse.cz>
References: <1363279568-9965-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1363279568-9965-1-git-send-email-markos.chandras@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls/getdents: Add parameter to test
 getdents64 syscall
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/getdents/Makefile b/testcases/kernel/syscalls/getdents/Makefile
> index df7b63f..8334aa7 100644
> --- a/testcases/kernel/syscalls/getdents/Makefile
> +++ b/testcases/kernel/syscalls/getdents/Makefile
> @@ -21,6 +21,8 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../utils/newer_64.mk
>  
> +CFLAGS += -D_LARGEFILE64_SOURCE

What exactly is this needed for? The getent64 function and
linux_dirent64 are both declared in the getdents.h.

>  /*
>   * The dirent struct that the C library exports is not the same
> @@ -45,6 +48,13 @@ struct linux_dirent {
>  	char            d_name[];
>  };
>  
> +struct linux_dirent64 {
> +	unsigned long long	d_ino;
> +	long long		d_off;
> +	unsigned short		d_reclen;
> +	char			d_name[];
> +};
> +
>  static inline int
>  getdents(unsigned int fd, struct dirent *dirp, unsigned int count)
>  {
> @@ -57,7 +67,43 @@ getdents(unsigned int fd, struct dirent *dirp, unsigned int count)
>  	unsigned int i;
>  
>  	ptrs.buf = buf;
> -	ret = syscall(SYS_getdents, fd, buf, count);
> +	ret = ltp_syscall(__NR_getdents, fd, buf, count);
> +	if (ret < 0)
> +		return ret;
> +
> +#define kdircpy(field) memcpy(&dirp[i].field, &ptrs.dirp->field, sizeof(dirp[i].field))
> +
> +	i = 0;
> +	while (i < count && i < ret) {
> +		unsigned long reclen;
> +
> +		kdircpy(d_ino);
> +		kdircpy(d_reclen);
> +		reclen = dirp[i].d_reclen;
> +		kdircpy(d_off);
> +		strcpy(dirp[i].d_name, ptrs.dirp->d_name);
> +
> +		ptrs.buf += reclen;
> +
> +		i += reclen;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int
> +getdents64(unsigned int fd, struct dirent64 *dirp, unsigned int count)
> +{
> +	union {
> +		struct linux_dirent64 *dirp;
> +		char *buf;
> +	} ptrs;
> +	char buf[count];
> +	long ret;
> +	unsigned int i;
> +
> +	ptrs.buf = buf;
> +	ret = ltp_syscall(__NR_getdents64, fd, buf, count);
>  	if (ret < 0)
>  		return ret;

Well my choice would be casting the buffer to the dirp pointer rather
than using the union but looking at the original code, this has been
there before...

> diff --git a/testcases/kernel/syscalls/getdents/getdents04.c b/testcases/kernel/syscalls/getdents/getdents04.c
> index 89479a4..7ba8a3d 100644
> --- a/testcases/kernel/syscalls/getdents/getdents04.c
> +++ b/testcases/kernel/syscalls/getdents/getdents04.c
> @@ -43,10 +43,12 @@
>   *             -e   : Turn on errno logging.
>   *	       -i n : Execute test n times.
>   *	       -I x : Execute test for x seconds.
> + *	       -l   : Test the getdents64 system call.
>   *	       -P x : Pause for x seconds between iterations.
>   *	       -t   : Turn on syscall timing.
>   *
>   * HISTORY
> + *	03/2013 - Added -l option by Markos Chandras
>   *	03/2001 - Written by Wayne Boyer
>   *
>   * RESTRICTIONS
> @@ -73,6 +75,17 @@ int TST_TOTAL = 1;
>  
>  int exp_enos[] = { ENOTDIR, 0 };	/* 0 terminated list of expected errnos */
>  
> +int longsyscall;
> +
> +option_t Options[] = {
> +		{"l", &longsyscall, NULL}, /* -l long option. Tests getdents64 */
> +		{NULL, NULL, NULL}
> +};
> +
> +void help() {
> +	printf("  -l      Test the getdents64 system call\n");
> +}

Please use LKML coding style, i.e. add void to the function prototype
and move the opening bracket on the new line (you can you chekpatch.pl
bundled with the linux kernel sources to check for style violations).

Also I tend to declare global functions and variables static so that
compiler can report them as unused when they are unused.

>  int main(int ac, char **av)
>  {
>  	int lc;
> @@ -80,11 +93,12 @@ int main(int ac, char **av)
>  	int count, rval, fd;
>  	size_t size = 0;
>  	char *dir_name = NULL;
> -	struct dirent *dirp;
>  	struct stat *sbuf;
>  	char *newfile;
> +	struct dirent64 *dirp64;
> +	struct dirent *dirp;
>  
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +	if ((msg = parse_opts(ac, av, Options, &help)) != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	setup();
> @@ -96,10 +110,15 @@ int main(int ac, char **av)
>  			tst_brkm(TBROK, cleanup, "Can not get current "
>  				 "directory name");
>  
> -		if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> -			tst_brkm(TBROK, cleanup, "malloc failed");
> -
> -		count = (int)sizeof(struct dirent);
> +		if (longsyscall) {
> +			if ((dirp64 = malloc(sizeof(struct dirent64))) == NULL)
> +				tst_brkm(TBROK, cleanup, "malloc failed");
> +			count = (int)sizeof(struct dirent64);

Does really assigment of size_t (return from sizeof) into the int
(count) generate warning?

> +		} else {
> +			if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> +				tst_brkm(TBROK, cleanup, "malloc failed");
> +			count = (int)sizeof(struct dirent);
> +		}
>  
>  		/* set up some space for a file name */
>  		if ((newfile = malloc(sizeof(char) * 20)) == NULL)
> @@ -123,7 +142,10 @@ int main(int ac, char **av)
>  		if (S_ISDIR(sbuf->st_mode))
>  			tst_brkm(TBROK, cleanup, "fd is a directory");
>  
> -		rval = getdents(fd, dirp, count);
> +		if (longsyscall)
> +			rval = getdents64(fd, dirp64, count);
> +		else
> +			rval = getdents(fd, dirp, count);
>  
>  		/*
>  		 * Calling with a non directory file descriptor should give
> @@ -149,7 +171,10 @@ int main(int ac, char **av)
>  		free(dir_name);
>  		dir_name = NULL;
>  
> -		free(dirp);
> +		if (longsyscall)
> +			free(dirp64);
> +		else
> +			free(dirp);

Hmm allocatin and freeing the structure in each loop iteration seems
pointless, what about defining it on the stack or allocating it once
before the main test loop and not bother freeing it. That would simplify
the code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
