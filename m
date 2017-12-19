From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Dec 2017 14:41:38 +0100
Subject: [LTP] [PATCH v2 2/2] ioctl: convert ioctl03 to new API
In-Reply-To: <20171214072432.15709-2-liwang@redhat.com>
References: <20171214072432.15709-1-liwang@redhat.com>
 <20171214072432.15709-2-liwang@redhat.com>
Message-ID: <20171219134138.GF28293@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
> index 8c3d446..f23b1f8 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
> @@ -1,7 +1,6 @@
>  /*
> - *
> - * Copyright (c) Rusty Russell <rusty@rustcorp.com.au>
>   * Copyright (c) International Business Machines  Corp., 2008
> + * Copyright (c) Linux Test Project, 2017
>   *
>   * This program is free software;  you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -12,30 +11,22 @@
>   * but WITHOUT ANY WARRANTY;  without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>   * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

If you are touching this, you should have replaced it with the version
with URL link.

>   */
>  
>  /*
> - *
> - *
>   * File:        ioctl03.c
>   *
>   * Description: This program tests whether all the valid IFF flags are
>   *              returned properly by implementation of TUNGETFEATURES ioctl
>   *              on kernel 2.6.27
>   *
> - * Total Tests: 1
> - *
>   * Test Name:   ioctl03
>   *
>   * Author:      Rusty Russell <rusty@rustcorp.com.au>
>   *
> - * History:     Created - Nov 28 2008 - Rusty Russell <rusty@rustcorp.com.au>
> - *              Ported to LTP
> - *                      - Nov 28 2008 - Subrata <subrata@linux.vnet.ibm.com>
> + * history:     created - nov 28 2008 - rusty russell <rusty@rustcorp.com.au>
> + *              ported to ltp
> + *                      - nov 28 2008 - subrata <subrata@linux.vnet.ibm.com>
>   */
>  
>  #include <sys/types.h>
> @@ -45,8 +36,7 @@
>  #include <errno.h>
>  #include <stdio.h>
   ^
   There is no need to include this header here.

>  #include <linux/if_tun.h>
> -
> -#include "test.h"
> +#include "tst_test.h"
>  
>  #ifndef TUNGETFEATURES
>  #define TUNGETFEATURES _IOR('T', 207, unsigned int)
> @@ -61,67 +51,51 @@
>  #endif
>  
>  #ifndef IFF_NAPI
> -#define IFF_NAPI       0x0010
> +#define IFF_NAPI	0x0010
>  #endif
>  
>  #ifndef IFF_NAPI_FRAGS
> -#define IFF_NAPI_FRAGS 0x0020
> +#define IFF_NAPI_FRAGS	0x0020
>  #endif
>  
> -char *TCID = "ioctl03";
> -int TST_TOTAL = 1;
> -
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> -
> -static void setup(void)
> -{
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -}
> -
>  static struct {
>  	unsigned int flag;
>  	const char *name;
>  } known_flags[] = {
> -	{
> -	IFF_TUN, "TUN"}, {
> -	IFF_TAP, "TAP"}, {
> -	IFF_NO_PI, "NO_PI"}, {
> -	IFF_ONE_QUEUE, "ONE_QUEUE"}, {
> -	IFF_VNET_HDR, "VNET_HDR"}, {
> -	IFF_MULTI_QUEUE, "MULTI_QUEUE"}, {
> -	IFF_NAPI, "IFF_NAPI"}, {
> -	IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
> +	{IFF_TUN, "TUN"},
> +	{IFF_TAP, "TAP"},
> +	{IFF_NO_PI, "NO_PI"},
> +	{IFF_ONE_QUEUE, "ONE_QUEUE"},
> +	{IFF_VNET_HDR, "VNET_HDR"},
> +	{IFF_MULTI_QUEUE, "MULTI_QUEUE"},
> +	{IFF_NAPI, "IFF_NAPI"},
> +	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
>  };
>  
> -int main(void)
> +static void verify_features(void)
>  {
>  	unsigned int features, i;
>  
> -	setup();
> -	tst_require_root();
> +	int netfd = SAFE_OPEN("/dev/net/tun", O_RDWR);
>  
> -	int netfd = open("/dev/net/tun", O_RDWR);
> -	if (netfd < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "opening /dev/net/tun failed");
> +	SAFE_IOCTL(netfd, TUNGETFEATURES, &features);
> -
> -	if (ioctl(netfd, TUNGETFEATURES, &features) != 0)
> -		tst_brkm(TCONF, cleanup,
> -			 "Kernel does not support TUNGETFEATURES");

After this change the test fails with TBROK instead of TCONF when the
ioctl() fails.

I suppose that the tun driver can be compiled out of the kernel and that
we should still handle this situation as TCONF rather than TBROK. The
question is what kind of errno we get in that case, I suppose that it
may be ENOTTY but that should be tested.

> -	tst_resm(TINFO, "Available features are: %#x", features);
> +	tst_res(TINFO, "Available features are: %#x", features);
>  	for (i = 0; i < sizeof(known_flags) / sizeof(known_flags[0]); i++) {
                         ^
			 We do have ARRAY_SIZE() macro in LTP.
>  		if (features & known_flags[i].flag) {
>  			features &= ~known_flags[i].flag;
> -			tst_resm(TINFO, "%s %#x", known_flags[i].name,
> +			tst_res(TPASS, "%s %#x", known_flags[i].name,
>  				 known_flags[i].flag);
>  		}
>  	}
>  	if (features)
> -		tst_resm(TFAIL, "(UNKNOWN %#x)", features);
> -	cleanup();
> -	tst_exit();
> +		tst_res(TFAIL, "(UNKNOWN %#x)", features);
> +
> +	SAFE_CLOSE(netfd);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = verify_features,
> +	.needs_tmpdir = 1,
            ^
	    Is this useful for something?

	    The test does not seem to be creating any files at all.

> +	.needs_root = 1,
> +};
> -- 
> 2.9.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
