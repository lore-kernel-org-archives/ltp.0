Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Urpdp-0003lW-H0
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 13:20:09 +0000
Date: Wed, 26 Jun 2013 15:21:35 +0200
From: chrubis@suse.cz
Message-ID: <20130626132135.GA16146@rei.suse.cz>
References: <1372251457-25602-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372251457-25602-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] lib: safe_macros: add SAFE_EXECVP()
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/safe_macros.h |    5 +++++
>  lib/safe_macros.c     |   26 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/include/safe_macros.h b/include/safe_macros.h
> index 3a26df6..8ef5113 100644
> --- a/include/safe_macros.h
> +++ b/include/safe_macros.h
> @@ -184,5 +184,10 @@ int safe_fclose(const char *file, const int lineno, void (cleanup_fn)(void),
>  #define SAFE_FCLOSE(cleanup_fn, f) \
>  	safe_fclose(__FILE__, __LINE__, cleanup_fn, f)
>  
> +void safe_execvp(const char *file, const int lineno, void (cleanup_fn)(void),
> +                 char *const argv[]);
> +#define SAFE_EXECVP(cleanup_fn, argv) \
> +	safe_execvp(__FILE__, __LINE__, cleanup_fn, argv)

Well it is not execvp as the code does vfork + execvp, which is
confusing as the rest of the functions in this header does only what the
original function does + error checks. We should rather name this as
tst_run_cmd() or so.

>  #endif /* __SAFE_MACROS_H__ */
>  #endif /* __TEST_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index fb02796..58e6f6a 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -2,6 +2,7 @@
>  #include <sys/mman.h>
>  #include <sys/resource.h>
>  #include <sys/stat.h>
> +#include <sys/wait.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <libgen.h>
> @@ -467,3 +468,28 @@ int safe_fclose(const char *file, const int lineno, void (cleanup_fn)(void),
>  
>  	return ret;
>  }
> +
> +void safe_execvp(const char *file, const int lineno, void (cleanup_fn)(void),
> +                 char *const argv[])
> +{
> +	if (argv == NULL || ARRAY_SIZE(argv) == 0) {
> +		tst_brkm(TBROK, cleanup_fn,
> +			"argument list is empty at %s:%d", file, lineno);
> +	}

I do not think that the ARRAY_SIZE() works here (there are actually two
reasons for that). You cannot create zero leght array in C as array is a
pointer to memory (this is why we have NULL in C) and the second is that
ARRAY_SIZE() macro works only for arrays for which sizeof() returns size
of the object, if you have allocated array or pass it as a fuction
argument the sizeof() has no chance of determining the object size.

> +	pid_t pid = vfork();
> +	if (pid == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn, "fork failed at %s:%d",
> +			file, lineno);
> +	}
> +	if (!pid)
> +		_exit(execvp(argv[0], argv));
> +
> +	int ret = -1;
> +	waitpid(pid, &ret, 0);
> +
> +	if (ret != 0) {
> +		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s' at %s:%d",
> +			argv[0], file, lineno);
> +	}
> +}

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
