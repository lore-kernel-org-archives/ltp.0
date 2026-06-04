Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6034CD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 10:32:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 223CC3E60BA
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8432C3C5AA2
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 12:31:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9B7A26005C3
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 12:31:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18EAC6A7CB;
 Thu,  4 Jun 2026 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780569103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bASTCIyd0VQms5Y4MjFq3HIMVaHibfHeAsocOri8iKM=;
 b=ruD29aTe1yuwurdIur+SAKflezU3bddSWG1EBKorI/l2YI9/WfCuT4Y7whcOOxXcqYjOmQ
 MM6SrzpVhNn0gj605B/7TuGsrHQGVGqazbNUex2XTbdnCnn9WI20coCeDDkBdjdV40yqf6
 DytbNxaQJv7SX279krHODqse9a+aCYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780569103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bASTCIyd0VQms5Y4MjFq3HIMVaHibfHeAsocOri8iKM=;
 b=9YfMPnPSSwUi1nzQAujJ7pp1ekAgC09BAttNB9IiohL342emJPPa1xJRad42xE8+6eUoBG
 Hty+KMjem6j5XhCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780569103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bASTCIyd0VQms5Y4MjFq3HIMVaHibfHeAsocOri8iKM=;
 b=ruD29aTe1yuwurdIur+SAKflezU3bddSWG1EBKorI/l2YI9/WfCuT4Y7whcOOxXcqYjOmQ
 MM6SrzpVhNn0gj605B/7TuGsrHQGVGqazbNUex2XTbdnCnn9WI20coCeDDkBdjdV40yqf6
 DytbNxaQJv7SX279krHODqse9a+aCYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780569103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bASTCIyd0VQms5Y4MjFq3HIMVaHibfHeAsocOri8iKM=;
 b=9YfMPnPSSwUi1nzQAujJ7pp1ekAgC09BAttNB9IiohL342emJPPa1xJRad42xE8+6eUoBG
 Hty+KMjem6j5XhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 082E5779A8;
 Thu,  4 Jun 2026 10:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zTgdAQ9UIWoGBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Jun 2026 10:31:43 +0000
Date: Thu, 4 Jun 2026 12:31:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <aiFUB1QyVXZcM-ah@yuki.lan>
References: <20260604065417.25924-1-sachinp@linux.ibm.com>
 <20260604065417.25924-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260604065417.25924-2-sachinp@linux.ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/8] fs/acl: Add ACL_USER_OBJ permissions test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/* Extended attribute test values */
> +#define XATTR_TEST_DIR_NAME	"user.test_attr"
> +#define XATTR_TEST_DIR_VALUE	"test_value"
> +#define XATTR_TEST_DIR_SIZE	10
> +#define XATTR_TEST_FILE_NAME	"user.file_attr"
> +#define XATTR_TEST_FILE_VALUE	"file_val"
> +#define XATTR_TEST_FILE_SIZE	8
> +#define XATTR_TEST1_NAME	"user.test1"
> +#define XATTR_TEST1_VALUE	"value1"
> +#define XATTR_TEST1_SIZE	6
> +#define XATTR_TEST2_NAME	"user.test2"
> +#define XATTR_TEST2_VALUE	"value2"
> +#define XATTR_TEST2_SIZE	6
> +
> +/* Global variables for test users */
> +extern uid_t user1_uid, user2_uid, user3_uid;
> +extern gid_t user1_gid, user2_gid, user3_gid;
> +extern int users_created;
> +
> +/* Helper functions */
> +static inline void reset_test_path_no_chown(void)
> +{
> +	if (unlink(TESTSYMLINK) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
> +
> +	if (unlink(TESTFILE) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
> +
> +	if (rmdir(TESTDIR) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);
> +
> +	SAFE_MKDIR(TESTDIR, 0755);
> +}
> +
> +static inline void reset_test_path(void)
> +{
> +	reset_test_path_no_chown();
> +	SAFE_CHOWN(TESTDIR, user1_uid, user1_gid);
> +}
> +
> +static inline void cleanup_testfile(void)
> +{
> +	if (unlink(TESTFILE) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
> +}
> +
> +#ifdef HAVE_LIBACL
> +static inline void safe_acl_free(void *ptr)
> +{
> +	if (ptr && acl_free(ptr) == -1)
> +		tst_res(TWARN | TERRNO, "acl_free failed");
> +}
> +
> +static inline void safe_add_perm(acl_permset_t permset, acl_perm_t perm)
> +{
> +	if (acl_add_perm(permset, perm) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_add_perm failed");
> +}
> +
> +static inline void safe_fill_permset(acl_permset_t permset, int perms)
> +{
> +	if (acl_clear_perms(permset) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_clear_perms failed");
> +
> +	if (perms & ACL_READ)
> +		safe_add_perm(permset, ACL_READ);
> +
> +	if (perms & ACL_WRITE)
> +		safe_add_perm(permset, ACL_WRITE);
> +
> +	if (perms & ACL_EXECUTE)
> +		safe_add_perm(permset, ACL_EXECUTE);
> +}
> +
> +/*
> + * Helper to clear ACL mask permissions.
> + * Finds the ACL_MASK entry in the given ACL and sets its permissions to 0.
> + */
> +static inline void clear_acl_mask_perms(acl_t acl)
> +{
> +	acl_entry_t entry;
> +	acl_permset_t permset;
> +	acl_tag_t tag;
> +	int i;
> +
> +	for (i = ACL_FIRST_ENTRY; ; i = ACL_NEXT_ENTRY) {
> +		int ret = acl_get_entry(acl, i, &entry);
> +
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "acl_get_entry failed");
> +
> +		if (ret != 1)
> +			break;
> +
> +		if (acl_get_tag_type(entry, &tag) == -1)
> +			tst_brk(TBROK | TERRNO, "acl_get_tag_type failed");
> +
> +		if (tag != ACL_MASK)
> +			continue;
> +
> +		if (acl_get_permset(entry, &permset) == -1)
> +			tst_brk(TBROK | TERRNO, "acl_get_permset failed");
> +
> +		safe_fill_permset(permset, 0);
> +
> +		if (acl_set_permset(entry, permset) == -1)
> +			tst_brk(TBROK | TERRNO, "acl_set_permset failed");
> +
> +		break;
> +	}
> +}
> +
> +/*
> + * Helper to add an ACL entry with optional qualifier.
> + * For ACL_USER and ACL_GROUP tags, qualifier must be provided.
> + * For other tags (ACL_USER_OBJ, ACL_GROUP_OBJ, ACL_OTHER, ACL_MASK),
> + * qualifier should be NULL.
> + */
> +static inline void add_acl_entry_with_qualifier(acl_t acl, acl_tag_t tag,
> +						const void *qualifier,
> +						int perms)
> +{
> +	acl_entry_t entry;
> +	acl_permset_t permset;
> +
> +	if (acl_create_entry(&acl, &entry) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_create_entry failed");
> +
> +	if (acl_set_tag_type(entry, tag) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_set_tag_type failed");
> +
> +	/* Set qualifier for ACL_USER and ACL_GROUP entries */
> +	if (qualifier && acl_set_qualifier(entry, qualifier) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_set_qualifier failed");
> +
> +	if (acl_get_permset(entry, &permset) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_get_permset failed");
> +
> +	safe_fill_permset(permset, perms);
> +
> +	if (acl_set_permset(entry, permset) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_set_permset failed");
> +}
> +
> +/* Convenience wrapper for entries without qualifiers */
> +static inline void add_acl_entry(acl_t acl, acl_tag_t tag, int perms)
> +{
> +	add_acl_entry_with_qualifier(acl, tag, NULL, perms);
> +}
> +
> +/* Convenience wrapper for named user entries */
> +static inline void add_named_user_acl_entry(acl_t acl, uid_t uid, int perms)
> +{
> +	add_acl_entry_with_qualifier(acl, ACL_USER, &uid, perms);
> +}
> +
> +/* Convenience wrapper for named group entries */
> +static inline void add_named_group_acl_entry(acl_t acl, gid_t gid, int perms)
> +{
> +	add_acl_entry_with_qualifier(acl, ACL_GROUP, &gid, perms);
> +}
> +
> +static inline void add_empty_acl_entry(acl_t acl, acl_tag_t tag)
> +{
> +	add_acl_entry(acl, tag, 0);
> +}
> +
> +static inline void set_acl_file(const char *path, acl_type_t type, acl_t acl)
> +{
> +	if (acl_valid(acl) == -1)
> +		tst_brk(TBROK | TERRNO, "acl_valid failed");
> +
> +	if (acl_set_file(path, type, acl) == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "ACL not supported on %s",
> +				path);
> +		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", path);
> +	}
> +}
> +#endif
> +
> +static inline int create_file_as(uid_t uid, gid_t gid, mode_t mode,
> +				 int use_umask, mode_t mask)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		int fd, err;
> +
> +		if (setgroups(0, NULL) == -1) {
> +			err = errno;
> +			_exit(err);
> +		}
> +
> +		if (setgid(gid) == -1) {
> +			err = errno;
> +			_exit(err);
> +		}
> +
> +		if (setuid(uid) == -1) {
> +			err = errno;
> +			_exit(err);
> +		}
> +
> +		if (use_umask)
> +			umask(mask);
> +
> +		fd = open(TESTFILE, O_CREAT | O_WRONLY, mode);
> +		if (fd >= 0) {
> +			close(fd);
> +			_exit(0);
> +		}
> +
> +		err = errno;
> +		_exit(err);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (!WIFEXITED(status))
> +		tst_brk(TBROK, "Child terminated abnormally");
> +
> +	return WEXITSTATUS(status);
> +}
> +
> +static inline int try_create_as(uid_t uid, gid_t gid, mode_t mode)
> +{
> +	return create_file_as(uid, gid, mode, 0, 0);
> +}
> +
> +static inline int create_with_umask_as(uid_t uid, gid_t gid, mode_t mode,
> +					mode_t mask)
> +{
> +	return create_file_as(uid, gid, mode, 1, mask);
> +}
> +
> +static inline void create_user_if_needed(const char *username, int flag)
> +{
> +	struct passwd *pw;
> +
> +	errno = 0;
> +	pw = getpwnam(username);
> +	if (!pw && errno != 0)
> +		tst_brk(TBROK | TERRNO, "getpwnam(%s) failed", username);
> +
> +	if (!pw) {
> +		if (tst_cmd((const char *[]){"useradd", "-M", "-U", username,
> +			    NULL}, NULL, NULL, TST_CMD_PASS_RETVAL) != 0)
> +			tst_brk(TBROK, "Failed to create user %s", username);
> +		users_created |= flag;
> +	}
> +}
> +
> +static inline void create_test_users(void)
> +{
> +	create_user_if_needed(TEST_USER1, USER1_CREATED);
> +	create_user_if_needed(TEST_USER2, USER2_CREATED);
> +	create_user_if_needed(TEST_USER3, USER3_CREATED);
> +}
> +
> +static inline void init_test_users(void)
> +{
> +	struct passwd *pw;
> +
> +	create_test_users();
> +
> +	pw = SAFE_GETPWNAM(TEST_USER1);
> +	user1_uid = pw->pw_uid;
> +	user1_gid = pw->pw_gid;
> +
> +	pw = SAFE_GETPWNAM(TEST_USER2);
> +	user2_uid = pw->pw_uid;
> +	user2_gid = pw->pw_gid;
> +
> +	pw = SAFE_GETPWNAM(TEST_USER3);
> +	user3_uid = pw->pw_uid;
> +	user3_gid = pw->pw_gid;
> +}
> +
> +static inline void cleanup_test_users(void)
> +{
> +	if (users_created & USER1_CREATED)
> +		tst_cmd((const char *[]){"userdel", TEST_USER1, NULL},
> +			NULL, NULL, TST_CMD_PASS_RETVAL);
> +
> +	if (users_created & USER2_CREATED)
> +		tst_cmd((const char *[]){"userdel", TEST_USER2, NULL},
> +			NULL, NULL, TST_CMD_PASS_RETVAL);
> +
> +	if (users_created & USER3_CREATED)
> +		tst_cmd((const char *[]){"userdel", TEST_USER3, NULL},
> +			NULL, NULL, TST_CMD_PASS_RETVAL);
> +}
> +
> +static inline void cleanup_test_paths(void)
> +{
> +	if (unlink(TESTSYMLINK) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
> +
> +	if (unlink(TESTFILE) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
> +
> +	if (unlink(XATTR_BACKUP_FILE) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed",
> +			XATTR_BACKUP_FILE);
> +
> +	if (rmdir(TESTDIR) == -1 && errno != ENOENT)
> +		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);
> +}

I think that it would actually be way simpler and easier if we avoided
the whole userspace username to UID lookups. The test does not need to
create users, etc. if we simply focus on the kernel part of the ACL
implementation. For that we would create extended attributes with UIDs
(that is what is stored in kernel) and then we could simply run a child
process that sets its UIDs so that they match the rules in extended
attributes. That way there would be no dependency on libacl, no
userspace lookups and we would validate only the kernel part, which is
what LTP should do.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
