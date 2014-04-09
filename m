Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WXppl-0006fH-DI
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 10:34:21 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WXppj-0005qv-Tq
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 10:34:21 +0000
Date: Wed, 9 Apr 2014 06:34:08 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <472091851.2162463.1397039648410.JavaMail.zimbra@redhat.com>
In-Reply-To: <1397015193-18623-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397015193-18623-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3] lib/tst_path_has_mnt_flags.c: create a
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
To: gux fnst <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "gux fnst" <gux.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 9 April, 2014 5:46:34 AM
> Subject: [LTP] [PATCH v3] lib/tst_path_has_mnt_flags.c: create a function tst_path_has_mnt_flags()
> 
> Create a function tst_path_has_mnt_flags() for checking whether
> a path is on a system that is mounted with specified flags.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  include/test.h               |  9 +++++
>  lib/tst_path_has_mnt_flags.c | 79
>  ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 lib/tst_path_has_mnt_flags.c
> 
> diff --git a/include/test.h b/include/test.h
> index baa3ef6..39bc5a1 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -295,6 +295,15 @@ gid_t tst_get_unused_gid(void);
>  unsigned short tst_get_unused_port(void (cleanup_fn)(void),
>  	unsigned short family, int type);
>  
> +/* lib/tst_path_has_mnt_flags.c
> + *
> + * Check whether a path is on a filesystem that is mounted with
> + * specified flags.
> + * @path: path to file
> + * @flags: mount flags
> + */
> +int tst_path_has_mnt_flags(const char *path, const char *flags[]);
> +
>  #ifdef TST_USE_COMPAT16_SYSCALL
>  #define TCID_BIT_SUFFIX "_16"
>  #elif  TST_USE_NEWER64_SYSCALL
> diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
> new file mode 100644
> index 0000000..abd71b0
> --- /dev/null
> +++ b/lib/tst_path_has_mnt_flags.c
> @@ -0,0 +1,79 @@
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
> +#include "test.h"

Hi,

Minor nit here, I'd also add includes for printf and strlen:
+#include <stdio.h>
+#include <string.h>

> +
> +/*
> + * Check whether a path is on a filesystem that is mounted with
> + * specified flags.
> + *
> + * Returns:
> + *   -1 - an error has occurred
> + *   0 - the filesystem does not have any specified flags
> + *   1 - the filesystem has at least one flag matched
> + */
> +int tst_path_has_mnt_flags(const char *path, const char *flags[])
> +{
> +	struct mntent *mnt;
> +	size_t prefix_max = 0, prefix_len;
> +	int has_flags = 0, has_opt;
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
> +			has_opt = 0;
> +			i = 0;
> +			while ((has_opt == 0) && (flags[i] != NULL)) {
> +				has_opt = hasmntopt(mnt, flags[i]) != NULL;
> +				i++;
> +			}
> +			has_flags = has_opt;
> +		}
> +	}
> +
> +	endmntent(f);
> +
> +	return has_flags;
> +}

This function looks OK for one testcase that needs to check for
OR logic between flags. I was thinking, whether we should change
this function to return number matched flags. That way we could
also check easily for AND logic (matches all flags) if we need
that in future.


  * Returns:
  *   -1 - an error has occurred
  *   0 - the filesystem does not have any specified flags
- *   1 - the filesystem has at least one flag matched
+ *   1..n - number of flags matched
  */
 int tst_path_has_mnt_flags(const char *path, const char *flags[])
 {
        struct mntent *mnt;
        size_t prefix_max = 0, prefix_len;
-       int has_flags = 0, has_opt;
+       int flags_matched = 0;
        FILE *f;
        int i;
 
@@ -63,17 +65,24 @@ int tst_path_has_mnt_flags(const char *path, const char *flags[])
                if (strncmp(path, mnt->mnt_dir, prefix_len) == 0
                                && prefix_len > prefix_max) {
                        prefix_max = prefix_len;
-                       has_opt = 0;
+                       flags_matched = 0;
                        i = 0;
-                       while ((has_opt == 0) && (flags[i] != NULL)) {
-                               has_opt = hasmntopt(mnt, flags[i]) != NULL;
+                       while (flags[i] != NULL) {
+                               if (hasmntopt(mnt, flags[i]) != NULL)
+                                       flags_matched++;
                                i++;
                        }
-                       has_flags = has_opt;
                }
        }
 
        endmntent(f);
 
-       return has_flags;
+       return flags_matched;
+}

What do you think?

Regards,
Jan

> --
> 1.8.3.1
> ------------------------------------------------------------------------------
> Put Bad Developers to Shame
> Dominate Development with Jenkins Continuous Integration
> Continuously Automate Build, Test & Deployment
> Start a new project now. Try Jenkins in the cloud.
> http://p.sf.net/sfu/13600_Cloudbees
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
