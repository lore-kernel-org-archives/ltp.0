From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Apr 2020 17:10:50 +0200
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200417151050.GA2491@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

In the end I've renamed and moved these functions into the test library
because the functionality is generic enough and I doubt that these
tests would be the only one using it.

-- 
Cyril Hrubis
chrubis@suse.cz
