From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 May 2019 17:18:35 +0200
Subject: [LTP] [PATCH v1] syscalls/acct02: add functional testcase
In-Reply-To: <20190510132400.28963-1-camann@suse.com>
References: <20190510132400.28963-1-camann@suse.com>
Message-ID: <20190529151835.GA5913@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/acct/.gitignore b/testcases/kernel/syscalls/acct/.gitignore
> index c2fb15611..ed68d202c 100644
> --- a/testcases/kernel/syscalls/acct/.gitignore
> +++ b/testcases/kernel/syscalls/acct/.gitignore
> @@ -1 +1,2 @@
>  /acct01
> +/acct02
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> new file mode 100644
> index 000000000..4ddc482c3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + *  Copyright (c) SUSE LLC, 2019
> + *  Author: Christian Amann <camann@suse.com>
> + */
> +
> +/*
> + * This tests if the kernel writes correct data to the
> + * process accounting file.
> + *
> + * First, system-wide process accounting is turned on and the output gets
> + * directed to a defined file. After that a simple command is issued in order
> + * to generate data and the process accounting gets turned off again.
> + *
> + * To verify the written data, the entries of the accounting file get
> + * parsed into the corresponding acct structure. Since it cannot be guaranteed
> + * that only the command issued by this test gets written into the accounting
> + * file, the contents get parsed until the correct entry is found, or EOF
> + * is reached.
> + */
> +
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <time.h>
> +#include <unistd.h>
> +#include "config.h"
> +#include "tst_kconfig.h"
> +#include "tst_test.h"
> +
> +#ifdef HAVE_STRUCT_ACCT_V3
  ^
Can't we, rather than ifdefing the test out, add a fallback definition?

> +#include <sys/acct.h>
> +
> +#define COMMAND		"echo"
                                  ^
Can we rather than this create a dummy program that has more or less
unique name?

Bonus points for sleeping/burning cpu time for a second in the test
program and then checking that the utime and etime are within resonable
bounds. We can probably check different exit values as well.

> +#define OUTPUT_FILE	"acct_file"
> +#define SIZE		sizeof(struct acct_v3)
             ^
	     Shouldn't this depend on the return value from the
	     acct_version_is_3() ?
> +
> +static int fd;
> +static int v3;
> +static unsigned int rc;
> +static unsigned int start_time;
> +
> +static union acct_union {
> +	struct acct	v0;
> +	struct acct_v3	v3;
> +} ACCT;
     ^
     Uppercase identifiers are mostly used for macros.

> +static int acct_version_is_3(void)
> +{
> +	const char *kconfig_acct_v3[] = {
> +		"CONFIG_BSD_PROCESS_ACCT_V3",
> +		NULL
> +	};
> +
> +	struct tst_kconfig_res results[1];
> +
> +	tst_kconfig_read(kconfig_acct_v3, results, 1);
> +
> +	return results[0].match == 'y';
> +}
> +
> +static void run_command(void)
> +{
> +	const char *const cmd[] = {COMMAND, NULL};
> +
> +	rc = tst_run_cmd(cmd, NULL, NULL, 1);
> +}
> +
> +static int verify_acct(struct acct *acc)
> +{
> +	if (strcmp(acc->ac_comm, COMMAND) ||
> +		acc->ac_btime - start_time > 1 ||
                    ^
This will also pass if there is a garbage in the ac_btime that happens
to be <= start_time e.g. for ac_btime == 0. And it may also fail when we
executed the command right before the kernel timer wheel increments.

We should rather check that ac_btime >= start_time and that ac_btime -
start_time <= 1.

> +		acc->ac_uid != getuid() ||
> +		acc->ac_gid != getgid() ||
> +		acc->ac_exitcode != rc)
> +		return 0;
> +	return 1;
> +}
> +
> +static int verify_acct_v3(struct acct_v3 *acc)
> +{
> +	if (strcmp(acc->ac_comm, COMMAND) ||
> +		acc->ac_btime - start_time > 1 ||

Here as well.

> +		acc->ac_uid != getuid() ||
> +		acc->ac_gid != getgid() ||
> +		acc->ac_exitcode != rc ||
> +		acc->ac_version != 3 ||
> +		acc->ac_pid < 1)
> +		return 0;
> +	return 1;
> +}
> +
> +static void run(void)
> +{
> +	int read_bytes, ret;
> +
> +	fd = SAFE_OPEN(OUTPUT_FILE, O_RDWR | O_CREAT, 0644);
> +
> +	TEST(acct(OUTPUT_FILE));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "Could not set acct output file");
> +
> +	start_time = time(NULL);
> +	run_command();
> +	acct(NULL);
> +
> +	do {
> +		read_bytes = SAFE_READ(0, fd, &ACCT, SIZE);
> +
> +		if (v3)
> +			ret = verify_acct_v3(&ACCT.v3);
> +		else
> +			ret = verify_acct(&ACCT.v0);
> +
> +		if (!ret)
> +			tst_res(TINFO, "acct file entry did not match; "
> +					"trying to check next entry...");
                                  ^
				  This will probably flood the test
				  output, can't we just increment
				  counter here and print how many
				  entries we processed?
> +	} while (read_bytes == SIZE && !ret);
> +
> +	if (ret)
> +		tst_res(TPASS, "acct() wrote correct file contents!");
> +	else
> +		tst_res(TFAIL, "acct() wrote incorrect file contents!");
> +}
> +
> +static void setup(void)
> +{
> +	TEST(acct(NULL));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO,
> +			"acct() system call returned with error");
> +
> +	v3 = acct_version_is_3();
> +	if (v3)
> +		tst_res(TINFO, "Verifying using 'struct acct_v3'");
> +	else
> +		tst_res(TINFO, "Verifying using 'struct acct'");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +	acct(NULL);
> +}
> +
> +static const char *kconfigs[] = {
> +	"CONFIG_BSD_PROCESS_ACCT",
> +	NULL
> +};
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_kconfigs = kconfigs,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};
> +
> +#else
> +	TST_TEST_TCONF("This system does not support acct_v3 structure");
> +#endif /* HAVE_STRUCT_ACCT_V3 */

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
