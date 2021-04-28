From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Apr 2021 19:48:23 +0200
Subject: [LTP] [PATCH v4 1/6] API: Add safe openat, printfat,
 readat and unlinkat
In-Reply-To: <20210428142719.8065-2-rpalethorpe@suse.com>
References: <20210428142719.8065-1-rpalethorpe@suse.com>
 <20210428142719.8065-2-rpalethorpe@suse.com>
Message-ID: <YImf5zpy71k1sKqM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Add 'at' variants for a number of system calls and LTP SAFE API
> functions. This avoids using sprintf everywhere to build paths.

> diff --git a/lib/tst_safe_file_at.c b/lib/tst_safe_file_at.c
> new file mode 100644
> index 000000000..a92a48fb2
> --- /dev/null
> +++ b/lib/tst_safe_file_at.c
> @@ -0,0 +1,170 @@
> +#define _GNU_SOURCE
> +#include "lapi/fcntl.h"
> +#include "tst_safe_file_at.h"
This requires <stdio.h> (sprintf).

Also file should have SPDX license + copyright.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +char fd_path[PATH_MAX];
> +
> +char *tst_decode_fd(int fd)
> +{
> +	ssize_t ret;
> +	char proc_path[32];
> +
> +	if (fd < 0)
> +		return "!";
> +
> +	sprintf(proc_path, "/proc/self/fd/%d", fd);
> +	ret = readlink(proc_path, fd_path, sizeof(fd_path));
...
