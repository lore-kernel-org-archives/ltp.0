From: Sandeep Patil <sspatil@google.com>
Date: Thu, 9 Nov 2017 10:50:24 -0800
Subject: [LTP] [PATCH v3 05/16] lib/tst_fs: Add tst_fill_fs()
In-Reply-To: <20171011144130.29728-5-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
 <20171011144130.29728-5-chrubis@suse.cz>
Message-ID: <20171109185024.GM12564@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 11, 2017 at 04:41:19PM +0200, Cyril Hrubis wrote:
> Adds a simple helper to fill a filesystem.
> 
> All the funciton does is to create and write to files in a given

s/funciton/function

> directory until write() fails with ENOSPC.
> 
> This is intended to be used in various filesystem related tests such as
> fallocate and stress tests.

Couple of other use cases
 - To fill a filesystem would be to create nested directories for EMLINK
   testing in order to test file system limit(s) (e.g. syscalls/mkdir)
 - Filling a filesystem with empty files (e.g syscalls/rename etc )

 That said, the function can be expanded to do this at a later time as well
 based on the function parameters.


> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fs.h  |  5 +++++
>  lib/tst_fill_fs.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 lib/tst_fill_fs.c
> 
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index 1f6d2bab5..0ad535c2b 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -151,6 +151,11 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
>   */
>  const char **tst_get_supported_fs_types(void);
>  
> +/*
> + * Creates and writes to files on given path until write fails with ENOSPC
> + */
> +void tst_fill_fs(const char *path, int verbose);
> +
>  #ifdef TST_TEST_H__
>  static inline long tst_fs_type(const char *path)
>  {
> diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
> new file mode 100644
> index 000000000..6b2bbbcd7
> --- /dev/null
> +++ b/lib/tst_fill_fs.c
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_fs.h"
> +
> +void tst_fill_fs(const char *path, int verbose)
> +{
> +	int i = 0;
> +	char file[PATH_MAX];
> +	char buf[4096];
> +	size_t len;
> +	ssize_t ret;
> +	int fd;
> +
> +	for (;;) {
> +		len = random() % (1024 * 102400);
> +
> +		snprintf(file, sizeof(file), "%s/file%i", path, i++);
> +
> +		if (verbose)
> +			tst_res(TINFO, "Creating file %s size %zu", file, len);
> +
> +		fd = SAFE_OPEN(file, O_WRONLY | O_CREAT, 0700);
> +
> +		while (len) {
> +			ret = write(fd, buf, MIN(len, sizeof(buf)));
> +
> +			if (ret < 0) {
> +				SAFE_CLOSE(fd);
> +
> +				if (errno != ENOSPC)
> +					tst_brk(TBROK | TERRNO, "write()");
> +
> +				tst_res(TINFO | TERRNO, "write()");
> +				return;
> +			}
> +
> +			len -= ret;
> +		}
> +
> +		SAFE_CLOSE(fd);
> +	}
> +}

Reviewed-by: Sandeep Patil <sspatil@google.com>

> -- 
> 2.13.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
