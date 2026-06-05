Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E45CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DE443E618B
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:18:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 664553E5477
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:17:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A94F61A009A6
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:17:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 039286A939;
 Fri,  5 Jun 2026 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780651035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqivF00Bk3V7SlPL5IflVkbSe+8An3ipCQiZDqcniVU=;
 b=I792ei7StbR8S+dUsR6lAR8K3FNAdhw8GZApdNqLiwEIs3H8r9NwmQxT3kFeDX0gT0RWen
 0jSDLKCQtQeX+miZr2R1zriUDeCv30ZfIly4EMN/KbPtAdsWT8c4Fxi4nf7Os1dWhM/E90
 Yixkk17CszePKYhBuRW83/r9CB3OdP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780651035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqivF00Bk3V7SlPL5IflVkbSe+8An3ipCQiZDqcniVU=;
 b=5b9bI/UEUyn3P/JnxZnexnXvLJfkADqAfy0t2SIi/TGj2/V4RSW3LRAtTjE17+9omSUYzB
 jrVC0ZU7YxgDblDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780651035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqivF00Bk3V7SlPL5IflVkbSe+8An3ipCQiZDqcniVU=;
 b=I792ei7StbR8S+dUsR6lAR8K3FNAdhw8GZApdNqLiwEIs3H8r9NwmQxT3kFeDX0gT0RWen
 0jSDLKCQtQeX+miZr2R1zriUDeCv30ZfIly4EMN/KbPtAdsWT8c4Fxi4nf7Os1dWhM/E90
 Yixkk17CszePKYhBuRW83/r9CB3OdP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780651035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqivF00Bk3V7SlPL5IflVkbSe+8An3ipCQiZDqcniVU=;
 b=5b9bI/UEUyn3P/JnxZnexnXvLJfkADqAfy0t2SIi/TGj2/V4RSW3LRAtTjE17+9omSUYzB
 jrVC0ZU7YxgDblDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AADC6779AA;
 Fri,  5 Jun 2026 09:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uOXCJhqUImodHAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 05 Jun 2026 09:17:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 05 Jun 2026 11:17:13 +0200
MIME-Version: 1.0
Message-Id: <20260605-doc_add_missing_headers-v6-1-678aac302a60@suse.com>
References: <20260605-doc_add_missing_headers-v6-0-678aac302a60@suse.com>
In-Reply-To: <20260605-doc_add_missing_headers-v6-0-678aac302a60@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780651034; l=43524;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KiIGbnFEe/UEQclhuXfPj1PpC6yEMTtbZl6QCyapf0k=;
 b=T1AtIsmLnIm5MQd7x731Rp9dr5AVS1Nd19tDkNi5m3q61oZ24xMC64LuOBUzQwpgrNPbmmCZW
 qy+e83nMy1ICQLZF+ONUkeX6P4OqCTf8ks4Iu/+XoGO2cQLo3UoDB59
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.cz:email];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] doc: Add missing API references to
 api_c_tests.rst
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add kernel-doc directives for 10 headers that were missing from the C
API documentation page:

  tse_uinput.h, tst_clone.h, tst_device.h, tst_fs.h, tst_fuzzy_sync.h,
  tst_hugepage.h, tst_kconfig.h, tst_memutils.h, tst_safe_file_ops.h,
  tst_taint.h

Convert plain and Doxygen-style comments to kernel-doc format in
tse_uinput.h, tst_clone.h, tst_device.h, tst_fuzzy_sync.h,
tst_hugepage.h, tst_kconfig.h and tst_taint.h so the documentation
builder can extract them. This includes removing leftover Doxygen
directives (@param, @return, @relates, @sa) superseded by the new
kernel-doc comments.

Sort all sections alphabetically under LTP C API.

Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/api_c_tests.rst |  71 ++++++++++---
 include/tse_uinput.h           |  30 +++---
 include/tst_clone.h            |  24 +++--
 include/tst_device.h           | 166 ++++++++++++++++++-----------
 include/tst_fuzzy_sync.h       | 232 ++++++++++++++++++++---------------------
 include/tst_hugepage.h         |  35 +++++--
 include/tst_kconfig.h          |  78 +++++++-------
 include/tst_taint.h            |  32 +++---
 8 files changed, 377 insertions(+), 291 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 65cf6d6cd0be5cb4cd9c986e09df021071d968f1..1e9e595dde24755817396deb2d78ae0a7c56a29a 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -7,46 +7,68 @@
 LTP C API
 =========
 
-Core LTP API
-------------
-.. kernel-doc:: ../../include/tst_res_flags.h
-.. kernel-doc:: ../../include/tst_test.h
-
-Test macros
------------
-.. kernel-doc:: ../../include/tst_test_macros.h
-
 Capabilities
 ------------
 .. kernel-doc:: ../../include/tst_capability.h
 
 Checkpoints
 -----------
-
 .. kernel-doc:: ../../include/tst_checkpoint.h
 
+Clone
+-----
+.. kernel-doc:: ../../include/tst_clone.h
+
 Commands
 --------
 .. kernel-doc:: ../../include/tst_cmd.h
 
+Core LTP API
+------------
+.. kernel-doc:: ../../include/tst_res_flags.h
+.. kernel-doc:: ../../include/tst_test.h
+
 Crypto
 ------
 .. kernel-doc:: ../../include/tst_crypto.h
 .. kernel-doc:: ../../include/tst_af_alg.h
 
+Devices
+-------
+.. kernel-doc:: ../../include/tst_device.h
+
+Filesystems
+-----------
+.. kernel-doc:: ../../include/tst_fs.h
+
+Fuzzy sync
+----------
+.. kernel-doc:: ../../include/tst_fuzzy_sync.h
+
 Guarded buffers
 ---------------
 .. kernel-doc:: ../../include/tst_buffers.h
 
+Hugepages
+---------
+.. kernel-doc:: ../../include/tst_hugepage.h
+
 Kernel
 ------
 .. kernel-doc:: ../../include/tst_kernel.h
 .. kernel-doc:: ../../include/tst_kvercmp.h
 
-Process state
--------------
+Kernel configuration
+--------------------
+.. kernel-doc:: ../../include/tst_kconfig.h
 
-.. kernel-doc:: ../../include/tst_process_state.h
+Kernel taint
+------------
+.. kernel-doc:: ../../include/tst_taint.h
+
+Memory
+------
+.. kernel-doc:: ../../include/tst_memutils.h
 
 NUMA
 ----
@@ -54,17 +76,32 @@ NUMA
 
 Option parsing
 --------------
-
 .. kernel-doc:: ../../include/tst_parse.h
 
+Process state
+-------------
+.. kernel-doc:: ../../include/tst_process_state.h
+
+Safe file operations
+--------------------
+.. kernel-doc:: ../../include/tst_safe_file_ops.h
+
 Saving and restoring /proc|sys values
 -------------------------------------
 .. kernel-doc:: ../../include/tst_sys_conf.h
 
+Swap
+----
+.. kernel-doc:: ../../include/tse_swap.h
+
 Temporary directory
 -------------------
 .. kernel-doc:: ../../include/tst_tmpdir.h
 
-LTP libraries
--------------
-.. kernel-doc:: ../../include/tse_swap.h
+Test macros
+-----------
+.. kernel-doc:: ../../include/tst_test_macros.h
+
+Uinput
+------
+.. kernel-doc:: ../../include/tse_uinput.h
diff --git a/include/tse_uinput.h b/include/tse_uinput.h
index e336de780b1c9ce2d9cd2977e15b287cadfb76a4..272cf16483643b5552f3f88a9b87211a6863c8f5 100644
--- a/include/tse_uinput.h
+++ b/include/tse_uinput.h
@@ -7,40 +7,40 @@
 #define TSE_UINPUT_H__
 
 /**
- * Tries to open the uinput device.
+ * open_uinput() - Try to open the uinput device.
  *
- * Returns file descriptor on success, -1 on failure.
+ * Return: File descriptor on success, -1 on failure.
  */
 int open_uinput(void);
 
 /**
- * Creates virtual input device.
- *
- * @fd File descriptor returned by open_uinput().
+ * create_input_device() - Create a virtual input device.
+ * @fd: File descriptor returned by open_uinput().
  */
 void create_input_device(int fd);
 
 /**
- * Parses /proc/bus/input/devices and returns the strings for our virtual device.
- * If passing 'H' to it, it returns HANDLERS string. If passing 'S' to it, it
- * returns SYSFS string.
+ * get_input_field_value() - Get a field string for the virtual device.
+ * @field: Field character ('H' for handlers, 'S' for sysfs).
+ *
+ * Parses /proc/bus/input/devices and returns the string for our
+ * virtual device matching the requested field.
  *
- * Returns newly allocated string, or NULL in a case of failure.
+ * Return: Newly allocated string, or NULL on failure.
  */
 char *get_input_field_value(char field);
 
 /**
- * Sets up the virtual device to appear as a mouse, this must be called before
- * the call to create_input_device().
+ * setup_mouse_events() - Set up the virtual device as a mouse.
+ * @fd: File descriptor as returned by open_uinput().
  *
- * @fd File descriptor as returned by open_uinput().
+ * Must be called before create_input_device().
  */
 void setup_mouse_events(int fd);
 
 /**
- * Destroys virtual input device.
- *
- * @fd File descriptor returned by open_uinput().
+ * destroy_input_device() - Destroy a virtual input device.
+ * @fd: File descriptor returned by open_uinput().
  */
 void destroy_input_device(int fd);
 
diff --git a/include/tst_clone.h b/include/tst_clone.h
index a07689c78f575ae6ca87c0952b3e48b3a626012c..daae7562f46d78b0bbe24a7a5794f7b62d4e2364 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -9,7 +9,14 @@
 
 #ifdef TST_TEST_H__
 
-/* The parts of clone3's clone_args we support */
+/**
+ * struct tst_clone_args - Arguments for tst_clone().
+ * @flags: Clone flags (e.g. CLONE_NEWNS, CLONE_NEWPID).
+ * @pidfd: Pointer (cast to u64) where the kernel stores the pidfd when
+ *         CLONE_PIDFD is set.
+ * @exit_signal: Signal sent to the parent when the child exits.
+ * @cgroup: Target cgroup fd (requires CLONE_INTO_CGROUP).
+ */
 struct tst_clone_args {
 	uint64_t flags;
 	uint64_t pidfd;
@@ -17,15 +24,16 @@ struct tst_clone_args {
 	uint64_t cgroup;
 };
 
-/* clone3 with fallbacks to clone when possible. Be aware that it
- * returns -1 if clone3 fails (except ENOSYS), but -2 if clone fails.
+/**
+ * tst_clone() - Create a child process via clone3 with clone fallback.
+ * @args: Clone arguments.
  *
- * Without CLONE_VM this acts like fork so you may want to set
- * tst_test.forks_child (safe_clone requires this).
+ * Without CLONE_VM this acts like fork(); set tst_test.forks_child
+ * accordingly (safe_clone requires it). Set exit_signal to SIGCHLD
+ * for tst_reap_children.
  *
- * You should set exit_signal to SIGCHLD for
- * tst_reap_children. Otherwise you must call wait with the
- * appropriate parameters.
+ * Return: Child PID in the parent, 0 in the child, -1 on clone3 failure
+ *         (except ENOSYS), -2 on clone failure.
  */
 pid_t tst_clone(const struct tst_clone_args *args);
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 85150670de903f5d411efa255d75df4099ea1dd2..eb19b41aefa637e887448dc9a35ef9a04c3e2c21 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -11,123 +11,171 @@
 #include <stdint.h>
 #include <sys/stat.h>
 
+/**
+ * struct tst_device - Block device used by a test.
+ * @dev: Device path (e.g. /dev/loop0).
+ * @fs_type: Filesystem type used to format the device.
+ * @size: Device size in bytes.
+ * @is_fuse: Set by the library when the mounted filesystem is FUSE-based.
+ */
 struct tst_device {
 	const char *dev;
 	const char *fs_type;
 	uint64_t size;
-	/* If device was mounted by the test library this flag is set for fuse fileystems. */
 	int is_fuse;
 };
 
 /*
- * Automatically initialized if test.needs_device is set.
+ * tst_device - Pointer to the test block device.
+ *
+ * Automatically initialized if tst_test.needs_device is set.
  */
 extern struct tst_device *tst_device;
 
-/*
- * Just like umount() but retries several times on failure.
- * @path: Path to umount
+/**
+ * tst_umount() - Unmount a filesystem, retrying on transient failures.
+ * @path: Mount point to unmount.
+ *
+ * Return: 0 on success, -1 on failure.
  */
 int tst_umount(const char *path);
 
-/*
- * Verifies if an earlier mount is successful or not.
- * @path: Mount path to verify
+/**
+ * tst_mount_has_opt() - Check if a mount point has a specific mount option.
+ * @path: Mount point to check.
+ * @opt: Mount option to look for.
+ *
+ * Return: 1 if found, 0 otherwise.
  */
 int tst_mount_has_opt(const char *path, const char *opt);
+
+/**
+ * tst_is_mounted() - Check if a path is a mount point.
+ * @path: Path to check.
+ *
+ * Return: 1 if mounted, 0 otherwise.
+ */
 int tst_is_mounted(const char *path);
+
+/**
+ * tst_is_mounted_ro() - Check if a path is mounted read-only.
+ * @path: Path to check.
+ *
+ * Return: 1 if mounted read-only, 0 otherwise.
+ */
 int tst_is_mounted_ro(const char *path);
+
+/**
+ * tst_is_mounted_rw() - Check if a path is mounted read-write.
+ * @path: Path to check.
+ *
+ * Return: 1 if mounted read-write, 0 otherwise.
+ */
 int tst_is_mounted_rw(const char *path);
+
+/**
+ * tst_is_mounted_at_tmpdir() - Check if a path is mounted at the test tmpdir.
+ * @path: Path to check.
+ *
+ * Return: 1 if mounted at tmpdir, 0 otherwise.
+ */
 int tst_is_mounted_at_tmpdir(const char *path);
 
-/*
- * Clears a first few blocks of the device. This is needed when device has
- * already been formatted with a filesystems, subset of mkfs.foo utils aborts
- * the operation if it finds a filesystem signature there.
+/**
+ * tst_clear_device() - Wipe filesystem signatures from a block device.
+ * @dev: Device path.
+ *
+ * Clears the first few blocks of the device so that mkfs utilities do not
+ * refuse to reformat it. Called automatically by tst_mkfs().
  *
- * Note that this is called from tst_mkfs() automatically, so you probably will
- * not need to use this from the test yourself.
+ * Return: 0 on success, -1 on failure.
  */
 int tst_clear_device(const char *dev);
 
-/*
- * Finds a free loop device for use and returns the free loopdev minor(-1 for no
- * free loopdev). If path is non-NULL, it will be filled with free loopdev path.
+/**
+ * tst_find_free_loopdev() - Find an unused loop device.
+ * @path: If non-NULL, filled with the loop device path.
+ * @path_len: Size of @path buffer.
  *
+ * Return: The loop device minor number, or -1 if none is free.
  */
 int tst_find_free_loopdev(char *path, size_t path_len);
 
-/*
- * Attaches a file to a loop device.
+/**
+ * tst_attach_device() - Attach a file to a loop device.
+ * @dev_path: Path to the loop device (e.g. /dev/loop0).
+ * @file_path: Path to a file (e.g. disk.img).
  *
- * @dev_path Path to the loop device e.g. /dev/loop0
- * @file_path Path to a file e.g. disk.img
- * @return Zero on success, non-zero otherwise.
+ * Return: Zero on success, non-zero otherwise.
  */
 int tst_attach_device(const char *dev_path, const char *file_path);
 
-/*
- * Get size (in MB) of the given device
+/**
+ * tst_get_device_size() - Get device size in megabytes.
+ * @dev_path: Device path.
+ *
+ * Return: Device size in MB.
  */
 uint64_t tst_get_device_size(const char *dev_path);
 
-/*
- * Detaches a file from a loop device by a fd.
+/**
+ * tst_detach_device_by_fd() - Detach a file from a loop device using an fd.
+ * @dev_path: Path to the loop device (e.g. /dev/loop0).
+ * @dev_fd: Open fd for the loop device; set to -1 on completion.
  *
- * The dev_fd needs to be the last file descriptor opened for the device. Call
- * to this function will close dev_fd and set it to -1 in order to avoid
- * incorrect usage after it's closed.
+ * The @dev_fd must be the last file descriptor opened for the device.
  *
- * @dev_path Path to the loop device e.g. /dev/loop0
- * @dev_fd An open fd for the loop device, set to -1 after the completion.
- * @return Zero on succes, non-zero otherwise.
+ * Return: Zero on success, non-zero otherwise.
  */
 int tst_detach_device_by_fd(const char *dev_path, int *dev_fd);
 
-/*
- * Detaches a file from a loop device.
+/**
+ * tst_detach_device() - Detach a file from a loop device.
+ * @dev_path: Path to the loop device (e.g. /dev/loop0).
  *
- * @dev_path Path to the loop device e.g. /dev/loop0
- * @return Zero on succes, non-zero otherwise.
+ * Opens the device internally and calls tst_detach_device_by_fd(). If the
+ * device fd is already open, use tst_detach_device_by_fd() instead.
  *
- * Internally this function opens the device and calls
- * tst_detach_device_by_fd(). If you keep device file descriptor open you
- * have to call the by_fd() variant since having the device open twice will
- * prevent it from being detached.
+ * Return: Zero on success, non-zero otherwise.
  */
 int tst_detach_device(const char *dev_path);
 
-/*
- * To avoid FS deferred IO metadata/cache interference, so we do syncfs
- * simply before the tst_dev_bytes_written invocation. For easy to use,
- * we create this inline function tst_dev_sync.
+/**
+ * tst_dev_sync() - Sync filesystem to avoid deferred IO interference.
+ * @fd: Open file descriptor on the filesystem to sync.
+ *
+ * Return: 0 on success, -1 on failure.
  */
 int tst_dev_sync(int fd);
 
-/*
- * Reads test block device stat file and returns the bytes written since the
- * last call of this function.
- * @dev: test block device
+/**
+ * tst_dev_bytes_written() - Get bytes written to a block device since last call.
+ * @dev: Test block device path.
+ *
+ * Return: Number of bytes written since the previous invocation.
  */
 unsigned long tst_dev_bytes_written(const char *dev);
 
-/*
- * Find the file or path belongs to which block dev
- * @path       Path to find the backing dev
- * @dev        The buffer to store the block dev in
- * @dev_size   The length of the block dev buffer
+/**
+ * tst_find_backing_dev() - Find the block device backing a path.
+ * @path: Path to look up.
+ * @dev: Buffer to store the block device path.
+ * @dev_size: Size of @dev buffer.
  */
 void tst_find_backing_dev(const char *path, char *dev, size_t dev_size);
 
-/*
- * Stat the device mounted on a given path.
+/**
+ * tst_stat_mount_dev() - Stat the device mounted at a given path.
+ * @mnt_path: Mount point path.
+ * @st: Stat buffer to fill.
  */
 void tst_stat_mount_dev(const char *const mnt_path, struct stat *const st);
 
-/*
- * Returns the size of a physical device block size for the specific path
- * @path   Path to find the block size
- * @return Size of the block size
+/**
+ * tst_dev_block_size() - Get physical block size for a device.
+ * @path: Path on the filesystem to query.
+ *
+ * Return: Physical block size in bytes.
  */
 int tst_dev_block_size(const char *path);
 
diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index b22364cab2bdcfbc62585dc6fd142d10489a0528..b341bb037264f93579b30ac6dd61f3d260377304 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -2,8 +2,7 @@
 /*
  * Copyright (c) 2017-2018 Richard Palethorpe <rpalethorpe@suse.com>
  */
-/**
- * @file tst_fuzzy_sync.h
+/*
  * Fuzzy Synchronisation - abbreviated to fzsync
  *
  * This library is intended to help reproduce race conditions by synchronising
@@ -55,8 +54,6 @@
  *
  * For a usage example see testcases/cve/cve-2016-7117.c or just run
  * 'git grep tst_fuzzy_sync.h'
- *
- * @sa tst_fzsync_pair
  */
 
 #include <math.h>
@@ -83,7 +80,31 @@ struct tst_fzsync_stat {
 };
 
 /**
- * The state of a two way synchronisation or race.
+ * struct tst_fzsync_pair - The state of a two way synchronisation or race.
+ * @avg_alpha: Rate at which old diff samples are forgotten (default 0.25).
+ * @a_start: Internal; Thread A start time.
+ * @b_start: Internal; Thread B start time.
+ * @a_end: Internal; Thread A end time.
+ * @b_end: Internal; Thread B end time.
+ * @diff_ss: Internal; Avg. difference between a_start and b_start.
+ * @diff_sa: Internal; Avg. difference between a_start and a_end.
+ * @diff_sb: Internal; Avg. difference between b_start and b_end.
+ * @diff_ab: Internal; Avg. difference between a_end and b_end.
+ * @spins: Internal; Number of spins while waiting for the slower thread.
+ * @spins_avg: Internal; Average spins stat.
+ * @delay: Internal; Number of spins to use in the delay.
+ * @delay_bias: Internal; Bias added to delay.
+ * @sampling: Internal; Sampling state or remaining count.
+ * @min_samples: Minimum samples before random delays are calculated (default 1024).
+ * @max_dev_ratio: Maximum allowed proportional average deviation (default 0.1).
+ * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait().
+ * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait().
+ * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait().
+ * @exec_time_start: Internal; Test time remaining on tst_fzsync_pair_reset().
+ * @exec_loops: Maximum number of iterations to execute.
+ * @exec_loop: Internal; Current loop index.
+ * @thread_b: Internal; The second thread or 0.
+ * @yield_in_wait: Yield CPU while waiting on single-core machines.
  *
  * This contains all the necessary state for approximately synchronising two
  * sections of code in different threads.
@@ -96,53 +117,53 @@ struct tst_fzsync_stat {
  * Internal fields should only be accessed by library functions.
  */
 struct tst_fzsync_pair {
-	/**
+	/*
 	 * The rate at which old diff samples are forgotten
 	 *
 	 * Defaults to 0.25.
 	 */
 	float avg_alpha;
-	/** Internal; Thread A start time */
+	/* Internal; Thread A start time */
 	struct timespec a_start;
-	/** Internal; Thread B start time */
+	/* Internal; Thread B start time */
 	struct timespec b_start;
-	/** Internal; Thread A end time */
+	/* Internal; Thread A end time */
 	struct timespec a_end;
-	/** Internal; Thread B end time */
+	/* Internal; Thread B end time */
 	struct timespec b_end;
-	/** Internal; Avg. difference between a_start and b_start */
+	/* Internal; Avg. difference between a_start and b_start */
 	struct tst_fzsync_stat diff_ss;
-	/** Internal; Avg. difference between a_start and a_end */
+	/* Internal; Avg. difference between a_start and a_end */
 	struct tst_fzsync_stat diff_sa;
-	/** Internal; Avg. difference between b_start and b_end */
+	/* Internal; Avg. difference between b_start and b_end */
 	struct tst_fzsync_stat diff_sb;
-	/** Internal; Avg. difference between a_end and b_end */
+	/* Internal; Avg. difference between a_end and b_end */
 	struct tst_fzsync_stat diff_ab;
-	/** Internal; Number of spins while waiting for the slower thread */
+	/* Internal; Number of spins while waiting for the slower thread */
 	int spins;
 	struct tst_fzsync_stat spins_avg;
-	/**
+	/*
 	 * Internal; Number of spins to use in the delay.
 	 *
 	 * A negative value delays thread A and a positive delays thread B.
 	 */
 	int delay;
 	int delay_bias;
-	/**
+	/*
 	 *  Internal; The number of samples left or the sampling state.
 	 *
 	 *  A positive value is the number of remaining mandatory
 	 *  samples. Zero or a negative indicate some other state.
 	 */
 	int sampling;
-	/**
+	/*
 	 * The Minimum number of statistical samples which must be collected.
 	 *
 	 * The minimum number of iterations which must be performed before a
 	 * random delay can be calculated. Defaults to 1024.
 	 */
 	int min_samples;
-	/**
+	/*
 	 * The maximum allowed proportional average deviation.
 	 *
 	 * A value in the range (0, 1) which gives the maximum average
@@ -154,25 +175,25 @@ struct tst_fzsync_pair {
 	 */
 	float max_dev_ratio;
 
-	/** Internal; Atomic counter used by fzsync_pair_wait() */
+	/* Internal; Atomic counter used by fzsync_pair_wait() */
 	tst_atomic_t a_cntr;
-	/** Internal; Atomic counter used by fzsync_pair_wait() */
+	/* Internal; Atomic counter used by fzsync_pair_wait() */
 	tst_atomic_t b_cntr;
-	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
+	/* Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
 	tst_atomic_t exit;
-	/** Internal; The test time remaining on tst_fzsync_pair_reset() */
+	/* Internal; The test time remaining on tst_fzsync_pair_reset() */
 	float exec_time_start;
-	/**
+	/*
 	 * The maximum number of iterations to execute during the test
 	 *
 	 * Defaults to a large number, but not too large.
 	 */
 	int exec_loops;
-	/** Internal; The current loop index  */
+	/* Internal; The current loop index  */
 	int exec_loop;
-	/** Internal; The second thread or 0 */
+	/* Internal; The second thread or 0 */
 	pthread_t thread_b;
-	/**
+	/*
 	 * The flag indicates single core machines or not
 	 *
 	 * If running on single core machines, it would take considerable
@@ -191,14 +212,11 @@ struct tst_fzsync_pair {
 		tst_brk(TBROK, #param " is more than the upper bound " #hi);  \
 	} while (0)
 /**
- * Ensures that any Fuzzy Sync parameters are properly set
- *
- * @relates tst_fzsync_pair
+ * tst_fzsync_pair_init() - Ensure Fuzzy Sync parameters are properly set.
+ * @pair: Fuzzy sync pair.
  *
  * Usually called from the setup function, it sets default parameter values or
  * validates any existing non-defaults.
- *
- * @sa tst_fzsync_pair_reset()
  */
 static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 {
@@ -213,9 +231,8 @@ static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 #undef CHK
 
 /**
- * Exit and join thread B if necessary.
- *
- * @relates tst_fzsync_pair
+ * tst_fzsync_pair_cleanup() - Exit and join thread B if necessary.
+ * @pair: Fuzzy sync pair.
  *
  * Call this from your cleanup function.
  */
@@ -231,9 +248,8 @@ static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Zero some stat fields
- *
- * @relates tst_fzsync_stat
+ * tst_init_stat() - Zero some stat fields.
+ * @s: Stat structure to zero.
  */
 static inline void tst_init_stat(struct tst_fzsync_stat *s)
 {
@@ -242,11 +258,9 @@ static inline void tst_init_stat(struct tst_fzsync_stat *s)
 }
 
 /**
- * Reset or initialise fzsync.
- *
- * @relates tst_fzsync_pair
- * @param pair The state structure initialised with TST_FZSYNC_PAIR_INIT.
- * @param run_b The function defining thread B or NULL.
+ * tst_fzsync_pair_reset() - Reset or initialise fzsync.
+ * @pair: Fuzzy sync pair.
+ * @run_b: Thread B function pointer.
  *
  * Call this from your main test function (thread A), just before entering the
  * main loop. It will (re)set any variables needed by fzsync and (re)start
@@ -256,8 +270,6 @@ static inline void tst_init_stat(struct tst_fzsync_stat *s)
  * you can pass NULL to run_b and handle starting and stopping thread B
  * yourself. You may need to place tst_fzsync_pair in some shared memory as
  * well.
- *
- * @sa tst_fzsync_pair_init()
  */
 static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 				  void *(*run_b)(void *))
@@ -285,9 +297,10 @@ static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 }
 
 /**
- * Print stat
- *
- * @relates tst_fzsync_stat
+ * tst_fzsync_stat_info() - Print stat.
+ * @stat: Stat to print.
+ * @unit: Unit string.
+ * @name: Name string.
  */
 static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
 					char *unit, char *name)
@@ -298,9 +311,8 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
 }
 
 /**
- * Print some synchronisation statistics
- *
- * @relates tst_fzsync_pair
+ * tst_fzsync_pair_info() - Print some synchronisation statistics.
+ * @pair: Fuzzy sync pair.
  */
 static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 {
@@ -313,7 +325,10 @@ static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 	tst_fzsync_stat_info(pair->spins_avg, "  ", "spins");
 }
 
-/** Wraps clock_gettime */
+/**
+ * tst_fzsync_time() - Wrap clock_gettime.
+ * @t: Timespec to fill.
+ */
 static inline void tst_fzsync_time(struct timespec *t)
 {
 #ifdef CLOCK_MONOTONIC_RAW
@@ -324,13 +339,12 @@ static inline void tst_fzsync_time(struct timespec *t)
 }
 
 /**
- * Exponential moving average
- *
- * @param alpha The preference for recent samples over old ones.
- * @param sample The current sample
- * @param prev_avg The average of the all the previous samples
+ * tst_exp_moving_avg() - Exponential moving average.
+ * @alpha: Smoothing factor.
+ * @sample: New sample value.
+ * @prev_avg: Previous average.
  *
- * @return The average including the current sample.
+ * Return: New average.
  */
 static inline float tst_exp_moving_avg(float alpha,
 					float sample,
@@ -340,9 +354,10 @@ static inline float tst_exp_moving_avg(float alpha,
 }
 
 /**
- * Update a stat with a new sample
- *
- * @relates tst_fzsync_stat
+ * tst_upd_stat() - Update a stat with a new sample.
+ * @s: Stat structure.
+ * @alpha: Smoothing factor.
+ * @sample: New sample value.
  */
 static inline void tst_upd_stat(struct tst_fzsync_stat *s,
 				 float alpha,
@@ -355,9 +370,11 @@ static inline void tst_upd_stat(struct tst_fzsync_stat *s,
 }
 
 /**
- * Update a stat with a new diff sample
- *
- * @relates tst_fzsync_stat
+ * tst_upd_diff_stat() - Update a stat with a new diff sample.
+ * @s: Stat structure.
+ * @alpha: Smoothing factor.
+ * @t1: First timespec.
+ * @t2: Second timespec.
  */
 static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
 				     float alpha,
@@ -368,10 +385,11 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
 }
 
 /**
- * Calculate various statistics and the delay
+ * tst_fzsync_pair_update() - Calculate various statistics and the delay.
+ * @pair: Fuzzy sync pair.
  *
  * This function helps create the fuzz in fuzzy sync. Imagine we have the
- * following timelines in threads A and B:
+ * following timelines in threads A and B::
  *
  *  start_race_a
  *      ^                    end_race_a (a)
@@ -398,7 +416,7 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
  * probability of hitting the race condition is close to zero. To solve this
  * scenario (and others) a randomised delay is introduced before the syscalls
  * in A and B. Given enough time the following should happen where the exit
- * paths are now synchronised:
+ * paths are now synchronised::
  *
  *  start_race_a
  *      ^                    end_race_a (a)
@@ -452,8 +470,6 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
  * [1] This assumes there is always a significant difference. The algorithm
  * may fail to introduce a delay (when one is needed) in situations where
  * Syscall A and B finish at approximately the same time.
- *
- * @relates tst_fzsync_pair
  */
 static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 {
@@ -510,21 +526,17 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Wait for the other thread
- *
- * @relates tst_fzsync_pair
- * @param our_cntr The counter for the thread we are on
- * @param other_cntr The counter for the thread we are synchronising with
- * @param spins A pointer to the spin counter or NULL
- * @param exit Exit flag when we need to break out of the wait loop
+ * tst_fzsync_pair_wait() - Wait for the other thread.
+ * @our_cntr: Our atomic counter.
+ * @other_cntr: Other thread's atomic counter.
+ * @spins: Spin counter.
+ * @exit: Exit flag.
+ * @yield_in_wait: Whether to yield while waiting.
  *
  * Used by tst_fzsync_pair_wait_a(), tst_fzsync_pair_wait_b(),
  * tst_fzsync_start_race_a(), etc. If the calling thread is ahead of the other
  * thread, then it will spin wait. Unlike pthread_barrier_wait it will never
  * use futex and can count the number of spins spent waiting.
- *
- * @return A non-zero value if the thread should continue otherwise the
- * calling thread should exit.
  */
 static inline void tst_fzsync_pair_wait(int *our_cntr,
 					int *other_cntr,
@@ -598,10 +610,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 }
 
 /**
- * Wait in thread A
- *
- * @relates tst_fzsync_pair
- * @sa tst_fzsync_pair_wait
+ * tst_fzsync_wait_a() - Wait in thread A.
+ * @pair: Fuzzy sync pair.
  */
 static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 {
@@ -610,10 +620,8 @@ static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Wait in thread B
- *
- * @relates tst_fzsync_pair
- * @sa tst_fzsync_pair_wait
+ * tst_fzsync_wait_b() - Wait in thread B.
+ * @pair: Fuzzy sync pair.
  */
 static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 {
@@ -622,15 +630,13 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Decide whether to continue running thread A
+ * tst_fzsync_run_a() - Decide whether to continue running thread A.
+ * @pair: Fuzzy sync pair.
  *
- * @relates tst_fzsync_pair
+ * Return: Non-zero to continue, 0 to stop.
  *
  * Checks some values and decides whether it is time to break the loop of
  * thread A.
- *
- * @return True to continue and false to break.
- * @sa tst_fzsync_run_a
  */
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
@@ -667,10 +673,10 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Decide whether to continue running thread B
+ * tst_fzsync_run_b() - Decide whether to continue running thread B.
+ * @pair: Fuzzy sync pair.
  *
- * @relates tst_fzsync_pair
- * @sa tst_fzsync_run_a
+ * Return: Non-zero to continue, 0 to stop.
  */
 static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
 {
@@ -679,9 +685,8 @@ static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the start of a race region in thread A
- *
- * @relates tst_fzsync_pair
+ * tst_fzsync_start_race_a() - Mark the start of a race region in thread A.
+ * @pair: Fuzzy sync pair.
  *
  * This should be placed just before performing whatever action can cause a
  * race condition. Usually it is placed just before a syscall and
@@ -689,12 +694,6 @@ static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
  *
  * A corresponding call to tst_fzsync_start_race_b() should be made in thread
  * B.
- *
- * @return A non-zero value if the calling thread should continue to loop. If
- * it returns zero then tst_fzsync_exit() has been called and you must exit
- * the thread.
- *
- * @sa tst_fzsync_pair_update
  */
 static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 {
@@ -719,10 +718,8 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the end of a race region in thread A
- *
- * @relates tst_fzsync_pair
- * @sa tst_fzsync_start_race_a
+ * tst_fzsync_end_race_a() - Mark the end of a race region in thread A.
+ * @pair: Fuzzy sync pair.
  */
 static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
 {
@@ -732,10 +729,8 @@ static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the start of a race region in thread B
- *
- * @relates tst_fzsync_pair
- * @sa tst_fzsync_start_race_a
+ * tst_fzsync_start_race_b() - Mark the start of a race region in thread B.
+ * @pair: Fuzzy sync pair.
  */
 static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 {
@@ -758,10 +753,8 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the end of a race region in thread B
- *
- * @relates tst_fzsync_pair
- * @sa tst_fzsync_start_race_a
+ * tst_fzsync_end_race_b() - Mark the end of a race region in thread B.
+ * @pair: Fuzzy sync pair.
  */
 static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 {
@@ -771,10 +764,9 @@ static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Add some amount to the delay bias
- *
- * @relates tst_fzsync_pair
- * @param change The amount to add, can be negative
+ * tst_fzsync_pair_add_bias() - Add some amount to the delay bias.
+ * @pair: Fuzzy sync pair.
+ * @change: Amount to add to bias.
  *
  * A positive change delays thread B and a negative one delays thread
  * A.
diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index f3f1ec0320a1038509212e603a9699fa090329f2..27ee36399ff4e111108872e89ce3b3bc51a78a14 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -11,6 +11,11 @@
 extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
 
+/**
+ * enum tst_hp_policy - Hugepage reservation policy.
+ * @TST_REQUEST: Try to reserve hugepages; tst_hugepages may be 0.
+ * @TST_NEEDS: Fail with TCONF if the requested count cannot be reserved.
+ */
 enum tst_hp_policy {
 	TST_REQUEST,
 	TST_NEEDS,
@@ -18,30 +23,40 @@ enum tst_hp_policy {
 
 #define TST_NO_HUGEPAGES ((unsigned long)-1)
 
+/**
+ * struct tst_hugepage - Hugepage reservation request.
+ * @number: Number of hugepages to reserve.
+ * @policy: Reservation policy (TST_REQUEST or TST_NEEDS).
+ */
 struct tst_hugepage {
 	const unsigned long number;
 	enum  tst_hp_policy policy;
 };
 
-/*
- * Get the default hugepage size. Returns 0 if hugepages are not supported.
+/**
+ * tst_get_hugepage_size() - Get the default hugepage size.
+ *
+ * Return: Hugepage size in bytes, or 0 if hugepages are not supported.
  */
 size_t tst_get_hugepage_size(void);
 
-/*
- * Try the best to request a specified number of huge pages from system,
- * it will store the reserved hpage number in tst_hugepages.
+/**
+ * tst_reserve_hugepages() - Reserve hugepages from the system.
+ * @hp: Hugepage request describing count and policy.
+ *
+ * Stores the number of actually reserved hugepages in tst_hugepages.
+ * The result depends on system memory fragmentation.
  *
- * Note: this depend on the status of system memory fragmentation.
+ * Return: Number of hugepages reserved.
  */
 unsigned long tst_reserve_hugepages(struct tst_hugepage *hp);
 
 /*
- * This variable is used for recording the number of hugepages which system can
- * provides. It will be equal to 'hpages' if tst_reserve_hugepages on success,
- * otherwise set it to a number of hugepages that we were able to reserve.
+ * tst_hugepages - Number of hugepages actually reserved.
  *
- * If system does not support hugetlb, then it will be set to 0.
+ * Set by tst_reserve_hugepages(). Equals the requested count on success,
+ * or fewer if the system could not provide enough. Zero when hugepages
+ * are not supported.
  */
 extern unsigned long tst_hugepages;
 
diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index b0608498d7e837e2c7b847fbef23334dcf2605c9..c454f346761394a258c7e3b2ab8a6d1ad580c893 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -10,13 +10,22 @@
 #include <stddef.h>
 
 /**
- * Initialization helper macro for struct tst_kconfig_var. Requires <string.h>
+ * TST_KCONFIG_INIT() - Initialization helper macro for struct
+ *     tst_kconfig_var. Requires <string.h> for strlen().
+ * @confname: Config variable name string.
  */
 #define TST_KCONFIG_INIT(confname) { \
 	.id = confname, \
 	.id_len = strlen(confname) \
 }
 
+/**
+ * struct tst_kconfig_var - Kernel config variable lookup result.
+ * @id: Config variable name (e.g. CONFIG_FOO).
+ * @id_len: Length of @id string.
+ * @choice: Result: 'm', 'y', 'v', 'n', or 0 (not found).
+ * @val: Allocated value string when @choice is 'v'.
+ */
 struct tst_kconfig_var {
 	char id[64];
 	unsigned int id_len;
@@ -25,56 +34,39 @@ struct tst_kconfig_var {
 };
 
 /**
+ * tst_kconfig_read() - Read and parse kernel config.
+ * @vars: An array of caller initialized tst_kconfig_var structures.
+ * @vars_len: Length of the @vars array.
  *
- * Reads a kernel config, parses it and writes results into an array of
- * tst_kconfig_var structures.
- *
- * The path to the kernel config should be autodetected in most of the cases as
- * the code looks for know locations. It can be explicitly set/overridden with
- * the KCONFIG_PATH environment variable as well.
- *
- * The caller has to initialize the tst_kconfig_var structure. The id has to be
- * filled with config variable name such as 'CONFIG_FOO', the id_len should
- * hold the id string length and the choice and val has to be zeroed.
+ * The path to the kernel config is autodetected from known locations
+ * and can be overridden with the KCONFIG_PATH environment variable.
  *
- * After a call to this function each choice be set as follows:
+ * After a call to this function each choice is set as follows:
  *
- *  'm' - config option set to m
- *  'y' - config option set to y
- *  'v' - config option set to other value
- *  'n' - config option is not set
- *   0  - config option not found
+ *  - 'm' - config option set to m
+ *  - 'y' - config option set to y
+ *  - 'v' - config option set to other value
+ *  - 'n' - config option is not set
+ *  - 0   - config option not found
  *
- * In the case that match is set to 'v' the val pointer points to a newly
- * allocated string that holds the value.
- *
- * @param vars An array of caller initialized tst_kconfig_var structures.
- * @param vars_len Length of the vars array.
+ * When choice is 'v' the val pointer holds a newly allocated string.
  */
 void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
 
 /**
- * Checks if required kernel configuration options are set in the kernel
- * config. Return 0 if every config is satisfied and return 1 if at least
- * one is missing.
+ * tst_kconfig_check() - Check if required kernel config options are set.
+ * @kconfigs: NULL-terminated array of config strings needed for the testrun.
  *
- * The config options can be passed in two different formats, either
- * "CONFIG_FOO" in which case the option has to be set in order to continue the
- * test or with an explicit value "CONFIG_FOO=bar" in which case the value has
- * to match.
+ * Config options can be passed as "CONFIG_FOO" (must be set) or
+ * "CONFIG_FOO=bar" (value must match).
  *
- * @param kconfigs NULL-terminated array of config strings needed for the testrun.
+ * Return: 0 if every config is satisfied, 1 if at least one is missing.
  */
 int tst_kconfig_check(const char *const kconfigs[]);
 
 /**
- * Macro to prepare a tst_kcmdline_var structure with a given parameter name.
- *
- * It initializes the .key field with the provided name, sets the .value field
- * to an empty string, and marks the parameter as not found (.found = false).
- *
- * This macro is typically used to prepopulate an array with configuration
- * parameters before processing the actual command line arguments.
+ * TST_KCMDLINE_INIT() - Initialization helper macro for struct tst_kcmdline_var.
+ * @paraname: Kernel command-line parameter name.
  */
 #define TST_KCMDLINE_INIT(paraname) { \
 	.key = paraname, \
@@ -83,8 +75,10 @@ int tst_kconfig_check(const char *const kconfigs[]);
 }
 
 /**
- * Structure for storing command-line parameter key and its corresponding
- * value, and a flag indicating whether the parameter was found.
+ * struct tst_kcmdline_var - Kernel command-line parameter storage.
+ * @key: Parameter name.
+ * @value: Parameter value buffer.
+ * @found: Whether the parameter was found.
  */
 struct tst_kcmdline_var {
 	const char *key;
@@ -93,9 +87,9 @@ struct tst_kcmdline_var {
 };
 
 /**
- * Parses command-line parameters from /proc/cmdline and stores them in params array.
- * params: The array of tst_kcmdline_var structures to be filled with parsed key-value pairs.
- * params_len: The length of the params array, indicating how many parameters to parse.
+ * tst_kcmdline_parse() - Parse kernel command-line parameters from /proc/cmdline.
+ * @params: Array of tst_kcmdline_var structures to fill.
+ * @params_len: Length of the @params array.
  */
 void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
 
diff --git a/include/tst_taint.h b/include/tst_taint.h
index b2b201688595cdfaf812e4fe7acc1760330199eb..e265fd50cc1fbb1613588200a331bdd8168d2741 100644
--- a/include/tst_taint.h
+++ b/include/tst_taint.h
@@ -66,32 +66,24 @@
 #define TST_TAINT_T     (1 << 17) /* kernel was built with the struct randomization plugin */
 #define TST_TAINT_N     (1 << 18) /* an in-kernel test has been run */
 
-/*
- * Initialize and prepare support for checking tainted kernel. Called
- * automatically by LTP library during test setup if tst_test.taint_check
- * is non-zero. The value of tst_test.taint_check will be passed as the mask
- * argument.
- *
- * supply the mask of TAINT-flags you want to check, for example
- * (TST_TAINT_W | TST_TAINT_D) when you want to check if the kernel issued
- * a warning or even reported it died.
- *
- * This function tests if the requested flags are supported on the
- * locally running kernel. In case the tainted-flags are already set by
- * the kernel, there is no reason to continue and TBROK is generated.
+/**
+ * tst_taint_init() - Set up kernel taint checking.
+ * @mask: Bitmask of TST_TAINT_* flags to monitor.
  *
- * The mask must not be zero.
+ * Called automatically by the LTP library during test setup when
+ * tst_test.taint_check is non-zero. Aborts with TBROK if any
+ * requested flags are already set.
  */
 void tst_taint_init(unsigned int mask);
 
 
-/*
- * check if the tainted flags handed to tst_taint_init() are still not set
- * during or after running the test.
- * Calling this function is only allowed after tst_taint_init() was called,
- * otherwise TBROK will be generated.
+/**
+ * tst_taint_check() - Check if monitored taint flags have been set.
+ *
+ * May only be called after tst_taint_init(). Also called automatically
+ * at the end of testing when tst_test.taint_check is non-zero.
  *
- * returns 0 or a bitmask of the flags that currently tainted the kernel.
+ * Return: 0 if clean, or a bitmask of newly set taint flags.
  */
 unsigned int tst_taint_check(void);
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
