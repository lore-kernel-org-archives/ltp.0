From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Mar 2020 16:25:12 +0100
Subject: [LTP] [PATCH] Add test for CVE 2018-1000204
In-Reply-To: <20200302140815.21440-1-mdoucha@suse.cz>
References: <20200302140815.21440-1-mdoucha@suse.cz>
Message-ID: <20200309152512.GB24110@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> Patch resolves GH issue #334.

I do not think that this will work, as far as I can tell everything
after the --- is cut off on git am.

>  runtest/cve                                  |   1 +
>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 133 +++++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> 
> diff --git a/runtest/cve b/runtest/cve
> index 57cf66075..e522b8096 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -39,4 +39,5 @@ cve-2017-18075 pcrypt_aead01
>  cve-2017-1000380 snd_timer01
>  cve-2018-5803 sctp_big_chunk
>  cve-2018-1000001 realpath01
> +cve-2018-1000204 ioctl_sg01
>  cve-2018-19854 crypto_user01
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> new file mode 100644
> index 000000000..c3947afbc
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
> + */
> +
> +/*
> + * CVE-2018-1000204
> + *
> + * Test ioctl(SG_IO) and check that kernel doesn't leak data. Requires
> + * a read-accessible SCSI-compatible device (e.g. SATA disk). Running mem01
> + * test program before this one may increase the chance of successfully
> + * reproducing the bug.
> + *
> + * Leak fixed in:
> + *
> + *  commit a45b599ad808c3c982fdcdc12b0b8611c2f92824
> + *  Author: Alexander Potapenko <glider@google.com>
> + *  Date:   Fri May 18 16:23:18 2018 +0200
> + *
> + *  scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
> + */
> +
> +#include <sys/types.h>
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +#include <scsi/sg.h>
> +#include <sys/ioctl.h>
> +#include "tst_test.h"
> +
> +#define BUF_SIZE 128 * 4096
> +#define CMD_SIZE 6
> +
> +static int devfd = -1;
> +static char buffer[BUF_SIZE];
> +static unsigned char command[CMD_SIZE];
> +static struct sg_io_hdr query;
> +
> +/* TODO: split this off to a separate SCSI library? */
> +static const char *find_generic_scsi_device(int access_flags)
> +{
> +	DIR *devdir;
> +	struct dirent *ent;
> +	char *filename;
> +	size_t path_len;
> +	int tmpfd;
> +	static char devpath[PATH_MAX];
> +
> +	errno = 0;
> +	strcpy(devpath, "/dev/");
> +	devdir = opendir(devpath);
> +	path_len = strlen(devpath);
> +	filename = devpath + path_len;
> +
> +	if (!devdir) {
> +		return NULL;
> +	}

Btw LKML coding style mandates no curly braces over single line
statements, that is unless we are in else branch and the if branch has
them.

> +	while ((ent = SAFE_READDIR(devdir))) {
> +		/* The bug is most likely reproducible only on /dev/sg* */
> +		if (strncmp(ent->d_name, "sg", 2) || !isdigit(ent->d_name[2]))
> +			continue;
> +
> +		strncpy(filename, ent->d_name, PATH_MAX - path_len - 1);

Can we please just do a single snprintf() here instead of the string
hackery we do above?

This is hardly a time critical code so I would prefer more readable code
over these optimizations.

> +		/* access() makes incorrect assumptions about block devices */
> +		tmpfd = open(devpath, access_flags);
> +
> +		if (tmpfd >= 0) {
> +			SAFE_CLOSE(tmpfd);
> +			SAFE_CLOSEDIR(devdir);
> +			return devpath;
> +		}
> +	}
> +
> +	SAFE_CLOSEDIR(devdir);
> +	return NULL;
> +}

Other than that the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
