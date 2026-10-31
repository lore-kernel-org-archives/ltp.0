Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A61606A31A
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=e1Jdg491;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=t23Q+8U5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793481259; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=eWLEz9oApuyJ4U0pT8CrE7+kgjcCCjUML2OHAqd5i3Y=;
 b=e1Jdg491i464bYSDx7aqJYjJGsNunzMHNs9lEus+cyIMaqCagehI7EJyZVhwLDUQc93cK
 qUA2vGOeSzEzw7uvXkSFFI0zV0q6BeuJw+oLk6e/xHcHRGKB1PggMGtgnU8XSUTvXCd0aj0
 0yAmd3ZIo8DDczeah8KdvflKbGDXJnQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0A663E217F
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 22:14:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03F43D266C
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 22:13:59 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6982014001EF
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 22:13:57 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 508521A022BC0
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 22:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793481237; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=gviBNruupJAtq7Zr2VCQTsnA+BBx9na3XNmZNaWbGAU=;
 b=t23Q+8U5c2l6SZNBs1j1ECRfmhpqVfKQkfahbZY2Sag9jz6lHZY+JdVzCLcvpKCK
 NSUNvS57EyXq1IGOW4J6e8deP8BzcMANwKf2lOyINbFcPojwCFdKWAtRFwBtRMJ7cAk
 tJl6yESQy1qjnwQiPrieGYNtF8pzIhy85B8HUH6rK23nYPeQkQJaBvuCFMjVYHIj25i
 lvtMwSvfqFTGMSstqIQiRGnXv6k6BN8zT1m+W5hVaI+PQ1ldhx7i5+x6oeFBQtnNzrr
 Hq3g1oicdyy23m5UWDH26NDt7gSpkCse7zYO6RhF0xG//MMlW5fkmRH+9npOzNpCxsD
 LQX213W0jw==
Date: Sat, 31 Oct 2026 22:13:57 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <P5Iny41--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fanotify26: Add directory cases for the
 nested event
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

A directory on overlayfs reaches its real directory through
ovl_dir_open_realfile() rather than backing_file_open(), so the fix
for regular files, commit c3d355f427ce ("fs: let backing files
inherit FMODE_NONOTIFY from the user file"), does not cover it: a
listener that marks the backing filesystem with FAN_OPEN_PERM |
FAN_ONDIR is still sent a nested permission event from its own
read(2) when the reported path is an overlay directory.

Add the directory counterparts of the two existing cases. The
listener's expected event mask stays FAN_OPEN_PERM: FAN_ONDIR is not
reported to a group without FAN_REPORT_FID.

The fourth case fails on a kernel without the pending fix "ovl:
inherit FMODE_NONOTIFY when opening directory realfiles".

Signed-off-by: Edvard Conrad <edvard@tuta.io>
---
Depends on the pending overlayfs fix, posted by Amir on the kernel
thread:
  https://lore.kernel.org/all/CAOQ4uxjm=cGPnug18VuhKqiMvkWwLPNLO_TE3KxO8iLZG+veYQ@mail.gmail.com/
Without it the fourth case fails on current mainline, so this should
wait in the queue until that fix is in Linus' tree; a linux-git tag for
it can then be added. The first three cases pass on v7.4-rc1 material
today.

Tested in a VM, each kernel run once and with -i 2:

  kernel                              file+backing  dir+backing
  v6.13                               PASS          FAIL
  6b4b543fa18 (no fix)                FAIL          FAIL
  + c3d355f427ce (files, in Linus')   PASS          FAIL
  + the pending ovl fix               PASS          PASS

The "overlay mark only" cases pass everywhere. The directory case
fails on v6.13 too: overlayfs never passed the nonotify state on to
the real directory, so it predates the 6.14 change that broke files.

 .../kernel/syscalls/fanotify/fanotify26.c     | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify26.c b/testcases/kernel/syscalls/fanotify/fanotify26.c
index 63d7eea0f..3f6b525ef 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify26.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
@@ -17,9 +17,11 @@
  * listener that reads with a single thread never returns, and every task that
  * touches a watched filesystem queues up behind it.
  *
- * The first test case marks the overlay only and must pass on any kernel. The
- * second one marks the backing filesystem as well, which is the shape an
- * anti-malware scanner uses on an overlayfs root.
+ * Regular files and directories reach their real file through different
+ * paths in overlayfs, so both are tested. For each, the first test case marks
+ * the overlay only and must pass on any kernel, the second one marks the
+ * backing filesystem as well, which is the shape an anti-malware scanner uses
+ * on an overlayfs root.
  *
  * The test needs root to create permission events and to mount overlayfs.
  */
@@ -39,8 +41,11 @@
 
 #define BACKING_MNT	OVL_BASE_MNTPOINT
 #define FNAME		"test_file"
+#define DNAME		"test_dir"
 #define OVL_FILE	OVL_MNT "/" FNAME
+#define OVL_DIR		OVL_MNT "/" DNAME
 #define LOWER_FILE	OVL_LOWER "/" FNAME
+#define LOWER_DIR	OVL_LOWER "/" DNAME
 
 /*
  * The listener either answers the event at once or is blocked for good, so
@@ -55,9 +60,12 @@ static int fd_notify = -1;
 static struct tcase {
 	const char *tname;
 	int mark_backing;
+	int ondir;
 } tcases[] = {
-	{"Mark on the overlay", 0},
-	{"Mark on the overlay and on the backing filesystem", 1},
+	{"Overlay mark, file", 0, 0},
+	{"Overlay and backing mark, file", 1, 0},
+	{"Overlay mark, directory", 0, 1},
+	{"Overlay and backing mark, directory", 1, 1},
 };
 
 static void answer_one_event(pid_t opener)
@@ -71,7 +79,9 @@ static void answer_one_event(pid_t opener)
 	/*
 	 * A wrong mask or a stranger's event is a result, not harness
 	 * breakage, so report and still answer: the opener stays parked in
-	 * the kernel until something does.
+	 * the kernel until something does. FAN_ONDIR is not reported to a
+	 * group without FAN_REPORT_FID, so a directory open arrives as a
+	 * plain FAN_OPEN_PERM as well.
 	 */
 	if (event.mask != FAN_OPEN_PERM) {
 		tst_res(TFAIL, "Got event mask %llx, expected %llx",
@@ -95,6 +105,7 @@ static void answer_one_event(pid_t opener)
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
+	uint64_t mask = FAN_OPEN_PERM | (tc->ondir ? FAN_ONDIR : 0);
 	pid_t opener, reader;
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
@@ -102,12 +113,12 @@ static void run(unsigned int n)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
-			   FAN_OPEN_PERM, AT_FDCWD, OVL_MNT);
+			   mask, AT_FDCWD, OVL_MNT);
 
 	if (tc->mark_backing) {
 		SAFE_FANOTIFY_MARK(fd_notify,
 				   FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
-				   FAN_OPEN_PERM, AT_FDCWD, BACKING_MNT);
+				   mask, AT_FDCWD, BACKING_MNT);
 	}
 
 	opener = SAFE_FORK();
@@ -121,7 +132,10 @@ static void run(unsigned int n)
 		 * answered it goes away, so a failure here is the fallout of
 		 * the test tearing a blocked listener down, not a result.
 		 */
-		fd = open(OVL_FILE, O_RDONLY);
+		if (tc->ondir)
+			fd = open(OVL_DIR, O_RDONLY | O_DIRECTORY);
+		else
+			fd = open(OVL_FILE, O_RDONLY);
 		if (fd != -1)
 			SAFE_CLOSE(fd);
 		exit(0);
@@ -161,18 +175,21 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	/* The file has to exist in the lower layer to be opened through it. */
+	/* Both have to exist in the lower layer to be opened through it. */
 	SAFE_UMOUNT(OVL_MNT);
 	SAFE_TOUCH(LOWER_FILE, 0644, NULL);
+	SAFE_MKDIR(LOWER_DIR, 0755);
 	SAFE_MOUNT_OVERLAY();
 
 	/*
-	 * Probe the combination run() uses, not a weaker proxy for it. Every
-	 * case marks the overlay; the second also marks the base.
+	 * Probe the widest combination run() uses, not a weaker proxy for
+	 * it. Every case marks the overlay; the second of each pair also
+	 * marks the base.
 	 */
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_CONTENT,
 						FAN_MARK_FILESYSTEM,
-						FAN_OPEN_PERM, OVL_MNT);
+						FAN_OPEN_PERM | FAN_ONDIR,
+						OVL_MNT);
 	REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_FILESYSTEM, BACKING_MNT);
 }
 
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
