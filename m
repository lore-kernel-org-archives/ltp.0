From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Aug 2020 14:56:03 +0200
Subject: [LTP] [PATCH V8 1/2] syscalls/utimensat: Migrate to new test
 framework
In-Reply-To: <ebc888947b095fd6a359ad749e50217d0b38954e.1596637728.git.viresh.kumar@linaro.org>
References: <ebc888947b095fd6a359ad749e50217d0b38954e.1596637728.git.viresh.kumar@linaro.org>
Message-ID: <20200806125603.GC3315@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void reset_time(char *pathname, int dfd, int flags)
> +{
> +	struct timespec ts[2];
> +	struct stat sb;
>  
> -		ts[1].tv_sec = atoi(argv[optind + 3]);
> -		if (argv[optind + 4][0] == 'n') {
> -			ts[1].tv_nsec = UTIME_NOW;
> -		} else if (argv[optind + 4][0] == 'o') {
> -			ts[1].tv_nsec = UTIME_OMIT;
> -		} else {
> -			ts[1].tv_nsec = atoi(argv[optind + 4]);
> -		}
> +	ts[0].tv_sec = 0;
> +	ts[0].tv_nsec = 0;
> +	ts[1].tv_sec = 0;
> +	ts[1].tv_nsec = 0;
>  
> -		tsp = ts;
> +	TEST(sys_utimensat(dfd, pathname, ts, flags));
> +	TEST(stat(pathname, &sb));

Wrapping the calls to TEST() macro here is useless.

Also we do pass libc timespec to a syscall that is supposed to take the
old kernel type, right?

I guess that the options are:

* Use the glibc function here instead

* Change the type in the follow up patch

> +	if (sb.st_atime || sb.st_mtime) {
> +		tst_res(TFAIL, "Failed to reset access and modification time (%lu: %lu)",
> +			sb.st_atime, sb.st_mtime);
>  	}
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
