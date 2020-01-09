From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 08:45:37 +0100
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <20200109071510.11223-1-liwang@redhat.com>
References: <20200109071510.11223-1-liwang@redhat.com>
Message-ID: <20200109074537.GA12486@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> To follow up commit 447c223dba538efc7be23edc.

> Signed-off-by: Li Wang <liwang@redhat.com>
> Tested-by: Li Wang <liwang@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>
BTW I wonder if my sieve filter is bad, because I didn't get this mail or git
send-email didn't sent it.

> Cc: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Nice, thanks for a fix. + Note about _XOPEN_SOURCE below.

Tested-by: Petr Vorel <pvorel@suse.cz>
https://travis-ci.org/pevik/ltp/builds/634613112
NOTE: it works, failures to Debian testing are caused by bug in libtirpc 1.2.5,
fixed in a86b4ff Add authdes_seccreate() stub [1].

...
> diff --git a/include/tst_device.h b/include/tst_device.h
> index f277afd77..b4067be52 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -18,7 +18,9 @@
>  #ifndef TST_DEVICE_H__
>  #define TST_DEVICE_H__

> +#define _GNU_SOURCE
>  #include <unistd.h>
> +#include <sys/syscall.h>

>  struct tst_device {
>  	const char *dev;
> @@ -75,9 +77,9 @@ int tst_detach_device(const char *dev_path);
>   * simply before the tst_dev_bytes_written invocation. For easy to use,
>   * we create this inline function tst_dev_sync.
>   */
> -static inline void tst_dev_sync(int fd)
> +static inline int tst_dev_sync(int fd)
>  {
> -	syncfs(fd);
> +	return syscall(__NR_syncfs, fd);
+1 for returning result.
>  }

>  /*
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> index 2af040840..f5d7ca8ac 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> @@ -20,6 +20,7 @@
>   *	None
>   */

> +#define _GNU_SOURCE
>  #define _XOPEN_SOURCE 600
If we define _GNU_SOURCE we probably don't need _XOPEN_SOURCE 600, do we?

>  #include <fcntl.h>

> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
> index d533a7953..899f58af8 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
> @@ -20,6 +20,7 @@
>   *	None
>   */

> +#define _GNU_SOURCE
>  #define _XOPEN_SOURCE 600
Same here.

>  #include <fcntl.h>
>  #include <unistd.h>
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> index 5bada5f3d..efd3ab378 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> @@ -20,6 +20,7 @@
>   *	None
>   */

> +#define _GNU_SOURCE
>  #define _XOPEN_SOURCE 600
Same here.

...
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
> index d8d8fb601..58162c6fb 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
> @@ -20,6 +20,7 @@
>   *	None
>   */

> +#define _GNU_SOURCE
>  #define _XOPEN_SOURCE 600
Same here.
>  #include <fcntl.h>
>  #include <unistd.h>

...
> diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
> index 056d44da2..4582d4e94 100644
> --- a/testcases/kernel/syscalls/pwrite/pwrite02.c
> +++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
> @@ -18,6 +18,7 @@
>   *      accessible address space, returns EFAULT.
>   */

> +#define _GNU_SOURCE
>  #define _XOPEN_SOURCE 500
Same here.

Kind regards,
Petr

[1] http://git.linux-nfs.org/?p=steved/libtirpc.git;a=commit;h=a86b4ff0c4b4e53df436f83c21a5fbf01568a301
