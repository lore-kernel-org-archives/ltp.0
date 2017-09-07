From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Sep 2017 03:48:23 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH 02/15] lib: Add interface to list
	supported	filesystems
In-Reply-To: <20170905160918.6477-2-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
 <20170905160918.6477-2-chrubis@suse.cz>
Message-ID: <493059632.10028491.1504770503631.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> A filesystem is supported if kernel can mount it (we do not get ENODEV
> when we attempt to mount it) and if there is mkfs installed so that we
> can format a test device.
> 
> The function starts with a whitelist of filesystems to use and loops
> over them filtering out unsupported ones, then finally returns a list
> of filesystem that could be used for the testing.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

...

> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> new file mode 100644
> index 000000000..fabc39111
> --- /dev/null
> +++ b/lib/tst_supported_fs_types.c
> @@ -0,0 +1,120 @@
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
> +/*
> + */
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_fs.h"

I'm running into:
  ltp/lib/tst_supported_fs_types.c:54: undefined reference to `WEXITSTATUS'
on older distros, "#include <sys/wait.h>" fixes that.

Regards,
Jan
