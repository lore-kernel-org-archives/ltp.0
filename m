From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Feb 2021 17:09:54 +0100
Subject: [LTP] [PATCH v2 1/4] Prevent linker issues in lapi/io_uring.h
In-Reply-To: <20210204110342.11821-1-mdoucha@suse.cz>
References: <20210204110342.11821-1-mdoucha@suse.cz>
Message-ID: <YB1t0lP2j+x2yKdn@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Fallback io_uring syscall wrappers were not defined as static inline. This
> will lead to linker issues when safe function variants get added to LTP
> library.

> Also add check for <linux/io_uring.h> to configure script and #include it
> in the LAPI header if it's available.

Thanks for cleanup!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/configure.ac
> @@ -49,6 +49,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      linux/if_alg.h \
>      linux/if_ether.h \
>      linux/if_packet.h \
> +    linux/io_uring.h \
>      linux/keyctl.h \
>      linux/mempolicy.h \
>      linux/module.h \
...

> +++ b/include/lapi/io_uring.h
...
> +#ifdef HAVE_LINUX_IO_URING_H
> +#include <linux/io_uring.h>
> +#endif
> +
>  #ifndef IOSQE_FIXED_FILE
This could be also guarded as ! HAVE_LINUX_IO_URING_H (#else branch), but
keeping IOSQE_FIXED_FILE is probably safer.

>  #ifndef __kernel_rwf_t
> @@ -260,8 +264,8 @@ struct io_uring_probe {


>  #ifndef HAVE_IO_URING_REGISTER
> -int io_uring_register(int fd, unsigned int opcode, void *arg,
> -		      unsigned int nr_args)
> +static inline int io_uring_register(int fd, unsigned int opcode, void *arg,
> +	unsigned int nr_args)
>  {
>  	return tst_syscall(__NR_io_uring_register, fd, opcode, arg, nr_args);
>  }
> @@ -269,22 +273,23 @@ int io_uring_register(int fd, unsigned int opcode, void *arg,
...

Kind regards,
Petr
