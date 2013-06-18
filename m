Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uov0O-0007F8-9P
	for ltp-list@lists.sourceforge.net; Tue, 18 Jun 2013 12:27:24 +0000
Date: Tue, 18 Jun 2013 14:28:51 +0200
From: chrubis@suse.cz
Message-ID: <20130618122850.GB6464@rei.suse.cz>
References: <1371474097-17589-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1371474097-17589-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] fw_load: new test of device firmware loading
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/firmware/Makefile b/testcases/kernel/firmware/Makefile
> new file mode 100644
> index 0000000..f6db454
> --- /dev/null
> +++ b/testcases/kernel/firmware/Makefile
> @@ -0,0 +1,45 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +top_srcdir	?= ../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +SUBDIRS			=
> +PROCEED			= 0
> +REQ_VERSION_MAJOR	= 3
> +REQ_VERSION_MINOR	= 7
> +
> +ifeq ($(MAKECMDGOALS),clean)
> +proceed = 1
> +endif
> +
> +ifeq ($(WITH_MODULES),yes)
> +proceed = $(shell expr $(LINUX_VERSION_MAJOR) '>' $(REQ_VERSION_MAJOR))
> +ifeq ($(proceed),0)
> +proceed = $(shell expr $(LINUX_VERSION_MAJOR) '=' $(REQ_VERSION_MAJOR))
> +ifeq ($(proceed),1)
> +proceed = $(shell expr $(LINUX_PATCHLEVEL) '>=' $(REQ_VERSION_MINOR))
> +endif
> +endif
> +endif
> +
> +ifeq ($(proceed),1)
> +SUBDIRS			+= fw_load_kernel
> +SUBDIRS			+= fw_load_user
> +endif
> +
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk

This is OK for now. But once we get more kernel modules to build we
should transition the logic to some include/mk/ file.

Also you initialize PROCEED variable but then go ahead and use lowercase
proceed instead. You should stick to uppercase.

And isn't the proceed value set if make target is clean replaced with
whatever we get later in the ifdefs? Did you mean proceed ?= $(shell
...) there?

> diff --git a/testcases/kernel/firmware/fw_load_kernel/Makefile b/testcases/kernel/firmware/fw_load_kernel/Makefile
> new file mode 100644
> index 0000000..e8d12be
> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
> @@ -0,0 +1,37 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +MODULE		:= fw_load
> +
> +ifneq ($(KERNELRELEASE),)
> +
> +obj-m		:= $(MODULE).o
> +
> +else
> +
> +top_srcdir	?= ../../../..
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +MAKE_TARGETS	:= $(MODULE).ko
> +$(MODULE).ko:
> +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> +	-mv $(MODULE).ko $(MODULE).ko~
> +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
> +	-mv $(MODULE).ko~ $(MODULE).ko
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +endif

Same as the previous one, OK for now may be translated to include/mk/
later.

> diff --git a/testcases/kernel/firmware/fw_load_kernel/README b/testcases/kernel/firmware/fw_load_kernel/README
> new file mode 100644
> index 0000000..320d956
> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_kernel/README
> @@ -0,0 +1,16 @@
> +The aim of the test is to check device firmware loading. Since kernel 3.7
> +firmware loading changed to direct loading (by-pass udev). The test consists
> +of the two parts:
> + - userspace part
> + - kernelspace part
> +
> +This is a kernel module, which is a part of the device firmware loading test.
> +It allows to call request_firmware kernel function with specified parameters.
> +Template firmware file name and expected firmware file's data size are passed
> +as the insmod command line parameters. Then, the number of firmware test files
> +should be written to sysfs file 'fwnum'. This write will initiate request
> +firmware procedure. In the end, results can be read from 'result' device sysfs
> +file. Also, some information regarding module loading, can be obtained by
> +looking at kernel log file.
> +
> +It is automatically used by userspace part of the test.
> diff --git a/testcases/kernel/firmware/fw_load_kernel/fw_load.c b/testcases/kernel/firmware/fw_load_kernel/fw_load.c
> new file mode 100644
> index 0000000..2da9517
> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_kernel/fw_load.c
> @@ -0,0 +1,173 @@

...

> diff --git a/testcases/kernel/firmware/fw_load_user/Makefile b/testcases/kernel/firmware/fw_load_user/Makefile
> new file mode 100644
> index 0000000..effd5da
> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_user/Makefile
> @@ -0,0 +1,20 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/firmware/fw_load_user/README b/testcases/kernel/firmware/fw_load_user/README
> new file mode 100644
> index 0000000..702fac9
> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_user/README
> @@ -0,0 +1,11 @@
> +The aim of the test is to check device firmware loading. Since kernel 3.7
> +firmware loading changed to direct loading (by-pass udev). The test consists
> +of the two parts:
> + - userspace part
> + - kernelspace part
> +
> +This is the userspace part, its tasks are:
> + - create firmware files in the standard firmware paths
> + - load the module and initiate firmware request procedure
> + - read device's result file and print final results
> + - unload the module.
> diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
> new file mode 100644
> index 0000000..943f793
> --- /dev/null
> +++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
> @@ -0,0 +1,242 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * Test checks device firmware loading.
> + */
> +
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +#include <sys/utsname.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +/* number of test firmware files */
> +#define FW_FILES	5
> +
> +char *TCID = "fw_load";
> +int TST_TOTAL = FW_FILES;
> +
> +#define MAX_CMD_LEN	256
> +/* hard coded paths in the kernel */
> +#define FW_PATHS_NUM	4
> +
> +static int fw_size = 0x1000;
> +
> +static const char fw_name[]	= "load_tst.fw";
> +static const char module_name[]	= "fw_load.ko";
> +
> +struct fw_file_info {
> +	char file[PATH_MAX];
> +	char dir[PATH_MAX];
> +	int fake;
> +	int remove_dir;
> +	int remove_file;
> +};
> +
> +static struct fw_file_info fw[FW_FILES];
> +static int fw_num;
> +
> +/* related firmware paths which are searched by kernel */
> +static char fw_paths[FW_PATHS_NUM][PATH_MAX];
> +
> +/* cleanup flags */
> +static int module_registered;
> +
> +/* test options */
> +static char *narg;
> +static int nflag;
> +static int skip_cleanup;
> +static int verbose;
> +static const option_t options[] = {
> +	{"n:", &nflag, &narg},
> +	{"s", &skip_cleanup, NULL},
> +	{"v", &verbose, NULL},
> +	{NULL, NULL, NULL}
> +};
> +
> +static void help(void);
> +static void setup(int argc, char *argv[]);
> +static void test_run(void);
> +static void cleanup(void);
> +
> +/*
> + * create firmware files in the fw_paths
> + * @path: start directory
> + */
> +static void create_firmware(const char *path);
> +
> +int main(int argc, char *argv[])
> +{
> +	setup(argc, argv);
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}
> +
> +static void help(void)
> +{
> +	printf("  -n x    Write x bytes to firmware file, default is %d\n",
> +		fw_size);
> +	printf("  -s      Skip cleanup\n");
> +	printf("  -v      Verbose\n");
> +}
> +
> +void setup(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg = parse_opts(argc, argv, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	if (nflag) {
> +		if (sscanf(narg, "%i", &fw_size) != 1)
> +			tst_brkm(TBROK, NULL, "-n option arg is not a number");
> +		if (fw_size < 0)
> +			tst_brkm(TBROK, NULL, "-n option arg is less than 0");
> +	}
> +
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"Test must be run with kernel 3.7 or newer");
> +	}
> +
> +	if (access(module_name, F_OK) == -1) {
> +		tst_brkm(TCONF, NULL,
> +			"Test requires kernel module '%s'", module_name);
> +	}

Here you expect that the module is in current directory, which is not 
robust enough.

What about creating module_exists() module_load() and module_unload()
library functions?

The path to the module should be determined from LTPROOT env variable,
see lib/tst_resource.c and lib/tst_resource.h that handles similar
situation for files needed by the tests.

> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	/* get current Linux version and make firmware paths */
> +	struct utsname uts_name;
> +	uname(&uts_name);
> +	strcpy(fw_paths[0], "firmware");
> +	strcpy(fw_paths[1], "firmware/updates");
> +	snprintf(fw_paths[2], PATH_MAX, "firmware/%s", uts_name.release);
> +	snprintf(fw_paths[3], PATH_MAX, "firmware/updates/%s",
> +		uts_name.release);
> +
> +	/* copy firmware to hard coded firmware search paths */
> +	create_firmware("/lib");
> +
> +	/* make non-existent firmware file */
> +	snprintf(fw[fw_num].file, PATH_MAX, "n%d_%s", fw_num, fw_name);
> +	fw[fw_num].fake = 1;
> +	++fw_num;
> +}
> +
> +static void test_run()

Missing void.

> +{
> +	/* load test module */
> +	char cmd[MAX_CMD_LEN];
> +	snprintf(cmd, MAX_CMD_LEN, "insmod %s fw_name=%s fw_size=%d",
> +		module_name, fw_name, fw_size);
> +	if (system(cmd) != 0)
> +		tst_brkm(TBROK, cleanup, "Failed to insert %s", module_name);
> +	module_registered = 1;
> +
> +	char dev_path[PATH_MAX];
> +	/* set number of testing firmware files to module */
> +	snprintf(dev_path, PATH_MAX, "/sys/devices/%s/fwnum", TCID);

The TCID string is constant, hardcode it to the path instead of the
snprintf().

> +	SAFE_FILE_PRINTF(cleanup, dev_path, "%d", fw_num);
> +
> +	/* get module results */
> +	snprintf(dev_path, PATH_MAX, "/sys/devices/%s/result", TCID);

Here as well.

> +	int result = 0;
> +	/* read result bit mask */
> +	SAFE_FILE_SCANF(cleanup, dev_path, "%d", &result);
> +
> +	int i, fail;
> +	for (i = 0; i < fw_num; ++i) {
> +		fail = (result & (1 << i)) == 0 && !fw[i].fake;
> +
> +		tst_resm((fail) ? TFAIL : TPASS,
> +			"Expect: %s load firmware '...%s'",
> +			(fw[i].fake) ? "can't" : "can",
> +			fw[i].file + strlen(fw[i].dir));
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (skip_cleanup)
> +		return;
> +	int i;
> +	for (i = fw_num - 1; i >= 0; --i) {

Is there any reason for the loop going backward?

> +		if (fw[i].remove_file && remove(fw[i].file) == -1)
> +			tst_resm(TWARN, "Can't remove: %s", fw[i].file);
> +
> +		if (fw[i].remove_dir && remove(fw[i].dir) == -1)
> +			tst_resm(TWARN, "Can't remove %s", fw[i].dir);
> +	}
> +
> +	if (module_registered) {
> +		char cmd[MAX_CMD_LEN];
> +		snprintf(cmd, MAX_CMD_LEN, "rmmod %s", module_name);
> +		if (system(cmd) != 0)
> +			tst_brkm(TBROK, NULL, "Can't remove %s", module_name);
> +	}
> +
> +	TEST_CLEANUP;
> +}
> +
> +static void create_firmware(const char *path)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(fw_paths); ++i) {
> +		struct fw_file_info *f = &fw[fw_num];
> +		snprintf(f->dir, PATH_MAX, "%s/%s", path, fw_paths[i]);
> +		if (access(f->dir, X_OK) == -1) {
> +			/* create dir */
> +			SAFE_MKDIR(cleanup, f->dir, 0755);
> +			f->remove_dir = 1;
> +		}
> +
> +		/* create test firmware file */
> +		snprintf(f->file, PATH_MAX, "%s/n%d_%s",
> +			f->dir, fw_num, fw_name);
> +
> +		FILE *fd = fopen(f->file, "w");

Naming FILE * variable fd is a little confusing as it suggests file
descriptor. I would settle on simple f instead.

> +		if (fd == NULL)
> +			tst_brkm(TBROK, cleanup, "Failed to create firmware");
> +		int k;
> +		for (k = 0; k < fw_size; ++k)
> +			fputc(fw_num, fd);
> +		fclose(fd);

It's important to check the return value from fclose() here, as the
output is buffered and the data flushed at the fclose() call. I've
looked into the safe_macros.h and it looks like we do not have
SAFE_FCLOSE() yet. I will add the FILE * calls there so that you can use
here.

> +		f->remove_file = 1;
> +		++fw_num;
> +	}
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
