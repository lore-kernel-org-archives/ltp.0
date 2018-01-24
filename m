From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jan 2018 14:13:13 +0100
Subject: [LTP] [PATCH] Add library support for /proc/sys/kernel/tainted
In-Reply-To: <20180123143013.2879-1-mmoese@suse.de>
References: <20180123143013.2879-1-mmoese@suse.de>
Message-ID: <20180124131313.GB26495@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  include/tst_taint.h | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_taint.c     |  52 ++++++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
>  create mode 100644 include/tst_taint.h
>  create mode 100644 lib/tst_taint.c
> 
> diff --git a/include/tst_taint.h b/include/tst_taint.h
> new file mode 100644
> index 000000000..34e69c2f5
> --- /dev/null
> +++ b/include/tst_taint.h
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (c) 2018 Michael Moese <mmoese@suse.de>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/* Usage example
> + *
> + * ...
> + * #include "tst_test.h"
> + * #include "tst_taint.h"
> + * ..
> + * void setup(void)
> + * {
> + *	if (!tst_taint_supported())
> + *		tst_brk(TCONF, "Kernel does not support tainted flags");

I think that we should check here if the kernel was tainted before the
test here and issue TBROK.

And also I would like to have the API tailored for the most common case
as well. So what about something as adding tst_check_taint(unsigned mask)
to be called from the test setup that would:

* check if kernel is new enough, otherwise do TCONF

* check if all flags in the mask are not set, otherwise do TBROK

> + * }
> + *
> + * void run(void)
> + * {
> + *	...
> + *	. test code here
> + *	...
> + *	if(tst_taint_check(TST_TAINT_W | TST_TAINT_D))
> + *		tst_res(TFAIL, "kernel has issues");
> + *	else
> + *		tst_res(TPASS, "kernel seems to be fine");
> + * }
> + *
> + *
> + *
> + * The above code checks, if the kernel issued a warning (TST_TAINT_W)
> + * or even died (TST_TAINT_D). If these are set durin execution of a
> + * test case, we most likely triggered a kernel bug.
> + */
> +
> +#ifndef TST_TAINTED_H__
> +#define TST_TAINTED_H__
> +
> +/*
> + * This are all 17 flags that are present in kernel 4.15
> + * see kernel/panic.c in kernel sources
> + *
> + * Not all of them are valid in all kernel versions.
> + */
> +#define TST_TAINT_G     (1 <<  0) /* a module with non-GPL license loaded */
> +#define TST_TAINT_F     (1 <<  1) /* a module was force-loaded */
> +#define TST_TAINT_S     (1 <<  2) /* SMP with Non-SMP kernel */
> +#define TST_TAINT_R     (1 <<  3) /* module force unloaded */
> +#define TST_TAINT_M     (1 <<  4) /* machine check error occurred */
> +#define TST_TAINT_B     (1 <<  5) /* page-release function found bad page */
> +#define TST_TAINT_U     (1 <<  6) /* user requested taint flag */
> +#define TST_TAINT_D     (1 <<  7) /* kernel died recently - OOPS or BUG */
> +#define TST_TAINT_A     (1 <<  8) /* ACPI table has been overwritten */
> +#define TST_TAINT_W     (1 <<  9) /* a warning has been issued by kernel */
> +#define TST_TAINT_C     (1 << 10) /* driver from drivers/staging was loaded */
> +#define TST_TAINT_I     (1 << 11) /* working around BIOS/Firmware bug */
> +#define TST_TAINT_O     (1 << 12) /* out of tree module loaded */
> +#define TST_TAINT_E     (1 << 13) /* unsigned module was loaded */
> +#define TST_TAINT_L     (1 << 14) /* A soft lock-up has previously occurred */
> +#define TST_TAINT_K     (1 << 15) /* kernel has been live-patched */
> +#define TST_TAINT_X	(1 << 16) /* auxiliary taint, for distro's use */
> +
> +/*
> + * check if kernel is recent enough to support the tainted-flags that
> + * allow us to check if the kernel issued a warning or died.
> + * This _must_ be called before calling other functions!
> + *
> + * returns 1 if supported, 0 otherwise
> + */
> +int tst_taint_supported(void);
> +
> +
> +/*
> + * read /proc/sys/kernel/tainted and check if at least one of the
> + * bits specified in mask is set.
> + * mask is required to be > 0. Use tst_taint_read() in order to check
> + * for absence of any tainted flags.
> + *
> + * returns 1 if at least one bit of mask is set in
> + * /proc/sys/kernel/tainted, 0 otherwise.
> + * (unsigned int) -1 is returned if mask is zero or tst_taint_supported
> + * was not called before
> + */
> +int tst_taint_check_mask(unsigned int mask);
> +
> +
> +/*
> + * read /proc/sys/kernel/tainted and return the value
> + */
> +unsigned int tst_taint_read(void);
> +
> +#endif /* TST_TAINTED_H__ */
> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> new file mode 100644
> index 000000000..de9093976
> --- /dev/null
> +++ b/lib/tst_taint.c
> @@ -0,0 +1,52 @@
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include "tst_test.h"
> +#include "tst_taint.h"
> +#include "tst_safe_stdio.h"
> +
> +#define TAINT_FILE "/proc/sys/kernel/tainted"
> +
> +static int taint_supported = -1;
> +
> +int tst_taint_supported(void)
> +{
> +	if (tst_kvercmp(2, 6, 26) < 0) {
> +		tst_res(TINFO, "Kernel version prior to 2.6.26 detected.\n");
> +		tst_res(TINFO, "please check kernel output manually\n");

Actually we skip the test if kernel is too old, so the second tst_res()
message does to make much sense.

> +		taint_supported = 0;
> +	} else
> +		taint_supported = 1;
> +
> +	return taint_supported;
> +}
> +
> +unsigned int tst_taint_read(void)
> +{
> +	unsigned int val;
> +
> +	if (taint_supported == -1) {
> +		tst_brk(TCONF, "call tst_taint_supported() before tst_taint_read()");
                         ^
			 This is definitelly TBROK == test broken, since
			 we are calling functions out of order.

> +		return (unsigned int) -1;

Actually we will never got here, so we may as well remove the return
here.

> +	}
> +	SAFE_FILE_SCANF(TAINT_FILE, "%u", &val);
> +
> +	return val;
> +}
> +
> +int tst_taint_check_mask(unsigned int mask)
> +{
> +	unsigned int taint;
> +
> +	taint = tst_taint_read();
> +	if (taint == (unsigned int) -1)
> +		return -1;

Here as well no need to check the return value against -1 since
tst_taint_read() will exit anyways.

> +	if (mask == 0) {
> +		tst_brk(TCONF, "mask is not allowed to be 0");
> +		return  -1;
> +	}

This should be done before we attempt to read the the tainted file, also
no need for the return, tst_brk() will exit the test.

> +	if ((taint & mask) != 0)
> +		return 1;
> +
> +	return 0;
> +}
> -- 
> 2.13.6
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
