Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C34CD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 10:36:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A63B53E5502
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 12:36:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95AB23E11C6
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 12:36:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DFC5D1A00146
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 12:36:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEB9F6BBF5;
 Mon,  1 Jun 2026 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780310174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etXdf/1w1LwGEK1L9un7mW3iAEZpCwh0TaCcNVqtfrY=;
 b=LT0M4ljh7+4rhj+isOKwk9Wu6m7kN1cd/BbvsmR1VWs9pOA7YwFRtgNGx4g/2UzGd3wbIa
 xaDM/EDVMA8KI72Eo+N76sN7szAUqSV9zpIEGQA96Laid9t4yD8ns54s6vo/Scir5i9LM8
 6CYLNCTrIszD2F5VCuZrqIrvXUYWVBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780310174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etXdf/1w1LwGEK1L9un7mW3iAEZpCwh0TaCcNVqtfrY=;
 b=iK0SKQNXfAPThmnuJJfirfYbNYafiT3ktyRmmFtWbEWpBzqaDzZPLrmY1TuOLiyMkAwXBM
 Uzo1ufVPQWzFRNBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ikk2qMoI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DruFKsrn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780310172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etXdf/1w1LwGEK1L9un7mW3iAEZpCwh0TaCcNVqtfrY=;
 b=Ikk2qMoIQBkX4NA61qj1Ryc1rMrSsT/l6Kr6EYxWGfhKtu1FdfI6hQqH2w+rYhMqUpl4Sf
 JrnelRLBO5Me/1pRCvs3fDXT2KGICj4JBO/xt480Nlw+nZz3slY5RiNDu3CZp0pU3wmOF6
 iyXeohelP7RZNUE3iVxOxQWFtwFApIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780310172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etXdf/1w1LwGEK1L9un7mW3iAEZpCwh0TaCcNVqtfrY=;
 b=DruFKsrnBeE+CfeGtPROMoXq0Og0y6hi9HtkhTX8B1Yc6V4bllfX90/BvmfSRKjWZyrdfz
 N0vrutgmEfcGRkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 950FF779A8;
 Mon,  1 Jun 2026 10:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iA2sIpxgHWpjFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 10:36:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 12:36:11 +0200
MIME-Version: 1.0
Message-Id: <20260601-doc_add_missing_headers-v1-1-6f1ee31945df@suse.com>
References: <20260601-doc_add_missing_headers-v1-0-6f1ee31945df@suse.com>
In-Reply-To: <20260601-doc_add_missing_headers-v1-0-6f1ee31945df@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780310172; l=38961;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3iGLgyUXRMBAycNV483gEjJ8TeZuOD7UUvw7L288UDw=;
 b=jMgXzGlrydaNO0HDphPAAQKe2XKVYdpogeQgJBdKbqTQWvcjCpYBGaW0rrLuw61yNhw0RfGX6
 Bzc8DZcOl47A2nsCb7Ibxt2jX15LWRfmG5Z3Y84Syt6pcS6YD/tEdxf
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BEB9F6BBF5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[mkfs.foo:url,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] doc: Add missing API references to api_c_tests.rst
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

Fix broken kernel-doc reference to renamed tse_numa.h header and add
kernel-doc directives for 12 headers that were missing from the C API
documentation page:

  tst_clone.h, tst_device.h, tst_fs.h, tst_fuzzy_sync.h,
  tst_hugepage.h, tst_kconfig.h, tst_memutils.h, tst_safe_file_ops.h,
  tst_taint.h, tse_numa.h, tse_swap.h, tse_uinput.h

Convert plain comments to kernel-doc format in tst_device.h,
tst_hugepage.h, tst_clone.h, and tst_taint.h so the documentation
builder can extract them.

Sort all sections alphabetically under LTP C API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/api_c_tests.rst |  71 +++++++++++++-----
 include/tse_uinput.h           |  30 ++++----
 include/tst_clone.h            |  23 ++++--
 include/tst_device.h           | 165 ++++++++++++++++++++++++++---------------
 include/tst_fuzzy_sync.h       | 163 ++++++++++++++++++++++++++++------------
 include/tst_hugepage.h         |  35 ++++++---
 include/tst_kconfig.h          |  77 +++++++++----------
 include/tst_taint.h            |  32 +++-----
 8 files changed, 377 insertions(+), 219 deletions(-)

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
index a07689c78f575ae6ca87c0952b3e48b3a626012c..1898c58f819f8eadc1468d2d2b86a9102f679eb9 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -9,7 +9,13 @@
 
 #ifdef TST_TEST_H__
 
-/* The parts of clone3's clone_args we support */
+/**
+ * struct tst_clone_args - Arguments for tst_clone().
+ * @flags: Clone flags (e.g. CLONE_NEWNS, CLONE_NEWPID).
+ * @pidfd: If CLONE_PIDFD is set, stores the pidfd here.
+ * @exit_signal: Signal sent to the parent when the child exits.
+ * @cgroup: Target cgroup fd (requires CLONE_INTO_CGROUP).
+ */
 struct tst_clone_args {
 	uint64_t flags;
 	uint64_t pidfd;
@@ -17,15 +23,16 @@ struct tst_clone_args {
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
index 85150670de903f5d411efa255d75df4099ea1dd2..405c37423fe0737bd6fc3dc3138dee97f7a52db9 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -11,123 +11,170 @@
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
index b22364cab2bdcfbc62585dc6fd142d10489a0528..503a0535e5611c9c01ced85dfab5e63ca5246c76 100644
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
@@ -83,7 +82,31 @@ struct tst_fzsync_stat {
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
@@ -96,53 +119,53 @@ struct tst_fzsync_stat {
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
@@ -154,25 +177,25 @@ struct tst_fzsync_pair {
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
@@ -191,7 +214,8 @@ struct tst_fzsync_pair {
 		tst_brk(TBROK, #param " is more than the upper bound " #hi);  \
 	} while (0)
 /**
- * Ensures that any Fuzzy Sync parameters are properly set
+ * tst_fzsync_pair_init() - Ensure Fuzzy Sync parameters are properly set.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  *
@@ -213,7 +237,8 @@ static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 #undef CHK
 
 /**
- * Exit and join thread B if necessary.
+ * tst_fzsync_pair_cleanup() - Exit and join thread B if necessary.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  *
@@ -231,7 +256,8 @@ static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Zero some stat fields
+ * tst_init_stat() - Zero some stat fields.
+ * @s: Stat structure to zero.
  *
  * @relates tst_fzsync_stat
  */
@@ -242,7 +268,9 @@ static inline void tst_init_stat(struct tst_fzsync_stat *s)
 }
 
 /**
- * Reset or initialise fzsync.
+ * tst_fzsync_pair_reset() - Reset or initialise fzsync.
+ * @pair: Fuzzy sync pair.
+ * @run_b: Thread B function pointer.
  *
  * @relates tst_fzsync_pair
  * @param pair The state structure initialised with TST_FZSYNC_PAIR_INIT.
@@ -285,7 +313,10 @@ static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 }
 
 /**
- * Print stat
+ * tst_fzsync_stat_info() - Print stat.
+ * @stat: Stat to print.
+ * @unit: Unit string.
+ * @name: Name string.
  *
  * @relates tst_fzsync_stat
  */
@@ -298,7 +329,8 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
 }
 
 /**
- * Print some synchronisation statistics
+ * tst_fzsync_pair_info() - Print some synchronisation statistics.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  */
@@ -313,7 +345,10 @@ static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
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
@@ -324,7 +359,12 @@ static inline void tst_fzsync_time(struct timespec *t)
 }
 
 /**
- * Exponential moving average
+ * tst_exp_moving_avg() - Exponential moving average.
+ * @alpha: Smoothing factor.
+ * @sample: New sample value.
+ * @prev_avg: Previous average.
+ *
+ * Return: New average.
  *
  * @param alpha The preference for recent samples over old ones.
  * @param sample The current sample
@@ -340,7 +380,10 @@ static inline float tst_exp_moving_avg(float alpha,
 }
 
 /**
- * Update a stat with a new sample
+ * tst_upd_stat() - Update a stat with a new sample.
+ * @s: Stat structure.
+ * @alpha: Smoothing factor.
+ * @sample: New sample value.
  *
  * @relates tst_fzsync_stat
  */
@@ -355,7 +398,11 @@ static inline void tst_upd_stat(struct tst_fzsync_stat *s,
 }
 
 /**
- * Update a stat with a new diff sample
+ * tst_upd_diff_stat() - Update a stat with a new diff sample.
+ * @s: Stat structure.
+ * @alpha: Smoothing factor.
+ * @t1: First timespec.
+ * @t2: Second timespec.
  *
  * @relates tst_fzsync_stat
  */
@@ -368,10 +415,11 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
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
@@ -398,7 +446,7 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
  * probability of hitting the race condition is close to zero. To solve this
  * scenario (and others) a randomised delay is introduced before the syscalls
  * in A and B. Given enough time the following should happen where the exit
- * paths are now synchronised:
+ * paths are now synchronised::
  *
  *  start_race_a
  *      ^                    end_race_a (a)
@@ -510,7 +558,12 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Wait for the other thread
+ * tst_fzsync_pair_wait() - Wait for the other thread.
+ * @our_cntr: Our atomic counter.
+ * @other_cntr: Other thread's atomic counter.
+ * @spins: Spin counter.
+ * @exit: Exit flag.
+ * @yield_in_wait: Whether to yield while waiting.
  *
  * @relates tst_fzsync_pair
  * @param our_cntr The counter for the thread we are on
@@ -598,7 +651,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 }
 
 /**
- * Wait in thread A
+ * tst_fzsync_wait_a() - Wait in thread A.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  * @sa tst_fzsync_pair_wait
@@ -610,7 +664,8 @@ static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Wait in thread B
+ * tst_fzsync_wait_b() - Wait in thread B.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  * @sa tst_fzsync_pair_wait
@@ -622,7 +677,10 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Decide whether to continue running thread A
+ * tst_fzsync_run_a() - Decide whether to continue running thread A.
+ * @pair: Fuzzy sync pair.
+ *
+ * Return: Non-zero to continue, 0 to stop.
  *
  * @relates tst_fzsync_pair
  *
@@ -667,7 +725,10 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Decide whether to continue running thread B
+ * tst_fzsync_run_b() - Decide whether to continue running thread B.
+ * @pair: Fuzzy sync pair.
+ *
+ * Return: Non-zero to continue, 0 to stop.
  *
  * @relates tst_fzsync_pair
  * @sa tst_fzsync_run_a
@@ -679,7 +740,8 @@ static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the start of a race region in thread A
+ * tst_fzsync_start_race_a() - Mark the start of a race region in thread A.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  *
@@ -719,7 +781,8 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the end of a race region in thread A
+ * tst_fzsync_end_race_a() - Mark the end of a race region in thread A.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  * @sa tst_fzsync_start_race_a
@@ -732,7 +795,8 @@ static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the start of a race region in thread B
+ * tst_fzsync_start_race_b() - Mark the start of a race region in thread B.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  * @sa tst_fzsync_start_race_a
@@ -758,7 +822,8 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Marks the end of a race region in thread B
+ * tst_fzsync_end_race_b() - Mark the end of a race region in thread B.
+ * @pair: Fuzzy sync pair.
  *
  * @relates tst_fzsync_pair
  * @sa tst_fzsync_start_race_a
@@ -771,7 +836,9 @@ static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 }
 
 /**
- * Add some amount to the delay bias
+ * tst_fzsync_pair_add_bias() - Add some amount to the delay bias.
+ * @pair: Fuzzy sync pair.
+ * @change: Amount to add to bias.
  *
  * @relates tst_fzsync_pair
  * @param change The amount to add, can be negative
diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 6b865b2f20b3deb3197638cff45a7a34b77e7d0e..6357e6ca9ff28572b687d6d15405b179cf8be6fa 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -19,6 +19,11 @@
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
@@ -26,30 +31,40 @@ enum tst_hp_policy {
 
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
index b0608498d7e837e2c7b847fbef23334dcf2605c9..56711c4d06c216f4d5be412ee3780c850037bdfd 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -10,13 +10,21 @@
 #include <stddef.h>
 
 /**
- * Initialization helper macro for struct tst_kconfig_var. Requires <string.h>
+ * TST_KCONFIG_INIT() - Initialization helper macro for struct tst_kconfig_var.
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
@@ -25,56 +33,39 @@ struct tst_kconfig_var {
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
@@ -83,8 +74,10 @@ int tst_kconfig_check(const char *const kconfigs[]);
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
@@ -93,9 +86,9 @@ struct tst_kcmdline_var {
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
