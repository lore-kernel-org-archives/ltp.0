Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1VnPqO-0003K5-A9
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 09:31:08 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VnPqM-0007HT-JZ
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 09:31:07 +0000
Message-ID: <529C5356.8000404@imgtec.com>
Date: Mon, 2 Dec 2013 09:31:02 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH v2] ptrace: Fix build problems with glibc-2.18
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
To: ltp-list@lists.sourceforge.net

On 11/25/2013 10:12 AM, Markos Chandras wrote:
> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
> also defined in sys/ptrace.h and conflicts with the definition
> from the Linux kernel in linux/ptrace.h. We fix this by not
> including the linux/ptrace.h header if the sys/ptrace.h header
> defines the said struct. Fixes
> https://github.com/linux-test-project/ltp/issues/6
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Build tested on glibc-2.17 and glibc-2.18 systems
>
> Changes since v1:
> Comments: http://sourceforge.net/mailarchive/message.php?msg_id=31677254
> - Move the AC_CHECK_TYPES from configure.ac to m4/ltp-ptrace.m4
> - Fix typo in config.h.default
> ---
>   include/config.h.default                  | 3 +++
>   m4/ltp-ptrace.m4                          | 3 +++
>   testcases/kernel/syscalls/ptrace/ptrace.h | 4 +++-
>   3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/config.h.default b/include/config.h.default
> index 96e25c4..7095b92 100644
> --- a/include/config.h.default
> +++ b/include/config.h.default
> @@ -167,6 +167,9 @@
>   /* Define to 1 if the system has the type `struct modify_ldt_ldt_s'. */
>   #undef HAVE_STRUCT_MODIFY_LDT_LDT_S
>
> +/* Define to 1 if the system has the type `struct ptrace_peeksiginfo_args'. */
> +#undef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARGS
> +
>   /* Define to 1 if `signo' is member of `struct signalfd_siginfo'. */
>   #undef HAVE_STRUCT_SIGNALFD_SIGINFO_SIGNO
>
> diff --git a/m4/ltp-ptrace.m4 b/m4/ltp-ptrace.m4
> index 63e968e..ca360bb 100644
> --- a/m4/ltp-ptrace.m4
> +++ b/m4/ltp-ptrace.m4
> @@ -40,5 +40,8 @@ save_CPPFLAGS=$CPPFLAGS
>   CPPFLAGS="$CPPFLAGS -I$srcdir/testcases/kernel/syscalls/ptrace"
>   AC_CHECK_TYPES([struct user_regs_struct, struct pt_regs],,,[#include "ptrace.h"])
>   AC_CHECK_DECLS([PTRACE_GETSIGINFO, PTRACE_O_TRACEVFORKDONE, PTRACE_SETOPTIONS],,,[#include "ptrace.h"])
> +dnl glibc-2.18 defines ptrace_peeksiginfo_args in sys/ptrace.h which
> +dnl conflicts with the one from linux kernel in linux/ptrace.h
> +AC_CHECK_TYPES([struct ptrace_peeksiginfo_args],,,[#include <sys/ptrace.h>])
>   CPPFLAGS=$save_CPPFLAGS
>   ])
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h b/testcases/kernel/syscalls/ptrace/ptrace.h
> index f0767d7..4a43f01 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace.h
> +++ b/testcases/kernel/syscalls/ptrace/ptrace.h
> @@ -19,7 +19,9 @@
>   # include <asm/ptrace.h>
>   #endif
>   #ifdef HAVE_LINUX_PTRACE_H
> -# include <linux/ptrace.h>
> +# ifndef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARGS
> +#  include <linux/ptrace.h>
> +# endif
>   #endif
>   #undef FU_ia64_fpreg
>   #undef FU_pt_all_user_regs
>

Hello,

ping?

-- 
markos


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
