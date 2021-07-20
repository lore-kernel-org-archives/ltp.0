From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jul 2021 14:35:37 +0200
Subject: [LTP] [PATCH] userns08,
 CVE-2018-18955: Broken id mappings in nested namespaces
In-Reply-To: <20210712162208.2396-1-rpalethorpe@suse.com>
References: <20210712162208.2396-1-rpalethorpe@suse.com>
Message-ID: <YPbDGQ3vIRpF87vD@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "tst_test.h"
> +#include "tst_clone.h"
> +#include "lapi/clone.h"
> +#include "tst_safe_file_at.h"
> +
> +static pid_t clone_newuser(void)
> +{
> +	const struct tst_clone_args cargs = {
> +		CLONE_NEWUSER,
> +		SIGCHLD };

I would have put the closing curly brace on a separate line here, but
that is very minor.

> +	return SAFE_CLONE(&cargs);
> +}
> +
> +static void write_mapping(const pid_t proc_in_ns,
> +			  const char *const id_mapping)
> +{
> +	char proc_path[PATH_MAX];
> +	int proc_dir;
> +
> +	sprintf(proc_path, "/proc/%d", (int)proc_in_ns);
> +	proc_dir = SAFE_OPEN(proc_path, O_DIRECTORY);
> +
> +	TEST(faccessat(proc_dir, "uid_map", F_OK, 0));
> +	if (TST_RET && TST_ERR == ENOENT)
> +		tst_brk(TCONF, "No uid_map file; interface was added in v3.5");
> +
> +	SAFE_FILE_PRINTFAT(proc_dir, "setgroups", "%s", "deny");
> +	SAFE_FILE_PRINTFAT(proc_dir, "uid_map", "%s", id_mapping);
> +	SAFE_FILE_PRINTFAT(proc_dir, "gid_map", "%s", id_mapping);
> +
> +	SAFE_CLOSE(proc_dir);
> +}
> +
> +static void ns_level2(void)
> +{
> +	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
> +		tst_res(TINFO | TERRNO, "Failed to set dumpable flag");
> +	TST_CHECKPOINT_WAKE(20);
> +	TST_CHECKPOINT_WAIT(21);

We do have TST_CHECKPOINT_WAKE_AND_WAIT() especially for this purpose.

Also the id passed to checkpoints is really offset to a memory, so it
makes sense to allocate them starting at 0 and increase by one.

It's not a big problem as long as the numbers are small enough, we have
nearly whole page for checkpoints, so everything should work fine as
long as the numbers are less than 1000 at the moment, but it may become
one if we attempt to stuff more test library stuff into the shared page
later on.

> +	TST_EXP_FAIL(open("restricted", O_WRONLY), EACCES,
> +		     "Denied write access to ./restricted");
> +
> +	exit(0);
> +}
> +
> +static void ns_level1(void)
> +{
> +	const char *const map_over_5 = "0 0 1\n1 1 1\n2 2 1\n3 3 1\n4 4 1\n5 5 990";
> +	pid_t level2_proc;
> +
> +	TST_CHECKPOINT_WAIT(10);
> +
> +	SAFE_SETGID(0);
> +	SAFE_SETUID(0);
> +
> +	level2_proc = clone_newuser();
> +	if (!level2_proc)
> +		ns_level2();
> +
> +	TST_CHECKPOINT_WAIT(20);
> +
> +	write_mapping(level2_proc, map_over_5);
> +
> +	TST_CHECKPOINT_WAKE(21);
> +	tst_reap_children();
> +
> +	exit(0);
> +}
> +
> +static void run(void)
> +{
> +	pid_t level1_proc;
> +
> +	SAFE_SETEGID(100000);
> +	SAFE_SETEUID(100000);
> +
> +	level1_proc = clone_newuser();
> +	if (!level1_proc)
> +		ns_level1();
> +
> +	SAFE_SETEGID(0);
> +	SAFE_SETEUID(0);
> +
> +	write_mapping(level1_proc, "0 100000 1000");
> +
> +	TST_CHECKPOINT_WAKE(10);
> +	tst_reap_children();
> +}
> +
> +static void setup(void)
> +{
> +	int fd = SAFE_OPEN("restricted", O_CREAT, 0700);
                                          ^
					  huh no |O_WRONLY?

> +	SAFE_WRITE(fd, 1, "\n", 1);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_checkpoints = 1,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d2f007dbe7e4"},
> +		{"CVE", "CVE-2018-18955"},
> +		{}
> +	},
> +};
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
