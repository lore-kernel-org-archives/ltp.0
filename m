From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Dec 2018 15:14:33 +0100
Subject: [LTP] [PATCH v3] syscalls/statx: Add test for sync flags
In-Reply-To: <1543988125-1048-1-git-send-email-vaishnavi.d@zilogic.com>
References: <1543988125-1048-1-git-send-email-vaishnavi.d@zilogic.com>
Message-ID: <20181205141433.GA30925@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Testcase 1: AT_STATX_DONT_SYNC
>  With AT_STATX_DONT_SYNC server changes should
>   not get sync with client.
> 
> Testcase 2: AT_STATX_FORCE_SYNC
>  With AT_STATX_FORCE_SYNC server changes should
>   get sync with client.

The testcase 2 i.e. FORCE_SYNC fails for me on 4.14.11 on ext4 dir
exported over nfs, is that a known problem?

> Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
> Signed-off-by: Vaishnavi.d <vaishnavi.d@zilogic.com>
> Signed-off-by: Tarun.T.U <tarun@zilogic.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/statx/.gitignore |   2 +
>  testcases/kernel/syscalls/statx/statx07.c  | 181 +++++++++++++++++++++++++++++
>  3 files changed, 184 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/statx/statx07.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ac1d2d2..957b999 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1524,5 +1524,6 @@ statx03 statx03
>  statx04 statx04
>  statx05 statx05
>  statx06 statx06
> +statx07 statx07
>  
>  membarrier01 membarrier01
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index c1cedda..436f5c0 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -4,3 +4,5 @@
>  /statx04
>  /statx05
>  /statx06
> +/statx07
> +
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> new file mode 100644
> index 0000000..80f01e3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + *  Email : code@zilogic.com
> + */
> +
> +/*
> + * Test statx
> + *
> + * This code tests the following flags:
> + * 1) AT_STATX_FORCE_SYNC
> + * 2) AT_STATX_DONT_SYNC
> + *
> + * By exportfs cmd creating NFS setup.
> + *
> + * A test file is created in server folder and statx is being
> + * done in client folder.
> + *
> + * TESTCASE 1:
> + * BY AT_STATX_SYNC_AS_STAT getting predefined mode value.
> +
> + * Then, by using AT_STATX_FORCE_SYNC getting new updated vaue
> + * from server file changes.
> + *
> + * TESTCASE 2:
> + * BY AT_STATX_SYNC_AS_STAT getting predefined mode value.
> + * AT_STATX_FORCE_SYNC is called to create cache data of the file.
> + * Then, by using DONT_SYNC_FILE getting old cached data in client folder,
> + * but mode has been chaged in server file.
> + *
> + * Minimum kernel version required is 4.11.
> + */
> +
> +#include <netdb.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/limits.h>
> +#include <sys/mount.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +
> +#define MODE(X) (X & (~S_IFMT))
> +#define F_PATH_SIZE 50
> +#define BUFF_SIZE (PATH_MAX + 50)

There is no point in adding 50 to PATH_MAX, you can use PATH_MAX
instead.

> +#define DEFAULT_MODE 0644
> +#define CURRENT_MODE 0777
> +
> +#define CLIENT_PATH "client"
> +#define SERVER_PATH "server"
> +#define FORCE_SYNC_FILE  "force_sync_file"
> +#define DONT_SYNC_FILE "dont_sync_file"
> +
> +static char cwd[PATH_MAX];
> +static char cmd[BUFF_SIZE];
> +static int mounted;
> +
> +static int get_mode(char *file_name, int flag_type, char *flag_name)
> +{
> +	char client_path[F_PATH_SIZE];
> +	struct statx buff;
> +
> +	snprintf(client_path, sizeof(client_path), "%s/%s",
> +		 CLIENT_PATH, file_name);
> +
> +	TEST(statx(AT_FDCWD, client_path, flag_type, STATX_ALL, &buff));
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
> +
> +const struct test_cases {
> +	char *file_name;
> +	char *flag_name;
> +	int flag;
> +	unsigned int mode;
> +
> +} tcases[] = {
> +	{DONT_SYNC_FILE,
> +	 "AT_STATX_DONT_SYNC",
> +	 AT_STATX_DONT_SYNC,
> +	 DEFAULT_MODE},
> +
> +	{FORCE_SYNC_FILE,
> +	 "AT_STATX_FORCE_SYNC",
> +	 AT_STATX_FORCE_SYNC,
> +	 CURRENT_MODE}
> +};
> +
> +static void test_statx(unsigned int nr)
> +{
> +	const struct test_cases *tc = &tcases[nr];
> +	unsigned int cur_mode;
> +	char server_path[F_PATH_SIZE];
> +
> +	snprintf(server_path, sizeof(server_path), "%s/%s", SERVER_PATH,
> +		 tc->file_name);

Why don't we add the server path and client path to the struct
test_case?

We could easily do:

const strut test_case {
	const char *server_file;
	const char *client_file;
	...
} = tcases[] {
	SERVER_PATH"/"DONT_SYNC_FILE,
	CLIENT_PATH"/"DONT_SYNC_FILE,
	...
};

Then there is no need to construct paths on runtime.

> +	get_mode(tc->file_name, AT_STATX_FORCE_SYNC, "AT_STATX_FORCE_SYNC");
> +
> +	SAFE_CHMOD(server_path, CURRENT_MODE);
> +	cur_mode = get_mode(tc->file_name, tc->flag, tc->flag_name);
> +
> +	if (MODE(cur_mode) == tc->mode)
> +		tst_res(TPASS,
> +			"statx() with %s for mode %o %o",
> +			tc->flag_name, tc->mode, MODE(cur_mode));
> +	else
> +		tst_res(TFAIL,
> +			"statx() with %s for mode %o %o",
> +			tc->flag_name, tc->mode, MODE(cur_mode));
> +}
> +
> +static void setup(void)
> +{
> +	int ret;
> +	char force_sync_file[F_PATH_SIZE];
> +	char dont_sync_file[F_PATH_SIZE];
> +	char mount_data[F_PATH_SIZE];
> +	char server_path[BUFF_SIZE];
> +	char client_path[BUFF_SIZE];
> +	char *ip = "127.0.0.1";
> +
> +	TESTPTR(getcwd(cwd, PATH_MAX));
> +	if (TST_RET_PTR == NULL)
> +		tst_brk(TBROK | TST_ERR, "Failed to get PWD");

We should use tst_get_tmpdir() here instead.

> +	snprintf(force_sync_file, sizeof(force_sync_file), "%s/%s",
> +		 SERVER_PATH, FORCE_SYNC_FILE);
> +	snprintf(dont_sync_file, sizeof(dont_sync_file), "%s/%s",
> +		 SERVER_PATH, DONT_SYNC_FILE);

Here as well, you are concatenating two statically defined paths
together, there is no point in doing anything else than:

#define DONT_SYNC_FILE SERVER_PATH"/dont_sync_file"

And using DONT_SYNC_FILE in the code instead.

> +	SAFE_MKDIR(SERVER_PATH, DEFAULT_MODE);
> +	SAFE_MKDIR(CLIENT_PATH, DEFAULT_MODE);
> +	SAFE_CREAT(force_sync_file, DEFAULT_MODE);
> +	SAFE_CREAT(dont_sync_file, DEFAULT_MODE);
> +
> +	snprintf(server_path, sizeof(server_path), ":%s/%s", cwd, SERVER_PATH);
> +	snprintf(client_path, sizeof(client_path), "%s/%s", cwd, CLIENT_PATH);

We don't have to use absolute path for the client, as far as I can tell
we can do mount(server_path, CLIENT_PATH, ...).

> +	snprintf(mount_data, sizeof(mount_data), "addr=%s", ip);

The addr is static string, why don't we just set the mount_data to
"addr=127.0.0.1" to begin with?

> +	snprintf(cmd, sizeof(cmd),
> +		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%.1024s",
> +		 server_path);
> +
> +	ret = tst_system(cmd);
> +	if (WEXITSTATUS(ret) == 127)
> +		tst_brk(TCONF | TST_ERR, "%s not found", cmd);
> +	if (ret == -1)

We should probably do if (ret) here instead which would catch all
different failure modes.

> +		tst_brk(TBROK | TST_ERR, "failed to exportfs");
> +
> +	SAFE_MOUNT(server_path, client_path, "nfs", 0, mount_data);


Given that exportfs only writes to the list of the exported files. The
mount will fail with EOPNOTSUPP unless the nfsd server is up and
running.  Hence we have to handle EOPNOTSUPP from mount here with
something as:

	if (mount(server_path, client_path, "nfs", 0, mount_data)) {
		if (errno == EOPNOTSUPP)
			tst_brk(TCONF | TERRNO, "nfs server not set up?");
		tst_brk(TBROK | TERRNO, "mount() nfs failed");
	}

> +	mounted = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tst_system("exportfs -ua") == -1)
> +		tst_res(TWARN | TST_ERR, "failed to clear exportfs");

Here we should make sure we unexport only the path we have exported
previously. As far as I can tell we should do 'exportfs -u
*:server_path' instead.

> +	if (mounted)
> +		SAFE_UMOUNT(CLIENT_PATH);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = test_statx,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "4.11",
> +	.needs_tmpdir = 1,
> +	.dev_fs_type = "nfs",
> +	.needs_root = 1,
> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
