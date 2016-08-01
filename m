From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Aug 2016 17:36:40 +0200
Subject: [LTP] [PATCH V3 10/23] sysconf01: Use _SC_2_C_VERSION
 conditionally
In-Reply-To: <20160722042656.22346-10-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-10-raj.khem@gmail.com>
Message-ID: <20160801153640.GE8568@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> _SC_2_C_VERSION is not available on musl

Looks like it has been removed from minimal required set of system
variables in newer POSIXes.

> ---
>  testcases/kernel/syscalls/sysconf/sysconf01.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/sysconf/sysconf01.c b/testcases/kernel/syscalls/sysconf/sysconf01.c
> index 8542e77..7ebae23 100644
> --- a/testcases/kernel/syscalls/sysconf/sysconf01.c
> +++ b/testcases/kernel/syscalls/sysconf/sysconf01.c
> @@ -102,7 +102,9 @@ int main(void)
>  	test_sysconf(_SC_ATEXIT_MAX);
>  	test_sysconf(_SC_2_C_BIND);
>  	test_sysconf(_SC_2_C_DEV);
> +#ifdef _SC_2_C_VERSION
>  	test_sysconf(_SC_2_C_VERSION);
> +#endif

I've added an else branch that prints TCONF so that the number of tests
is always the same and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
