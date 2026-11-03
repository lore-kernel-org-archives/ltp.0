Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29242606A32F
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=op56NMKy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=ZmWh2HWu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793708103; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=cu+M1nHKGAzMUBNIx6atMdKi/7ebS1kMPLb21tgb+kE=;
 b=op56NMKyOKRjo7/9HEM7lGBTNRATqwfPnNN0hbPXSRrBNHpJgFxI+WwV3gp+ba9C5jbpS
 UxzcGy+DYs0+Q9TMYUwOJfyADOuIgbg2FjDDGkArzN7mA5EzZaFOKrG3ADsPE2BOJaAbNiO
 pYINAHWi1CjKyIFO1NhKCF+XqWWt1IE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFBAC3C7A69
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 13:15:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7843C716C
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 13:14:42 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B4AF60068C
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 13:14:42 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 6F0F31A1A7FD7
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 13:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793708051; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=4j2XNxx45o4KDQkvP9EN7OoWAbbNjVIZd/MrCqB7Vb4=;
 b=ZmWh2HWuZS27mO/xBAgklSqJkKNC7tk9E/yhaEZjSEyF2xOdcDpTwftjSMAfh4A6
 iRAqM07HfH6hGNk3/gPmM78D86ymAxwHrLD70fvCZAPuErtK+PsRDKgyqUKm66OE+LW
 XKPpVwOBumZkxgzUa2lwcz1d7RFvrvFcqtC6UmrlUDMLlTauGGeZ4Tialc8NT/a5zrH
 td7KRAHsxl+ydBLDsNWM/8PChLWZnb0/MxdsmuVUfVbyDHFiJ/s+llK51wWWsONPrHw
 sti3LZcOFddmjJw2wGoRHyNVpz8Am8YrIvlHujCrk+Toq9x8m+qkV9NXk4Bs0TvMlRZ
 hAmr0rPNUA==
Date: Tue, 3 Nov 2026 13:14:11 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <P5WKBbq--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fanotify26: Add cases that list the directory
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edvard Conrad via ltp <ltp@lists.linux.it>
Reply-To: Edvard Conrad <edvard@tuta.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Listing a directory through the event file descriptor makes overlayfs
open its layers again, after the event fd exists: every layer of a
merged directory in ovl_dir_read_merged(), and the upper directory of
an impure one in ovl_dir_read_impure(). Unless those opens inherit
FMODE_NONOTIFY from the event fd, a listener that marks the backing
filesystem and lists the directory before it answers is sent a nested
permission event and blocks in getdents64().

Add a case for each. The impure directory is made by renaming a lower
file into a directory created on the overlay. The case reports TCONF
when the overlay cannot record the file's origin and so does not mark
the directory impure. The impure listing is cached with the inode, so
the case moves the entry out and back first; otherwise a later
iteration would read the cache instead of the layer.

Both cases fail on a kernel without the pending overlayfs fix for
directory opens.

Signed-off-by: Edvard Conrad <edvard@tuta.io>
---
Applies on top of "syscalls/fanotify26: Add directory cases for the
nested event":
  https://lore.kernel.org/ltp/P5Iny41--F-9@tuta.io/

Asked for by Amir on the kernel thread, where both paths came up:
  https://lore.kernel.org/all/CAOQ4uxh67+vs0mr-Lxmwz9-N+F8m29WUNz+8qFLLDpOVYB7=vg@mail.gmail.com/

Tested in a VM on 6b4b543fa18, each kernel run once and with -i 2,
with the backing filesystem marked:

                                file  dir   merged dir  impure dir
                                            listed      listed
  no fix                        FAIL  FAIL  FAIL        FAIL
  + c3d355f427ce                PASS  FAIL  FAIL        FAIL
  + ovl directory fix, v1       PASS  PASS  FAIL        FAIL
  + ovl directory fix, v2       PASS  PASS  PASS        FAIL
  + v2 and the follow-up on     PASS  PASS  PASS        PASS
    the kernel thread

The overlay-only cases pass on all of them. Without the fix the impure
case fails in both iterations of -i 2, which is what moving the entry
out and back is for.

 .../kernel/syscalls/fanotify/fanotify26.c     | 92 ++++++++++++++++---
 1 file changed, 79 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify26.c b/testcases/kernel/syscalls/fanotify/fanotify26.c
index 3f6b525ef..f6a56821f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify26.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
@@ -23,6 +23,11 @@
  * backing filesystem as well, which is the shape an anti-malware scanner uses
  * on an overlayfs root.
  *
+ * Listing a directory through the event file descriptor can make overlayfs
+ * open its layers again: every layer of a merged directory, and the upper
+ * directory of an impure one, which holds entries moved in from below. The
+ * last two test cases have the listener do that before it answers.
+ *
  * The test needs root to create permission events and to mount overlayfs.
  */
 
@@ -34,7 +39,9 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/xattr.h>
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
@@ -42,10 +49,21 @@
 #define BACKING_MNT	OVL_BASE_MNTPOINT
 #define FNAME		"test_file"
 #define DNAME		"test_dir"
+#define MNAME		"merged_dir"
+#define INAME		"impure_dir"
+#define MOVED		"moved_file"
 #define OVL_FILE	OVL_MNT "/" FNAME
 #define OVL_DIR		OVL_MNT "/" DNAME
+#define OVL_MDIR	OVL_MNT "/" MNAME
+#define OVL_IDIR	OVL_MNT "/" INAME
+#define OVL_MOVED	OVL_MNT "/" MOVED
+#define OVL_IDIR_MOVED	OVL_IDIR "/" MOVED
 #define LOWER_FILE	OVL_LOWER "/" FNAME
 #define LOWER_DIR	OVL_LOWER "/" DNAME
+#define LOWER_MDIR	OVL_LOWER "/" MNAME
+#define LOWER_MOVED	OVL_LOWER "/" MOVED
+#define UPPER_MDIR	OVL_UPPER "/" MNAME
+#define UPPER_IDIR	OVL_UPPER "/" INAME
 
 /*
  * The listener either answers the event at once or is blocked for good, so
@@ -56,19 +74,41 @@
 #define WAIT_MSEC	5000
 
 static int fd_notify = -1;
+static int idir_is_impure;
 
 static struct tcase {
 	const char *tname;
+	const char *path;
 	int mark_backing;
 	int ondir;
+	int list;
+	int impure;
 } tcases[] = {
-	{"Overlay mark, file", 0, 0},
-	{"Overlay and backing mark, file", 1, 0},
-	{"Overlay mark, directory", 0, 1},
-	{"Overlay and backing mark, directory", 1, 1},
+	{"Overlay mark, file", OVL_FILE, 0, 0, 0, 0},
+	{"Overlay and backing mark, file", OVL_FILE, 1, 0, 0, 0},
+	{"Overlay mark, directory", OVL_DIR, 0, 1, 0, 0},
+	{"Overlay and backing mark, directory", OVL_DIR, 1, 1, 0, 0},
+	{"Overlay and backing mark, merged directory, listed",
+	 OVL_MDIR, 1, 1, 1, 0},
+	{"Overlay and backing mark, impure directory, listed",
+	 OVL_IDIR, 1, 1, 1, 1},
 };
 
-static void answer_one_event(pid_t opener)
+static void list_dir(int fd)
+{
+	char buf[1024];
+	long ret;
+
+	/* Blocks for good if reading a layer generates a nested event. */
+	do {
+		ret = tst_syscall(__NR_getdents64, fd, buf, sizeof(buf));
+	} while (ret > 0);
+
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "getdents64() on the event fd failed");
+}
+
+static void answer_one_event(pid_t opener, int list)
 {
 	struct fanotify_event_metadata event;
 	struct fanotify_response resp;
@@ -76,6 +116,9 @@ static void answer_one_event(pid_t opener)
 	/* Blocks for good if the event fd generates a nested event. */
 	SAFE_READ(SAFE_READ_ALL, fd_notify, &event, sizeof(event));
 
+	if (list && event.fd != FAN_NOFD)
+		list_dir(event.fd);
+
 	/*
 	 * A wrong mask or a stranger's event is a result, not harness
 	 * breakage, so report and still answer: the opener stays parked in
@@ -110,6 +153,20 @@ static void run(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
+	if (tc->impure) {
+		if (!idir_is_impure) {
+			tst_res(TCONF, "Overlay did not mark the directory impure");
+			return;
+		}
+		/*
+		 * The impure listing is cached with the inode and reused, so
+		 * a later iteration would not open the layer at all. Moving
+		 * an entry with an origin out and back invalidates it.
+		 */
+		SAFE_RENAME(OVL_IDIR_MOVED, OVL_MOVED);
+		SAFE_RENAME(OVL_MOVED, OVL_IDIR_MOVED);
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
@@ -132,10 +189,7 @@ static void run(unsigned int n)
 		 * answered it goes away, so a failure here is the fallout of
 		 * the test tearing a blocked listener down, not a result.
 		 */
-		if (tc->ondir)
-			fd = open(OVL_DIR, O_RDONLY | O_DIRECTORY);
-		else
-			fd = open(OVL_FILE, O_RDONLY);
+		fd = open(tc->path, O_RDONLY | (tc->ondir ? O_DIRECTORY : 0));
 		if (fd != -1)
 			SAFE_CLOSE(fd);
 		exit(0);
@@ -148,7 +202,7 @@ static void run(unsigned int n)
 
 	reader = SAFE_FORK();
 	if (!reader) {
-		answer_one_event(opener);
+		answer_one_event(opener, tc->list);
 		exit(0);
 	}
 
@@ -160,8 +214,7 @@ static void run(unsigned int n)
 	 */
 	if (TST_PROCESS_STATE_WAIT(reader, 'Z',
 				   tst_multiply_timeout(WAIT_MSEC))) {
-		tst_res(TFAIL,
-			"Listener blocked in read() by a nested event");
+		tst_res(TFAIL, "Listener blocked by a nested event");
 		SAFE_KILL(reader, SIGKILL);
 		SAFE_WAITPID(reader, NULL, 0);
 	}
@@ -175,12 +228,25 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	/* Both have to exist in the lower layer to be opened through it. */
+	/* These have to exist in the layers to be opened through them. */
 	SAFE_UMOUNT(OVL_MNT);
 	SAFE_TOUCH(LOWER_FILE, 0644, NULL);
 	SAFE_MKDIR(LOWER_DIR, 0755);
+	SAFE_MKDIR(LOWER_MDIR, 0755);
+	SAFE_MKDIR(UPPER_MDIR, 0755);
+	SAFE_TOUCH(LOWER_MOVED, 0644, NULL);
 	SAFE_MOUNT_OVERLAY();
 
+	/*
+	 * A directory made through the overlay is upper only. Moving a lower
+	 * file into it records the file's origin and marks the directory
+	 * impure, unless the layers cannot carry an origin.
+	 */
+	SAFE_MKDIR(OVL_IDIR, 0755);
+	SAFE_RENAME(OVL_MOVED, OVL_IDIR_MOVED);
+	idir_is_impure =
+		getxattr(UPPER_IDIR, "trusted.overlay.impure", NULL, 0) != -1;
+
 	/*
 	 * Probe the widest combination run() uses, not a weaker proxy for
 	 * it. Every case marks the overlay; the second of each pair also
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
