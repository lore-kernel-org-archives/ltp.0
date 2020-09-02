From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Sep 2020 13:39:54 +0200
Subject: [LTP] [PATCH v2 1/4] Add SAFE_SYSINFO() macro
In-Reply-To: <20200825160735.24602-2-mdoucha@suse.cz>
References: <20200825160735.24602-1-mdoucha@suse.cz>
 <20200825160735.24602-2-mdoucha@suse.cz>
Message-ID: <20200902113954.GA22722@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Changes since v1: New patch

>  include/tst_safe_macros.h |  5 +++++
>  lib/safe_macros.c         | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+)

> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 000381c4f..053c3bcf9 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -12,6 +12,7 @@
>  #include <sys/resource.h>
>  #include <sys/stat.h>
>  #include <sys/vfs.h>
> +#include <sys/sysinfo.h>
>  #include <fcntl.h>
>  #include <libgen.h>
>  #include <signal.h>
> @@ -598,4 +599,8 @@ long tst_safe_ptrace(const char *file, const int lineno, int req, pid_t pid,
>  #define SAFE_PTRACE(req, pid, addr, data) \
>  	tst_safe_ptrace(__FILE__, __LINE__, req, pid, addr, data)

> +int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
> +#define SAFE_SYSINFO(info) \
> +	safe_sysinfo(__FILE__, __LINE__, (info))
> +
>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index dde9b7b5e..5ef9ee1c5 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -11,6 +11,7 @@
>  #include <sys/wait.h>
>  #include <sys/mount.h>
>  #include <sys/xattr.h>
> +#include <sys/sysinfo.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <libgen.h>
> @@ -1088,3 +1089,22 @@ int safe_mincore(const char *file, const int lineno, void *start,

>  	return rval;
>  }
> +
> +int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info)
> +{
> +	int ret;
> +
> +	errno = 0;
> +	ret = sysinfo(info);
> +
> +	if (ret == -1) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"sysinfo() failed");
> +	} else if (ret) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"Invalid sysinfo() return value %d", ret);
nit: unneeded line below.
> +
> +	}
Man page mentions only 0 and -1. Sure, it does not harm to test ret > 0, I just
wonder if it's needed.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +	return ret;
> +}
