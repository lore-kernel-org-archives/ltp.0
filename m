Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkuoY-0001El-92
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 12:31:10 +0000
Date: Thu, 15 May 2014 14:30:59 +0200
From: chrubis@suse.cz
Message-ID: <20140515123059.GA28445@rei.Home>
References: <20140512125913.GA4741@rei>
	<1399962023-23105-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399962023-23105-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] msg_common.h: corrected __sparc64__ definition
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
> __sparc64__ is not defined by cpp. We should use
> '__sparc__' and '__arch64__' instead.
> 
> Author: Jose E. Marchesi <jose.marchesi@oracle.com>
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/utils/msg_common.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utils/msg_common.h b/testcases/kernel/syscalls/utils/msg_common.h
> index 0471291..2ecd27e 100644
> --- a/testcases/kernel/syscalls/utils/msg_common.h
> +++ b/testcases/kernel/syscalls/utils/msg_common.h
> @@ -26,7 +26,8 @@
>  #ifndef MSG_CMSG_COMPAT
>  
>  #if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
> -	defined(__sparc64__) || defined(__ia64__) || defined(__s390x__)
> +	defined(__ia64__) || defined(__s390x__) || \
> +	defined(__sparc__) && defined(__arch64__)
>  #define MSG_CMSG_COMPAT 0x80000000
>  #else
>  #define MSG_CMSG_COMPAT 0

These two patches are OK, acked.

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
