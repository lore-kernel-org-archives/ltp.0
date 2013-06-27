Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsB9q-00066l-6s
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 12:18:38 +0000
Date: Thu, 27 Jun 2013 14:20:07 +0200
From: chrubis@suse.cz
Message-ID: <20130627122007.GB5384@rei>
References: <1372304589-16585-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372304589-16585-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] clock_settime03: don't test PROCESS_CPUTIME_ID
 and THREAD_CPUTIME_ID
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> PROCESS_CPUTIME_ID and THREAD_CPUTIME_ID are not supported before
> kernel 2.6.12, and changed back since 2.6.38. And they are
> thought improper supported on Linux, so we just remove them
> from the test of clock_settime and remain them be untested.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/timers/clock_settime/clock_settime03.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
> index a949303..3693395 100644
> --- a/testcases/kernel/timers/clock_settime/clock_settime03.c
> +++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
> @@ -37,8 +37,6 @@ clockid_t clocks[] = {
>  	CLOCK_REALTIME,
>  	CLOCK_REALTIME,
>  	CLOCK_REALTIME,
> -	CLOCK_PROCESS_CPUTIME_ID,
> -	CLOCK_THREAD_CPUTIME_ID
>  };
>  
>  int testcases[] = {
> @@ -49,8 +47,6 @@ int testcases[] = {
>  	EINVAL,			/* Invalid timespec     */
>  	EINVAL,			/* NSEC_PER_SEC + 1     */
>  	EPERM,			/* non-root user        */
> -	0,
> -	0,
>  };

What is the exact issue here?

I suspect that the problem is that the errno values are not stable
between kernel versions but AFAIK the PROCESS_CPUTIME clocks were never
setable but that shouldn't stop us from trying to set them and expect
failure. So what about we change the code to expect failure with
unspecified errno or add a list of expected errnos broad enough to cover
all kernel versions?

And btw, the Linux implementation is POSIXly correct as the ability to
set these clocks is left open to implementation.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
