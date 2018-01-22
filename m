From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jan 2018 16:39:42 +0100
Subject: [LTP] [RFC PATCH] Add library support for
 /proc/sys/kernel/tainted
In-Reply-To: <20180122131218.26407-1-mmoese@suse.de>
References: <20180122131218.26407-1-mmoese@suse.de>
Message-ID: <20180122153942.GA17451@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * check if kernel is recent enough to support the tainted-flags that
> + * allow us to check if the kernel issued a warning or died
> + *
> + * returns 1 if supported, 0 otherwise
> + */
> +int tst_taint_supported(void);
> +
> +/*
> + * read /proc/sys/kernel/tainted and return the value
> + * this function allows to be called even when the relevant flags are
> + * unsupported.
> + *
> + * returns bitmask of taint flag, or (unsigned int) -1 on read error.
> + */
> +unsigned int tst_taint_read(void);
> +
> +/*
> + * a small helper function to check if flags specified by mask are set
> + *
> + * returns 1 if at least one of the flags is set, 0 otherwise
> + */
> +int tst_taint_check_mask(unsigned int taint, unsigned int mask);
> +
> +#endif /* TST_TAINTED_H__ */

This patch lacks information on how this API is supposed to be used
which is quite important for the review. What I mean is that, while
important, the documentation for the function parameters and return
values is not enough. What should be included is some sketch code of
this is supposed to be used from an actual test source.

> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> new file mode 100644
> index 000000000..38bf355ec
> --- /dev/null
> +++ b/lib/tst_taint.c
> @@ -0,0 +1,69 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/utsname.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +#include <linux/version.h>
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
> +	struct utsname uname_data;
> +	int maj, min, patch;
> +
> +	if (uname(&uname_data) == -1)
> +		return -1;
> +
> +	if (sscanf(uname_data.release, "%d.%d.%d-", &maj, &min, &patch) != 3)
> +		fprintf(stderr, "error parsing uname information\n");
> +
> +	if ((maj < 2) || ((maj == 2) && (min < 26))) {
> +		fprintf(stderr, "Kernel version prior to 2.6.26 detected.\n");
> +		fprintf(stderr, "please check kernel output manually\n");

These messages should go out via tst_res().

> +		taint_supported = 0;
> +	} else
> +		taint_supported = 1;

We have tst_kvercmp() exactly for this purpose, see include/tst_kvercmp.h

> +	return taint_supported;
> +}
> +
> +unsigned int tst_taint_read(void)
> +{
> +	int fd;
> +	unsigned int val;
> +	char buffer[11];
> +
> +	if (taint_supported == -1)
> +		tst_taint_supported();

So this will only cause warning to be printed into the stderr, then we
go ahead and read the file? Shouldn't we just tst_brk(TCONF, "") at this
point?

> +	buffer[10] = 0;
> +
> +	fd = SAFE_OPEN(TAINT_FILE, O_RDONLY);
> +
> +	val = read(fd, buffer, 10);
> +	SAFE_CLOSE(fd);
> +	if (val == -1) {
> +		fprintf(stderr, "unable to read %s\n", TAINT_FILE);
> +		return (unsigned int) -1;
> +	}
> +	val = safe_atoi(buffer);

What about using SAFE_FILE_SCANF() instead?

> +	return val;
> +}
> +
> +int tst_taint_check_mask(unsigned int taint, unsigned int mask)
> +{
> +	if ((taint & mask) != 0)
> +		return 1;
> +	return 0;
> +}

Hmm, should this be combined with the read function?

-- 
Cyril Hrubis
chrubis@suse.cz
