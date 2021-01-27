From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2021 10:50:13 +0100
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <2021012716492236006117@chinatelecom.cn>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <CAEemH2csSFf7Ujz8H+KV7hTdmDVsxn5_oW2JZbwY=NsJUSat_w@mail.gmail.com>
 <2021012714540739834212@chinatelecom.cn>
 <CAEemH2dhpbm19HEaHkhv1WE+70VkDjM9C5L1-KJZqPX2G2BgrQ@mail.gmail.com>
 <2021012716492236006117@chinatelecom.cn>
Message-ID: <YBE3VUzecdhq7gJQ@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>
> ---
>  lib/tst_memutils.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index dd09db4..21df9a8 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -10,14 +10,33 @@
> 
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
> +#include "tst_safe_stdio.h"
> 
>  #define BLOCKSIZE (16 * 1024 * 1024)
> 
> +static unsigned long get_available_ram(void)
> +{

Can we prefix this function with tst_ and make it non-static?

I guess that there may be other tests that may use it later on.

> +       char buf[60]; /* actual lines we expect are ~30 chars or less */
> +       unsigned long available_kb = 0;
> +       FILE *fp;
> +
> +       fp = SAFE_FOPEN("/proc/meminfo","r");
> +       while (fgets(buf, sizeof(buf), fp)) {
> +               if (sscanf(buf, "MemAvailable: %lu %*s\n", &available_kb) == 1){
> +                       break;
> +               }
> +       }
> +       SAFE_FCLOSE(fp);

Just use FILE_LINES_SCANF() instead.

Also we should fall back to something as 90% of (MemFree + Cached) here
if MemAvailable is not present so that the function returns sensible
number on older kernels as well.

> +       return 1024 * available_kb;

Can we just return kilobytes instead?

It will be less likely to overflow if we do all the calculations in
kilobytes instead.

-- 
Cyril Hrubis
chrubis@suse.cz
