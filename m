From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Dec 2018 16:52:20 +0100
Subject: [LTP] [PATCH v4] syscalls/statx: Add test for sync flags
In-Reply-To: <1544172141-1676-1-git-send-email-vaishnavi.d@zilogic.com>
References: <1544172141-1676-1-git-send-email-vaishnavi.d@zilogic.com>
Message-ID: <20181207155220.GA14562@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vaishnavi,


> Testcase 1: AT_STATX_DONT_SYNC
>  With AT_STATX_DONT_SYNC server changes should not get sync with client.

> Testcase 2: AT_STATX_FORCE_SYNC
>  With AT_STATX_FORCE_SYNC server changes should get sync with client.

> Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
> Signed-off-by: Vaishnavi.d <vaishnavi.d@zilogic.com>
> Signed-off-by: Tarun.T.U <tarun@zilogic.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
Now reviewing it :).

...
> + * Minimum kernel version required is 4.16.
statx() was merged into 4.11 in commit a528d35e8bfc ("statx: Add a system call
to make enhanced file info available" as you had in v1. Why now requiring 4.16?
It looks like second test fails now on 4.11, because calling get_mode() for it
as well (see bellow).

BTW maybe .min_kver = "4.16" is self describing.

...
> +#include "old_tmpdir.h"
I think, we don't want to use old_*.h headers (although library itself
lib/tst_test.c uses it). IMHO previous version with getcwd() was better.

> +#define CLIENT_PATH "client"
> +#define SERVER_PATH "server"
> +#define CLI_FORCE_SYNC "client/force_sync_file"
> +#define CLI_DONT_SYNC "client/dont_sync_file"
> +#define SERV_FORCE_SYNC "server/force_sync_file"
> +#define SERV_DONT_SYNC "server/dont_sync_file"
Code style: SERVER_* vs. SERV_*, CLIENT_* vs. CLI_*. Can you unify them?
(pick only one variant for each?).

> +static int get_mode(char *file_name, int flag_type, char *flag_name)
I don't like passing flag and it's name, but no idea, how to avoid it.
> +{
> +	struct statx buff;
> +
> +	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buff));
> +
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TST_ERR,
> +			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
> +			file_name, flag_name);
> +	else
> +		tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
> +			file_name, flag_name);
> +
> +	return buff.stx_mode;
> +}

> +const struct test_cases {
> +	char *server_file;
> +	char *client_file;
> +	char *flag_name;
> +	int flag;
> +	unsigned int mode;
> +
> +} tcases[] = {
> +	{SERV_DONT_SYNC,
> +	 CLI_DONT_SYNC,
> +	 "AT_STATX_DONT_SYNC",
> +	 AT_STATX_DONT_SYNC,
> +	 DEFAULT_MODE},
> +	{SERV_FORCE_SYNC,
> +	 CLI_FORCE_SYNC,
> +	 "AT_STATX_FORCE_SYNC",
> +	 AT_STATX_FORCE_SYNC,
> +	 CURRENT_MODE}
> +};
flag_name and flag is duplicity.

We often use macro for this purpose:

testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
#define TYPE_NAME(x) .ttype = x, .desc = #x
...
static struct test_case tcase[] = {
	{
		TYPE_NAME(NORMAL),

Note about code style:
tcases[] formatting: { } should be on single line.
If you can, use shorter names (it's C).

> +static void test_statx(unsigned int nr)
Maybe i?
static void test_statx(unsigned int nr)

> +{
> +	const struct test_cases *tc = &tcases[nr];
> +	unsigned int cur_mode;
> +
> +	get_mode(tc->client_file, AT_STATX_FORCE_SYNC, "AT_STATX_FORCE_SYNC");
> +
> +	SAFE_CHMOD(tc->server_file, CURRENT_MODE);
> +	cur_mode = get_mode(tc->client_file, tc->flag, tc->flag_name);

This helps to be 4.11 compatible:
	if (tc->flag == AT_STATX_DONT_SYNC)
		get_mode(tc->client_file, AT_STATX_FORCE_SYNC, "AT_STATX_FORCE_SYNC");

> +	if (MODE(cur_mode) == tc->mode)
> +		tst_res(TPASS,
> +			"statx() with %s for mode %o %o",
> +			tc->flag_name, tc->mode, MODE(cur_mode));
> +	else
> +		tst_res(TFAIL,
> +			"statx() with %s for mode %o %o",
> +			tc->flag_name, tc->mode, MODE(cur_mode));
> +}
...

> +static void setup(void)
> +{
...
> +	snprintf(cmd, sizeof(cmd),
> +		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%.1024s",
> +		 server_path);
Maybe whole cleanup should be skipped if exportfs fails?
	exported = 1;

> +
> +	ret = tst_system(cmd);
> +	if (WEXITSTATUS(ret) == 127)
> +		tst_brk(TCONF | TST_ERR, "%s not found", cmd);
> +	if (ret)
> +		tst_brk(TBROK | TST_ERR, "failed to exportfs");
> +
> +	if (mount(server_path, CLIENT_PATH, "nfs", 0, "addr=127.0.0.1")) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "nfs server not set up?");
> +		tst_brk(TBROK | TERRNO, "mount() nfs failed");
> +	}
> +	mounted = 1;
> +}

> +static void cleanup(void)
> +{
	Here skip cleanup if exportfs during setup failed:
	if (!exported)
		return;

> +	snprintf(cmd, sizeof(cmd),
> +		 "exportfs -u *:%s/%s", cwd, SERVER_PATH);
> +
> +	if (tst_system(cmd) == -1)
> +		tst_res(TWARN | TST_ERR, "failed to clear exportfs");
> +
> +	if (mounted)
> +		SAFE_UMOUNT(CLIENT_PATH);
> +}
...


Kind regards,
Petr
