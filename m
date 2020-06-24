From: Carlos Hernandez <ceh@ti.com>
Date: Wed, 24 Jun 2020 14:16:25 -0400
Subject: [LTP] [PATCH 1/2] tst_test: Add support for device discovery
In-Reply-To: <20200623112827.10744-2-chrubis@suse.cz>
References: <20200623112827.10744-1-chrubis@suse.cz>
 <20200623112827.10744-2-chrubis@suse.cz>
Message-ID: <a1189d10-1539-2486-3d78-ede985d0f79e@ti.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for looking at this problem...

I think we a need:

1) A common way to define Hardware capabilities, i.e. UART_RX and 
UART_TX in your example.

I suspect for device-driver tests, ltp would be called by a test 
automation framework. It should be the test automation framework 
responsibility to setup the equipment per the HW capabilities requested 
by the test.

So from ltp point of view, the only requirement is to advertise the 
required capabilities. Of course, this implies a common understanding of 
the capabilities' tags.


2) A way to set platform-specific values when required. Ideally the test 
logic can figure out the values to use dynamically but for some test 
cases, it is required to statically defined them based on the platform 
the test is running on.

In ltp-ddt we added this functionality as platform overrides 
http://arago-project.org/git/projects/?p=test-automation/ltp-ddt.git;a=blob;f=README-DDT;h=78b79cd3ca0f66a6ef30b5dc05737188c146a9ca;hb=HEAD#l46, 
borrowing an idea from OE/Yocto world. I think a different approach 
where these info is maintained in a separate file with an API that it is 
called by the test case logic would work. However, I think that this 
information is not lab-specific but board-specific and it should be part 
of ltp.


Regards,

Carlos


On 6/23/20 7:28 AM, Cyril Hrubis wrote:
> Device discovery
> ----------------
>
> The problem
> -----------
>
> Each lab has a different hardware capabilities and configuration. A test
> that heavily depends on a hardware needs to get this information in
> order to be able to run correctly.
>
> The solution
> ------------
>
> The test declares which devices it needs for a testing. In the uart test
> these are UART_RX and UART_TX which are two UART endpoints which are
> connected together.
>
> This information is then passed as a parameter to a device-discovery.sh
> script that prints, possibly several lines, of device listrs, which is
> then parsed by the test library and the test is executed accordingly.
>
> The data are passed to the test as a environment variables, if these are
> set prior to the test start, we do not even attempt to do a device
> discovery. If these are unset, we run the device discovery and loop the
> test around the lists we got.
>
> Why this solution?
> ------------------
>
> The device discovery is lab specific and does not belong to the test
> itself. This is an attempt to abstract the interface between the test
> and the hardware so that we can finally add device drivers tests into
> LTP.
>
> Missing pieces
> --------------
>
> There are stil a few missing pieces, but these are probably easy to fix
> as well.
>
> Device reconfiguration
> ~~~~~~~~~~~~~~~~~~~~~~
>
> I suppose that we may need to run a command so that the devices are
> reconfigured as we need them. I.e. the device-discovery.sh will have to
> output a comand that needs to be executed in order to prepare the
> physical environment e.g. relays in case of the UART.
>
> Device parameters
> ~~~~~~~~~~~~~~~~~
>
> We may as well need some extra info about the devices, e.g. is hardware
> flow connected in case of UART. So the device-discover.sh will add one
> more environment variable e.g. UART_PARS="hwflow" that could be parsed
> in the test as well.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   device-discovery.sh |   5 +
>   include/tst_test.h  |   3 +
>   lib/tst_devices.c   | 228 ++++++++++++++++++++++++++++++++++++++++++++
>   lib/tst_devices.h   |  32 +++++++
>   lib/tst_test.c      |  60 ++++++++++--
>   5 files changed, 321 insertions(+), 7 deletions(-)
>   create mode 100755 device-discovery.sh
>   create mode 100644 lib/tst_devices.c
>   create mode 100644 lib/tst_devices.h
>
> diff --git a/device-discovery.sh b/device-discovery.sh
> new file mode 100755
> index 000000000..08460c41f
> --- /dev/null
> +++ b/device-discovery.sh
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +if [ "$1" = "UART_RX-UART_TX" ]; then
> +	echo "UART_RX=/dev/ttyUSB0 UART_TX=/dev/ttyUSB0"
> +fi
> diff --git a/include/tst_test.h b/include/tst_test.h
> index b84f7b9dd..3c3693098 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -215,6 +215,9 @@ struct tst_test {
>   	/* NULL terminated array of needed kernel drivers */
>   	const char * const *needs_drivers;
>   
> +	/* NULL terminated array of devices */
> +	const char *const *needs_devices;
> +
>   	/*
>   	 * NULL terminated array of (/proc, /sys) files to save
>   	 * before setup and restore after cleanup
> diff --git a/lib/tst_devices.c b/lib/tst_devices.c
> new file mode 100644
> index 000000000..087e2021b
> --- /dev/null
> +++ b/lib/tst_devices.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*
> + * Device discovery code.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "tst_devices.h"
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +struct tst_devlist {
> +	struct tst_devlist *next;
> +	unsigned int dev_cnt;
> +	char *devs[];
> +};
> +
> +static char *create_devstr(const char *const needs_devices[])
> +{
> +	unsigned int i;
> +	size_t len = 1;
> +
> +	for (i = 0; needs_devices[i]; i++)
> +		len += strlen(needs_devices[i]) + 1;
> +
> +	char *res = malloc(len);
> +
> +	if (!res) {
> +		tst_res(TWARN | TERRNO, "Malloc failed");
> +		return NULL;
> +	}
> +
> +	char *p = res;
> +
> +	for (i = 0; needs_devices[i]; i++) {
> +		strcpy(p, needs_devices[i]);
> +		p += strlen(needs_devices[i]);
> +		if (needs_devices[i+1]) {
> +			p[0] = '-';
> +			p++;
> +		}
> +	}
> +
> +	tst_res(TINFO, "Device discovery string '%s'", res);
> +
> +	return res;
> +}
> +
> +static int get_index(const char *env, const char *const needs_devices[])
> +{
> +	char *p = strdup(env);
> +	char *save;
> +	char *name = strtok_r(p, "=", &save);
> +	unsigned int i;
> +
> +	for (i = 0; needs_devices[i]; i++)
> +		if (!strcmp(needs_devices[i], name))
> +			return i;
> +
> +	return -1;
> +}
> +
> +static unsigned int count_devices(const char *const needs_devices[])
> +{
> +	unsigned int i = 0;
> +
> +	while (needs_devices[i])
> +		i++;
> +
> +	return i;
> +}
> +
> +static struct tst_devlist *new_devlist(char *devices[], unsigned int dev_cnt,
> +                                       const char *const needs_devices[])
> +{
> +	unsigned int i;
> +	int incomplete = 0;
> +
> +	for (i = 0; i < dev_cnt; i++) {
> +		if (!devices[i]) {
> +			tst_res(TWARN, "Missing env var '%s'", needs_devices[i]);
> +			incomplete = 1;
> +		}
> +	}
> +
> +	if (incomplete)
> +		goto err;
> +
> +	struct tst_devlist *new = malloc(sizeof(struct tst_devlist) + dev_cnt * sizeof(void*));
> +
> +	if (!new) {
> +		tst_res(TWARN, "Malloc failed");
> +		goto err;
> +	}
> +
> +	for (i = 0; i < dev_cnt; i++)
> +		new->devs[i] = devices[i];
> +
> +	new->dev_cnt = dev_cnt;
> +
> +	return new;
> +err:
> +	for (i = 0; needs_devices[i]; i++)
> +		free(devices[i]);
> +
> +	return NULL;
> +}
> +
> +struct tst_devlist *tst_devlist_discover(const char *const needs_devices[])
> +{
> +	const char *ltproot = getenv("LTPROOT");
> +	const char *device_discovery = getenv("DEVICE_DISCOVERY");
> +	char buf[2048];
> +	struct tst_devlist *root = NULL;
> +
> +	if (!device_discovery) {
> +		if (!ltproot) {
> +			tst_res(TCONF, "No LTPROOT nor DEVICE_DISCOVERY set!");
> +			return NULL;
> +		}
> +
> +		snprintf(buf, sizeof(buf), "%s/device-discovery.sh", ltproot);
> +
> +		device_discovery = buf;
> +	}
> +
> +	char *devstr = create_devstr(needs_devices);
> +
> +	if (!devstr)
> +		return NULL;
> +
> +	char *cmdline = malloc(strlen(buf) + strlen(devstr) + 3);
> +
> +	if (!cmdline) {
> +		tst_res(TWARN | TERRNO, "Malloc failed");
> +		return NULL;
> +	}
> +
> +	sprintf(cmdline, "%s \"%s\"", device_discovery, devstr);
> +
> +	free(devstr);
> +
> +	FILE *pipe = popen(cmdline, "r");
> +
> +	unsigned int dev_cnt = count_devices(needs_devices);
> +	char *devices[dev_cnt];
> +	unsigned int devlist_cnt = 0;
> +
> +	memset(devices, 0, sizeof(devices));
> +
> +	while (fgets(buf, sizeof(buf), pipe)) {
> +		char *tok, *save, *str = buf;
> +
> +		while ((tok = strtok_r(str, " \n\t", &save))) {
> +			int i = get_index(tok, needs_devices);
> +
> +			if (i < 0) {
> +				tst_res(TWARN, "Invalid env var '%s'", tok);
> +				break;
> +			}
> +
> +			if (devices[i]) {
> +				tst_res(TWARN,
> +				        "Duplicated env var '%s' and '%s'",
> +				        tok, devices[i]);
> +				break;
> +			}
> +
> +			devices[i] = strdup(tok);
> +
> +			str = NULL;
> +		}
> +
> +		struct tst_devlist *list = new_devlist(devices, dev_cnt, needs_devices);
> +
> +		memset(devices, 0, sizeof(devices));
> +
> +		if (!list)
> +			continue;
> +
> +		list->next = root;
> +		root = list;
> +		devlist_cnt++;
> +	}
> +
> +	free(cmdline);
> +
> +	if (!pipe)
> +		tst_res(TWARN | TERRNO, "Failed to execute device discovery");
> +
> +	pclose(pipe);
> +
> +	tst_res(TINFO, "Loaded %i device list(s)", devlist_cnt);
> +
> +	return root;
> +}
> +
> +unsigned int tst_devlist_cnt(struct tst_devlist *self)
> +{
> +	struct tst_devlist *i;
> +	unsigned int cnt = 0;
> +
> +	for (i = self; i; i = i->next)
> +		cnt++;
> +
> +	return cnt;
> +}
> +
> +void tst_devlist_setup(struct tst_devlist *self, unsigned int i)
> +{
> +	struct tst_devlist *l;
> +	unsigned int j, cnt = 0;
> +
> +	for (l = self; l; l = l->next) {
> +		if (i == cnt)
> +			break;
> +		cnt++;
> +	}
> +
> +	for (j = 0; j < l->dev_cnt; j++)
> +		putenv(l->devs[j]);
> +}
> diff --git a/lib/tst_devices.h b/lib/tst_devices.h
> new file mode 100644
> index 000000000..dd0047716
> --- /dev/null
> +++ b/lib/tst_devices.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*
> + * Device discovery code.
> + */
> +
> +#ifndef TST_DEVICES_H__
> +#define TST_DEVICES_H__
> +
> +struct tst_devlist;
> +
> +/*
> + * Attempts to run a device discovery scripts for a given needs_devices list.
> + */
> +struct tst_devlist *tst_devlist_discover(const char *const needs_devices[]);
> +
> +/*
> + * Returns the number of device configurations.
> + */
> +unsigned int tst_devlist_cnt(struct tst_devlist *self);
> +
> +/*
> + * Setups the environment for a device list with index i.
> + *
> + * Exports the device list base on the variables.
> + */
> +void tst_devlist_setup(struct tst_devlist *self, unsigned int i);
> +
> +#endif /* TST_DEVICES_H__ */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e93c88ba5..4ae6d7d52 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -27,6 +27,7 @@
>   #include "tst_wallclock.h"
>   #include "tst_sys_conf.h"
>   #include "tst_kconfig.h"
> +#include "tst_devices.h"
>   
>   #include "old_resource.h"
>   #include "old_device.h"
> @@ -42,6 +43,8 @@ const char *TCID __attribute__((weak));
>   
>   struct tst_test *tst_test;
>   
> +static struct tst_devlist *devlist;
> +
>   static const char *tid;
>   static int iterations = 1;
>   static float duration = -1;
> @@ -471,6 +474,22 @@ static void print_test_tags(void)
>   	printf("\n");
>   }
>   
> +static void print_test_devices(void)
> +{
> +	const char *const *devices = tst_test->needs_devices;
> +	int i;
> +
> +	if (!devices)
> +		return;
> +
> +	printf("\nNeeded devices\n--------------\n");
> +
> +	for (i = 0; devices[i]; i++)
> +		printf("%s\n", devices[i]);
> +
> +	printf("\n");
> +}
> +
>   static void check_option_collision(void)
>   {
>   	unsigned int i, j;
> @@ -550,6 +569,7 @@ static void parse_opts(int argc, char *argv[])
>   		case 'h':
>   			print_help();
>   			print_test_tags();
> +			print_test_devices();
>   			exit(0);
>   		case 'i':
>   			iterations = atoi(optarg);
> @@ -907,6 +927,24 @@ static void do_setup(int argc, char *argv[])
>   				tst_brk(TCONF, "%s driver not available", name);
>   	}
>   
> +	if (tst_test->needs_devices) {
> +		int i;
> +		const char *name;
> +		int all_set = 1;
> +
> +		for (i = 0; (name = tst_test->needs_devices[i]); i++) {
> +			if (!getenv(name))
> +				all_set = 0;
> +		}
> +
> +		if (!all_set) {
> +			devlist = tst_devlist_discover(tst_test->needs_devices);
> +
> +			if (!devlist)
> +				tst_brk(TCONF, "No devices discovered");
> +		}
> +	}
> +
>   	if (tst_test->format_device)
>   		tst_test->needs_device = 1;
>   
> @@ -1335,6 +1373,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   {
>   	int ret = 0;
>   	unsigned int test_variants = 1;
> +	unsigned int dev_list, device_lists;
>   
>   	lib_pid = getpid();
>   	tst_test = self;
> @@ -1349,14 +1388,21 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   	if (tst_test->test_variants)
>   		test_variants = tst_test->test_variants;
>   
> -	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
> -		if (tst_test->all_filesystems)
> -			ret |= run_tcases_per_fs();
> -		else
> -			ret |= fork_testrun();
> +	device_lists = tst_devlist_cnt(devlist);
> +
> +	for (dev_list = 0; dev_list < device_lists; dev_list++) {
>   
> -		if (ret & ~(TCONF))
> -			goto exit;
> +		tst_devlist_setup(devlist, dev_list);
> +
> +		for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
> +			if (tst_test->all_filesystems)
> +				ret |= run_tcases_per_fs();
> +			else
> +				ret |= fork_testrun();
> +
> +			if (ret & ~(TCONF))
> +				goto exit;
> +		}
>   	}
>   
>   exit:

-- 
Carlos

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200624/de24e95a/attachment-0001.htm>
