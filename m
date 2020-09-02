From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Sep 2020 19:13:58 +0200
Subject: [LTP] [PATCH v2 3/4] ioctl_sg01: Pollute free memory in setup
In-Reply-To: <20200825160735.24602-4-mdoucha@suse.cz>
References: <20200825160735.24602-1-mdoucha@suse.cz>
 <20200825160735.24602-4-mdoucha@suse.cz>
Message-ID: <20200902171358.GB26811@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> The test wasn't reliable if most of available memory was full of zeroes.
> Pollute free memory to increase the chance of detecting data leak.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1:
> - Split patch
> - Use tst_pollute_memory() instead of allocating and pre-polluting
>   a fixed-size block of memory in setup().

>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> index daaa96be5..8c9fd0dae 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> @@ -7,9 +7,7 @@
>   * CVE-2018-1000204
>   *
>   * Test ioctl(SG_IO) and check that kernel doesn't leak data. Requires
> - * a read-accessible SCSI-compatible device (e.g. SATA disk). Running oom*
> - * test program before this one may increase the chance of successfully
> - * reproducing the bug.
> + * a read-accessible generic SCSI device (e.g. a DVD drive).
>   *
>   * Leak fixed in:
>   *
> @@ -29,8 +27,9 @@
>  #include <sys/ioctl.h>
>  #include <stdio.h>
>  #include "tst_test.h"
> +#include "tst_memutils.h"

> -#define BUF_SIZE 128 * 4096
> +#define BUF_SIZE (128 * 4096)
>  #define CMD_SIZE 6

>  static int devfd = -1;
> @@ -80,6 +79,10 @@ static void setup(void)
>  		tst_brk(TCONF, "Could not find any usable SCSI device");

>  	tst_res(TINFO, "Found SCSI device %s", devpath);
> +
> +	/* Pollute some memory to avoid false negatives */
> +	tst_pollute_memory(0, 0x42);
> +
>  	devfd = SAFE_OPEN(devpath, O_RDONLY);
>  	query.interface_id = 'S';
>  	query.dxfer_direction = SG_DXFER_FROM_DEV;
