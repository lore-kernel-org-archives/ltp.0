From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 25 Dec 2017 12:50:07 +0300
Subject: [LTP] [RFC PATCH v2 2/4] lapi/socket.h: Move definitions from
 netstress.c
In-Reply-To: <20171221192739.4868-3-pvorel@suse.cz>
References: <20171221192739.4868-1-pvorel@suse.cz>
 <20171221192739.4868-3-pvorel@suse.cz>
Message-ID: <8186d043-06db-94a3-1da3-c2e57e42597b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/21/2017 10:27 PM, Petr Vorel wrote:
> and use lapi/socket.h in netstress.c.
> 
> + include <sys/socket.h> in lapi/socket.h
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/lapi/socket.h                   | 18 ++++++++++++++++++
>  testcases/network/netstress/netstress.c | 17 ++---------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/include/lapi/socket.h b/include/lapi/socket.h
> index 98263105e..d97d29f36 100644
> --- a/include/lapi/socket.h
> +++ b/include/lapi/socket.h
> @@ -19,8 +19,26 @@
>  #ifndef __LAPI_SOCKET_H__
>  #define __LAPI_SOCKET_H__
>  
> +#include <sys/socket.h>
> +
> +#ifndef MSG_FASTOPEN
> +# define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
> +#endif
> +
> +#ifndef SO_BUSY_POLL
> +# define SO_BUSY_POLL	46
> +#endif
> +
>  #ifndef SOCK_CLOEXEC
>  # define SOCK_CLOEXEC 02000000
>  #endif
>  
> +#ifndef SOCK_DCCP
> +# define SOCK_DCCP		6
> +#endif

I would move it above SOCK_CLOEXEC, so we can keep the order
of these flags similarly to bits/socket.h.

The other patches in this set look good, thanks!
