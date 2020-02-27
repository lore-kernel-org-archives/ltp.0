From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Feb 2020 14:49:25 +0100
Subject: [LTP] [PATCH v1] Stringify flags to improve error msg of
 unshare()
In-Reply-To: <20200226172620.29815-1-cfamullaconrad@suse.de>
References: <20200226172620.29815-1-cfamullaconrad@suse.de>
Message-ID: <20200227134924.GB24778@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If your test has multiple calls of unshare() it is hard to read which
> unshare() call really failed. With this we improve the error message to
> something like this:
> 
>   sendmsg03.c:43: CONF: unshare(CLONE_NEWUSER) unsupported: EINVAL (22)
> 
> Instead of having a hard to understand number like:
> 
>   sendmsg03.c:43: CONF: unshare(268435456) unsupported: EINVAL (22)
> 
> Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
> ---
>  include/tst_safe_macros.h | 5 +++--
>  lib/tst_safe_macros.c     | 7 ++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 80c4d9cb9..f2f8bd10f 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -544,7 +544,8 @@ int safe_personality(const char *filename, unsigned int lineno,
>  	}							\
>  	} while (0)
>  
> -void safe_unshare(const char *file, const int lineno, int flags);
> -#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
> +void safe_unshare(const char *file, const int lineno, const char *flags_str,
> +	int flags);
> +#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, #flags, (flags))

I would actually prefer to have a lookup table instead, because this
breaks when pass flags by a variable, e.g.

	int ns_flags = CLONE_NEWNS | CLONE_NEWPID;

	SAFE_UNSHARE(ns_flags);


Looking that the flags, these are bigflags, which makes it a bit tricky,
so we will have to write it as:

void get_ns_flags(int flags, char *flags, size_t flags_size)
{
	int first = 1;

	if (flags & CLONE_VM)
		append_flags("CLONE_VM", &first, &flags, &flags_size);

	if (flags & CLONE_FS)
		append_flags("CLONE_FS", &first, &flags, &flags_size);

	...
}

-- 
Cyril Hrubis
chrubis@suse.cz
