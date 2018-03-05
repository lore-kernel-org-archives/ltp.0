From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Mar 2018 22:47:25 +0100
Subject: [LTP] [PATCH] syscalls/connect01: bypass bionic connect()
 implementation
In-Reply-To: <20180303000947.76487-1-ghackmann@google.com>
References: <20180303000947.76487-1-ghackmann@google.com>
Message-ID: <20180305214725.onvea2ng2565fqoy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Greg,

> The connect01 test segfaults on Android when it gets to the second
> testcase.  bionic's connect() implementation hooks into the netd client
> library, which in turn expects addr to be a valid pointer.

> Work around this by directly calling the kernel connect syscall.

> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---
>  testcases/kernel/syscalls/connect/connect01.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

> diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
> index 2be83cfbb..e9b9c7945 100644
> --- a/testcases/kernel/syscalls/connect/connect01.c
> +++ b/testcases/kernel/syscalls/connect/connect01.c
> @@ -116,6 +116,23 @@ int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
>  static char *argv0;
>  #endif

> +#ifdef __BIONIC__
> +/**
> + * bionic's connect() implementation calls netdClientInitConnect() before
> + * sending the request to the kernel.  We need to bypass this, or the test will
> + * segfault during the addr = (struct sockaddr *)-1 testcase.
> + */
> +#include "lapi/syscalls.h"
> +
> +static int sys_connect(int sockfd, const struct sockaddr *addr,
> +		socklen_t addrlen)
> +{
> +	return ltp_syscall(__NR_connect, sockfd, addr, addrlen);
> +}
> +
> +#define connect(sockfd, addr, addrlen) sys_connect(sockfd, addr, addrlen)
> +#endif
> +
>  int main(int argc, char *argv[])
>  {
>  	int lc;

Pushed, thanks!


Kind regards,
Petr
