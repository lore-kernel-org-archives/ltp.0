From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Apr 2020 17:13:06 +0200
Subject: [LTP] [PATCH v2 1/3] testcases/kernel/syscalls/ioctl: Add test
 for RTC ioctls used to read and set RTC time
In-Reply-To: <20200423150626.12672-2-fbozuta1@gmail.com>
References: <20200423150626.12672-1-fbozuta1@gmail.com>
 <20200423150626.12672-2-fbozuta1@gmail.com>
Message-ID: <20200430151306.GA3299@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch tests functionalities of following ioctls:
> 
> RTC_RD_TIME - Getting RTC time
> 
>     Returns this RTC's time in the following structure:
> 
>         struct rtc_time {
>             int tm_sec;
>             int tm_min;
>             int tm_hour;
>             int tm_mday;
>             int tm_mon;
>             int tm_year;
>             int tm_wday;     /* unused */
>             int tm_yday;     /* unused */
>             int tm_isdst;    /* unused */
>         };
> 
>     The fields in this structure have the same meaning and
>     ranges as the tm structure described in gmtime man page.
>     A pointer to this structure should be passed as the third
>     ioctl argument.
> 
> RTC_SET_TIME - Setting RTC time
> 
>     Sets this RTC's time to the time specified by the rtc_time
>     structure pointed to by the third ioctl argument. To set the
>     RTC's time the process must be privileged (i.e., have the
>     CAP_SYS_TIME capability).
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  runtest/syscalls                              |   2 +
>  testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
>  testcases/kernel/syscalls/ioctl/ioctl_rtc01.c | 121 ++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc01.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 44254d7da..c6b8a85ad 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -539,6 +539,8 @@ ioctl_ns07 ioctl_ns07
>  
>  ioctl_sg01 ioctl_sg01
>  
> +ioctl_rtc01 ioctl_rtc01
> +
>  inotify_init1_01 inotify_init1_01
>  inotify_init1_02 inotify_init1_02
>  
> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
> index 97fbb9681..b297407bd 100644
> --- a/testcases/kernel/syscalls/ioctl/.gitignore
> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
> @@ -14,3 +14,4 @@
>  /ioctl_ns06
>  /ioctl_ns07
>  /ioctl_sg01
> +/ioctl_rtc01
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_rtc01.c b/testcases/kernel/syscalls/ioctl/ioctl_rtc01.c
> new file mode 100644
> index 000000000..e097f8f65
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_rtc01.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Filip Bozuta Filip.Bozuta@rt-rk.com
> + */
> +
> +/*
> + * Test RTC ioctls with RTC_RD_TIME and RTC_SET_TIME requests
> + *
> + * Reads the current time from RTC device using RTC_RD_TIME
> + * request and displays the time information as follows:
> + * hour:minute, month day.month.year
> + *
> + * Sets a new time in RTC device using RTC_SET_TIME request
> + * and displays the new time information as follws:
> + * hour:minute, month day.month.year
> + *
> + * Reads the new time from RTC device using RTC_RD_TIME
> + * request and checks whether the read time information
> + * is same as the one set by RTC_SET_TIME
> +
> + * Runs RTC_SET_TIME to set back the current time read by
> + * RTC_RD_TIME at the beginning of the test
> + */
> +
> +#include <stdint.h>
> +#include <errno.h>
> +#include <linux/rtc.h>
> +#include "tst_test.h"
> +
> +static void setup(void)
> +{
> +	int exists = access("/dev/rtc", O_RDONLY);
> +
> +	if (exists < 0)
> +		tst_brk(TCONF, "RTC device driver file not found");

The old LTP test allowed an RTC device to be passed to the test, I
wonder what should we do here. Should we loop over all rtcX devices under
/dev/ by default?

Also the same interface seems to be exported via proc and sysfs, it may make
sense to check that /sys/class/rtc/rtcX/time and date matches the
results from ioctl commands. We do have SAFE_FILE_SCANF() so reading
these should be simple enough.

> +}
> +
> +char *read_time_request = "RTC_RD_TIME";
> +char *set_time_request = "RTC_SET_TIME";
> +
> +static void run(void)
> +{
> +	int fd;
> +
> +	struct rtc_time rtc_read_time;
> +	struct rtc_time rtc_cur_time;
> +	struct rtc_time rtc_set_time = {
> +		.tm_sec = 0, .tm_min = 15, .tm_hour = 13,
> +		.tm_mday = 26, .tm_mon = 8, .tm_year = 119};
> +
> +	int time_read_supported, time_set_supported = 0;
> +
> +	fd = SAFE_OPEN("/dev/rtc", O_RDONLY);
> +
> +	if (fd == -1)
> +		tst_brk(TCONF, "RTC device driver file could not be opened");

You are using SAFE_OPEN() the return value will never be -1, SAFE_OPEN()
either succeeds or exits the test.

You have to use raw open() call if you want to handle the errors
yourself. Also you should really check for errno here, I guess that we
should TCONF only or ENOENT?

And lastly but not least we should open the device once in the test
setup and close it once in test cleanup, there is no point in opening it
for each test iteration (the test -i parameter).

> +	if (ioctl(fd, RTC_RD_TIME, &rtc_cur_time) == -1) {

Just for the sake of being pedantic we should test that the retuned
value here is exactly the one that describes success, so we should do:

	ioctl(fd, RTC_RD_TIME, &foo) != 0

There have been cases where wrongly applied patch caused random values
to be returned from a syscall which would not be caught here.

> +		if (errno == ENOTTY)
> +			tst_res(TCONF, "ioctl %s not supported on RTC device",
> +				read_time_request);
> +		else
> +			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
> +	} else {
> +		tst_res(TPASS, "time successfully read from RTC device");
> +		tst_res(TINFO, "current RTC time: %d:%d, %d.%d.%d",
> +			rtc_cur_time.tm_hour, rtc_cur_time.tm_min,
> +			rtc_cur_time.tm_mday, rtc_cur_time.tm_mon,
> +			rtc_cur_time.tm_year);
> +		time_read_supported = 1;
> +	}
> +
> +	if (ioctl(fd, RTC_SET_TIME, &rtc_set_time) == -1) {
> +		if (errno == ENOTTY)
> +			tst_res(TCONF, "ioctl %s not supported on RTC device",
> +				set_time_request);

Huh, why do we pass static string as %s? Why can't we just simply put it
verbatim into the string?

> +		else
> +			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
> +	} else {
> +		tst_res(TPASS, "time successfully set to RTC device");
> +		tst_res(TINFO, "new RTC time: %d:%d, %d.%d.%d",
> +			rtc_set_time.tm_hour, rtc_set_time.tm_min,
> +			rtc_set_time.tm_mday, rtc_set_time.tm_mon,
> +			rtc_set_time.tm_year);
> +		time_set_supported = 1;
> +	}
> +
> +	if (time_read_supported && time_set_supported) {
> +		ioctl(fd, RTC_RD_TIME, &rtc_read_time);
> +
> +		char time_data[][10] = {"minute", "hour", "month",
> +			"month day", "year"};

This can be just const char *time_data[] = {...};

> +		int read_time_data[] = {
> +			rtc_read_time.tm_min, rtc_read_time.tm_hour,
> +			rtc_read_time.tm_mday, rtc_read_time.tm_mon,
> +			rtc_read_time.tm_year};
> +		int set_time_data[] = {
> +			rtc_set_time.tm_min, rtc_set_time.tm_hour,
> +			rtc_set_time.tm_mday, rtc_set_time.tm_mon,
> +			rtc_set_time.tm_year};
> +		for (int i = 0; i < 5; i++)
> +			if (read_time_data[i] == set_time_data[i])
> +				tst_res(TPASS, "%s reads new %s as expected",
> +					read_time_request, time_data[i]);
> +			else
> +				tst_res(TFAIL, "%s reads different %s than set",
> +					read_time_request, time_data[i]);

Here as well, why do we pass static string as a parameter?

> +	}
> +
> +	if (time_set_supported)
> +		ioctl(fd, RTC_SET_TIME, &rtc_cur_time);

If we are allowed to set the time but not read it we will not restore
the value at the end. Also does having write-only RTC even make sense?
Shouldn't we just drop the time_read_supported flag and exit the test if
we can't read it?

> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.setup = setup,
> +};

Lastly there are some minor coding style violations, LTP uses LKML
coding style, and there is a script packed along with the Linux kernel
that can check your patches before sending them, see
linux/scripts/checkpatch.pl.

-- 
Cyril Hrubis
chrubis@suse.cz
