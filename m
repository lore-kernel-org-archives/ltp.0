Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgdkC-0007b7-6r
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 16:56:44 +0000
Date: Wed, 13 Nov 2013 17:56:29 +0100
From: chrubis@suse.cz
Message-ID: <20131113165629.GB12406@rei.Home>
References: <1383910521-12669-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383910521-12669-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: acpi: add new test for
 acpi-cpufreq driver
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
> The test checks support for disabling dynamic overclocking
> in acpi_cpufreq driver.
> Linux commit: 615b7300717b9ad5c23d1f391843484fe30f6c12.
> It were implemented in Linux 3.7.
     ^
     was

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/kernel/device-drivers/acpi/.gitignore    |    1 +
>  testcases/kernel/device-drivers/acpi/Makefile      |    4 +-
>  .../kernel/device-drivers/acpi/ltp_acpi_cpufreq.c  |  199 ++++++++++++++++++++
>  3 files changed, 203 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
> 
> diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcases/kernel/device-drivers/acpi/.gitignore
> index 76fbdc8..7061be3 100644
> --- a/testcases/kernel/device-drivers/acpi/.gitignore
> +++ b/testcases/kernel/device-drivers/acpi/.gitignore
> @@ -1,5 +1,6 @@
>  /LtpAcpiCmds.ko
>  /ltp_acpi
> +/ltp_acpi_cpufreq
>  /*.mod.c
>  /modules.order
>  /.tmp_versions
> diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/kernel/device-drivers/acpi/Makefile
> index b62eb0b..47ef8c6 100644
> --- a/testcases/kernel/device-drivers/acpi/Makefile
> +++ b/testcases/kernel/device-drivers/acpi/Makefile
> @@ -25,7 +25,9 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  REQ_VERSION_MAJOR	:= 2
>  REQ_VERSION_PATCH	:= 6
> -MAKE_TARGETS		:= ltp_acpi LtpAcpiCmds.ko
> +MAKE_TARGETS		:= ltp_acpi_cpufreq ltp_acpi LtpAcpiCmds.ko
> +
> +LDLIBS			+= -lpthread

Ideally you should set the LDLIBS selectively for the ltp_acpi_cpufreq,
does something like:

ltp_acpi_cpufreq: LDLIBS += -lpthread

work?

>  include $(top_srcdir)/include/mk/module.mk
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
> new file mode 100644
> index 0000000..08092df
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
> @@ -0,0 +1,199 @@
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
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * Check support for disabling dynamic overclocking in acpi_cpufreq driver.
> + * Required Linux 3.7+.
> + *
> + * The test loads CPU0 in a thread. When the loading approaches to the end
> + * (2/3 elapsed), the test will check processor frequency. if boost is enabled
> + * we can get a slightly higher speed under load.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sched.h>
> +#include <sys/time.h>
> +#include <pthread.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "safe_stdio.h"
> +
> +char *TCID = "ltp_acpi_cpufreq";
> +
> +#define SYSFS_CPU_DIR "/sys/devices/system/cpu/"
> +
> +const char boost[]	= SYSFS_CPU_DIR "cpufreq/boost";
> +static int boost_value;
> +
> +const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> +static char governor_name[16];
> +
> +const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
> +const char curspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/cpuinfo_cur_freq";
> +const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> +
> +const char up_limit[]	= SYSFS_CPU_DIR "cpufreq/ondemand/up_threshold";
> +static int threshold;
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
> +
> +	if (governor[0] != '\0')
> +		SAFE_FILE_PRINTF(NULL, governor, "%s", governor_name);
> +
> +	if (threshold)
> +		SAFE_FILE_PRINTF(NULL, up_limit, "%d", threshold);
> +
> +	TEST_CLEANUP;
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"disable overclocking required Linux 3.7+");
> +		return;

The returns here are useless, the tst_brkm() calls tst_exit() which
calls exit().

> +	}
> +
> +	if (access(boost, R_OK | W_OK)) {
> +		tst_brkm(TCONF, NULL,
> +			"acpi-cpufreq not loaded or overclock not supported");
> +		return;
> +	}

Does this test need a machine with specific ACPI implementation?

I've haven't been able to find a machine to run the test on, either the
governor is not acpi-cpufreq or the boost file is missing.

> +	SAFE_FILE_SCANF(NULL, boost, "%d", &boost_value);
> +
> +	SAFE_FILE_SCANF(NULL, up_limit, "%d", &threshold);
> +
> +	/* change cpu0 scaling governor */
> +	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
> +	SAFE_FILE_PRINTF(cleanup, governor, "%s", "userspace");
> +
> +	/* use only cpu0 */
> +	cpu_set_t set;
> +	CPU_ZERO(&set);
> +	CPU_SET(0, &set);
> +	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
> +
> +	SAFE_FILE_PRINTF(cleanup, up_limit, "11");
> +}
> +
> +static void set_speed(int freq)
> +{
> +	int set_freq;
> +	SAFE_FILE_SCANF(cleanup, setspeed, "%d", &set_freq);
> +
> +	if (set_freq != freq) {
> +		tst_resm(TINFO, "change speed from %d to %d...",
> +			set_freq, freq);
> +		SAFE_FILE_PRINTF(cleanup, setspeed, "%d", freq);
> +	} else {
> +		tst_resm(TINFO, "set speed is %d", set_freq);
> +	}
> +}
> +
> +void *thread_fn(void *val)
> +{
> +	struct timeval tv_start;
> +	struct timeval tv_end;
> +	int i, res = 0;
> +	intptr_t timeout = (intptr_t) val;
> +
> +	gettimeofday(&tv_start, NULL);
> +	tst_resm(TINFO, "load CPU0 for %ld sec...", timeout);
> +
> +	do {
> +		for (i = 1; i < 1000; ++i)
> +			res += i * i;
> +		gettimeofday(&tv_end, NULL);
> +	} while ((tv_end.tv_sec - tv_start.tv_sec) < timeout);
> +
> +	tst_resm(TINFO, "CPU0 load done: insignificant value '%d'", res);
> +
> +	return NULL;
> +}
> +
> +static int load_cpu(intptr_t timeout)
> +{
> +	pthread_t thread_id;
> +
> +	if (pthread_create(&thread_id, 0, thread_fn,
> +		(intptr_t *) timeout) != 0) {

I would cast it to (void*) here, the value is intptr_t which guarantees
that casting it to pointer does not clobber the value and that it's
suitably aligned, then you can cast it to (void*) so that passing it as
parameter does not generate warning.

> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"pthread_create failed at %s:%d",
> +			__FILE__, __LINE__);
> +	}
> +
> +	sleep(2 * timeout / 3);
> +
> +	int cur_freq;
> +	SAFE_FILE_SCANF(cleanup, curspeed, "%d", &cur_freq);
> +	tst_resm(TINFO, "got cpu freq under load: %d", cur_freq);
> +
> +	pthread_join(thread_id, NULL);
> +
> +	return cur_freq;
> +}
> +
> +static void test_run(void)
> +{
> +	int cur_freq, max_freq;
> +	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq);
> +	set_speed(max_freq);
> +
> +	/* Enable boost */
> +	if (boost_value == 0)
> +		SAFE_FILE_PRINTF(cleanup, boost, "1");
> +	cur_freq = load_cpu(30);
> +	tst_resm((cur_freq >= max_freq) ? TPASS : TFAIL,
> +		"compare current speed %d and max speed %d",
> +		cur_freq, max_freq);
> +
> +	/* Disable boost */
> +	SAFE_FILE_PRINTF(cleanup, boost, "0");
> +	cur_freq = load_cpu(30);
> +	tst_resm((cur_freq < max_freq) ? TPASS : TFAIL,
> +		"compare current speed %d and max speed %d",
> +		cur_freq, max_freq);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"Test must be run with kernel 3.7 or newer");
> +	}
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	setup();
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}

Minus the minor issues the test looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
