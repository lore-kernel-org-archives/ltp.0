Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B05C27C77
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 12:12:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A680C3D0BA5
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 14:11:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F36D3D0BA5
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:11:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6085014088EE
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:11:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A574343F2
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F0N6sPMJkybMVH+WLETJI5u/JvxkWOhMsHqBwEgFxw=;
 b=S6JwrB2Z/aZZ5/1f+GU+BpnvkkBHsK8XWbpycPABFeTUdJmw/vlxHV20xlQbcD0UIotFat
 qL47nQGaP/J/4C6BAbD6Hw1JPEDxejH/uWysUIsG12XtnC+IcMWNNCUTwq7WcnAzmTrwGe
 KVJb+Mt06hs1ZaMsc7BYOwmrOLC9VsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F0N6sPMJkybMVH+WLETJI5u/JvxkWOhMsHqBwEgFxw=;
 b=2JA4REz6OkRhS0oxmJzpOyjP5fCy/2SBMtJBxyLWP4R76SBf/5xD9ZD0aTn8DAWs4bETfY
 I1ez1fD6i6lQWPDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F0N6sPMJkybMVH+WLETJI5u/JvxkWOhMsHqBwEgFxw=;
 b=S6JwrB2Z/aZZ5/1f+GU+BpnvkkBHsK8XWbpycPABFeTUdJmw/vlxHV20xlQbcD0UIotFat
 qL47nQGaP/J/4C6BAbD6Hw1JPEDxejH/uWysUIsG12XtnC+IcMWNNCUTwq7WcnAzmTrwGe
 KVJb+Mt06hs1ZaMsc7BYOwmrOLC9VsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F0N6sPMJkybMVH+WLETJI5u/JvxkWOhMsHqBwEgFxw=;
 b=2JA4REz6OkRhS0oxmJzpOyjP5fCy/2SBMtJBxyLWP4R76SBf/5xD9ZD0aTn8DAWs4bETfY
 I1ez1fD6i6lQWPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6823B1372E
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FF96FWuQaWZBIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:23 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Jun 2024 14:11:05 +0200
Message-ID: <20240612121106.11127-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240612121106.11127-1-chrubis@suse.cz>
References: <20240612121106.11127-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit does:

* Group the filesystem type, mkfs and mount options into a separate
  structure

* Add an array of these structures to be able to define per filesystem
  mkfs and mount options

The details on the usage should be hopefully clear from the
documentation comments for the struct tst_test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                            |  66 ++++++----
 lib/tst_test.c                                | 117 ++++++++++++++----
 .../kernel/syscalls/fanotify/fanotify22.c     |   5 +-
 .../kernel/syscalls/fanotify/fanotify23.c     |   5 +-
 .../kernel/syscalls/getxattr/getxattr04.c     |   5 +-
 testcases/kernel/syscalls/ioctl/ioctl08.c     |   5 +-
 testcases/kernel/syscalls/mmap/mmap16.c       |  22 ++--
 .../kernel/syscalls/quotactl/quotactl01.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl02.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl03.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl04.c     |   5 +-
 .../kernel/syscalls/quotactl/quotactl05.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl07.c     |   5 +-
 .../kernel/syscalls/quotactl/quotactl08.c     |   5 +-
 .../kernel/syscalls/quotactl/quotactl09.c     |   9 +-
 testcases/kernel/syscalls/statx/statx05.c     |   5 +-
 testcases/kernel/syscalls/statx/statx06.c     |  11 +-
 testcases/kernel/syscalls/statx/statx07.c     |   5 +-
 testcases/kernel/syscalls/statx/statx09.c     |   5 +-
 20 files changed, 234 insertions(+), 86 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 8dc20d110..ea1d09972 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -247,6 +247,36 @@ struct tst_ulimit_val {
 	rlim_t rlim_cur;
 };
 
+/**
+ * struct tst_fs - A file system type, mkfs and mount options
+ *
+ * @type A filesystem type to use.
+ *
+ * @mkfs_opts: A NULL terminated array of options passed to mkfs in the case
+ *             of 'tst_test.format_device'. These options are passed to mkfs
+ *             before the device path.
+ *
+ * @mkfs_size_opt: An option passed to mkfs in the case of
+ *                 'tst_test.format_device'. The device size in blocks is
+ *                 passed to mkfs after the device path and can be used to
+ *                 limit the file system not to use the whole block device.
+ *
+ * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
+ *             device in the case of 'tst_test.mount_device'.
+ *
+ * @mnt_data: The data passed to mount(2) when the test library mounts a device
+ *            in the case of 'tst_test.mount_device'.
+ */
+struct tst_fs {
+	const char *type;
+
+	const char *const *mkfs_opts;
+	const char *mkfs_size_opt;
+
+	const unsigned int mnt_flags;
+	const void *mnt_data;
+};
+
 /**
  * struct tst_test - A test description.
  *
@@ -377,29 +407,22 @@ struct tst_ulimit_val {
  *
  * @dev_min_size: A minimal device size in megabytes.
  *
- * @dev_fs_type: If set overrides the default file system type for the device and
- *               sets the tst_device.fs_type.
- *
- * @dev_fs_opts: A NULL terminated array of options passed to mkfs in the case
- *               of 'tst_test.format_device'. These options are passed to mkfs
- *               before the device path.
- *
- * @dev_extra_opts: A NULL terminated array of extra options passed to mkfs in
- *                  the case of 'tst_test.format_device'. Extra options are
- *                  passed to mkfs after the device path. Commonly the option
- *                  after mkfs is the number of blocks and can be used to limit
- *                  the file system not to use the whole block device.
+ * @filesystems: A NULL type terminated array of per file system type
+ *               parameters for mkfs and mount. If the first entry type is NULL
+ *               it describes a default parameters for all file system tests.
+ *               The rest of the entries the describes per file system type
+ *               parameters. If tst_test.all_filesystems is set, the test runs
+ *               for all filesystems and uses the array to lookup the mkfs
+ *               and mount options. If tst_test.all_filesystems is not set
+ *               the test iterates over file system types defined in the array.
+ *               If there is only a single entry in the array with a NULL type,
+ *               the test runs just once for the default file sytem i.e.
+ *               $TST_FS_TYPE.
  *
  * @mntpoint: A mount point where the test library mounts requested file system.
  *            The directory is created by the library, the test must not create
  *            it itself.
  *
- * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
- *             device in the case of 'tst_test.mount_device'.
- *
- * @mnt_data: The data passed to mount(2) when the test library mounts a device
- *            in the case of 'tst_test.mount_device'.
- *
  * @max_runtime: Maximal test runtime in seconds. Any test that runs for more
  *               than a second or two should set this and also use
  *               tst_remaining_runtime() to exit when runtime was used up.
@@ -516,14 +539,9 @@ struct tst_ulimit_val {
 
 	unsigned int dev_min_size;
 
-	const char *dev_fs_type;
-
-	const char *const *dev_fs_opts;
-	const char *const *dev_extra_opts;
+	struct tst_fs *filesystems;
 
 	const char *mntpoint;
-	unsigned int mnt_flags;
-	void *mnt_data;
 
 	int max_runtime;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8c212c983..453169954 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1097,15 +1097,15 @@ static const char *get_device_name(const char *fs_type)
 		return tdev.dev;
 }
 
-static void prepare_device(void)
+static void prepare_device(struct tst_fs *fs)
 {
 	const char *mnt_data;
 	char buf[1024];
 
-	if (tst_test->format_device) {
-		SAFE_MKFS(tdev.dev, tdev.fs_type, tst_test->dev_fs_opts,
-			  tst_test->dev_extra_opts);
-	}
+	const char *const extra[] = {fs->mkfs_size_opt, NULL};
+
+	if (tst_test->format_device)
+		SAFE_MKFS(tdev.dev, tdev.fs_type, fs->mkfs_opts, extra);
 
 	if (tst_test->needs_rofs) {
 		prepare_and_mount_ro_fs(tdev.dev, tst_test->mntpoint,
@@ -1114,11 +1114,11 @@ static void prepare_device(void)
 	}
 
 	if (tst_test->mount_device) {
-		mnt_data = limit_tmpfs_mount_size(tst_test->mnt_data,
+		mnt_data = limit_tmpfs_mount_size(fs->mnt_data,
 				buf, sizeof(buf), tdev.fs_type);
 
 		SAFE_MOUNT(get_device_name(tdev.fs_type), tst_test->mntpoint,
-				tdev.fs_type, tst_test->mnt_flags, mnt_data);
+				tdev.fs_type, fs->mnt_flags, mnt_data);
 		mntpoint_mounted = 1;
 	}
 }
@@ -1160,6 +1160,38 @@ static void set_ulimit_(const char *file, const int lineno, const struct tst_uli
 	safe_setrlimit(file, lineno, conf->resource, &rlim);
 }
 
+static unsigned int count_fs_descs(void)
+{
+	unsigned int ret = 0;
+
+	if (!tst_test->filesystems)
+		return 0;
+
+	/*
+	 * First entry is special, if it has zero type is the it's the default
+	 * entry and is either followed by a terminating entry or by filesystem
+	 * description(s) plus terminating entry.
+	 */
+	if (!tst_test->filesystems[0].type)
+		ret = 1;
+
+	while (tst_test->filesystems[ret].type)
+		ret++;
+
+	return ret;
+}
+
+static const char *default_fs_type(void)
+{
+	if (!tst_test->filesystems)
+		return tst_dev_fs_type();
+
+	if (tst_test->filesystems[0].type)
+		return tst_test->filesystems[0].type;
+
+	return tst_dev_fs_type();
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
@@ -1321,13 +1353,10 @@ static void do_setup(int argc, char *argv[])
 
 		tst_device = &tdev;
 
-		if (tst_test->dev_fs_type)
-			tdev.fs_type = tst_test->dev_fs_type;
-		else
-			tdev.fs_type = tst_dev_fs_type();
+		tdev.fs_type = default_fs_type();
 
-		if (!tst_test->all_filesystems)
-			prepare_device();
+		if (!tst_test->all_filesystems && count_fs_descs() == 1)
+			prepare_device(&tst_test->filesystems[0]);
 	}
 
 	if (tst_test->needs_overlay && !tst_test->mount_device)
@@ -1680,6 +1709,52 @@ static int fork_testrun(void)
 	return 0;
 }
 
+static struct tst_fs *lookup_fs_desc(const char *fs_type, int all_filesystems)
+{
+	struct tst_fs *fs = tst_test->filesystems;
+	static struct tst_fs empty;
+
+	if (!fs)
+		goto ret;
+
+	for (; fs->type; fs++) {
+
+		if (!fs->type)
+			continue;
+
+		if (!strcmp(fs_type, fs->type))
+			return fs;
+	}
+
+ret:
+	if (!all_filesystems)
+		return NULL;
+
+	if (!tst_test->filesystems || tst_test->filesystems[0].type)
+		return &empty;
+
+	return &tst_test->filesystems[0];
+}
+
+static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
+{
+	int ret;
+
+	tst_res(TINFO, "=== Testing on %s ===", fs_type);
+	tdev.fs_type = fs_type;
+
+	prepare_device(fs);
+
+	ret = fork_testrun();
+
+	if (mntpoint_mounted) {
+		tst_umount(tst_test->mntpoint);
+		mntpoint_mounted = 0;
+	}
+
+	return ret;
+}
+
 static int run_tcases_per_fs(void)
 {
 	int ret = 0;
@@ -1690,18 +1765,12 @@ static int run_tcases_per_fs(void)
 		tst_brk(TCONF, "There are no supported filesystems");
 
 	for (i = 0; filesystems[i]; i++) {
+		struct tst_fs *fs = lookup_fs_desc(filesystems[i], tst_test->all_filesystems);
 
-		tst_res(TINFO, "=== Testing on %s ===", filesystems[i]);
-		tdev.fs_type = filesystems[i];
-
-		prepare_device();
-
-		ret = fork_testrun();
+		if (!fs)
+			continue;
 
-		if (mntpoint_mounted) {
-			tst_umount(tst_test->mntpoint);
-			mntpoint_mounted = 0;
-		}
+		run_tcase_on_fs(fs, filesystems[i]);
 
 		if (ret == TCONF)
 			continue;
@@ -1742,7 +1811,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 		test_variants = tst_test->test_variants;
 
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
-		if (tst_test->all_filesystems)
+		if (tst_test->all_filesystems || count_fs_descs() > 1)
 			ret |= run_tcases_per_fs();
 		else
 			ret |= fork_testrun();
diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index f4b7987de..19d437b94 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -319,7 +319,10 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.needs_root = 1,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []){
+		{.type = "ext4"},
+		{}
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "124e7c61deb2"},
 		{}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 35a613fea..957eba19a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -256,7 +256,10 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	/* Shrinkers on other fs do not work reliably enough to guarantee mark eviction on drop_caches */
-	.dev_fs_type = "ext2",
+	.filesystems = (struct tst_fs []){
+		{.type = "ext2"},
+		{}
+	},
 };
 
 #else
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 61c8826c9..27059fef0 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -105,7 +105,10 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
-	.dev_fs_type = "xfs",
+	.filesystems = (struct tst_fs []){
+		{.type = "xfs"},
+		{}
+	},
 	.mntpoint = MNTPOINT,
 	.forks_child = 1,
 	.test_all = verify_getxattr,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 1fb195797..834c5ae74 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -126,7 +126,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "btrfs",
+	.filesystems = (struct tst_fs []) {
+		{.type = "btrfs"},
+		{}
+	},
 	.needs_drivers = (const char *const[]) {
 		"btrfs",
 		NULL,
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index 4e0d8a3f4..6b1708dff 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -176,19 +176,15 @@ static struct tst_test test = {
 	.needs_checkpoints = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "ext4",
-	.dev_fs_opts = (const char *const[]){
-		"-b",
-		"1024",
-		NULL,
-	},
-	.dev_extra_opts = (const char *const[]){
-		"10240",
-		NULL,
-	},
-	.needs_cmds = (const char *const[]){
-		"mkfs.ext4",
-		NULL,
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const[]){
+				"-b", "1024", NULL
+			},
+			.mkfs_size_opt = "10240",
+		},
+		{}
 	},
 	.tags = (const struct tst_tag[]){
 		{"linux-git", "d6320cbfc929"},
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 36ec93edc..7b7fb6360 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -216,9 +216,14 @@ static struct tst_test test = {
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext4",
+			.mnt_data = "usrquota,grpquota",
+		},
+		{}
+	},
 	.mntpoint = MNTPOINT,
-	.mnt_data = "usrquota,grpquota",
 	.needs_cmds = (const char *const []) {
 		"quotacheck",
 		NULL
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index d9c4f9b2e..f83716556 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -150,9 +150,14 @@ static struct tst_test test = {
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
-	.dev_fs_type = "xfs",
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "xfs",
+			.mnt_data = "usrquota,grpquota",
+		},
+		{}
+	},
 	.mntpoint = MNTPOINT,
-	.mnt_data = "usrquota,grpquota",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 22f5496b6..78d9a5458 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -83,9 +83,14 @@ static struct tst_test test = {
 	},
 	.test_all = verify_quota,
 	.mount_device = 1,
-	.dev_fs_type = "xfs",
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "xfs",
+			.mnt_data = "usrquota",
+		},
+		{}
+	},
 	.mntpoint = MNTPOINT,
-	.mnt_data = "usrquota",
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "657bdfb7f5e6"},
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index a57e6be60..7fdff6502 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -162,7 +162,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_device = 1,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{.type = "ext4"},
+		{}
+	},
 	.mntpoint = MNTPOINT,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.needs_cmds = (const char *[]) {
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index ac75cee31..d19c729f8 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -113,9 +113,14 @@ static struct tst_test test = {
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
-	.dev_fs_type = "xfs",
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "xfs",
+			.mnt_data = "prjquota",
+		},
+		{}
+	},
 	.mntpoint = MNTPOINT,
-	.mnt_data = "prjquota",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 74a098a8c..86b0d95d2 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -219,10 +219,15 @@ static struct tst_test test = {
 	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_quotactl,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext4",
+			.mnt_data = "usrquota",
+		},
+		{}
+	},
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
-	.mnt_data = "usrquota",
 	.needs_cmds = (const char *const []) {
 		"quotacheck",
 		NULL
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index 34ff2705d..c4caad99a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -83,7 +83,10 @@ static struct tst_test test = {
 	},
 	.test_all = verify_quota,
 	.format_device = 1,
-	.dev_fs_type = "xfs",
+	.filesystems = (struct tst_fs []) {
+		{.type = "xfs"},
+		{}
+	},
 	.mntpoint = MNTPOINT,
 	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 0fabb51a5..aafb1cd2b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -216,7 +216,10 @@ static struct tst_test test = {
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{.type = "ext4"},
+		{}
+	},
 	.needs_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 9a03bff5f..4ddcbd659 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -176,8 +176,13 @@ static struct tst_test test = {
 	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_quotactl,
-	.dev_fs_opts = (const char *const[]){"-O quota", NULL},
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const[]){"-O quota", NULL},
+		},
+		{}
+	},
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 9781b3e70..2411f3f9f 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -121,7 +121,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{.type = "ext4"},
+		{}
+	},
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4 >= 1.43.0",
 		"e4crypt",
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 1771dff49..d3dd9b9cf 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -155,7 +155,12 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mntpoint = MOUNT_POINT,
 	.mount_device = 1,
-	.dev_fs_type = "ext4",
-	.dev_fs_opts = (const char *const []){"-I", "256", NULL},
-	.mnt_flags = MS_STRICTATIME,
+	.filesystems = (struct tst_fs[]) {
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const []){"-I", "256", NULL},
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{}
+	},
 };
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 1a568ec9e..7b02cfae7 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -168,7 +168,10 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "4.16",
 	.needs_tmpdir = 1,
-	.dev_fs_type = "nfs",
+	.filesystems = (struct tst_fs []) {
+		{.type = "nfs"},
+		{}
+	},
 	.needs_root = 1,
 	.needs_cmds = (const char *[]) {
 		"exportfs",
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index 6e75ff3ec..864e35c7d 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -156,7 +156,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
 	.mntpoint = MNTPOINT,
-	.dev_fs_type = "ext4",
+	.filesystems = (struct tst_fs []) {
+		{.type = "ext4"},
+		{}
+	},
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_FS_VERITY",
 		NULL
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
