Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UZiss-0006Zl-EJ
	for ltp-list@lists.sourceforge.net; Tue, 07 May 2013 14:28:50 +0000
Date: Tue, 7 May 2013 16:29:49 +0200
From: chrubis@suse.cz
Message-ID: <20130507142949.GB29725@rei.suse.cz>
References: <1367916033-4056-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1367916033-4056-1-git-send-email-alexey.kodanev@oracle.com>
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
The commit message first line is way too long. Please reformat it as:

Short commit description

Longer commit description that can compose of several lines.

Signed-of-by: ...

> +static void setup(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg = parse_opts(argc, argv, options, &help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	tst_require_root(NULL);
> +
> +	if (tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, &cleanup,
> +			"Test must be run with kernel 3.7 or newer");
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
> +	test_user_cmd("useradd");
> +	/*
> +	 * enable hardlinks and symlinks restrictions,
> +	 * it's not defualt but have to check
> +	 */
> +	if (!get_protected_hlinks()) {
> +		switch_protected_hlinks(1);
> +		disable_protected_hlinks = 1;
> +	}
> +	if (!get_protected_slinks()) {
> +		switch_protected_slinks(1);
> +		disable_protected_slinks = 1;
> +	}
> +
> +	tst_tmpdir();
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
> +		usr_idx,
> +		file_idx;

I usually discurage people from naming variables with idx suffix, the
code gets longer for no reason and it's IMHO is more readable as:

	for (usr = 0; usr < USERS_NUM; ++usr) {
		for (file = 0; file < users[usr].num; ++file) {


> +	const struct user_file *ufile;
> +	/*
> +	 * create symlinks and hardlinks from each user's files
> +	 * to each world writable directory
> +	 */
> +	for (usr_idx = 0; usr_idx < USERS_NUM; ++usr_idx) {
> +		/* get all users files and directories */
> +		for (file_idx = 0; file_idx < users[usr_idx].num; ++file_idx) {
> +			ufile = &users[usr_idx].file[file_idx];
> +			result_slink |= create_check_slinks(ufile, usr_idx);
> +			result_hlink |= create_check_hlinks(ufile, usr_idx);
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
> +	/* call cleanup function only once */
> +	static int first_call = 1;
> +	if (!first_call)
> +		return;
> +	first_call = 0;

I think that slightly cleaner solution would be adding cleanup pointers
to the test_user_cmd() and swith_protected_*links(). But anyway both
works for me.

> +	set_user(NULL);
> +
> +	if (skip_cleanup)
> +		return;
> +
> +	test_user_cmd("userdel -r");
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

I've looked into the C standard to ensure that the ampersand (&) before
the cleanup is redundant here. The function designator (called cleanup
here) is converted into function pointer automatically when ampersand is
not used. Interestingly enough *cleanup would yield the same pointer, as
designator will be converted to pointer, back to designator and again to
pointer...

In short there is no need to add & before function name to get function
pointer.

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
> +static void test_user_cmd(const char *user_cmd)
> +{
> +	char cmd[MAX_CMD_LEN];
> +	snprintf(cmd, MAX_CMD_LEN, "%s %s", user_cmd, users[TEST_USER].name);
> +	if (system(cmd) != 0) {
> +		tst_brkm(TBROK, &cleanup, "Failed to run cmd: %s %s",
> +			user_cmd, users[TEST_USER].name);
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
> +	snprintf(bdir->path, MAX_PATH, "%s/tmp_%s",
> +		path, users[bdir->owner].name);
> +	SAFE_MKDIR(&cleanup, bdir->path, mode);
> +
> +	if (bdir->sticky)
> +		mode |= S_ISVTX;
> +	chmod(bdir->path, mode);
> +}
> +
> +static void init_base_dirs(void)
> +{
> +	char *cwd = get_tst_tmpdir();
> +	cwd_offset = strlen(cwd);
> +
> +	mode_t mode = S_IRWXU | S_IRWXG | S_IRWXO;
> +	chmod(cwd, mode);
> +
> +	struct dir_params *bdir = bdirs;
> +	strcpy(bdir->path, cwd);
> +	free(cwd);
> +
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

IMHO using bdirs[i].sticky etc. would be more readable than looping with
two variables. The same pattern repeats several times.

Also name the loop variable better either simple i or usr.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
