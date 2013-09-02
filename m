Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGVxt-0001w8-Ki
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 15:22:53 +0000
Date: Mon, 2 Sep 2013 17:23:01 +0200
From: chrubis@suse.cz
Message-ID: <20130902152301.GC26252@rei>
References: <20130828095459.GB22849@rei.Home>
	<1377782535-15955-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1377782535-15955-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3 2/3] fixes for 16-bit syscalls testcases
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

> +/*
> + * LTP_COMPAT16_IS_DEFINED(SNAME) - if true, then __NR_SNAME
> + *   is a 16-bit version of SNAME() syscall
> + *
> + * LTP_COMPAT16_IF_DEFINED(SNAME, ...) - action to execute
> + *   if 16-bit version of SNAME syscall is supported
> + *
> + * LTP_COMPAT16_IF_UNDEFINED(SNAME) - action to execute
> + *   if 16-bit version of SNAME syscall is not supported
> + */
> +#define LTP_COMPAT16_IS_DEFINED(SNAME) \
> +	(__NR_##SNAME##32 != __LTP__NR_INVALID_SYSCALL)
> +
> +#define LTP_COMPAT16_IF_DEFINED(SNAME, ...) \
> +	return ltp_syscall(__NR_##SNAME, ##__VA_ARGS__);
> +
> +#define LTP_COMPAT16_IF_UNDEFINED(SNAME) \
> +	tst_brkm(TCONF, cleanup, \
> +		"16-bit version of %s() is not supported on your platform", \
> +		#SNAME);

What I do not like is the calling cleanup from this part of the code, it
was not passed there and the code will break badly if you name the
cleanup function differently (or create more of them, cleanup, cleanup1,
...).

What I would do here is to set errno to ENOSYS and return a failure. And
let the test that called the function handle it.

Or we can add a cleanup parameter to the all caps functions bellow.

> +int
> +SETGROUPS(size_t gidsetsize, GID_T *list16)
> +{
> +# if LTP_COMPAT16_IS_DEFINED(setgroups)
> +	LTP_COMPAT16_IF_DEFINED(setgroups, gidsetsize, list16)
> +# else
> +	LTP_COMPAT16_IF_UNDEFINED(setgroups)
> +# endif
> +}
> +
> +int
> +GETGROUPS(int gidsetsize, GID_T *list16)
> +{
> +# if LTP_COMPAT16_IS_DEFINED(getgroups)
> +	LTP_COMPAT16_IF_DEFINED(getgroups, gidsetsize, list16)
> +# else
> +	LTP_COMPAT16_IF_UNDEFINED(getgroups)
> +# endif
> +}
> +
> +#else
> +int
> +SETGROUPS(size_t size, const GID_T *list)
> +{
> +	return setgroups(size, list);
> +}
> +
> +int
> +GETGROUPS(int size, GID_T *list)
> +{
> +	return getgroups(size, list);
> +}
> +
> +#endif	/* TST_USE_COMPAT16_SYSCALL */
> +
> +#endif /* __SETGROUPS_COMPAT_16_H__ */

We can even simplify this macros. At least the innter part of SETGROUPS
and GETGROUPS could be created by a single macro:

COMPAT16_SYSCALL(setgroups, gitsetsize, list16)

#define COMPAT16_SYSCALL(sys_name, ...) \
# ifdef TST_USE_COMPAT16_SYSCALL
#  if ....
	return ltp_syscall(sys_name, ##__VA_ARGS__);
#  else
	errno = ENOSYS;
	return -1;
#  fi
# else
	return sys_name(__VA_ARGS__);
# endif

In case that the syscall and libcall params does not match we can use
only the part enclosed in the ifdef TST_USE_COMPAT16_SYSCALL.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
