From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Aug 2017 15:47:14 +0200
Subject: [LTP] [PATCH v3 3/3] Test for CVE-2016-10044 mark AIO pseudo-fs
 noexec
In-Reply-To: <20170801132701.16317-3-rpalethorpe@suse.com>
References: <20170801132701.16317-1-rpalethorpe@suse.com>
 <20170801132701.16317-3-rpalethorpe@suse.com>
Message-ID: <20170804134714.GB7915@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"
> +#include "tst_personality.h"
> +#include "tst_safe_stdio.h"
> +
> +#define CONV_STR "%*x-%*x %s7"
> +
> +static FILE *f;
> +
> +static void cleanup(void)
> +{
> +	if (f != NULL)

Could be just

	if (f)
		SAFE_CLOSE(f);

> +		SAFE_FCLOSE(f);
> +}
> +
> +static void run(void)
> +{
> +	uint64_t ctx = 0;
> +	pid_t pid = getpid();
> +	char perms[8], line[BUFSIZ];
> +	char maps_path[256];
> +
> +	SAFE_PERSONALITY(READ_IMPLIES_EXEC);
> +	if (tst_syscall(__NR_io_setup, 1, &ctx))
> +		tst_brk(TBROK | TERRNO, "Failed to create AIO context");
> +
> +	snprintf(maps_path, sizeof(maps_path), "/proc/%d/maps", pid);

You can use the "/proc/self/maps" insetad and save yourself getpid() and
snprintf().

> +	f = SAFE_FOPEN(maps_path, "r");
> +	while (fgets(line, BUFSIZ, f) != NULL) {
> +		if (strstr(line, "/[aio]") != NULL)
> +			goto found_mapping;
> +	}

Here again, the != NULL is redundant.

> +	tst_brk(TBROK, "Could not find mapping in %s", maps_path);
> +
> +found_mapping:
> +	if (sscanf(line, CONV_STR, perms) < 0)
> +		tst_brk(TBROK, "failed find permission string in %s", line);

I fail to see why is the CONV_STR defined as a macro?

It's not like we use it twice or something.

> +	if (strchr(perms, (int)'x'))
> +		tst_res(TFAIL, "AIO mapping is executable: %s!", perms);
> +	else
> +		tst_res(TPASS, "AIO mapping is not executable: %s", perms);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.min_kver = "2.6.8",
> +};
> -- 
> 2.13.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
