From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Aug 2020 15:01:25 +0200
Subject: [LTP] [PATCH] ioctl_sg01: Increase chance of detecting data leak
In-Reply-To: <20200820101844.6398-1-mdoucha@suse.cz>
References: <20200820101844.6398-1-mdoucha@suse.cz>
Message-ID: <20200820130125.GE9000@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test wasn't reliable if most of available memory was full of zeroes.
> Pollute 256MB of memory in setup() to increase the chance of catching a data
> leak without needing pre-pollution from another program. Then loop the test
> 100 times.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 36 +++++++++++++-------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> index daaa96be5..7cd22d103 100644
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
> @@ -30,7 +28,8 @@
>  #include <stdio.h>
>  #include "tst_test.h"
>  
> -#define BUF_SIZE 128 * 4096
> +#define BUF_SIZE (128 * 4096)
> +#define DIRTY_SIZE (256 * 1024 * 1024)

Can we please check this againts system free memory?

While it's not likely there may be system that have less that 256MB of
free RAM.

Also when we do check system memory, we can scale up with available
memory as well and dirty 1GB or more on, which is not that much on
modern systems.

Also perhaps it may be a good idea to put this code into a library
function.

>  #define CMD_SIZE 6
>  
>  static int devfd = -1;
> @@ -74,12 +73,20 @@ static const char *find_generic_scsi_device(int access_flags)
>  
>  static void setup(void)
>  {
> +	void *dirty_mem;
>  	const char *devpath = find_generic_scsi_device(O_RDONLY);
>  
>  	if (!devpath)
>  		tst_brk(TCONF, "Could not find any usable SCSI device");
>  
>  	tst_res(TINFO, "Found SCSI device %s", devpath);
> +
> +	/* Pollute some memory to avoid false negatives */
> +	dirty_mem = SAFE_MMAP(NULL, DIRTY_SIZE, PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	memset(dirty_mem, 0xda, DIRTY_SIZE);
> +	SAFE_MUNMAP(dirty_mem, DIRTY_SIZE);
> +
>  	devfd = SAFE_OPEN(devpath, O_RDONLY);
>  	query.interface_id = 'S';
>  	query.dxfer_direction = SG_DXFER_FROM_DEV;
> @@ -97,19 +104,22 @@ static void cleanup(void)
>  
>  static void run(void)
>  {
> -	size_t i;
> +	size_t i, j;
>  
>  	memset(buffer, 0, BUF_SIZE);
> -	TEST(ioctl(devfd, SG_IO, &query));
>  
> -	if (TST_RET != 0 && TST_RET != -1)
> -		tst_brk(TBROK | TTERRNO, "Invalid ioctl() return value");
> +	for (i = 0; i < 100; i++) {
> +		TEST(ioctl(devfd, SG_IO, &query));
> +
> +		if (TST_RET != 0 && TST_RET != -1)
> +			tst_brk(TBROK|TTERRNO, "Invalid ioctl() return value");
>  
> -	/* Check the output buffer even if ioctl() failed, just in case. */
> -	for (i = 0; i < BUF_SIZE; i++) {
> -		if (buffer[i]) {
> -			tst_res(TFAIL, "Kernel memory leaked");
> -			return;
> +		/* Check the buffer even if ioctl() failed, just in case. */
> +		for (j = 0; j < BUF_SIZE; j++) {
> +			if (buffer[j]) {
> +				tst_res(TFAIL, "Kernel memory leaked");
> +				return;
> +			}
>  		}
>  	}

Can we put this part into a seprate patch please?

-- 
Cyril Hrubis
chrubis@suse.cz
