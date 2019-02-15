From: Steve Muckle <smuckle@google.com>
Date: Fri, 15 Feb 2019 15:47:36 -0800
Subject: [LTP] [PATCH v2 1/2] sigpending: use direct syscall
In-Reply-To: <20190212161236.74385-2-maennich@google.com>
References: <20190207155153.41816-1-maennich@google.com>
 <20190212161236.74385-1-maennich@google.com>
 <20190212161236.74385-2-maennich@google.com>
Message-ID: <22cfe1f7-2357-8b9f-df34-3534ec5b3404@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/12/2019 08:12 AM, 'Matthias Maennich' via kernel-team wrote:
> Expand coverage to the Android platform.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>   testcases/kernel/syscalls/sigpending/sigpending02.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
> index a38157ae1..e7ec0d681 100644
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
> +	TEST(tst_syscall(__NR_sigpending, sigset));
>   
>   	/* check return code */
>   	if (TST_RET == -1) {
> 

Reviewed-by: Steve Muckle <smuckle@google.com>
