Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xxwhk-0006xO-DV
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 11:42:16 +0000
Date: Mon, 8 Dec 2014 12:42:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208114200.GB11071@rei.suse.de>
References: <1417713657-2556-1-git-send-email-alexey.kodanev@oracle.com>
	<1417713657-2556-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417713657-2556-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] device-drivers/cpufreq: add intel_pstate
 driver to boost test
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

On Thu, Dec 04, 2014 at 08:20:57PM +0300, Alexey Kodanev wrote:
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  .../kernel/device-drivers/cpufreq/cpufreq_boost.c  |   67 +++++++++++---------
>  1 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> index 423188e..941e4db 100644
> --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.

This should rather be "Copyright (c) 2013-2014 ..."

>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> @@ -37,22 +37,33 @@
>  #include "safe_macros.h"
>  #include "safe_stdio.h"
>  
> -char *TCID = "ltp_acpi_cpufreq";
> +char *TCID = "cpufreq_boost";
>  
>  #define SYSFS_CPU_DIR "/sys/devices/system/cpu/"
>  
> -const char boost[]	= SYSFS_CPU_DIR "cpufreq/boost";
> +struct cpufreq_driver_info {
> +	char *name;
> +	int off;
> +	char *on_str;
> +	char *off_str;
> +	char *file;
> +};
> +static const struct cpufreq_driver_info cdrv[] = {
> +	{ "acpi_cpufreq", 0, "1", "0", SYSFS_CPU_DIR "cpufreq/boost" },
> +	{ "intel_pstate", 1, "0", "1", SYSFS_CPU_DIR "intel_pstate/no_turbo" },
> +};
> +static int id = -1;
> +
>  static int boost_value;
>  
>  const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
>  static char governor_name[16];
>  
> -const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
>  const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
>  
>  static void cleanup(void)
>  {
> -	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
> +	SAFE_FILE_PRINTF(NULL, cdrv[id].file, "%d", boost_value);
>  
>  	if (governor[0] != '\0')
>  		SAFE_FILE_PRINTF(NULL, governor, "%s", governor_name);
> @@ -63,22 +74,32 @@ static void cleanup(void)
>  static void setup(void)
>  {
>  	int fd;
> +	unsigned int i;
>  	tst_require_root(NULL);
>  
> -	fd = open(boost, O_RDWR);
> -	if (fd == -1) {
> -		tst_brkm(TCONF, NULL,
> -			"acpi-cpufreq not loaded or overclock not supported");
> +	for (i = 0; i < ARRAY_SIZE(cdrv); ++i) {
> +		fd = open(cdrv[i].file, O_RDWR);
> +		if (fd == -1)
> +			continue;
> +
> +		id = i;
> +		close(fd);

Will simple access() suffice here or do we have to actually open the
file?


Otherwise it looks Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
