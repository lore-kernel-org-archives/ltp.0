From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Apr 2020 14:16:03 +0200
Subject: [LTP] [PATCH v1 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <1585839990-19923-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1585839990-19923-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1585839990-19923-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200403121603.GD26355@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ioctl/Makefile      |  3 +
>  .../syscalls/ioctl/ioctl_loop_support.c       | 74 +++++++++++++++++++
>  .../syscalls/ioctl/ioctl_loop_support.h       | 14 ++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop_support.h
> 
> diff --git a/testcases/kernel/syscalls/ioctl/Makefile b/testcases/kernel/syscalls/ioctl/Makefile
> index c2ff6c8e7..05a75d1b4 100644
> --- a/testcases/kernel/syscalls/ioctl/Makefile
> +++ b/testcases/kernel/syscalls/ioctl/Makefile
> @@ -7,6 +7,9 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  INSTALL_TARGETS		+= test_ioctl
>  
> +MAKE_TARGETS            := $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/ioctl_loop[0-9]*.c))
> +$(MAKE_TARGETS): %: ioctl_loop_support.o

I guess that we should use anything else than MAKE_TARGETS because
changing that variable will disable rest of the ioctl tests from build
right?

As this only expresses dependency on the object file we should use any
variable name that is not used by the test library itself.

>  ifeq ($(ANDROID),1)
>  FILTER_OUT_MAKE_TARGETS	+= ioctl02
>  endif
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop_support.c b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
> new file mode 100644
> index 000000000..4099bd364
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +#define TST_NO_DEFAULT_MAIN
> +#include "ioctl_loop_support.h"
> +#include "tst_test.h"
> +
> +void check_sys_value(char *path, int setvalue)
> +{
> +	int getvalue;
> +
> +	SAFE_FILE_SCANF(path, "%d", &getvalue);
> +	if (setvalue == getvalue)
> +		tst_res(TPASS, "%s value is %d", path, setvalue);
> +	else
> +		tst_res(TFAIL, "%s value expected %d got %d", path, setvalue, getvalue);
> +}
> +
> +void check_sys_string(char *path, char *setmessage)
> +{
> +	char getmessage[1024];
> +
> +	SAFE_FILE_SCANF(path, "%s", getmessage);
> +	if (strcmp(setmessage, getmessage))
> +		tst_res(TFAIL, "%s expected %s got %s", path, setmessage, getmessage);
> +	else
> +		tst_res(TPASS, "%s string is %s", path, getmessage);
> +}
> +
> +void safe_set_status(int dev_fd, struct loop_info loopinfo)
> +{
> +	int sleep_us = 4096;
> +	int ret = 0;
> +
> +	/*
> +	 * It may have dirty page, so loop dirver may get EAGAIN error
> +	 * when we use different offset or sizelimit.
> +	 */
> +	ret = ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo);
> +	while (ret != 0 && errno == EAGAIN && sleep_us < 100000) {
> +		ret = ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo);
> +		usleep(sleep_us);
> +		sleep_us *= 2;
> +	}

TBROK here if we failed to set the status?

Also we should use the TST_RETRY_FUNC() instead because that one uses
the timeout multiplier environment variable.

> +}
> +
> +void safe_set_status64(int dev_fd, struct loop_info64 loopinfo)
> +{
> +	int sleep_us = 4096;
> +	int ret = 0;
> +
> +	/*
> +	 * It may have dirty page, so loop dirver may get EAGAIN error
> +	 * when we use different offset or sizelimit.
> +	 */
> +	ret = ioctl(dev_fd, LOOP_SET_STATUS64, &loopinfo);
> +	while (ret != 0 && errno == EAGAIN && sleep_us < 100000) {
> +		ret = ioctl(dev_fd, LOOP_SET_STATUS64, &loopinfo);
> +		usleep(sleep_us);
> +		sleep_us *= 2;
> +	}

Here as well.

> +}
> +
> +void check_support_cmd(int dev_fd, int ioctl_flag, int value, char *message)
> +{
> +	int ret = 0;
> +
> +	ret = ioctl(dev_fd, ioctl_flag, value);
> +	if (ret && errno == EINVAL)
> +		tst_brk(TCONF, "Current environment doesn't support this flag(%s)",
> +				message);
> +}
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop_support.h b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.h
> new file mode 100644
> index 000000000..44445af8a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.h
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +#ifndef IOCTL_LOOP_H
> +#define IOCTL_lOOP_H
> +#include <linux/loop.h>
> +void check_sys_value(char *path, int setvalue);
> +void check_sys_string(char *path, char *setmessage);
> +void safe_set_status(int dev_fd, struct loop_info loopinfo);
> +void safe_set_status64(int dev_fd, struct loop_info64 loopinfo);
> +void check_support_cmd(int dev_fd, int ioctl_flag, int value, char *message);
> +#endif
> -- 
> 2.23.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
