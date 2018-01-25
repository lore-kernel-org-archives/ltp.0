From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jan 2018 14:28:15 +0100
Subject: [LTP] [PATCH v2] Add library support for
	/proc/sys/kernel/tainted
In-Reply-To: <20180125121641.26795-1-mmoese@suse.de>
References: <20180125121641.26795-1-mmoese@suse.de>
Message-ID: <20180125132814.GA19878@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_taint.h b/include/tst_taint.h
> new file mode 100644
> index 000000000..89162b44c
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
> + *	...
> + *	tst_taint_init(TST_TAINT_W | TST_TAINT_D));
> + *	...
> + * }
> + *
> + * void run(void)
> + * {
> + *	...
> + *	. test code here
> + *	...
> + *	if(tst_taint_check() != 0)
          ^
	  Missing space, but that is very minor.
> + *		tst_res(TFAIL, "kernel has issues");
> + *	else
> + *		tst_res(TPASS, "kernel seems to be fine");
> + * }
> + *
> + *
> + *
> + * The above code checks, if the kernel issued a warning (TST_TAINT_W)
> + * or even died (TST_TAINT_D) during test execution.
> + * If these are set after running a test case, we most likely
> + * triggered a kernel bug.
> + */

API looks good, nice work.

> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> new file mode 100644
> index 000000000..723a25c0e
> --- /dev/null
> +++ b/lib/tst_taint.c
> @@ -0,0 +1,106 @@
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include "tst_test.h"
> +#include "tst_taint.h"
> +#include "tst_safe_stdio.h"
> +
> +#define TAINT_FILE "/proc/sys/kernel/tainted"
> +
> +static unsigned int taint_mask = -1;
> +
> +static unsigned int tst_taint_read(void)
> +{
> +	unsigned int val;
> +
> +	if (taint_mask == (unsigned int) -1)
> +		tst_brk(TBROK, "need to call tst_taint_init() first");
> +
> +	SAFE_FILE_SCANF(TAINT_FILE, "%u", &val);
> +
> +	return val;
> +}
> +
> +static int tst_taint_check_kver(unsigned int mask)
> +{
> +	int r1;
> +	int r2;
> +	int r3 = 0;
> +
> +	if (mask & TST_TAINT_X) {
> +		r1 = 4;
> +		r2 = 15;
> +	} else if (mask & TST_TAINT_K) {
> +		r1 = 4;
> +		r2 = 0;
> +	} else if (mask & TST_TAINT_L) {
> +		r1 = 3;
> +		r2 = 17;
> +	} else if (mask & TST_TAINT_E) {
> +		r1 = 3;
> +		r2 = 15;
> +	} else if (mask & TST_TAINT_O) {
> +		r1 = 3;
> +		r2 = 2;
> +	} else if (mask & TST_TAINT_I) {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 35;
> +	} else if (mask & TST_TAINT_C) {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 28;
> +	} else if (mask & TST_TAINT_W) {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 26;
> +	} else if (mask & TST_TAINT_A) {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 25;
> +	} else if (mask & TST_TAINT_D) {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 23;
> +	} else if (mask & TST_TAINT_U) {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 21;
> +	} else {
> +		r1 = 2;
> +		r2 = 6;
> +		r3 = 16;
> +	}

I would have probably put these into an array of structures indexed by
the position of the flag bit, but it's fine as it is as well.

> +	return tst_kvercmp(r1, r2, r3);
> +}
> +
> +void tst_taint_init(unsigned int mask)
> +{
> +	unsigned int taint = -1;
> +
> +	if (mask == 0)
> +		tst_brk(TBROK, "mask is not allowed to be 0");
> +
> +	if (tst_taint_check_kver(mask) < 0)
> +		tst_res(TCONF, "Kernel is too old for requested mask");
> +
> +	taint = tst_taint_read();
> +	if ((taint & mask) != 0)
> +		tst_res(TCONF, "Kernel is already tainted: %u", taint);
                          ^
			  I would argue this is TBROK rather than TCONF,
			  since the test is applicable just cannot be
			  run since kernel is tainted already.

			  TCONF means "test not applicable" usually due
			  to unsupported architecture, old kernel, etc.

> +	taint_mask = mask;
> +}
> +
> +
> +unsigned int tst_taint_check(void)
> +{
> +	unsigned int taint = -1;
> +
> +	if (taint_mask == (unsigned int) -1)
> +		tst_brk(TBROK, "need to call tst_taint_init() first");
> +
> +	taint = tst_taint_read();
> +
> +	return (taint & taint_mask);
> +}

Other than the minor things, this version looks good.

Can you please also add a paragraph 2.2.23 with the documentation to the
doc/test-writing-guidelines.txt (asciidoc formatted)?

-- 
Cyril Hrubis
chrubis@suse.cz
