From: Sandeep Patil <sspatil@google.com>
Date: Thu, 22 Nov 2018 20:56:15 -0800
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <20181115134441.27359-1-chrubis@suse.cz>
References: <20181115134441.27359-1-chrubis@suse.cz>
Message-ID: <20181123045615.GS239052@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 15, 2018 at 02:44:41PM +0100, Cyril Hrubis wrote:
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
>  doc/test-writing-guidelines.txt |  32 +++++++
>  include/tst_kconfig.h           |  34 ++++++++
>  include/tst_test.h              |   6 ++
>  lib/newlib_tests/.gitignore     |   1 +
>  lib/newlib_tests/tst_kconfig.c  |  24 ++++++
>  lib/tst_kconfig.c               | 183 ++++++++++++++++++++++++++++++++++++++++
>  lib/tst_test.c                  |   4 +
>  7 files changed, 284 insertions(+)
>  create mode 100644 include/tst_kconfig.h
>  create mode 100644 lib/newlib_tests/tst_kconfig.c
>  create mode 100644 lib/tst_kconfig.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index d0b91c362..846c39532 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1504,6 +1504,38 @@ static struct tst_test test = {
>  	.save_restore = save_restore,
>  };
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
>  2.3 Writing a testcase in shell
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  	 * before setup and restore after cleanup
>  	 */
>  	const char * const *save_restore;
> +
> +	/*
> +	 * NULL terminated array of kernel config options required for the
> +	 * test.
> +	 */
> +	const char *const *needs_kconfigs;
>  };
>  
>  /*
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index c702644f0..4052162bf 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -24,3 +24,4 @@ test19
>  tst_expiration_timer
>  test_exec
>  test_exec_child
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

<snip>

FWIW, this here covers all of Android now. Android _always_ has
/proc/config.gz and this now allows us to double check the android required
options before running some of those tests. Thanks for doing this :).

Acked-by: Sandeep Patil <sspatil@google.com>
