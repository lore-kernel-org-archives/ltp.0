From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Oct 2019 04:56:47 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] fanotify: Fix missing __kernel_fsid_t
 definition
In-Reply-To: <20191016211501.3777-1-petr.vorel@gmail.com>
References: <20191016211501.3777-1-petr.vorel@gmail.com>
Message-ID: <1170755640.6589868.1571302607540.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> which is missing at least on musl which doesn't have FAN_REPORT_FID
> support.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h
> b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 1c7623d3b..01a2d52bd 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -35,6 +35,10 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  
> +#if !defined(FAN_REPORT_FID) && defined(HAVE_NAME_TO_HANDLE_AT)
> +#include <asm/posix_types.h> // __kernel_fsid_t
> +#endif

Would an alternative that adds this type to lapi work?
(just looking if we can avoid extra kernel include)

typedef struct {
        int     val[2];
} lapi_fsid_t;

#define __kernel_fsid_t lapi_fsid_t
