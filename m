Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGnZk-0002eO-75
	for ltp-list@lists.sourceforge.net; Tue, 03 Sep 2013 10:11:08 +0000
Date: Tue, 3 Sep 2013 12:11:19 +0200
From: chrubis@suse.cz
Message-ID: <20130903101118.GA2100@rei>
References: <20130828095459.GB22849@rei.Home>
	<1377782535-15955-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130902152301.GC26252@rei> <52259811.3000604@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52259811.3000604@oracle.com>
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

Hi!
> Sorry, but is it possible to use #ifdef or #if inside a #define macro?

Right it does not, sorry. I tend to forget how dumb it the C preprocessor is.

> This doesn't work:
> 
> #define MYDEF(NN) \
> # ifdef TST_USE_COMPAT16_SYSCALL
>          return NN(0);
> # else
>          return NN(1);
> # endif
> 
> MYDEF(bla)

We need to pull the first if out of the macro and we can do the second
one as a regular if (it will be optimized away anyway).

#ifdef TST_USE_COMPAT16_SYSCALL
# define LTP_CREATE_SYSCALL(sys_name, ...) \
	if (__NR_##sys_name##32 != __LTP__NR_INVALID_SYSCALL) { \
		return ltp_syscall(sys_name, ##__VA_ARGS__); \
	} else { \
		errno = ENOSYS; \
		return -1; \
	}
#else
# define LTP_CREATE_SYSCALL(sys_name, ...) \
	return sys_name(__VA_ARGS__)
#endif


The usage will be:

int SETGROUPS(size_t size, const GID_T *list)
{
	LTP_CREATE_SYSCALL(getgroups, size, list);
}

Does this sound reasonable?

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
