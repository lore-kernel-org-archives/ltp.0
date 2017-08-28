From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Aug 2017 13:02:06 +0200
Subject: [LTP] [PATCH v3 1/2] lapi/keyctl.h: Add fallback definition of
 keyutil.h
In-Reply-To: <20170825032423.21004-1-fenggw-fnst@cn.fujitsu.com>
References: <1d294342-1504-e66f-5fdc-f9cd7806afef@cn.fujitsu.com>
 <20170825032423.21004-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170828110206.GA21355@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef HAVE_KEYUTILS_H
> +# include <keyutils.h>

We should also make sure we do not include both linux/keyctl.h and
keyutils.h they both define KEY_* and KEYCTL_* constants.

So the <linux/keyctl.h> include should be in the else branch of the
HAVE_KEYUTILS_H.

> +#else
> +# include <stdarg.h>
> +# include <stdint.h>
> +# include "lapi/syscalls.h"
> +# ifdef __TEST_H__
> +#  define TST_SYSCALL_WRAPPER ltp_syscall
> +# else
> +#  define TST_SYSCALL_WRAPPER tst_syscall
> +# endif /* __TEST_H__ */

What do we need these ifdefs for?

I've checked all the keyctl tests and they are all converted to new
library and so we can call tst_syscall() directly.

> +typedef int32_t key_serial_t;
> +
> +static inline key_serial_t add_key(const char *type,
> +				   const char *description,
> +				   const void *payload,
> +				   size_t plen,
> +				   key_serial_t ringid)
> +{
> +	return TST_SYSCALL_WRAPPER(__NR_add_key,
> +		type, description, payload, plen, ringid);
> +}
> +
> +static inline key_serial_t request_key(const char *type,
> +				       const char *description,
> +				       const char *callout_info,
> +				       key_serial_t destringid)
> +{
> +	return TST_SYSCALL_WRAPPER(__NR_request_key,
> +		type, description, callout_info, destringid);
> +}
> +
> +static inline long keyctl(int cmd, ...)
> +{
> +	va_list va;
> +	unsigned long arg2, arg3, arg4, arg5;
> +
> +	va_start(va, cmd);
> +	arg2 = va_arg(va, unsigned long);
> +	arg3 = va_arg(va, unsigned long);
> +	arg4 = va_arg(va, unsigned long);
> +	arg5 = va_arg(va, unsigned long);
> +	va_end(va);
> +
> +	return TST_SYSCALL_WRAPPER(__NR_keyctl,
> +		cmd, arg2, arg3, arg4, arg5);
> +}
> +#endif /* HAVE_KEYUTILS_H */
> +
>  #ifndef KEYCTL_GET_KEYRING_ID
>  # define KEYCTL_GET_KEYRING_ID 0
>  #endif
> -- 
> 2.9.4
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
