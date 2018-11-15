From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 15 Nov 2018 18:57:36 +0000
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <20181115134441.27359-1-chrubis@suse.cz>
References: <20181115134441.27359-1-chrubis@suse.cz>
Message-ID: <4a063677-8a43-2737-b9af-3459a57fa3f5@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

On 15/11/2018 13:44, Cyril Hrubis wrote:
> This is meant as last resort action for disabling tests if certain
> kernel funcitonality was not present, in general case runtime checks are
> prefered.
> 
> For functionality that can be build as a module tst_check_driver() is
> most likely better fit since it will also insert requested kernel module
> into kernel if needed.
> 
> For newly added syscalls kernel version comparsion and/or checking errno
> is prefered.
> 
> However in rare cases certain core kernel functionality cannot be
> detected in any other way than checking the kernel config, which is
> where this API gets into the play.
> 
> The path to the kernel config could be specified by LTP_KCONFIG
> environment variable, which also takes precedence before the
> autodetection that attempts to read the config from known locations.
> 
> The required kernel options are passed as an array of strings via the
> .needs_kconfigs pointer in the tst_test structure. The purpose of this
> is twofold, one is that the test can disable itself at runtime if given
> functionality is missing from kernel .config and second is about being
> able to propagate this information to the testrunner (this could be done
> once we figure out how export the information from the structure to the
> test runner) then we can avoid running tests on unsuitable
> configurations from the start.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Pengfei Xu <pengfei.xu@intel.com>
> CC: automated-testing@yoctoproject.org
> ---

this morning I was just thinking about brutally zcatting config.gz to be 
able to skip some tests based upon current Kernel configs (not 
drivers/moduleoptions)...and I'd need a mechanism to do that...then I 
saw this patch :D

So I picked up your patch in my local tree for testing, but given that I 
would need all of the above checks inside a shell testcase, I tried 
building something on top of it.

FAR FROM BEING A FINAL PATCH...this adds the kconfig shell helper and my 
test case fix together...just to try...


diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh 
b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index 04b7af922..dd8f68ac4 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -53,6 +53,11 @@ if tst_kvcmp -lt "2.6.25"; then
          exit 32
  fi

+if ! tst_check_kconfigs CONFIG_QFMT_V1 CONFIG_QFMT_V2; then
+        tst_resm TCONF "Kernel QUOTA Options NOT configured!"
+        exit 32
+fi
+
  if [ ! -d /proc/sys/fs/quota ]; then
          tst_resm TCONF "Quota not supported in kernel!"
          exit 0
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index e1dea3b05..21f64b215 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -28,6 +28,6 @@ INSTALL_TARGETS               := *.sh

  MAKE_TARGETS           := tst_sleep tst_random tst_checkpoint tst_rod 
tst_kvcmp\
                            tst_device tst_net_iface_prefix 
tst_net_ip_prefix tst_net_vars\
-                          tst_getconf tst_supported_fs tst_check_drivers
+                          tst_getconf tst_supported_fs 
tst_check_drivers tst_check_kconfigs

  include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_check_kconfigs.c 
b/testcases/lib/tst_check_kconfigs.c
new file mode 100644
index 000000000..71129e547
--- /dev/null
+++ b/testcases/lib/tst_check_kconfigs.c
@@ -0,0 +1,50 @@
+/*
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include <stdio.h>
+#include <stdlib.h>
+#include <tst_test.h>
+#include <tst_kconfig.h>
+
+int main(int argc, const char **argv)
+{
+       int missing = 0;
+       const char **cfg = NULL;
+
+       if (argc < 2)
+               return -1;
+
+       for (cfg = &argv[1]; !missing && *cfg; cfg++) {
+               char rval = '\0';
+
+               fprintf(stderr, "Check for: %s\n", *cfg);
+               rval = tst_kconfig(*cfg);
+               switch (rval) {
+               case 'y':
+               case 'm':
+                       tst_res(TINFO, "Kernel %s found", *cfg);
+                       break;
+               default:
+                       missing = 1;
+                       tst_res(TINFO, "Kernel is missing %s", *cfg);
+                       break;
+               }
+       }
+
+       return missing;
+}

and it seems to work !

cmdline="quota_remount_test01.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Check for: CONFIG_QFMT_V1
tst_check_kconfigs.c:44: INFO: Kernel is missing CONFIG_QFMT_V1
quota_remount_test01    1  TCONF  :  ltpapicmd.c:188: Kernel QUOTA 
Options NOT configured!
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0

Do you think could be useful ?
Or should be done another way really (I'm brand new to LTP tests...) ?

Thanks

Cristian


>   doc/test-writing-guidelines.txt |  32 +++++++
>   include/tst_kconfig.h           |  34 ++++++++
>   include/tst_test.h              |   6 ++
>   lib/newlib_tests/.gitignore     |   1 +
>   lib/newlib_tests/tst_kconfig.c  |  24 ++++++
>   lib/tst_kconfig.c               | 183 ++++++++++++++++++++++++++++++++++++++++
>   lib/tst_test.c                  |   4 +
>   7 files changed, 284 insertions(+)
>   create mode 100644 include/tst_kconfig.h
>   create mode 100644 lib/newlib_tests/tst_kconfig.c
>   create mode 100644 lib/tst_kconfig.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index d0b91c362..846c39532 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1504,6 +1504,38 @@ static struct tst_test test = {
>   	.save_restore = save_restore,
>   };
>   
> +2.2.28 Parsing kernel .config
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Generally testcases should attempt to autodetect as much kernel features as
> +possible based on the currently running kernel. We do have tst_check_driver()
> +to check if functionality that could be compiled as kernel module is present
> +on the system, disabled syscalls can be detected by checking for 'ENOSYS'
> +errno etc.
> +
> +However in rare cases core kernel features couldn't be detected based on the
> +kernel userspace API and we have to resort on kernel .config parsing.
> +
> +For this cases the test should set the 'NULL' terminated needs_kconfig array
> +of kernel config options required for the test. The test will exit with
> +'TCONF' if any of the required options wasn't set to 'y' or 'm'.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static const char *kconfigs[] = {
> +	"CONFIG_X86_INTEL_UMIP",
> +	NULL
> +};
> +
> +static struct tst_test test = {
> +	...
> +	.needs_kconfigs = kconfigs,
> +	...
> +};
> +-------------------------------------------------------------------------------
> +
>   
>   2.3 Writing a testcase in shell
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> new file mode 100644
> index 000000000..daba808b0
> --- /dev/null
> +++ b/include/tst_kconfig.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#ifndef TST_KCONFIG_H__
> +#define TST_KCONFIG_H__
> +
> +/*
> + * Parses kernel config given a CONFIG_FOO symbol.
> + *
> + * The location of the config is detected automatically in case that the config
> + * lives in one of the standard locations or can be set/overrided by setting
> + * LTP_KCONFIG environment variable.
> + *
> + * The functions returns:
> + *
> + * 'y' -- when compiled in
> + * 'm' -- when compiled as a module
> + * 'v' -- when set to some value e.g. CONFIG_BLK_DEV_RAM_COUNT=16
> + * 'n' -- when not set
> + * 'u' -- when CONFIG_FOO wasn't present in CONFIG
> + * 'e' -- on error i.e. .config couldn't be located
> + */
> +char tst_kconfig(const char *id);
> +
> +/*
> + * Exits the test with TCONF on first config option that is not set to 'm' or 'y'
> + *
> + * @kconfigs: NULL terminated array of kernel config options such as "CONFIG_MMU"
> + */
> +void tst_kconfig_check(const char *const *kconfigs);
> +
> +#endif	/* TST_KCONFIG_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 2ebf746eb..f21687c06 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -182,6 +182,12 @@ struct tst_test {
>   	 * before setup and restore after cleanup
>   	 */
>   	const char * const *save_restore;
> +
> +	/*
> +	 * NULL terminated array of kernel config options required for the
> +	 * test.
> +	 */
> +	const char *const *needs_kconfigs;
>   };
>   
>   /*
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index c702644f0..4052162bf 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -24,3 +24,4 @@ test19
>   tst_expiration_timer
>   test_exec
>   test_exec_child
> +tst_kconfig
> diff --git a/lib/newlib_tests/tst_kconfig.c b/lib/newlib_tests/tst_kconfig.c
> new file mode 100644
> index 000000000..855269366
> --- /dev/null
> +++ b/lib/newlib_tests/tst_kconfig.c
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include "tst_test.h"
> +#include "tst_kconfig.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TPASS, "Not reached!");
> +}
> +
> +static const char *kconfigs[] = {
> +	"CONFIG_MMU",
> +	"CONFIG_EXT4_FS",
> +	/* Comment this to make the test run */
> +	"CONFIG_NONEXISTENT",
> +	NULL
> +};
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_kconfigs = kconfigs,
> +};
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> new file mode 100644
> index 000000000..348767b3d
> --- /dev/null
> +++ b/lib/tst_kconfig.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#ifndef TST_KCONFIG_H__
> +#define TST_KCONFIG_H__
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/utsname.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +static const char *kconfig_path(char *path_buf, size_t path_buf_len)
> +{
> +	const char *path = getenv("LTP_KCONFIG");
> +	struct utsname un;
> +
> +	if (path) {
> +		if (!access(path, F_OK))
> +			return path;
> +
> +		tst_res(TWARN, "LTP_KCONFIG='%s' does not exist", path);
> +	}
> +
> +	if (!access("/proc/config.gz", F_OK))
> +		return "/proc/config.gz";
> +
> +	uname(&un);
> +
> +	snprintf(path_buf, path_buf_len, "/boot/config-%s", un.release);
> +
> +	if (!access(path_buf, F_OK))
> +		return path_buf;
> +
> +	tst_res(TINFO, "Couldn't locate kernel config!");
> +
> +	return NULL;
> +}
> +
> +static char parse_line(const char *line)
> +{
> +	if (strstr(line, "=y"))
> +		return 'y';
> +
> +	if (strstr(line, "=m"))
> +		return 'm';
> +
> +	if (strstr(line, "="))
> +		return 'v';
> +
> +	return 'n';
> +}
> +
> +static char is_gzip;
> +
> +static FILE *open_kconfig(void)
> +{
> +	FILE *fp;
> +	char buf[1024];
> +	char path_buf[1024];
> +	const char *path = kconfig_path(path_buf, sizeof(path_buf));
> +
> +	if (!path)
> +		return NULL;
> +
> +	is_gzip = !!strstr(path, ".gz");
> +
> +	if (is_gzip) {
> +		snprintf(buf, sizeof(buf), "zcat '%s'", path);
> +		fp = popen(buf, "r");
> +	} else {
> +		fp = fopen(path, "r");
> +	}
> +
> +	if (!fp)
> +		tst_brk(TBROK | TERRNO, "Failed to open '%s'", path);
> +
> +	return fp;
> +}
> +
> +static void close_kconfig(FILE *fp)
> +{
> +	if (is_gzip)
> +		pclose(fp);
> +	else
> +		fclose(fp);
> +}
> +
> +static int match_option(const char *line, const char *opt)
> +{
> +	size_t opt_len = strlen(opt);
> +
> +	return !strncmp(line, opt, opt_len) &&
> +		(line[opt_len] == '=' || line[opt_len] == ' ');
> +}
> +
> +char tst_kconfig(const char *id)
> +{
> +	char buf[1024];
> +	char match = 'u';
> +	FILE *fp;
> +
> +	fp = open_kconfig();
> +	if (!fp)
> +		return 'e';
> +
> +	while (fgets(buf, sizeof(buf), fp)) {
> +		if (match_option(buf, id)) {
> +			match = parse_line(buf);
> +			break;
> +		}
> +	}
> +
> +	close_kconfig(fp);
> +
> +	return match;
> +}
> +
> +static unsigned int array_len(const char *const *kconfigs)
> +{
> +	unsigned int i = 0;
> +
> +	while (kconfigs[i])
> +		i++;
> +
> +	return i;
> +}
> +
> +void tst_kconfig_check(const char *const *kconfigs)
> +{
> +	char buf[1024];
> +	FILE *fp;
> +	unsigned int conf_cnt = array_len(kconfigs);
> +	unsigned int conf_match[conf_cnt];
> +	unsigned int i, j;
> +
> +	memset(conf_match, 0, sizeof(conf_match));
> +
> +	fp = open_kconfig();
> +	if (!fp)
> +		tst_brk(TBROK, "Cannot parse kernel .config");
> +
> +	while (fgets(buf, sizeof(buf), fp)) {
> +		for (i = 0; i < conf_cnt; i++) {
> +			if (conf_match[i])
> +				continue;
> +
> +			if (match_option(buf, kconfigs[i]) &&
> +			    (strstr(buf, "=y") || strstr(buf, "=m"))) {
> +				conf_match[i] = 1;
> +
> +				for (j = 0; j < conf_cnt; j++) {
> +					if (!conf_match[j])
> +						break;
> +				}
> +
> +				if (j == i)
> +					goto exit;
> +			}
> +		}
> +
> +	}
> +
> +	int abort_test = 0;
> +
> +	for (i = 0; i < conf_cnt; i++) {
> +		if (!conf_match[i]) {
> +			abort_test = 1;
> +			tst_res(TINFO, "Kernel is missing %s", kconfigs[i]);
> +		}
> +	}
> +
> +	if (abort_test)
> +		tst_brk(TCONF, "Aborting test due to missing kernel config options!");
> +
> +exit:
> +	close_kconfig(fp);
> +}
> +
> +#endif	/* TST_KCONFIG_H__ */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 661fbbfce..da3e0c8a0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -36,6 +36,7 @@
>   #include "tst_clocks.h"
>   #include "tst_timer.h"
>   #include "tst_sys_conf.h"
> +#include "tst_kconfig.h"
>   
>   #include "old_resource.h"
>   #include "old_device.h"
> @@ -770,6 +771,9 @@ static void do_setup(int argc, char *argv[])
>   	if (tst_test->tconf_msg)
>   		tst_brk(TCONF, "%s", tst_test->tconf_msg);
>   
> +	if (tst_test->needs_kconfigs)
> +		tst_kconfig_check(tst_test->needs_kconfigs);
> +
>   	assert_test_fn();
>   
>   	tid = get_tid(argv);
> 

