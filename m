Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WlADu-0006vw-M9
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 04:58:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WlADt-000873-NQ
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 04:58:22 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4G4wEPB020556
	for <ltp-list@lists.sourceforge.net>; Fri, 16 May 2014 12:58:14 +0800
Message-ID: <53759A5E.4020104@cn.fujitsu.com>
Date: Fri, 16 May 2014 12:55:58 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1400149938-12805-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1400215973-2049-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1400215973-2049-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] lib: Add SAFE_KILL()
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi,

    I forgot to send this patch first, please review this patch first, thanks.

Regards,
Xiaoguang Wang

On 05/16/2014 12:52 PM, Xiaoguang Wang wrote:
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  include/safe_macros.h |  5 +++++
>  lib/safe_macros.c     | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/safe_macros.h b/include/safe_macros.h
> index 9e3ba98..c79dadf 100644
> --- a/include/safe_macros.h
> +++ b/include/safe_macros.h
> @@ -231,5 +231,10 @@ pid_t safe_waitpid(const char *file, const int lineno, void (cleanup_fn)(void),
>  #define SAFE_WAITPID(cleanup_fn, pid, status, opts) \
>          safe_waitpid(__FILE__, __LINE__, (cleanup_fn), (pid), (status), (opts))
>  
> +int safe_kill(const char *file, const int lineno, void (cleanup_fn)(void),
> +		  pid_t pid, int sig);
> +#define SAFE_KILL(cleanup_fn, pid, sig) \
> +	safe_kill(__FILE__, __LINE__, (cleanup_fn), (pid), (sig))
> +
>  #endif /* __SAFE_MACROS_H__ */
>  #endif /* __TEST_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 48a837c..81c66b5 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -659,3 +659,19 @@ pid_t safe_waitpid(const char *file, const int lineno, void (cleanup_fn)(void),
>  
>  	return rval;
>  }
> +
> +int safe_kill(const char *file, const int lineno, void (cleanup_fn)(void),
> +	      pid_t pid, int sig)
> +{
> +	int rval;
> +
> +	rval = kill(pid, sig);
> +
> +	if (rval == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: kill(%d,%s) failed",
> +			 file, lineno, pid, tst_strsig(sig));
> +	}
> +
> +	return rval;
> +}


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
