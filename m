From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Mar 2020 19:47:03 +0100
Subject: [LTP] [PATCH v2 5/9] syscalls/sysinfo03: Add time namespace test
In-Reply-To: <20200318153801.3529-6-chrubis@suse.cz>
References: <20200318153801.3529-1-chrubis@suse.cz>
 <20200318153801.3529-6-chrubis@suse.cz>
Message-ID: <20200323184703.GA7013@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> +++ b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
...
> +#include <sys/sysinfo.h>
> +#include "lapi/namespaces_constants.h"
> +#include "tst_test.h"
...
> +static void verify_sysinfo(unsigned int n)
> +{
> +	struct sysinfo si;
> +	long uptime;
> +	int off = offsets[n];
> +
> +	SAFE_UNSHARE(CLONE_NEWTIME);
> +
> +        SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
> +	                 CLOCK_BOOTTIME, off);
One more fix needed for CentOS 6 to get missing definition: CLOCK_BOOTTIME

#include "lapi/posix_clocks.h"

Or do we want to finally drop CentOS 6 ? (see [1]).

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2020-March/016164.html
