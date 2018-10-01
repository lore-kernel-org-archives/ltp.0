From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Oct 2018 04:47:59 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/membarrier: Add membarrier() initial test
In-Reply-To: <20180927220941.19783-1-rafael.tinoco@linaro.org>
References: <20180927220941.19783-1-rafael.tinoco@linaro.org>
Message-ID: <243767154.55279006.1538383679362.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

----- Original Message -----
> Fixes: #265
> +/*
> + * Basic tests for membarrier(2) syscall. Tests bellow are responsible for
> + * testing the membarrier(2) interface only, without checking if the barrier
> was
> + * successful or not.
> + *
> + * There are 11 test cases:
> + *
> + * 00) invalid cmd:
> + *		- enabled by default
> + *		- should always fail with EINVAL
> + * 01) invalid flags:
> + *		- enabled by default
> + *		- should always fail with EINVAL
> + * ----
> + * 02) global barrier:
> + *		- ALWAYS enabled by CMD_QUERY
> + *		- should always succeed
> + * ----
> + * commit 22e4ebb975 (v4.14-rc1) added following feature:
> + *
> + * 03) private expedited barrier with no registrations:
> + *		- should fail with errno=EPERM due to no registrations
> + *		- or be skipped if unsupported by running kernel
> + * 04) register private expedited
> + *		- should succeed when supported by running kernel
> + *		- or fail with errno=EINVAL if unsupported and forced
> + * 05) private expedited barrier with registration
> + *		- should succeed due to existing registration (case 04)
> + *		- or fail with errno=EINVAL if unsupported and forced
> + *		- NOTE: if unsupported, and forced, on < 4.10, errno is EINVAL
> + * ----
> + * commit 70216e18e5 (v4.16-rc1) added following feature:
> + *
> + * 06) private expedited sync core barrier with no registrations
> + *		- should fail with errno=EPERM due to no registrations
> + *		- or be skipped if unsupported by running kernel
> + * 07) register private expedited sync core
> + *		- should succeed when supported by running kernel
> + *		- or fail with errno=EINVAL if unsupported and forced
> + * 08) private expedited sync core barrier with registration
> + *		- should succeed due to existing registration (case 07)
> + *		- or fail with errno=EINVAL if unsupported and forced
> + * ----
> + * commit c5f58bd58f4 (v4.16-rc1) added following feature:
> + *
> + * 09) global expedited barrier with no registrations
> + *		- should never fail due to no registrations
> + *		- or be skipped if unsupported by running kernel
> + * 10) register global expedited
> + *		- should succeed when supported by running kernel
> + *		- or fail with errno=EINVAL if unsupported and forced
> + * 11) global expedited barrier with registration
> + *		- should succeed due to existing registration (case 10) or not
> + *		- or fail with errno=EINVAL if unsupported and forced

I'd move these comments to test_case array. Because your cases
depend on each other, it'd be good to have description there.

> + * ----
> + * OBSERVATION:
> + *
> + * Linux kernel does not provide a way to unregister (mm->membarrier_state)

This breaks -i parameter, maybe fork a child?

> the
> + * process intent of being affected by the membarrier(2) call.
> + */
> +
> +#include "config.h"
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <linux/membarrier.h>

Including linux headers directly is discouraged.
This breaks compilation on older distros:

membarrier01.c:72:30: error: linux/membarrier.h: No such file or directory

So we either need lapi header or configure check.

> +#include <syscall.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "tst_test.h"

<snip>

> static int sys_membarrier(int cmd, int flags)
> {
>        return syscall(__NR_membarrier, cmd, flags);
> }

Needs syscall define in lapi/syscalls:

membarrier01.c:146: error: ‘__NR_membarrier’ undeclared (first use in this function)

> +
> +struct test_case tc[] = {
> +	{
> +	 /* case 00 */
> +	 .testname = "cmd_fail\0",

string literals already contain null terminating character

> +	 .command = -1,
> +	 .exp_ret = -1,
> +	 .exp_errno = EINVAL,
> +	 .enabled = 1,
> +	 },
> +	{
> +	 /* case 01 */
> +	 .testname = "cmd_flags_fail\0",
> +	 .command = MEMBARRIER_CMD_QUERY,
> +	 .flags = 1,
> +	 .exp_ret = -1,
> +	 .exp_errno = EINVAL,
> +	 .enabled = 1,
> +	 },
> +	{
> +	 /* case 02 */
> +	 .testname = "cmd_global_success\0",
> +	 .command = MEMBARRIER_CMD_GLOBAL,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .always = 1,
> +	 },
> +	{
> +	 /* case 03 */
> +	 .testname = "cmd_private_expedited_fail\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = -1,
> +	 .exp_errno = EPERM,
> +	 },
> +	{
> +	 /* case 04 */
> +	 .testname = "cmd_private_expedited_register_success\0",
> +	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	{
> +	 /* case 05 */
> +	 .testname = "cmd_private_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	{
> +	 /* case 06 */
> +	 .testname = "cmd_private_expedited_sync_core_fail\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
> +	 .flags = 0,
> +	 .exp_ret = -1,
> +	 .exp_errno = EPERM,
> +	 },
> +	{
> +	 /* case 07 */
> +	 .testname = "cmd_private_expedited_sync_core_register_success\0",
> +	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	{
> +	 /* case 08 */
> +	 .testname = "cmd_private_expedited_sync_core_success\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	{
> +	 /* case 09 */
> +	 .testname = "cmd_global_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +	{
> +	 /* case 10 */
> +	 .testname = "cmd_global_expedited_register_success\0",
> +	 .command = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	{
> +	 /* case 11 */
> +	 .testname = "cmd_global_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +};

Same as for membarrier header applies to commands:
We either need configure check or lapi header to not break
LTP build on older distros.

> +
> +static void verify_membarrier(unsigned int i)
> +{
> +	/* skips tests depending on supportability */
> +
> +	if (tc[i].enabled != 1 && tc[i].force != 1) {
> +		if (tc[i].always == 0)
> +			skipped(tc[i]);
> +
> +		skipped_fail(tc[i]);
> +	}
> +
> +	TEST(sys_membarrier(tc[i].command, tc[i].flags));
> +
> +	/* cmd passes */
> +
> +	if (tc[i].exp_ret == TST_RET) {
> +
> +		if (TST_RET >= 0)
> +			passed_ok(tc[i]);
> +		else {
> +			if (tc[i].enabled == 1 && tc[i].force != 1) {
> +				if (tc[i].exp_errno != TST_ERR)
> +					failed_not_ok(tc[i], TST_RET, TST_ERR);
> +				else
> +					failed_ok(tc[i]);
> +			} else {
> +				if (tc[i].force_exp_errno != TST_ERR)
> +					failed_not_ok(tc[i], TST_RET, TST_ERR);
> +				else
> +					failed_ok_unsupported(tc[i]);
> +			}
> +		}
> +
> +	/* cmd fails */
> +
> +	} else {
> +		if (tc[i].enabled == 1 && tc[i].force != 1) {
> +			if (TST_RET >= 0)
> +				passed_unexpectedly(tc[i]);
> +			else
> +				failed_unexpectedly(tc[i], TST_RET, TST_ERR);
> +		} else {
> +			if (tc[i].force_exp_errno == TST_ERR)
> +				failed_ok_unsupported(tc[i]);
> +			else
> +				failed_not_ok(tc[i], TST_RET, TST_ERR);
> +		}
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	size_t i;
> +	int ret;
> +
> +	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> +	if (ret < 0) {
> +		if (errno == ENOSYS)
> +			tst_brk(TCONF, "sys_membarrier(2) not supported");
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(tc); i++) {
> +		if ((tc[i].command > 0) && (ret & tc[i].command))
> +			tc[i].enabled = 1;
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = verify_membarrier,
> +	.tcnt = ARRAY_SIZE(tc),
> +};

Presumably, this syscall won't see many backports to older trees,
so I'd add minimum supported kernel version here.

Regards,
Jan
