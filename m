Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UZLkE-0002GO-8M
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:46:22 +0000
Date: Mon, 6 May 2013 15:47:22 +0200
From: chrubis@suse.cz
Message-ID: <20130506134721.GE4388@rei>
References: <1367833278-18177-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1367833278-18177-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of hardlinks and symlinks
 restrictions added in Linux 3.6. Disabled by default in Linux 3.7.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <pwd.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <signal.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "prot_hsymlinks";
> +int TST_TOTAL = 396;
> +
> +/* create 3 files and 1 dir in each base dir */
> +#define MAX_FILES_CREATED	4
> +#define MAX_PATH		128
> +#define MAX_CMD_LEN		64
> +#define MAX_USER_NAME		16
> +
> +enum {
> +	ROOT = 0,
> +	TEST_USER,
> +	USERS_NUM
> +};
> +
> +#define BASE_DIR_NUM		(USERS_NUM+1)
> +/*
> + * max test files and directories
> + * that will be created during the test
> + * is't not include symlinks and hardlinks
> + * and base directories
> + */
> +#define MAX_ENTITIES		(MAX_FILES_CREATED*BASE_DIR_NUM)
> +
> +struct dir_params {
> +	char path[MAX_PATH];
> +	int world_writable;
> +	int sticky;
> +	int owner;
> +};
> +
> +static struct dir_params bdirs[BASE_DIR_NUM];
> +
> +static const char *file_postfix = ".hs";

Although postfix is synonym for suffix it is also mailer daenom, name as
file_suffix or file_ext (as for extension) would be better.

> +enum {
> +	IS_FILE = 0,
> +	IS_DIRECTORY,
> +};
> +
> +struct user_file {
> +	char path[MAX_PATH];
> +	int is_dir;
> +};
> +
> +struct test_user {
> +	char name[MAX_USER_NAME];
> +	struct user_file file[MAX_ENTITIES];
> +	int num;
> +};
> +
> +static struct test_user users[USERS_NUM];
> +
> +struct link_info {
> +	char path[MAX_PATH];
> +	int owner;
> +	int source_owner;
> +	int in_world_write;
> +	int in_sticky;
> +	int is_dir;
> +	int dir_owner;
> +};
> +
> +/* test flags */
> +enum {
> +	CANNOT_FOLLOW = -1,
> +	CAN_FOLLOW = 0,
> +};
> +
> +enum {
> +	CANNOT_CREATE = -1,
> +	CAN_CREATE = 0,
> +};
> +
> +static char *tmp_user_name;
> +static char *default_user = "hsym";
> +static int nflag;
> +static int skip_cleanup;
> +
> +option_t options[] = {
> +	{"u:", &nflag, &tmp_user_name},	/* -u #user name */
> +	{"s", &skip_cleanup, NULL},
> +	{NULL, NULL, NULL}
> +};
> +/* full length of the test tmpdir path in /tmp */
> +static int cwd_offset;
> +
> +static const char *hrdlink_proc_path	= "/proc/sys/fs/protected_hardlinks";
> +static const char *symlink_proc_path	= "/proc/sys/fs/protected_symlinks";
> +
> +static void help(void);
> +static void setup(int ac, char **av);
> +static void cleanup(void);
> +
> +static void create_test_user(void);
> +static void delete_test_user(void);
> +
> +static int disable_protected_slinks;
> +static int disable_protected_hlinks;
> +
> +/*
> + * changes links restrictions
> + * @param value can be:
> + * 0 - restrictions is off
> + * 1 - restrictions is on
> + */
> +static void switch_protected_slinks(int value);
> +static void switch_protected_hlinks(int value);
> +
> +static int get_protected_slinks(void);
> +static int get_protected_hlinks(void);
> +
> +static void create_link_path(char *buffer, int size, const char *path);
> +static int create_check_hlinks(const struct user_file *ufile, int owner_idx);
> +static int create_check_slinks(const struct user_file *ufile, int owner_idx);
> +static int check_symlink(const struct link_info *li);
> +static int try_fopen(const char *name, int mode);
> +/* try to open symlink in diff modes */
> +static int try_symlink(const char *name);
> +
> +static int test_run(void);
> +static void init_base_dirs(void);
> +static void init_files_dirs(void);
> +
> +/* change effective user id and group id by name
> + * pass NULL to set root
> + */
> +static void set_user(const char *name);
> +
> +/* add new created files to user struct */
> +static void ufiles_add(int user_idx, char *path, int type);
> +
> +int main(int ac, char **av)
> +{
> +	setup(ac, av);
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}
> +
> +static void setup(int ac, char **av)
> +{
> +	char *msg;
> +	msg = parse_opts(ac, av, options, &help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, &cleanup,
> +		"Test must be run with kernel 3.7 or newer");
> +	}
> +
> +	/* initialize user names */
> +	strcpy(users[ROOT].name, "root");
> +
> +	if (tmp_user_name == NULL)
> +		tmp_user_name = default_user;
> +	snprintf(users[TEST_USER].name, MAX_USER_NAME, "%s", tmp_user_name);
> +
> +	tst_sig(FORK, DEF_HANDLER, &cleanup);
> +
> +	create_test_user();
> +	/*
> +	 * enable hardlinks and symlinks restrictions,
> +	 * it's not defualt but have to check
> +	 */
> +	if (!get_protected_hlinks()) {
> +	    switch_protected_hlinks(1);
> +	    disable_protected_hlinks = 1;
> +	}
> +	if (!get_protected_slinks()) {
> +	    switch_protected_slinks(1);
> +	    disable_protected_slinks = 1;

Use tabs for indentation. And look for lines over 80 chars. Please use
checkpatch.pl from linux kernel sources to check the patch next time.

> +	}
> +
> +	init_base_dirs();
> +
> +	init_files_dirs();
> +}
> +
> +static int test_run(void)
> +{
> +	tst_resm(TINFO, " --- HARDLINKS AND SYMLINKS RESTRICTIONS TEST ---\n");
> +
> +	int	result_slink = 0,
> +		result_hlink = 0,
> +		owner_idx,
> +		file_idx;
> +
> +	const struct user_file *ufile;
> +	/*
> +	 * create symlinks and hardlinks from each user's files
> +	 * to each world writable directory
> +	 */
> +	for (owner_idx = 0; owner_idx < USERS_NUM; ++owner_idx) {
> +		/* get all users files and directories */
> +		for (file_idx = 0; file_idx < users[owner_idx].num; ++file_idx) {
> +			ufile = &users[owner_idx].file[file_idx];
> +			result_slink |= create_check_slinks(ufile, owner_idx);
> +			result_hlink |= create_check_hlinks(ufile, owner_idx);
> +		}
> +	}
> +
> +	/* final results */
> +	tst_resm(TINFO, "All test-cases have been completed, summary:\n"
> +		" - symlinks  test:\t%s\n"
> +		" - hardlinks test:\t%s",
> +		(result_slink == 1) ? "FAIL" : "PASS",
> +		(result_hlink == 1) ? "FAIL" : "PASS");
> +
> +	return result_slink | result_hlink;
> +}
> +
> +static void cleanup(void)
> +{
> +	set_user(NULL);
> +
> +	if (skip_cleanup)
> +		return;
> +
> +	delete_test_user();
> +
> +	if (disable_protected_hlinks) {
> +		tst_resm(TINFO, "Disable protected hardlinks mode back");
> +		switch_protected_hlinks(0);
> +	}
> +	if (disable_protected_slinks) {
> +		tst_resm(TINFO, "Disable protected symlinks mode back");
> +		switch_protected_slinks(0);
> +	}
> +
> +	tst_rmdir();
> +	TEST_CLEANUP;
> +}
> +
> +static int get_protected_hlinks(void)
> +{
> +	int value = 0;
> +	SAFE_FILE_SCANF(&cleanup, hrdlink_proc_path, "%d", &value);
> +	return value;
> +}
> +
> +static int get_protected_slinks(void)
> +{
> +	int value = 0;
> +	SAFE_FILE_SCANF(&cleanup, symlink_proc_path, "%d", &value);
> +	return value;
> +}
> +
> +static void switch_protected_hlinks(int value)
> +{
> +	SAFE_FILE_PRINTF(&cleanup, hrdlink_proc_path, "%d", value == 1);
> +}
> +
> +static void switch_protected_slinks(int value)
> +{
> +	SAFE_FILE_PRINTF(&cleanup, symlink_proc_path, "%d", value == 1);
> +}
> +
> +static void create_test_user(void)
> +{
> +	char cmd[MAX_CMD_LEN];
> +	snprintf(cmd, MAX_CMD_LEN, "%s %s", "useradd", users[TEST_USER].name);

You can change the format string to "useradd %s" ;)

> +	if (system(cmd) != 0) {
> +		tst_brkm(TBROK, &cleanup, "Can't create new user: %s",
> +			users[TEST_USER].name);
> +	}
> +}
> +
> +static void delete_test_user(void)
> +{
> +	char cmd[MAX_CMD_LEN];
> +	snprintf(cmd, MAX_CMD_LEN, "%s %s", "userdel -r", users[TEST_USER].name);

Here as well.

> +	if (system(cmd) != 0) {
> +		tst_brkm(TBROK, &cleanup, "Can't delete user: %s",
> +			users[TEST_USER].name);

You are calling this function from cleanup right? So if this fails the
cleanup function will be called which would again get to this point and
call cleanup etc...

> +	}
> +}
> +
> +static void help(void)
> +{
> +	printf("  -s      Skip cleanup.\n");
> +	printf("  -u #user name : Define test user\n");
> +}
> +
> +static void create_sub_dir(const char *path,
> +	struct dir_params *bdir, mode_t mode)
> +{
> +	snprintf(bdir->path, MAX_PATH, "%s/tmp_%s", path, users[bdir->owner].name);
> +	SAFE_MKDIR(&cleanup, bdir->path, mode);
> +
> +	if (bdir->sticky)
> +	    mode |= S_ISVTX;
> +	chmod(bdir->path, mode);
> +}
> +
> +static void init_base_dirs(void)
> +{
> +	memset(&bdirs, 0, sizeof(bdirs));

Again bdirs is global variable and as such is initialized to zero
automatically.

> +	/* create main dir, world-writable */
> +	tst_tmpdir();

It is customary to call this function in setup, so that everyone knows
the test creates temporary directory.

> +	char *cwd = get_tst_tmpdir();
> +	cwd_offset = strlen(cwd);
> +
> +	mode_t mode = S_IRWXU | S_IRWXG | S_IRWXO;
> +	chmod(cwd, mode);
> +
> +	struct dir_params *bdir = bdirs;
> +	strcpy(bdir->path, cwd);
> +	free(cwd);

Do you really need the global path to the tst tmp dir? The call to
tst_tmpdir() changes your CWD to it, so at least the subdirs could be
created with local paths.

> +	bdir->sticky  = 0;
> +	bdir->world_writable = 1;
> +
> +	/* create subdir for each user */
> +	++bdir;
> +	int idx;
> +	for (idx = 0; idx < USERS_NUM; ++idx, ++bdir) {
> +		set_user(users[idx].name);
> +
> +		bdir->sticky  = 1;
> +		bdir->world_writable = 1;
> +		bdir->owner = idx;
> +
> +		create_sub_dir(bdirs[0].path, bdir, mode);
> +	}
> +}
> +
> +static void init_files_dirs(void)
> +{
> +	int i, owner_idx;
> +	/* create all other dirs and files */
> +	const struct dir_params *bdir = bdirs;
> +	for (i = 0; i < ARRAY_SIZE(bdirs); ++i, ++bdir) {
> +		for (owner_idx = 0; owner_idx < USERS_NUM; ++owner_idx) {
> +			set_user(users[owner_idx].name);
> +			char path[MAX_PATH];
> +
> +			/* create file in the main directory */
> +			snprintf(path, MAX_PATH, "%s/%s%s",
> +				bdir->path, users[owner_idx].name, file_postfix);
> +			ufiles_add(owner_idx, path, IS_FILE);
> +
> +			/* create file with S_IWOTH bit set */
> +			strcat(path, "_w");
> +			ufiles_add(owner_idx, path, IS_FILE);
> +
> +			chmod(path, S_IRUSR | S_IRGRP | S_IWOTH | S_IROTH);
> +
> +			/* create sub directory */
> +			snprintf(path, MAX_PATH, "%s/%s", bdir->path,
> +				users[owner_idx].name);
> +			ufiles_add(owner_idx, path, IS_DIRECTORY);
> +
> +			/* create local file inside sub directory */
> +			snprintf(path + strlen(path), MAX_PATH - strlen(path),
> +				"/local_%s%s", users[owner_idx].name, file_postfix);
> +			ufiles_add(owner_idx, path, IS_FILE);
> +		}
> +	}
> +}
> +
> +static void ufiles_add(int user_idx, char *path, int type)
> +{
> +	int file_idx = users[user_idx].num;
> +
> +	if (file_idx >= MAX_ENTITIES)
> +		tst_brkm(TBROK, &cleanup, "Unexpected number of files");
> +
> +	struct user_file *ufile = &users[user_idx].file[file_idx];
> +
> +	if (type == IS_FILE)
> +		SAFE_CREAT(&cleanup, path, 0644);
> +	else
> +		SAFE_MKDIR(&cleanup, path, 0755);
> +
> +	strcpy(ufile->path, path);
> +
> +	ufile->is_dir = (type == IS_DIRECTORY);
> +	++users[user_idx].num;
> +}
> +
> +static void create_link_path(char *buffer, int size, const char *path)
> +{
> +	/* to make sure name is unique */
> +	static int count;
> +	++count;
> +
> +	/* construct link name */
> +	snprintf(buffer, size, "%s/link_%d", path, count);
> +}
> +
> +static int create_check_slinks(const struct user_file *ufile, int owner_idx)
> +{
> +	int result = 0;
> +	int i, user_idx;
> +
> +	const struct dir_params *bdir = bdirs;
> +	for (i = 0; i < ARRAY_SIZE(bdirs); ++i, ++bdir) {
> +		for (user_idx = 0; user_idx < USERS_NUM; ++user_idx) {
> +			/* set user who will create symlink */
> +			set_user(users[user_idx].name);
> +
> +			struct link_info slink_info;
> +			create_link_path(slink_info.path, MAX_PATH, bdir->path);
> +
> +			slink_info.owner = user_idx;
> +			slink_info.source_owner = owner_idx;
> +			slink_info.in_world_write = bdir->world_writable;
> +			slink_info.in_sticky = bdir->sticky;
> +			slink_info.dir_owner = bdir->owner;
> +
> +			if (symlink(ufile->path, slink_info.path) == -1) {
> +				tst_brkm(TBROK, &cleanup, "Can't create symlink: %s",
> +					slink_info.path);
> +			}
> +			result |= check_symlink(&slink_info);
> +		}
> +	}
> +	return result;
> +}
> +
> +static int create_check_hlinks(const struct user_file *ufile, int owner_idx)
> +{
> +	int result = 0;
> +	int i, user_idx;
> +	const struct dir_params *bdir = bdirs;
> +	for (i = 0; i < ARRAY_SIZE(bdirs); ++i, ++bdir) {
> +		for (user_idx = 0; user_idx < USERS_NUM; ++user_idx) {
> +			/* can't create hardlink to directory */
> +			if (ufile->is_dir)
> +				continue;
> +			/* set user who will create hardlink */
> +			set_user(users[user_idx].name);
> +
> +			struct link_info hlink_info;
> +			create_link_path(hlink_info.path, MAX_PATH, bdir->path);
> +
> +			int can_write = try_fopen(ufile->path, O_WRONLY) == 0;
> +
> +			int tst_flag = (can_write || user_idx == owner_idx ||
> +				user_idx == ROOT) ? CAN_CREATE : CANNOT_CREATE;
> +
> +			int fail = tst_flag != link(ufile->path, hlink_info.path);
> +
> +			result |= fail;
> +			tst_resm((fail) ? TFAIL : TPASS,
> +				"Expect: %s create hardlink \"...%s\" to \"...%s\", "
> +				"owner \"%s\", curr.user \"%s\", w(%d)",
> +				(tst_flag == CAN_CREATE) ? "can" : "can't",
> +				ufile->path + cwd_offset,
> +				hlink_info.path + cwd_offset,
> +				users[owner_idx].name, users[user_idx].name,
> +				can_write);
> +		}
> +	}
> +	return result;
> +}
> +
> +static int check_symlink(const struct link_info *li)
> +{
> +	int symlink_result = 0;
> +	int user_idx;
> +	for (user_idx = 0; user_idx < USERS_NUM; ++user_idx) {
> +		set_user(users[user_idx].name);
> +		int tst_flag = (user_idx == li->dir_owner &&
> +			li->in_world_write && li->in_sticky &&
> +			user_idx != li->owner) ? CANNOT_FOLLOW : CAN_FOLLOW;
> +
> +		int fail = tst_flag != try_symlink(li->path);
> +
> +		symlink_result |= fail;
> +
> +		tst_resm((fail) ? TFAIL : TPASS,
> +			"Expect: %s follow symlink \"...%s\", "
> +			"owner \"%s\", src.owner \"%s\", "
> +			"curr.user \"%s\", dir.owner \"%s\"",
> +			(tst_flag == CAN_FOLLOW) ? "can" : "can't",
> +			li->path + cwd_offset, users[li->owner].name,
> +			users[li->source_owner].name, users[user_idx].name,
> +			users[li->dir_owner].name);
> +	}

If you use simple quotes you don't have to escape then in the format
string such as: "Failed to find usere '%s'"

> +	return symlink_result;
> +}
> +
> +/* differenet modes to try in the test */
> +static const int o_modes[] = {
> +	O_RDONLY,
> +	O_WRONLY,
> +	O_RDWR,
> +	O_RDONLY | O_NONBLOCK | O_DIRECTORY,
> +};
> +
> +static int try_symlink(const char *name)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(o_modes); ++i) {
> +		if (try_fopen(name, o_modes[i]) != -1)
> +			return CAN_FOLLOW;
> +	}
> +
> +	return CANNOT_FOLLOW;
> +}
> +
> +static int try_fopen(const char *name, int mode)
> +{
> +	int fd = open(name, mode);
> +
> +	if (fd == -1)
> +		return fd;
> +
> +	if (close(fd) == -1)
> +		tst_brkm(TBROK, &cleanup, "Can't close file: %s", name);
> +
> +	return 0;
> +}

This function name is confusing, it has fopen in name but calls open.

> +static void set_user(const char *name)
> +{
> +	uid_t user_id = 0;
> +	gid_t user_gr = 0;
> +
> +	if (name != NULL) {
> +		struct passwd *pswd = getpwnam(name);
> +
> +		if (pswd == 0)
> +			tst_brkm(TBROK, &cleanup, "Failed to find user \"%s\"", name);
> +		user_id = pswd->pw_uid;
> +		user_gr = pswd->pw_gid;
> +	}
> +
> +	SAFE_SETEGID(&cleanup, user_gr);
> +	SAFE_SETEUID(&cleanup, user_id);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
