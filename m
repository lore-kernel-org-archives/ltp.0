From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 6 Nov 2018 11:56:21 +0800
Subject: [LTP] [PATCH v3] lib: new tst_test field to save and restore
 proc|sys
In-Reply-To: <86f0d3dcbf24e6ceabd39db41da85c6d5549d649.1541404595.git.jstancek@redhat.com>
References: <86f0d3dcbf24e6ceabd39db41da85c6d5549d649.1541404595.git.jstancek@redhat.com>
Message-ID: <5BE110E5.4000002@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/11/05 16:00, Jan Stancek wrote:
> To avoid adding specially crafted functions for every feature
> where we need to save/restore some proc/sys config, this patch
> introduces a new field to tst_test struct where user specifies
> NULL terminated array of strings whose values should be saved
> before test and restored after.
>
> Signed-off-by: Jan Stancek<jstancek@redhat.com>
> ---
> Changes in v3:
>   - make list single linked
>   - drop list parameter, all functions use one single list
>
>   doc/test-writing-guidelines.txt |  37 +++++++++++++++
>   include/tst_sys_conf.h          |  21 +++++++++
>   include/tst_test.h              |   7 +++
>   lib/newlib_tests/.gitignore     |   1 +
>   lib/newlib_tests/test19.c       |  48 +++++++++++++++++++
>   lib/tst_sys_conf.c              | 100 ++++++++++++++++++++++++++++++++++++++++
>   lib/tst_test.c                  |  13 ++++++
>   7 files changed, 227 insertions(+)
>   create mode 100644 include/tst_sys_conf.h
>   create mode 100644 lib/newlib_tests/test19.c
>   create mode 100644 lib/tst_sys_conf.c
>
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index f590896472d1..d0b91c36294c 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1468,6 +1468,43 @@ first missing driver.
>   Since it relies on modprobe command, the check will be skipped if the command
>   itself is not available on the system.
>
> +2.2.27 Saving&  restoring /proc|sys values
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +LTP library can be instructed to save and restore value of specified
> +(/proc|sys) files. This is achieved by initialized tst_test struct
> +field 'save_restore'. It is a NULL terminated array of strings where
> +each string represents a file, whose value is saved at the beginning
> +and restored at the end of the test. Only first line of a specified
> +file is saved and restored.
> +
> +Pathnames can be optionally prefixed to specify how strictly (during
> +'store') are handled files that don't exist:
> +  (no prefix) - test ends with TCONF
> +  '?'         - test prints info message and continues
> +  '!'         - test ends with TBROK
> +
> +'restore' is always strict and will TWARN if it encounters any error.
> +
> +Example:
> +
> +static const char *save_restore[] = {
> +	"/proc/sys/kernel/core_pattern",
> +	NULL,
> +};
> +
> +static void setup(void)
> +{
> +	FILE_PRINTF("/proc/sys/kernel/core_pattern", "/mypath");
> +}
> +
> +static struct tst_test test = {
> +	...
> +	.setup = setup,
> +	.save_restore = save_restore,
> +};
> +
> +
>   2.3 Writing a testcase in shell
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
> new file mode 100644
> index 000000000000..784a94dbe37c
> --- /dev/null
> +++ b/include/tst_sys_conf.h
> @@ -0,0 +1,21 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2018 Jan Stancek<jstancek@redhat.com>
> + */
> +
> +#ifndef TST_SYS_CONF_H__
> +#define TST_SYS_CONF_H__
> +
> +struct tst_sys_conf {
> +	char path[PATH_MAX];
> +	char value[PATH_MAX];
> +	struct tst_sys_conf *next;
> +};
> +
> +int tst_sys_conf_save_str(const char *path, const char *value);
> +int tst_sys_conf_save(const char *path);
> +void tst_sys_conf_restore(int verbose);
> +void tst_sys_conf_dump(void);
> +
> +#endif
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 080b0171d5f2..2ebf746eb720 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -42,6 +42,7 @@
>   #include "tst_minmax.h"
>   #include "tst_get_bad_addr.h"
>   #include "tst_path_has_mnt_flags.h"
> +#include "tst_sys_conf.h"
>
>   /*
>    * Reports testcase result.
> @@ -175,6 +176,12 @@ struct tst_test {
>
>   	/* NULL terminated array of needed kernel drivers */
>   	const char * const *needs_drivers;
> +
> +	/*
> +	 * NULL terminated array of (/proc, /sys) files to save
> +	 * before setup and restore after cleanup
> +	 */
> +	const char * const *save_restore;
>   };
>
>   /*
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index 76e89e438f55..c702644f0d1c 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -20,6 +20,7 @@ tst_res_hexd
>   tst_strstatus
>   test17
>   test18
> +test19
>   tst_expiration_timer
>   test_exec
>   test_exec_child
> diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
> new file mode 100644
> index 000000000000..37fc8e9e0227
> --- /dev/null
> +++ b/lib/newlib_tests/test19.c
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (c) 2018, Linux Test Project
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
> + * along with this program. If not, see<http://www.gnu.org/licenses/>.
> + */
> +
> +#include<stdlib.h>
> +#include<unistd.h>
> +#include "tst_test.h"
> +#include "tst_sys_conf.h"
> +
> +static char orig[1024];
> +
> +static const char * const save_restore[] = {
> +	"?/proc/nonexistent",
> +	"!/proc/sys/kernel/numa_balancing",
> +	"/proc/sys/kernel/core_pattern",
> +	NULL,
> +};
> +
> +static void setup(void)
> +{
> +	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%s", orig);
> +	SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
> +}
Hi Jan,

Why do you save the value of core_pattern by SAFE_FILE_SCANF() ?
It seems that the .save_restore flag has done it.
> +
> +static void run(void)
> +{
> +	tst_res(TPASS, "OK");
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.save_restore = save_restore,
> +};
> diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> new file mode 100644
> index 000000000000..893ef9d5c74b
> --- /dev/null
> +++ b/lib/tst_sys_conf.c
> @@ -0,0 +1,100 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2018 Jan Stancek<jstancek@redhat.com>
> + */
> +
> +#include<limits.h>
> +#include<stdio.h>
> +#include<unistd.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_sys_conf.h"
> +
> +static struct tst_sys_conf save_restore_data;
> +
> +void tst_sys_conf_dump(void)
> +{
> +	struct tst_sys_conf *i = save_restore_data.next;
> +
> +	while (i) {
> +		tst_res(TINFO, "%s ->  %s", i->path, i->value);
> +		i = i->next;
> +	}
> +}
> +
> +int tst_sys_conf_save_str(const char *path, const char *value)
> +{
> +	struct tst_sys_conf *n = SAFE_MALLOC(sizeof(*n));
> +
> +	strncpy(n->path, path, sizeof(n->path));
> +	strncpy(n->value, value, sizeof(n->value));
> +
> +	/* add new entry at the beginning, right after 'c' */
Does this comment need to be updated?

Best Regards,
Xiao Yang
> +	n->next = save_restore_data.next;
> +	save_restore_data.next = n;
> +
> +	return 0;
> +}
> +
> +int tst_sys_conf_save(const char *path)
> +{
> +	char line[PATH_MAX];
> +	FILE *fp;
> +	void *ret;
> +	char flag;
> +
> +	if (!path)
> +		tst_brk(TBROK, "path is empty");
> +
> +	flag = path[0];
> +	if (flag  == '?' || flag == '!')
> +		path++;
> +
> +	if (access(path, F_OK) != 0) {
> +		switch (flag) {
> +		case '?':
> +			tst_res(TINFO, "Path not found: '%s'", path);
> +			break;
> +		case '!':
> +			tst_brk(TBROK|TERRNO, "Path not found: '%s'", path);
> +			break;
> +		default:
> +			tst_brk(TCONF|TERRNO, "Path not found: '%s'", path);
> +		}
> +		return 1;
> +	}
> +
> +	fp = fopen(path, "r");
> +	if (fp == NULL) {
> +		tst_brk(TBROK | TERRNO, "Failed to open FILE '%s' for reading",
> +			path);
> +		return 1;
> +	}
> +
> +	ret = fgets(line, sizeof(line), fp);
> +	fclose(fp);
> +
> +	if (ret == NULL) {
> +		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
> +			path);
> +	}
> +
> +	return tst_sys_conf_save_str(path, line);
> +}
> +
> +void tst_sys_conf_restore(int verbose)
> +{
> +	struct tst_sys_conf *i = save_restore_data.next;
> +
> +	while (i) {
> +		if (verbose) {
> +			tst_res(TINFO, "Restoring conf.: %s ->  %s\n",
> +				i->path, i->value);
> +		}
> +		FILE_PRINTF(i->path, "%s", i->value);
> +		i = i->next;
> +	}
> +}
> +
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 117e61462d30..661fbbfce003 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -35,6 +35,7 @@
>   #include "tst_timer_test.h"
>   #include "tst_clocks.h"
>   #include "tst_timer.h"
> +#include "tst_sys_conf.h"
>
>   #include "old_resource.h"
>   #include "old_device.h"
> @@ -809,6 +810,15 @@ static void do_setup(int argc, char *argv[])
>   	if (needs_tmpdir()&&  !tst_tmpdir_created())
>   		tst_tmpdir();
>
> +	if (tst_test->save_restore) {
> +		const char * const *name = tst_test->save_restore;
> +
> +		while (*name) {
> +			tst_sys_conf_save(*name);
> +			name++;
> +		}
> +	}
> +
>   	if (tst_test->mntpoint)
>   		SAFE_MKDIR(tst_test->mntpoint, 0777);
>
> @@ -885,6 +895,9 @@ static void do_cleanup(void)
>   		tst_rmdir();
>   	}
>
> +	if (tst_test->save_restore)
> +		tst_sys_conf_restore(0);
> +
>   	cleanup_ipc();
>   }
>



