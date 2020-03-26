From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 08:08:08 +0100
Subject: [LTP] [PATCH] Add test for CVE 2018-1000199
In-Reply-To: <20200319162114.3967-1-mdoucha@suse.cz>
References: <20200319162114.3967-1-mdoucha@suse.cz>
Message-ID: <20200326070808.GB17560@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> +++ b/include/tst_safe_ptrace.h
...
> +long tst_safe_ptrace(const char *file, const int lineno,
> +	enum __ptrace_request req, pid_t pid, void *addr, void *data);
enum __ptrace_request is glibc/uclibc specific (musl and bionic don't have it).
Can we just use int?

> +#define SAFE_PTRACE(req, pid, addr, data) \
> +	tst_safe_ptrace(__FILE__, __LINE__, req, pid, addr, data)
> +
> +#endif /* TST_SAFE_PTRACE_H_ */
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index f5413a18e..5769b5068 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -14,6 +14,7 @@
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
> +#include "tst_safe_ptrace.h"
>  #include "lapi/personality.h"

>  int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
> @@ -202,3 +203,21 @@ void safe_unshare(const char *file, const int lineno, int flags)
>  		}
>  	}
>  }
> +
> +long tst_safe_ptrace(const char *file, const int lineno,
> +	enum __ptrace_request req, pid_t pid, void *addr, void *data)
And here.

Kind regards,
Petr
