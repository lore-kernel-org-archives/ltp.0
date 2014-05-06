Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Whj9R-0005Ly-Ck
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 17:27:33 +0000
Date: Tue, 6 May 2014 19:26:34 +0200
From: chrubis@suse.cz
Message-ID: <20140506172634.GA10697@rei>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397202849-5956-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397202849-5956-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 1/2] lib/tst_path_has_mnt_flags.c: create a
 function tst_path_has_mnt_flags()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> +/* lib/tst_path_has_mnt_flags.c
> + *
> + * Check whether a path is on a filesystem that is mounted with
> + * specified flags.
> + * @path: path to file
> + * @flags: mount flags

You should describe that flags is NULL terminated array here.

And add a note about the return value (which is number of flags matched).

> + */
> +int tst_path_has_mnt_flags(const char *path, const char *flags[]);

Looking at the function interface, we may add the clenanup callback
parameter and do tst_brkm(TBROK, ) instead of the return -1. What do you
think?

>  #ifdef TST_USE_COMPAT16_SYSCALL
>  #define TCID_BIT_SUFFIX "_16"
>  #elif  TST_USE_NEWER64_SYSCALL
> diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
> new file mode 100644
> index 0000000..92c7494
> --- /dev/null
> +++ b/lib/tst_path_has_mnt_flags.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <unistd.h>
> +#include <mntent.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include "test.h"
> +
> +/*
> + * Check whether a path is on a filesystem that is mounted with
> + * specified flags.
> + *
> + * Returns:
> + *   -1 - an error has occurred
> + *   0 - the filesystem does not have any specified flags
> + *   1..n - number of flags matched
> + */

I would omit this comment, it's more important to have this description
in the header file (which is where people look) than here.

> +int tst_path_has_mnt_flags(const char *path, const char *flags[])
> +{
> +	struct mntent *mnt;
> +	size_t prefix_max = 0, prefix_len;
> +	int flags_matched = 0;
> +	FILE *f;
> +	int i;
> +
> +	if (path == NULL) {
> +		printf("The path is NULL.\n");
> +		return -1;
> +	}
> +
> +	if (access(path, F_OK) == -1) {
> +		printf("The path %s doesn't exist.\n", path);
> +		return -1;
> +	}
> +
> +	f = setmntent("/proc/mounts", "r");
> +
> +	if (f == NULL) {
> +		printf("Couldn't mount /proc/mounts.\n");
                                 ^
				 open
> +		return -1;
> +	}
> +
> +	while ((mnt = getmntent(f))) {
> +		/* ignore all pseudo fs */
> +		if (mnt->mnt_fsname[0] != '/')
> +			continue;
> +
> +		prefix_len = strlen(mnt->mnt_dir);
> +
> +		if (strncmp(path, mnt->mnt_dir, prefix_len) == 0
> +				&& prefix_len > prefix_max) {
> +			prefix_max = prefix_len;
> +			flags_matched = 0;
> +			i = 0;
> +			while (flags[i] != NULL) {
> +				if (hasmntopt(mnt, flags[i]) != NULL)
> +					flags_matched++;
> +				i++;
> +			}
> +		}
> +	}
> +
> +	endmntent(f);
> +
> +	return flags_matched;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
