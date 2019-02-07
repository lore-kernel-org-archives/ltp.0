From: Steve Muckle <smuckle@google.com>
Date: Thu, 7 Feb 2019 10:58:22 -0800
Subject: [LTP] [PATCH v1] sigpending: use direct syscall
In-Reply-To: <20190207155153.41816-1-maennich@google.com>
References: <20190207155153.41816-1-maennich@google.com>
Message-ID: <aaf4de2f-9171-3e27-e9ab-3811eea7b5c3@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/07/2019 07:51 AM, Matthias Maennich wrote:
> Expand coverage to the Android platform.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>   testcases/kernel/syscalls/sigpending/sigpending02.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
> index a38157ae1..ff8b59c8c 100644
> --- a/testcases/kernel/syscalls/sigpending/sigpending02.c
> +++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
> @@ -17,13 +17,14 @@
>   #include <sys/types.h>
>   
>   #include "tst_test.h"
> +#include "lapi/syscalls.h"
>   
>   static void run(void)
>   {
>   	/* set sigset to point to an invalid location */
>   	sigset_t *sigset = (sigset_t *) - 1;
>   
> -	TEST(sigpending(sigset));
> +	TEST(tst_syscall(__NR_rt_sigpending, sigset, NSIG / 8));
>   
>   	/* check return code */
>   	if (TST_RET == -1) {

Should this be using __NR_sigpending instead? That worked for me (for 
32-bit anyway, it's not available on arm64).

Alternately, this test/dir could be renamed to rt_sigpending, though we 
should also add a test for sigpending.

thanks,
steve

