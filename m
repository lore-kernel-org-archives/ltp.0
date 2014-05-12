Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wjpq3-0004k1-JN
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 13:00:15 +0000
Date: Mon, 12 May 2014 14:59:13 +0200
From: chrubis@suse.cz
Message-ID: <20140512125913.GA4741@rei>
References: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1399540004-14742-4-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399540004-14742-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 3/4] syscalls: corrected the rest of __sparc64__
 defines
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
> '__sparc64__' is not defined by cpp. We should use
> '__sparc__' and '__arch64__' instead.
> 
> Author: Jose E. Marchesi <jose.marchesi@oracle.com>
> Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/recvmsg/recvmsg01.c |    3 ++-
>  testcases/kernel/syscalls/sendmsg/sendmsg01.c |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> index bc84a23..102a268 100644
> --- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> +++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> @@ -45,7 +45,8 @@
>  /* and this test to function correctly.                        */
>  #ifndef MSG_CMSG_COMPAT
>  
> -#if defined (__powerpc64__) || defined (__mips64) || defined (__x86_64__) || defined (__sparc64__)
> +#if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
> +	defined(__sparc__) && defined(__arch64__)
>  #define MSG_CMSG_COMPAT 0x80000000
>  #else
>  #define MSG_CMSG_COMPAT 0
> diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> index 58d3364..9e5d4f2 100644
> --- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> +++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> @@ -37,7 +37,8 @@
>   */
>  #ifndef MSG_CMSG_COMPAT
>  #if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
> -     defined(__sparc64__) || defined(__ia64__) || defined(__s390x__)
> +	defined(__sparc__) && defined(__arch64__) || defined(__ia64__) || \
> +	defined(__s390x__)
>  #define MSG_CMSG_COMPAT 0x80000000
>  #else
>  #define MSG_CMSG_COMPAT 0

Aren't these two nearly the same? Shouldn't we pull them into a common
header first?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
