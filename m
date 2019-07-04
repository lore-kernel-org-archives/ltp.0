From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 Jul 2019 04:08:39 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib: add tst_no_corefile to avoid corefile
 dumping
In-Reply-To: <20190703072417.24091-1-liwang@redhat.com>
References: <20190703072417.24091-1-liwang@redhat.com>
Message-ID: <2030850327.31633394.1562227719657.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> If crash is expected in a testcase, we can avoid dumping core file
> in calling this function.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>
> ---
> 
> Notes:
>     v1 --> v2
>         * add a paramenter to hide the message print
>         * add notes in test-writing-guidelines.txt
> 
>  doc/test-writing-guidelines.txt                | 14 ++++++++++++--
>  include/tst_safe_macros.h                      | 18 ++++++++++++++++++
>  .../kernel/security/umip/umip_basic_test.c     |  2 ++
>  testcases/kernel/syscalls/ipc/shmat/shmat01.c  | 16 +++-------------
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index c6d4e001d..1a77db6bf 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -826,8 +826,8 @@ The 'TST_PROCESS_STATE_WAIT()' waits until process 'pid'
> is in requested
>  It's mostly used with state 'S' which means that process is sleeping in
>  kernel
>  for example in 'pause()' or any other blocking syscall.
>  
> -2.2.10 Signal handlers
> -^^^^^^^^^^^^^^^^^^^^^^
> +2.2.10 Signals and signal handlers
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  If you need to use signal handlers, keep the code short and simple. Don't
>  forget that the signal handler is called asynchronously and can interrupt
>  the
> @@ -859,6 +859,16 @@ type defined in C99 but this one *DOES NOT* imply
> 'volatile' (it's just a
>  'typedef' to 'int'). So the correct type for a flag that is changed from a
>  signal handler is either 'volatile int' or 'volatile sig_atomic_t'.
>  
> +If a crash (e.g. triggered by signal SIGSEGV) is expected in testing, you
> can
> +avoid dumping core file via calling this below tst_no_corefile() function.
> +Note that this chanage will only effect on that process with this invoke.
> And

I'd rephrase it to:

   If a crash (e.g. triggered by signal SIGSEGV) is expected in testing, you
   can avoid creation of core files by calling tst_no_corefile() function.
   This takes effect for process (and its children) which invoked it, unless
   they subsequently modify RLIMIT_CORE.

   Note that LTP library will reap any processes that test didn't reap itself,
   and report any non-zero exit code as failure.

One note below.

> +the parameter 'verbose' is used as message print option.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +void tst_no_corefile(int verbose);
> +-------------------------------------------------------------------------------
> +
>  2.2.11 Kernel Modules
>  ^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 53a888c80..c4ddf84ef 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -394,6 +394,24 @@ static inline int safe_setrlimit(const char *file, const
> int lineno,
>  #define SAFE_SETRLIMIT(resource, rlim) \
>  	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
>  
> +/*
> + * Crash is expected, avoid dumping corefile.
> + * 1 is a special value, that disables core-to-pipe.
> + * At the same time it is small enough value for
> + * core-to-file, so it skips creating cores as well.
> + */
> +static inline void tst_no_corefile(int verbose)
> +{
> +       struct rlimit r;
> +
> +       r.rlim_cur = 1;
> +       r.rlim_max = 1;
> +       SAFE_SETRLIMIT(RLIMIT_CORE, &r);

SAFE_SETRLIMIT is fine if needs_root = 1. But if test runs as unprivileged user
and RLIMIT_CORE is already 0, unprivileged user won't be able to increase it,
so we get TBROK here.
