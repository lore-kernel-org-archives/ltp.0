From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 May 2019 15:21:09 +0200
Subject: [LTP] [PATCH v3] syscalls/prctl05.c: New test for prctl() with
 PR_{SET, GET}_NAME
In-Reply-To: <1558684246-2658-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <70578dc6-1a6b-9ab1-1298-0539ae8562f9@163.com>
 <1558684246-2658-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190524132109.GA30293@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <sys/prctl.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include "lapi/syscalls.h"
> +#include "lapi/prctl.h"
> +#include "tst_test.h"
> +
> +static struct tcase {
> +	char setname[20];
> +	char expname[20];
> +} tcases[] = {
> +	{"prctl05_test", "prctl05_test"},
> +	{"prctl05_test_xxxxx", "prctl05_test_xx"}
> +};
> +
> +static void verify_prctl(unsigned int n)
> +{
> +	char buf[20];
> +	char comm_buf[20];
> +	char PROC_NAME_PATH[40];

Uppercase identifiers are by convention used for macros, this should be
proc_path, or just path.

> +	pid_t tid;
> +	struct tcase *tc = &tcases[n];
> +
> +	TEST(prctl(PR_SET_NAME, tc->setname));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_NAME) failed");
> +		return;
> +	}
> +	tst_res(TPASS,
> +		"prctl(PR_SET_NAME) succeeded, set thread name as %s", tc->setname);

This could be shorter, why not just:

	tst_res(TPASS, "prctl(PR_SET_NAME, '%s')", tc->setname);

> +	TEST(prctl(PR_GET_NAME, buf));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_NAME) failed");
> +		return;
> +	}


Looks like the null-termination got lost between v2 and v3.

And it would be better not to hardcode the size with:

buf[sizeof(buf)-1] = 0;

> +	if (strcmp(tc->expname, buf))
> +		tst_res(TFAIL,
> +			"prctl(PR_GET_NAME) failed ,expected %s, got %s", tc->expname, buf);
                                                  ^
						  The comma should be
						  before the space.
> +	else
> +		tst_res(TPASS,
> +			"prctl(PR_GET_NAME) succeeded, thread name is %s", buf);
> +
> +	tid = tst_syscall(__NR_gettid);
> +
> +	sprintf(PROC_NAME_PATH, "/proc/self/task/%d/comm", tid);
> +	SAFE_FILE_SCANF(PROC_NAME_PATH, "%s", comm_buf);
> +	if (strcmp(tc->expname, comm_buf))
> +		tst_res(TFAIL,
> +			"%s sets thread name failed, expected %s, got %s",

This message could be shorter and to the point, something as:

tst_res(TFAIL, "%s has %s, expected %s", path, buf, tc->expname);


> +			PROC_NAME_PATH, tc->expname, comm_buf);
> +	else
> +		tst_res(TPASS, "%s sets thread name succeed as %s",

Here as well, something as:

tst_res(TPASS, "%s set to %s", path, buf);

> +			PROC_NAME_PATH, comm_buf);
> +
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_prctl,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> -- 
> 2.18.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
