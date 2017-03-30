From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 11:35:40 +0200
Subject: [LTP] [PATCH] syscalls/memfd_create: Fix build fail when
 HAVE_FALLOCATE not defined
In-Reply-To: <1490779921-7162-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20170329091839.GD7089@rei.lan>
 <1490779921-7162-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170330093540.GB12095@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	/* Deal with 32bit ABIs that have 64bit syscalls. */
>  # if LTP_USE_64_ABI
> +#ifdef __TEST_H__
>  	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
> +#else
> +	return tst_syscall(__NR_fallocate, fd, mode, offset, len);
> +#endif /* __TEST_H__ */
>  # else
> +#ifdef __TEST_H__
>  	return (long)ltp_syscall(__NR_fallocate, fd, mode,
>  				 __LONG_LONG_PAIR((off_t) (offset >> 32),
>  						  (off_t) offset),
>  				 __LONG_LONG_PAIR((off_t) (len >> 32),
>  						  (off_t) len));
> +#else
> +	return (long)tst_syscall(__NR_fallocate, fd, mode,
> +				 __LONG_LONG_PAIR((off_t) (offset >> 32),
> +						  (off_t) offset),
> +				 __LONG_LONG_PAIR((off_t) (len >> 32),
> +						  (off_t) len));
> +#endif /* __TEST_H__ */

We can spare a bit of the duplication by definign the function name:

...

#ifdef __TEST_H__
# define TST_SYSCALL_WRAPPER ltp_syscall
#else
# define TST_SYSCALL_WRAPPER tst_syscall
#endif

...
	return (long)TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode,
				 __LONG_LONG_PAIR((off_t) (offset >> 32),
						  (off_t) offset),
				 __LONG_LONG_PAIR((off_t) (len >> 32),
						  (off_t) len));

-- 
Cyril Hrubis
chrubis@suse.cz
