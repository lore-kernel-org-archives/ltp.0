From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 15 Oct 2019 15:02:59 +0200
Subject: [LTP] [PATCH] include: undefine _LINUX_TYPES_H if including
 sys/capability.h
In-Reply-To: <20191015101534.17691-1-liwang@redhat.com>
References: <20191015101534.17691-1-liwang@redhat.com>
Message-ID: <87sgnuw48s.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> In some of the libcap-devel(1.96~2.16) versions, it defines the _LINUX_TYPES_H
> macro to make ltp-lib cann't include linux/types.h essentially.
>
>     # cat -n /usr/include/sys/capability.h
>     ...
>     25  /*
>     26   * Make sure we can be included from userland by preventing
>     27   * capability.h from including other kernel headers
>     28   */
>     29  #define _LINUX_TYPES_H
>
> To get rid of this compiling errors on rhel6(libcap-devel-2.16) series platform,
> here undefine _LINUX_TYPES_H if included that sys/capability.h.
>
>   == Error log ==
>   In file included from ../include/tst_netlink.h:26,
>                  from tst_crypto.c:13:
>   /usr/include/linux/netlink.h:45: error: expected specifier-qualifier-list before ?__u16?
>   /usr/include/linux/netlink.h:135: error: expected specifier-qualifier-list before ?__u16?
>   tst_crypto.c: In function ?tst_crypto_recv_ack?:
>   tst_crypto.c:46: error: ?struct nlmsghdr? has no member named ?nlmsg_seq?
>   tst_crypto.c:47: error: ?struct nlmsghdr? has no member named ?nlmsg_type?
>   tst_crypto.c:47: error: ?struct nlmsghdr? has no member named ?nlmsg_seq?
>   tst_crypto.c:55: error: ?struct nlmsghdr? has no member named ?nlmsg_type?
>   tst_crypto.c:58: error: ?struct nlmsghdr? has no member named ?nlmsg_type?
>   tst_crypto.c:58: error: ?struct nlmsghdr? has no member named ?nlmsg_seq?
>   tst_crypto.c: In function ?tst_crypto_add_alg?:
>   ...
>   make: *** [tst_crypto.o] Error 1
>
> Reported-by: Ping Fang <pifang@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Ping Fang <pifang@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  include/lapi/capability.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/lapi/capability.h b/include/lapi/capability.h
> index dac233d84..3c2ee7937 100644
> --- a/include/lapi/capability.h
> +++ b/include/lapi/capability.h
> @@ -10,6 +10,7 @@
>  
>  #ifdef HAVE_SYS_CAPABILITY_H
>  # include <sys/capability.h>
> +# undef _LINUX_TYPES_H

My concern here is if linux/types.h has already been included. Then this
could cause a redefinition error if it is included again.

>  #endif
>  
>  #ifndef CAP_NET_RAW


-- 
Thank you,
Richard.
