From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 5 Apr 2017 11:34:17 +0200
Subject: [LTP] [RFC] [PATCH] lib: Fix undefined reference to `mq_open'
 build failures
In-Reply-To: <20170329165008.6396-1-chrubis@suse.cz>
References: <20170329165008.6396-1-chrubis@suse.cz>
Message-ID: <20170405113417.49876712@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Metan,

On Wed, 29 Mar 2017 18:50:08 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> It appears that since the addition of the tst_safe_posix_ipc.c to the
> test library random testcases (mostly ltp-aiodio seems to be triggering
> the issue) started to fail on linking with missing reference to mq_open.
> 
> The problem is that -lrt is needed for mq_open() so this commit adds a
> weak stub symbol that is used as fallback when we are compiling without
> -lrt.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/tst_safe_posix_ipc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/tst_safe_posix_ipc.c b/lib/tst_safe_posix_ipc.c
> index 7142a25..4c617c8 100644
> --- a/lib/tst_safe_posix_ipc.c
> +++ b/lib/tst_safe_posix_ipc.c
> @@ -22,6 +22,13 @@
>  #include "tst_test.h"
>  #include "tst_safe_posix_ipc.h"
>  
> +mqd_t __attribute__((weak)) mq_open(const char *name __attribute__((unused)),
> +				    int oflag __attribute__((unused)), ...)
> +{
> +	tst_brk(TBROK, "mq_open() stub called!");

Maybe expand this to "mq_open() stub called! Add -lrt to linker flags".

If we start stubbing a lot of functions then we could have a TST_STUB macro
which takes the function name, arguments and linker switch (e.g. -lrt) and
produces a stub.

> +	return 0;
> +}
> +
>  int safe_mq_open(const char *file, const int lineno, const char *pathname,
>  	int oflags, ...)
>  {

I ran into this problem and the stub fixed it. I wonder why a test which never
calls SAFE_MQ_OPEN triggers it and others do not and why it does not happen
consistently. Perhaps the linker tries to do some relocation at a stage when
the library is not available and whether it tries to do the relocation is
effected by whatever libraries are available in the environment. I can't think
why else it would only try to resolve it some of the time?

Anyway, I have tried it on gcc6, clang and gcc4 without any problems. It seems
like a good approach.

Thank you,
Richard.
