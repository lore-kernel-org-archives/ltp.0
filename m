From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 12:59:06 +0100
Subject: [LTP] [PATCH v2] Test statx syscall for SYNC_FLAGS
In-Reply-To: <20180917075248.28004-1-kewal@zilogic.com>
References: <20180917075248.28004-1-kewal@zilogic.com>
Message-ID: <20181127115905.GB4792@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kewal,

LGTM, bellow are some minor enhancement tips.

> * statx06.c :-
This could be deleted.

Maybe first line of commit message "syscalls/statx: Add test for sync flags"
(SYNC_FLAGS looks like a constant, which is misleading).

>  Testcase 1: AT_STATX_DONT_SYNC
>   With AT_STATX_DONT_SYNC server changes should not get sync with client.

>  Testcase 2: AT_STATX_FORCE_SYNC
>   With AT_STATX_FORCE_SYNC server changes should get sync with client.

> Signed-off-by: Kewal Ukunde <kewal@zilogic.com>
> Signed-off-by: Vaishnavi.d <vaishnavi.d@zilogic.com>
> Signed-off-by: Tarun.T.U <tarun@zilogic.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>  testcases/kernel/syscalls/statx/statx06.c  | 195 +++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/statx/statx06.c

It's needed to rename statx06.c to statx07.c (as previous was taken).

...
> diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
...

> +static void test_for_dont_sync(void)
> +{
> +	unsigned int cur_mode;
> +	char server_path[F_PATH_SIZE];
> +
> +	snprintf(server_path, sizeof(server_path), "%s/%s", SERVER_PATH,
> +		 DONT_SYNC_FILE);
> +
> +	get_mode(DONT_SYNC_FILE, AT_STATX_FORCE_SYNC,
> +		 "AT_STATX_FORCE_SYNC");
> +
> +	SAFE_CHMOD(server_path, CURRENT_MODE);
> +	cur_mode = get_mode(DONT_SYNC_FILE, AT_STATX_DONT_SYNC,
> +			    "AT_STATX_DONT_SYNC");
> +
> +	if (MODE(cur_mode) == DEFAULT_MODE)
> +		tst_res(TPASS,
> +			"statx() with AT_STATX_DONT_SYNC for mode %o %o",
> +			DEFAULT_MODE, MODE(cur_mode));
> +	else
> +		tst_res(TFAIL,
> +			"statx() with AT_STATX_DONT_SYNC for mode %o %o",
> +			DEFAULT_MODE, MODE(cur_mode));
> +}
> +
> +static void test_for_force_sync(void)
> +{
> +	unsigned int cur_mode;
> +	char server_path[F_PATH_SIZE];
> +
> +	snprintf(server_path, sizeof(server_path), "%s/%s", SERVER_PATH,
> +		 FORCE_SYNC_FILE);
> +
> +	SAFE_CHMOD(server_path, CURRENT_MODE);
> +	cur_mode = get_mode(FORCE_SYNC_FILE, AT_STATX_FORCE_SYNC,
> +			    "AT_STATX_FORCE_SYNC");
> +
> +	if (MODE(cur_mode) == CURRENT_MODE)
> +		tst_res(TPASS,
> +			"statx() with AT_STATX_FORCE_SYNC for mode %o %o",
> +			CURRENT_MODE, MODE(cur_mode));
> +	else
> +		tst_res(TFAIL,
> +			"statx() with AT_STATX_FORCE_SYNC for mode %o %o",
> +			CURRENT_MODE, MODE(cur_mode));
> +}
> +
> +const struct test_cases {
> +	void (*func)(void);
> +} tcases[] = {
> +	{test_for_dont_sync},
> +	{test_for_force_sync}
> +};
Both testing functions are nearly the same, why to repeat yourself?
How about, instead of passing test function pointer, pass mode and other needed
parameters to single test function?

> +
> +static void test_statx(unsigned int nr)
> +{
> +	const struct test_cases *tc = &tcases[nr];
> +
> +	tc->func();
> +}

I suggest other changes (see following diff):

* Add mount flag to avoid false positive warning:
safe_macros.c:773: WARN: statx07.c:181: umount(client) failed: EINVAL

* Fix gcc-8 format-truncation error (1024 is far too much, it could be less).

* Use tst_res(TWARN, ...) for exportfs.


Kind regards,
Petr



diff --git testcases/kernel/syscalls/statx/statx07.c testcases/kernel/syscalls/statx/statx07.c
index f64322d7d..ff988fd00 100644
--- testcases/kernel/syscalls/statx/statx07.c
+++ testcases/kernel/syscalls/statx/statx07.c
@@ -51,6 +51,7 @@
 
 static char cwd[PATH_MAX];
 static char cmd[BUFF_SIZE];
+static int mounted;
 
 static int get_mode(char *file_name, int flag_type, char *flag_name)
 {
@@ -163,7 +162,7 @@ static void setup(void)
 	snprintf(mount_data, sizeof(mount_data), "addr=%s", ip);
 
 	snprintf(cmd, sizeof(cmd),
-		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%s",
+		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check *%.1024s",
 		 server_path);
 
 	ret = tst_system(cmd);
@@ -173,14 +172,16 @@ static void setup(void)
 		tst_brk(TBROK | TST_ERR, "failed to exportfs");
 
 	SAFE_MOUNT(server_path, client_path, "nfs", 0, mount_data);
+	mounted = 1;
 }
 
 static void cleanup(void)
 {
 	if (tst_system("exportfs -ua") == -1)
-		tst_brk(TBROK | TST_ERR, "failed to clear exportfs");
+		tst_res(TWARN | TST_ERR, "failed to clear exportfs");
 
-	SAFE_UMOUNT(CLIENT_PATH);
+	if (mounted)
+		SAFE_UMOUNT(CLIENT_PATH);
 }
 
 static struct tst_test test = {
