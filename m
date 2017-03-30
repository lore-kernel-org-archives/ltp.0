From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 16:04:21 +0200
Subject: [LTP] [PATCH v2] syscalls/memfd_create: Fix build failure when
 HAVE_FALLOCATE not defined
In-Reply-To: <1490870937-1160-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <58DCD4B1.5060705@cn.fujitsu.com>
 <1490870937-1160-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170330140421.GK12095@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with cosmetic changes and ack from Jan, thanks.

> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> index 8612db7..ddf9f05 100644
> --- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> @@ -18,7 +18,6 @@
>  #include <sys/types.h>
>  #include <sys/syscall.h>
>  #include <sys/uio.h>
> -#include <lapi/fallocate.h>
>  #include <lapi/fcntl.h>
>  #include <lapi/memfd.h>
>  #include <errno.h>
> @@ -28,7 +27,8 @@
>  #include <unistd.h>
>  
>  #define TST_NO_DEFAULT_MAIN
> -#include <tst_test.h>
> +#include "tst_test.h"
> +#include "lapi/fallocate.h"

I've moved the rest of the lapi headers down here so they stay grouped
toghether.

-- 
Cyril Hrubis
chrubis@suse.cz
