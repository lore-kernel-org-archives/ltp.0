Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47008C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BF833CF931
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:08:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D354E3CE19E
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B02F11A0C26E
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:03 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F62721E73;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CIiygPmiC8CRRbfFxQ7YOJEHJsqkRU6I/91yOQ16Tc=;
 b=DsMfi2g4IeXozOI4CE8moz9tQSSsQ2mgGpEqurXJ8TocTE7CZacTfph8GIkoiUnuq+5Ieg
 o/61d19Xp4KeM8q9GSvh6SUdrp3Ava1fE6KZP7LXxzYWZsE/aicJpJndv0FcWg7T9aHic1
 W1Qkl0h/neDSRD8g2ASAQrsGgM7OSxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CIiygPmiC8CRRbfFxQ7YOJEHJsqkRU6I/91yOQ16Tc=;
 b=AtuGXnEPaMtcvODJoBlpM/8es7fkKKAsi2HyQssB5582jH1CYrKnJr80ktVHM/WPzEbyyr
 mhp02WpPsFeE9sDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CIiygPmiC8CRRbfFxQ7YOJEHJsqkRU6I/91yOQ16Tc=;
 b=DsMfi2g4IeXozOI4CE8moz9tQSSsQ2mgGpEqurXJ8TocTE7CZacTfph8GIkoiUnuq+5Ieg
 o/61d19Xp4KeM8q9GSvh6SUdrp3Ava1fE6KZP7LXxzYWZsE/aicJpJndv0FcWg7T9aHic1
 W1Qkl0h/neDSRD8g2ASAQrsGgM7OSxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CIiygPmiC8CRRbfFxQ7YOJEHJsqkRU6I/91yOQ16Tc=;
 b=AtuGXnEPaMtcvODJoBlpM/8es7fkKKAsi2HyQssB5582jH1CYrKnJr80ktVHM/WPzEbyyr
 mhp02WpPsFeE9sDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BFA56139FC;
 Wed, 31 Jan 2024 18:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id wMWxLEaMumUoIgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:07:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 19:06:56 +0100
Message-ID: <20240131180659.23587-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131180659.23587-1-pvorel@suse.cz>
References: <20240131180659.23587-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] tree: Define MNTPOINT in include/tst_fs.h
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

and therefore remove it in all tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fs.h                                          | 3 ++-
 testcases/kernel/fs/fs_fill/fs_fill.c                     | 1 -
 testcases/kernel/mem/hugetlb/lib/hugetlb.h                | 2 --
 testcases/kernel/syscalls/chdir/chdir01.c                 | 1 -
 testcases/kernel/syscalls/creat/creat09.c                 | 1 -
 testcases/kernel/syscalls/fallocate/fallocate05.c         | 1 -
 testcases/kernel/syscalls/fallocate/fallocate06.c         | 1 -
 testcases/kernel/syscalls/fanotify/fanotify14.c           | 1 -
 testcases/kernel/syscalls/fgetxattr/fgetxattr01.c         | 1 -
 testcases/kernel/syscalls/fgetxattr/fgetxattr02.c         | 1 -
 testcases/kernel/syscalls/fremovexattr/fremovexattr01.c   | 1 -
 testcases/kernel/syscalls/fremovexattr/fremovexattr02.c   | 1 -
 testcases/kernel/syscalls/fsconfig/fsconfig01.c           | 1 -
 testcases/kernel/syscalls/fsconfig/fsconfig03.c           | 1 -
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c         | 1 -
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c         | 1 -
 testcases/kernel/syscalls/fsmount/fsmount01.c             | 1 -
 testcases/kernel/syscalls/fsmount/fsmount02.c             | 1 -
 testcases/kernel/syscalls/fsopen/fsopen01.c               | 1 -
 testcases/kernel/syscalls/fspick/fspick01.c               | 1 -
 testcases/kernel/syscalls/fspick/fspick02.c               | 1 -
 testcases/kernel/syscalls/ftruncate/ftruncate04.c         | 1 -
 testcases/kernel/syscalls/getxattr/getxattr02.c           | 1 -
 testcases/kernel/syscalls/getxattr/getxattr03.c           | 1 -
 testcases/kernel/syscalls/getxattr/getxattr04.c           | 1 -
 testcases/kernel/syscalls/lremovexattr/lremovexattr01.c   | 1 -
 testcases/kernel/syscalls/mkdir/mkdir09.c                 | 1 -
 testcases/kernel/syscalls/mmap/mmap16.c                   | 1 -
 testcases/kernel/syscalls/mount/mount01.c                 | 1 -
 testcases/kernel/syscalls/mount/mount03.c                 | 1 -
 testcases/kernel/syscalls/mount/mount04.c                 | 1 -
 testcases/kernel/syscalls/mount/mount07.c                 | 1 -
 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c | 1 -
 testcases/kernel/syscalls/move_mount/move_mount01.c       | 1 -
 testcases/kernel/syscalls/move_mount/move_mount02.c       | 1 -
 testcases/kernel/syscalls/open/open11.c                   | 1 -
 testcases/kernel/syscalls/open/open12.c                   | 1 -
 testcases/kernel/syscalls/open_tree/open_tree01.c         | 1 -
 testcases/kernel/syscalls/open_tree/open_tree02.c         | 1 -
 testcases/kernel/syscalls/openat/openat04.c               | 1 -
 testcases/kernel/syscalls/prctl/prctl06.h                 | 1 -
 testcases/kernel/syscalls/preadv/preadv03.c               | 1 -
 testcases/kernel/syscalls/preadv2/preadv203.c             | 1 -
 testcases/kernel/syscalls/pwritev/pwritev03.c             | 1 -
 testcases/kernel/syscalls/quotactl/quotactl01.c           | 1 -
 testcases/kernel/syscalls/quotactl/quotactl06.c           | 1 -
 testcases/kernel/syscalls/quotactl/quotactl08.c           | 1 -
 testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h | 1 -
 testcases/kernel/syscalls/rename/rename11.c               | 1 -
 testcases/kernel/syscalls/renameat/renameat01.c           | 1 -
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 1 -
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 1 -
 testcases/kernel/syscalls/setxattr/setxattr01.c           | 1 -
 testcases/kernel/syscalls/statx/statx12.c                 | 1 -
 testcases/kernel/syscalls/umount/umount01.c               | 1 -
 testcases/kernel/syscalls/umount/umount02.c               | 1 -
 testcases/kernel/syscalls/umount/umount03.c               | 1 -
 testcases/kernel/syscalls/umount2/umount2_01.c            | 1 -
 testcases/kernel/syscalls/umount2/umount2_02.c            | 1 -
 testcases/kernel/syscalls/utime/utime03.c                 | 1 -
 testcases/kernel/syscalls/utimensat/utimensat01.c         | 1 -
 testcases/kernel/syscalls/writev/writev03.c               | 1 -
 62 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 1dd7d32fc..0690d051d 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -49,7 +49,8 @@ enum {
 	TST_GB = 1073741824,
 };
 
-#define OVL_BASE_MNTPOINT        "mntpoint"
+#define MNTPOINT	"mntpoint"
+#define OVL_BASE_MNTPOINT	MNTPOINT
 #define OVL_LOWER	OVL_BASE_MNTPOINT"/lower"
 #define OVL_UPPER	OVL_BASE_MNTPOINT"/upper"
 #define OVL_WORK	OVL_BASE_MNTPOINT"/work"
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 3b4ee1ae9..c842f2817 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -17,7 +17,6 @@
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
 
-#define MNTPOINT "mntpoint"
 #define THREADS_DIR MNTPOINT "/subdir"
 
 static volatile int run;
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 0f5707621..34fe08c24 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -20,8 +20,6 @@
 #include "old_tmpdir.h"
 #include "mem.h"
 
-#define MNTPOINT "mntpoint"
-
 #define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
 
 #define SHM_RD	0400
diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index d50a8f50c..7f36bec06 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -18,7 +18,6 @@
 
 #include "tst_test.h"
 
-#define MNTPOINT "mntpoint"
 
 #define FILE_NAME "testfile"
 #define DIR_NAME "subdir"
diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index a5d3740ac..c381c0317 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -49,7 +49,6 @@
 #define MODE_RWX        0777
 #define MODE_SGID       (S_ISGID|0777)
 
-#define MNTPOINT	"mntpoint"
 #define WORKDIR		MNTPOINT "/testdir"
 #define CREAT_FILE	WORKDIR "/creat.tmp"
 #define OPEN_FILE	WORKDIR "/open.tmp"
diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index af6bf9e8c..b5c7f8b9e 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -25,7 +25,6 @@
 #include "tst_test.h"
 #include "lapi/fallocate.h"
 
-#define MNTPOINT "mntpoint"
 #define FALLOCATE_BLOCKS 256
 #define DEALLOCATE_BLOCKS 64
 #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 24f98e271..01dfa5d7a 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -41,7 +41,6 @@
 #include "tst_test.h"
 #include "lapi/fallocate.h"
 
-#define MNTPOINT "mntpoint"
 #define TEMPFILE MNTPOINT "/test_file"
 #define WRITE_BLOCKS 8
 #define FALLOCATE_BLOCKS 2
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 0b0da89ca..ebc9d3f52 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -31,7 +31,6 @@
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
 
-#define MNTPOINT "mntpoint"
 #define FILE1 MNTPOINT"/file1"
 
 /*
diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
index 52e6e44ab..cc147613c 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
@@ -39,7 +39,6 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 #define XATTR_TEST_INVALID_KEY "user.nosuchkey"
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/fgetxattr01testfile"
 
 static int fd = -1;
diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
index 1a9a39c9b..2033e8af6 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
@@ -54,7 +54,6 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 
-#define MNTPOINT "mntpoint"
 #define OFFSET    11
 #define FILENAME "fgetxattr02testfile"
 #define DIRNAME  "fgetxattr02testdir"
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
index 907d210d1..0286fe554 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
@@ -32,7 +32,6 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/fremovexattr01testfile"
 
 static int fd = -1;
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
index eb106a8fa..909013998 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
@@ -34,7 +34,6 @@
 
 #define XATTR_TEST_KEY "user.testkey"
 
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/fremovexattr02testfile"
 
 static int fd = -1;
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
index a585daa6d..909cb3fa2 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -8,7 +8,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 static int fd;
 
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index 0ba5355d3..d5e85c1fb 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -19,7 +19,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 static int fd = -1;
 
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
index b65b27bdf..af44af0a6 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
@@ -52,7 +52,6 @@
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/fsetxattr01testfile"
 
 static int fd = -1;
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 39265af36..813908c43 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -54,7 +54,6 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 
-#define MNTPOINT "mntpoint"
 #define OFFSET    11
 #define FILENAME "fsetxattr02testfile"
 #define DIRNAME  "fsetxattr02testdir"
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 5f755863f..babdc398e 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -9,7 +9,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 #define TCASE_ENTRY(_flags, _attrs)	{.name = "Flag " #_flags ", Attr " #_attrs, .flags = _flags, .attrs = _attrs}
 
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index a4f42dc18..f82dab111 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -9,7 +9,6 @@
 
 int fd = -1, invalid_fd = -1;
 
-#define MNTPOINT	"mntpoint"
 
 static struct tcase {
 	char *name;
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
index c2c719c96..b0b5ee69e 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen01.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -8,7 +8,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
 
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d3309a912..640187f29 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -7,7 +7,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
 
 static struct tcase {
diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
index f9a3697c1..4a2b5ed00 100644
--- a/testcases/kernel/syscalls/fspick/fspick02.c
+++ b/testcases/kernel/syscalls/fspick/fspick02.c
@@ -7,7 +7,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT		"mntpoint"
 
 static struct tcase {
 	char *name;
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index c832ceaa6..1ab3d4a8e 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -35,7 +35,6 @@
 #include "tst_test.h"
 
 #define RECLEN	100
-#define MNTPOINT	"mntpoint"
 #define TESTFILE	MNTPOINT"/testfile"
 
 static int len = 8 * 1024;
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 5a84d876c..c269033d0 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -34,7 +34,6 @@
 #include "tst_test.h"
 #include "tst_test_macros.h"
 
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/getxattr02"
 #define XATTR_TEST_KEY "user.testkey"
 
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 1fe4ba48f..05dce2201 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -17,7 +17,6 @@
 #include <sys/xattr.h>
 #include "tst_safe_macros.h"
 
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/getxattr03testfile"
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "test value"
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index e64f2a1f1..554571463 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -34,7 +34,6 @@
 
 #ifdef HAVE_SYS_XATTR_H
 
-#define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT "/file"
 #define TRUSTED_BIG	"trusted.big"
 #define TRUSTED_SMALL	"trusted.small"
diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
index 590f5a6f3..4fd8893df 100644
--- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
+++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
@@ -43,7 +43,6 @@
 #define XATTR_VALUE		"file and link"
 #define XATTR_VALUE_SIZE	13
 
-#define MNTPOINT "mntpoint"
 #define FILENAME MNTPOINT"/lremovexattr01testfile"
 #define SYMLINK  MNTPOINT"/lremovexattr01symlink"
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir09.c b/testcases/kernel/syscalls/mkdir/mkdir09.c
index 44a2348be..89e1f9afd 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir09.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir09.c
@@ -16,7 +16,6 @@
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
 
-#define MNTPOINT	"mntpoint"
 #define MODE_RWX	07770
 #define DIR_NAME	MNTPOINT "/X.%d"
 #define DIR_NAME_GROUP	MNTPOINT "/X.%d.%d"
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index 4e0d8a3f4..434cc7dfc 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -34,7 +34,6 @@
 #include <sys/wait.h>
 #include "tst_test.h"
 
-#define MNTPOINT "mntpoint"
 #define FILE_PARENT "mntpoint/testfilep"
 #define FILE_CHILD "mntpoint/testfilec"
 #define FS_BLOCKSIZE 1024
diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index 1d902ba89..16734cdb6 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -34,7 +34,6 @@ char *TCID = "mount01";
 int TST_TOTAL = 1;
 
 #define DIR_MODE (S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
-#define MNTPOINT "mntpoint"
 
 static const char *device;
 static const char *fs_type;
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 98d5933b7..403adbe03 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -31,7 +31,6 @@
 #include "tst_test.h"
 #include "lapi/mount.h"
 
-#define MNTPOINT	"mntpoint"
 #define TESTBIN	"mount03_suid_child"
 #define BIN_PATH	MNTPOINT "/" TESTBIN
 #define TEST_STR "abcdefghijklmnopqrstuvwxyz"
diff --git a/testcases/kernel/syscalls/mount/mount04.c b/testcases/kernel/syscalls/mount/mount04.c
index 5eb5ee11b..1c92b997a 100644
--- a/testcases/kernel/syscalls/mount/mount04.c
+++ b/testcases/kernel/syscalls/mount/mount04.c
@@ -16,7 +16,6 @@
 #include <pwd.h>
 #include <sys/mount.h>
 
-#define MNTPOINT "mntpoint"
 
 static void cleanup(void)
 {
diff --git a/testcases/kernel/syscalls/mount/mount07.c b/testcases/kernel/syscalls/mount/mount07.c
index eb3fb55a0..264f2eaa6 100644
--- a/testcases/kernel/syscalls/mount/mount07.c
+++ b/testcases/kernel/syscalls/mount/mount07.c
@@ -29,7 +29,6 @@
 # define ST_NOSYMFOLLOW 0x2000
 #endif
 
-#define MNTPOINT "mntpoint"
 
 static char test_file[PATH_MAX];
 static char link_file[PATH_MAX];
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index e500df28e..6ede36f05 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -33,7 +33,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT        "mntpoint"
 #define OT_MNTPOINT     "ot_mntpoint"
 #define TCASE_ENTRY(attrs, exp_attrs)   \
 	{                                \
diff --git a/testcases/kernel/syscalls/move_mount/move_mount01.c b/testcases/kernel/syscalls/move_mount/move_mount01.c
index 445e6197e..dd8a2f644 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount01.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount01.c
@@ -7,7 +7,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
 
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
index 45b1db4be..b8c0c44c1 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount02.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -7,7 +7,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 int invalid_fd = -1, fsmfd;
 
diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 3431efc2c..514cfca8c 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -54,7 +54,6 @@
 
 #include "tst_test.h"
 
-#define MNTPOINT "mntpoint"
 #define T_REG "t_reg"			/* regular file with content */
 #define T_REG_EMPTY "t_reg_empty"	/* empty regular file */
 #define T_LINK_REG "t_link_reg"		/* hard link to T_REG */
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 188d17946..6b0701a9d 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -32,7 +32,6 @@
 #include "lapi/fcntl.h"
 #include "lapi/mount.h"
 
-#define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT"/test_file"
 #define LARGE_FILE	"large_file"
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
index 808d25665..faf63c212 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree01.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -7,7 +7,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 #define OT_MNTPOINT	"ot_mntpoint"
 
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
index ddaa204f2..985f1e7b9 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree02.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -7,7 +7,6 @@
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-#define MNTPOINT	"mntpoint"
 
 static struct tcase {
 	char *name;
diff --git a/testcases/kernel/syscalls/openat/openat04.c b/testcases/kernel/syscalls/openat/openat04.c
index df5956cd8..e9945b354 100644
--- a/testcases/kernel/syscalls/openat/openat04.c
+++ b/testcases/kernel/syscalls/openat/openat04.c
@@ -36,7 +36,6 @@
 
 #define MODE_RWX        0777
 #define MODE_SGID       (S_ISGID|0777)
-#define MNTPOINT	"mntpoint"
 #define WORKDIR		MNTPOINT "/testdir"
 #define OPEN_FILE	"open.tmp"
 
diff --git a/testcases/kernel/syscalls/prctl/prctl06.h b/testcases/kernel/syscalls/prctl/prctl06.h
index dfb2de4ba..400af93eb 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.h
+++ b/testcases/kernel/syscalls/prctl/prctl06.h
@@ -17,7 +17,6 @@
 #include "tst_test.h"
 
 #define PROC_STATUS        "/proc/self/status"
-#define MNTPOINT           "mntpoint"
 #define TESTBIN            "prctl06_execve"
 #define TEST_REL_BIN_DIR   MNTPOINT"/"
 #define BIN_PATH           MNTPOINT"/"TESTBIN
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 558d85050..5213dec18 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -24,7 +24,6 @@
 #include "tst_test.h"
 #include "preadv.h"
 
-#define MNTPOINT	"mntpoint"
 #define FNAME	MNTPOINT"/file"
 
 static int fd;
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index c87deb674..5b57b01af 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -49,7 +49,6 @@
 
 #define CHUNK_SZ 4123
 #define CHUNKS 60
-#define MNTPOINT "mntpoint"
 #define FILES 500
 
 static int fds[FILES];
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 1bf9d5731..c5f51795b 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -25,7 +25,6 @@
 #include "pwritev.h"
 #include "tst_safe_prw.h"
 
-#define MNTPOINT	"mntpoint"
 #define FNAME	MNTPOINT"/file"
 
 static char *initbuf, *preadbuf;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 36ec93edc..6ca2cbcdc 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -39,7 +39,6 @@
 
 #define USRPATH MNTPOINT "/aquota.user"
 #define GRPPATH MNTPOINT "/aquota.group"
-#define MNTPOINT	"mntpoint"
 
 static int32_t fmt_id;
 static int test_id;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 74a098a8c..536e70300 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -45,7 +45,6 @@
 
 #define OPTION_INVALID 999
 #define USRPATH MNTPOINT "/aquota.user"
-#define MNTPOINT "mntpoint"
 #define TESTDIR1 MNTPOINT "/testdir1"
 #define TESTDIR2 MNTPOINT "/testdir2"
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 0fabb51a5..dc8589586 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -41,7 +41,6 @@
 #include "tst_test.h"
 #include "quotactl_syscall_var.h"
 
-#define MNTPOINT	"mntpoint"
 
 static int32_t fmt_id = QFMT_VFS_V1;
 static int test_id, mount_flag;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
index 3d1a2c8f5..52752df20 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl_syscall_var.h
@@ -10,7 +10,6 @@
 #include "lapi/quotactl.h"
 
 #define QUOTACTL_SYSCALL_VARIANTS 2
-#define MNTPOINT "mntpoint"
 
 static int fd = -1;
 
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 17cf04c85..689bf5a2f 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -41,7 +41,6 @@
 
 char *TCID = "rename11";
 
-#define MNTPOINT	"mntpoint"
 #define TEST_EROFS	"mntpoint/test_erofs"
 #define TEST_NEW_EROFS	"mntpoint/new_test_erofs"
 
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index c318a7971..4590d9d58 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -51,7 +51,6 @@
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 
-#define MNTPOINT "mntpoint"
 #define TESTDIR "testdir"
 #define NEW_TESTDIR "new_testdir"
 #define TESTDIR2 "/loopdir"
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
index 5cfcda6d8..33f78bb57 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -17,7 +17,6 @@
 #include "tst_test.h"
 #include "tst_numa.h"
 
-#define MNTPOINT "mntpoint"
 #define PAGES_ALLOCATED 16u
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
index 2a1d2e1b9..4596686ed 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -28,7 +28,6 @@
 #include "tst_test.h"
 #include "tst_numa.h"
 
-#define MNTPOINT "mntpoint"
 #define FILES 10
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 31f41369a..88e22467c 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -51,7 +51,6 @@
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
-#define MNTPOINT "mntpoint"
 #define FNAME MNTPOINT"/setxattr01testfile"
 
 static char long_key[XATTR_NAME_LEN];
diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
index 432f1cb77..b8ddce9e9 100644
--- a/testcases/kernel/syscalls/statx/statx12.c
+++ b/testcases/kernel/syscalls/statx/statx12.c
@@ -23,7 +23,6 @@
 #include "tst_test.h"
 #include "lapi/stat.h"
 
-#define MNTPOINT "mntpoint"
 #define TESTFILE MNTPOINT"/testfile"
 
 static int dir_fd = -1, file_fd = -1;
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 264c8f7d7..ee9b3fe7c 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -14,7 +14,6 @@
 #include <sys/mount.h>
 #include "tst_test.h"
 
-#define MNTPOINT	"mntpoint"
 
 static int mount_flag;
 
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index acc35e8a4..61897e9bd 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -23,7 +23,6 @@
 #include <sys/mount.h>
 #include "tst_test.h"
 
-#define MNTPOINT	"mntpoint"
 
 static char long_path[PATH_MAX + 2];
 static int mount_flag;
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 3260312f7..c2e57f85e 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -16,7 +16,6 @@
 #include <sys/mount.h>
 #include "tst_test.h"
 
-#define MNTPOINT	"mntpoint"
 
 static int mount_flag;
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 5696270d6..9b70ee4d2 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -37,7 +37,6 @@ int TST_TOTAL = 1;
 
 #define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
 #define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
-#define MNTPOINT	"mntpoint"
 
 static int fd;
 static int mount_flag;
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index f4b228f97..fd9d2426a 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -23,7 +23,6 @@
 #include "lapi/mount.h"
 #include "tst_test.h"
 
-#define MNTPOINT        "mntpoint"
 #define SYMLINK	"symlink"
 
 #define FLAG_DESC(x, y) .flag = x, .exp_errno = 0, \
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 734f4897b..8ef8a67d6 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -26,7 +26,6 @@
 #include "tst_uid.h"
 #include "tst_clocks.h"
 
-#define MNTPOINT	"mntpoint"
 #define TEMP_FILE	MNTPOINT"/tmp_file"
 #define FILE_MODE	0766
 
diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index efcb5c7a4..34ba236ac 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -21,7 +21,6 @@
 #include "time64_variants.h"
 #include "tst_timer.h"
 
-#define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT"/test_file"
 #define TEST_DIR	MNTPOINT"/test_dir"
 
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 3575ca449..99a29827e 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -29,7 +29,6 @@
 
 #define CHUNK_SIZE 256
 #define BUF_SIZE (2 * CHUNK_SIZE)
-#define MNTPOINT "mntpoint"
 #define TEMPFILE MNTPOINT "/test_file"
 #define MAPFILE MNTPOINT "/map_file"
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
