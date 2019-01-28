From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Jan 2019 17:12:12 +0100
Subject: [LTP] [PATCH 1/2] lib: Add library functions to check specified
 cgroup subsystem
In-Reply-To: <1548654851-19112-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1548654851-19112-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190128161211.GA11600@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1) Check if specified cgroup subsystem is supported.
> 2) Check if specified cgroup subsystem is mounted by default, and use
>    custom mountpoint as the cgroup subsystem's mountpoint properly.
> 3) Add doc for these library functions.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  doc/test-writing-guidelines.txt |  45 +++++++++++++++++
>  include/tst_cgroups.h           |  13 +++++
>  lib/tst_cgroups.c               | 107 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+)
>  create mode 100644 include/tst_cgroups.h
>  create mode 100644 lib/tst_cgroups.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 731be76..57ae6aa 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1539,6 +1539,51 @@ static struct tst_test test = {
>  };
>  -------------------------------------------------------------------------------
>  
> +2.2.29 Parsing specified cgroup subsystem
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +void tst_set_cgroup_mntpoint(char *subsys_name, char *spec_mntpoint);

This function name is a bit misleading as it actually mounts the cgroup.

> +void tst_umount_cgroup(char *spec_mntpoint);
> +
> +The 'tst_set_cgroup_mntpoint()' function checks if 'subsys_name' (i.e. specified
> +cgroup subsystem) is supported and mounted by default, and uses 'spec_mntpoint'
> +(custom mountpoint) as 'subsys_name' mountpoint to test.  For details:
> +1) It exits with TCONF if 'subsys_name' is not supported.
> +2) If 'subsys_name' is already mounted to a mountpoint, it creates a symlink
> +   named by 'spec_mntpoint' to the pre-existent mountpoint.
> +3) If 'subsys_name' is not mounted, it mounts 'subsys_name' to 'spec_mntpoint'.
> +
> +The 'tst_umount_cgroup()' function unmounts and removes 'spec_mntpoint'.
> +
> +Note:
> +We should set .needs_tmpdir flag because we create 'spec_mntpoint' in tmpdir.

Generally this is a great step forward but what this is missing:

* Automatic cleanup, if tests creates any subdirectories in the cgroup
  filesystem these will stay there until the machine is rebooted

  I guess that it will be much easier to create the interface so that it
  returns a path to a newly created subdirectory in the cgroup
  filesystem tree so that we can remove it recursively later on

* Interface in tst_test structure. I suppose that we may add something
  as const char *needs_cgroup; to the tst_test structure which would
  be set to subsystem name such as:

  static struct tst_test test = {
	...
	.needs_cgroup = "memory",
	...
  };

  And the test will then set const char *tst_cgroup_path pointer to the
  actuall path to the cgroup.

* I do wonder if we will nedd support for more than one cgroup type
  later on, but so far I do not see that need so keeping it as an
  interface for a single subsytem type will suffice.

> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +#include "tst_cgroups.h"
> +
> +static void setup(void)
> +{
> +	...
> +	tst_set_cgroups_mntpoint("memory", "mntpoint");
> +	...
> +}
> +
> +static void cleanup(void)
> +{
> +	...
> +	tst_umount_cgroup("mntpoint");
> +	...
> +}
> +
> +sturct tst_test test = {
> +        ...
> +        .setup = setup,
> +        .cleanup = cleanup,
> +        ...
> +};
> +-------------------------------------------------------------------------------
>  
>  2.3 Writing a testcase in shell
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/include/tst_cgroups.h b/include/tst_cgroups.h
> new file mode 100644
> index 0000000..70f5d18
> --- /dev/null
> +++ b/include/tst_cgroups.h
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */
> +
> +#ifndef TST_CGROUPS_H__
> +#define TST_CGROUPS_H__
> +
> +void tst_set_cgroup_mntpoint(char *subsys_name, char *spec_mntpoint);
> +void tst_umount_cgroup(char *spec_mntpoint);
> +
> +#endif	/* TST_CGROUPS_H__ */
> diff --git a/lib/tst_cgroups.c b/lib/tst_cgroups.c
> new file mode 100644
> index 0000000..dd027c5
> --- /dev/null
> +++ b/lib/tst_cgroups.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <mntent.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +#define CGROUPS_PATH	"/proc/cgroups"
> +#define MOUNTS_PATH	"/proc/mounts"
> +
> +static char *cgroup_mntpoint;
> +static int cgroup_mounted;
> +
> +void tst_umount_cgroup(char *spec_mntpoint)
> +{
> +	char buf[1024];
> +
> +	if (cgroup_mntpoint) {
> +		if (!access(spec_mntpoint, F_OK))
> +			SAFE_UNLINK(spec_mntpoint);
> +		return;
> +	}
> +
> +	if (cgroup_mounted) {
> +		/* 'spec_mntpoint' may be treated as source instead
> +		 * of target, so append '/' to 'spec_mntpoint'.  See
> +		 * ltp commit 4617249 for details.
> +		 */
> +		sprintf(buf, "%s/", spec_mntpoint);
> +		SAFE_UMOUNT(buf);
> +		cgroup_mounted = 0;
> +	}
> +
> +	if (!access(spec_mntpoint, F_OK))
> +		SAFE_RMDIR(spec_mntpoint);
> +}
> +
> +void tst_set_cgroup_mntpoint(char *subsys_name, char *spec_mntpoint)
> +{
> +	FILE *fp = NULL, *mp = NULL;
> +	struct mntent *mnt;
> +	char buf[1024], name[64];
> +	int enabled = 0, supported = 0;
> +
> +	if (access(CGROUPS_PATH, F_OK))
> +		tst_brk(TCONF, "Kernel didn't support for control groups");
> +
> +	fp = SAFE_FOPEN(CGROUPS_PATH, "r");
> +
> +	while (fgets(buf, 1024, fp)) {
> +		if (sscanf(buf, "%s %*d %*d %d", name, &enabled) == -1) {
> +			SAFE_FCLOSE(fp);
> +			tst_brk(TBROK | TERRNO,
> +				"sscanf() failed to read %s info",
> +				subsys_name);
> +		}
> +
> +		if (!strcmp(name, subsys_name)) {
> +			supported++;
> +			break;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(fp);
> +
> +	if (!supported || !enabled) {
> +		tst_brk(TCONF,
> +			"%s wasn't supported by kernel or it wasn't enabled",
> +			subsys_name);
> +	}
> +
> +	mp = setmntent(MOUNTS_PATH, "r");
> +	if (mp == NULL) {
> +		tst_brk(TBROK | TERRNO,
> +			"setmntent() failed to open /proc/mounts");
> +	}
> +
> +	while ((mnt = getmntent(mp))) {
> +		if (hasmntopt(mnt, subsys_name)) {
> +			cgroup_mntpoint = mnt->mnt_dir;
> +			break;
> +		}
> +	}
> +
> +	endmntent(mp);
> +
> +	if (cgroup_mntpoint) {
> +		/* Use pre-existent subsys mountpoint and creat a symlink
> +		 * named by spec_mntpoint to it.
> +		 */
> +		SAFE_SYMLINK(cgroup_mntpoint, spec_mntpoint);
> +	} else {
> +		/* Mount subsys to spec_mntpoint. */
> +		SAFE_MKDIR(spec_mntpoint, 0777);
> +		SAFE_MOUNT("none", spec_mntpoint, "cgroup", 0, subsys_name);
> +		cgroup_mounted = 1;
> +	}
> +}
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
