From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Jul 2021 15:52:47 +0200
Subject: [LTP] [PATCH 1/2] Add tst_hexdump utility
In-Reply-To: <20210726151736.14299-1-mdoucha@suse.cz>
References: <20210726151736.14299-1-mdoucha@suse.cz>
Message-ID: <YQQEL/Tlun7pAI5X@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks! I suppose I'll merge it as is, but few notes below:

As you use only -d in this patchset I suppose you want to have
it as a general utility. It might be worth to mention that xxd by default wraps by
16 cols (-c 16), which we don't do:

$ echo "06a441375b431e06280e2d4e199ba650c14c47d9" | ./testcases/lib/tst_hexdump; echo
303661343431333735623433316530363238306532643465313939626136353063313463343764390a

$ echo "06a441375b431e06280e2d4e199ba650c14c47d9" | xxd -p
303661343431333735623433316530363238306532643465313939626136
353063313463343764390a

Other option would be just make -d as default and remove encode_hex() until is
really needed.

Kind regards,
Petr


> tst_hexdump implements conversion between binary and hexadecimal values in both
> directions for shell tests.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/lib/Makefile      |  2 +-
>  testcases/lib/tst_hexdump.c | 55 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/lib/tst_hexdump.c

> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 98d9e4613..38813e640 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
>  MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>  			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
>  			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
> -			   tst_get_median
> +			   tst_get_median tst_hexdump

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tst_hexdump.c b/testcases/lib/tst_hexdump.c
> new file mode 100644
> index 000000000..f83b8bfbf
> --- /dev/null
> +++ b/testcases/lib/tst_hexdump.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * Convert bytes from standard input to hexadecimal representation.
> + *
> + * Parameters:
> + * -d   Convert hexadecimal values from standard input to binary representation
> + *      instead.
This could be printed in -h parameter if really meant to be a general tool.
But understand you didn't bother.

Kind regards,
Petr

> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +int decode_hex(void)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	while ((ret = scanf("%2x", &val)) == 1)
> +		putchar(val);
> +
> +	return ret != EOF || ferror(stdin);
> +}
> +
> +int encode_hex(void)
> +{
> +	int val;
> +
> +	for (val = getchar(); val >= 0 && val <= 0xff; val = getchar())
> +		printf("%02x", val);
> +
> +	return val != EOF || ferror(stdin);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret, decode = 0;
> +
> +	while ((ret = getopt(argc, argv, "d"))) {
> +		if (ret < 0)
> +			break;
> +
> +		switch (ret) {
> +		case 'd':
> +			decode = 1;
> +			break;
> +		}
> +	}
> +
> +	if (decode)
> +		return decode_hex();
> +	else
> +		return encode_hex();
> +}
