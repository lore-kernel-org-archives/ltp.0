From: Sandeep Patil <sspatil@google.com>
Date: Thu, 9 Nov 2017 10:38:58 -0800
Subject: [LTP] [PATCH v3 02/16] lib: Add interface to list supported
 filesystems
In-Reply-To: <20171011144130.29728-2-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
 <20171011144130.29728-2-chrubis@suse.cz>
Message-ID: <20171109183858.GL12564@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 11, 2017 at 04:41:16PM +0200, Cyril Hrubis wrote:
> A filesystem is supported if kernel can mount it (we do not get ENODEV
> when we attempt to mount it) and if there is mkfs installed so that we
> can format a test device.
> 
> The function starts with a whitelist of filesystems to use and loops
> over them filtering out unsupported ones, then finally returns a list
> of filesystem that could be used for the testing.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fs.h             |   4 ++
>  lib/tst_supported_fs_types.c | 118 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 lib/tst_supported_fs_types.c
> 
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index 52befbec9..1f6d2bab5 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -146,6 +146,10 @@ int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
>   */
>  int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
>  
> +/*
> + * Returns NULL-terminated array of kernel-supported filesystems.
> + */
> +const char **tst_get_supported_fs_types(void);
>  
>  #ifdef TST_TEST_H__
>  static inline long tst_fs_type(const char *path)
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> new file mode 100644
> index 000000000..a23b1ed52
> --- /dev/null
> +++ b/lib/tst_supported_fs_types.c
> @@ -0,0 +1,118 @@
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
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <sys/wait.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_fs.h"
> +
> +static const char *const fs_type_whitelist[] = {
> +	"ext2",
> +	"ext3",
> +	"ext4",
> +	"xfs",
> +	"btrfs",
> +	"vfat",
> +	"exfat",
> +	"ntfs",
> +	NULL
> +};
> +
> +static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];
> +
> +static int has_mkfs(const char *fs_type)
> +{
> +	char buf[128];
> +	int ret;
> +
> +	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
> +
> +	ret = tst_system(buf);
> +
> +	if (WEXITSTATUS(ret) == 127) {
> +		tst_res(TINFO, "mkfs.%s does not exist", fs_type);
> +		return 0;
> +	}
> +
> +	tst_res(TINFO, "mkfs.%s does exist", fs_type);
> +	return 1;
> +}
> +
> +static int has_kernel_support(const char *fs_type)
> +{
> +	static int fuse_supported = -1;
> +	const char *tmpdir = getenv("TMPDIR");
> +	char buf[128];
> +	int ret;
> +
> +	if (!tmpdir)
> +		tmpdir = "/tmp";
> +
> +	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
> +	if (errno != ENODEV) {
> +		tst_res(TINFO, "Kernel supports %s", fs_type);
> +		return 1;
> +	}
> +
> +	/* Is FUSE supported by kernel? */
> +	if (fuse_supported == -1) {
> +		ret = open("/dev/fuse", O_RDWR);
> +		if (ret < 0) {
> +			fuse_supported = 0;
> +		} else {
> +			fuse_supported = 1;
> +			SAFE_CLOSE(ret);
> +		}
> +	}
> +
> +	if (!fuse_supported)
> +		return 0;
> +
> +	/* Is FUSE implementation installed? */
> +	sprintf(buf, "mount.%s >/dev/null 2>&1", fs_type);
> +
> +	ret = tst_system(buf);
> +	if (WEXITSTATUS(ret) == 127) {
> +		tst_res(TINFO, "Filesystem %s is not supported", fs_type);
> +		return 0;
> +	}
> +
> +	tst_res(TINFO, "FUSE does support %s", fs_type);
> +	return 1;
> +}
> +
> +static int is_supported(const char *fs_type)
> +{
> +	return has_kernel_support(fs_type) && has_mkfs(fs_type);
> +}

It will be nice if this was an exported API as well.

Other than that, this is very useful for a bunch of tests
that rely on formatting + mounting devices for error checks.

Acked-by: Sandeep Patil <sspatil@google.com>
