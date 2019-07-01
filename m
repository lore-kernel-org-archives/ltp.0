From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Jul 2019 07:01:36 -0400 (EDT)
Subject: [LTP] [RFC PATCH] lib: add tst_no_corefile to avoid corefile
 dumping
In-Reply-To: <20190701100343.3406-1-liwang@redhat.com>
References: <20190701100343.3406-1-liwang@redhat.com>
Message-ID: <2137465502.31003797.1561978896804.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_safe_macros.h                        | 16 ++++++++++++++++
>  testcases/kernel/security/umip/umip_basic_test.c |  2 ++
>  testcases/kernel/syscalls/ipc/shmat/shmat01.c    | 16 +++-------------
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 53a888c80..110e2984f 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -394,6 +394,22 @@ static inline int safe_setrlimit(const char *file, const
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
> +static inline void tst_no_corefile(void)
> +{
> +       struct rlimit r;
> +
> +       r.rlim_cur = 1;
> +       r.rlim_max = 1;
> +       SAFE_SETRLIMIT(RLIMIT_CORE, &r);
> +       tst_res(TINFO, "Avoid dumping corefile in following test");

I'm fine with helper func. Maybe I'd print also current pid.
It could be little spammy if there are many children, but we could
address that later (if needed) with a parameter to control verbosity.
