Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0A606A33C
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=djlKx11w;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yuudv6NH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795105530; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4fSc/mqqbo76gnMvarBrQ8aEO/FPiCgalz3aEyp/mQI=;
 b=djlKx11wy48Lwn5ccvlg6h7r/nM4rHgdX+8nGsAmSjzTUTlYBTSOBQUJQyBEIBetCI5ee
 8hUX8YEFQGMrwUadLy1nIDAvQNCu/ZVAOWgZiEF/vILFzX/te1w9J/exoJg671p84Sf5J38
 YTidVLh3pIs0NmVe+VtkJqJ2ar7iTUI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C79CF3EA99B
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 17:25:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBB343CEC24
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 17:25:09 +0100 (CET)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com
 [IPv6:2607:f8b0:4864:20::548])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B3F12005E6
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 17:25:09 +0100 (CET)
Received: by mail-pg1-x548.google.com with SMTP id
 41be03b00d2f7-cd65070d3feso693698a12.0
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795105508; x=1795710308; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jRv5nJK7T1BA9ujH3+S3T27yJ1BkwQT3fSwIHeAX8Co=;
 b=Yuudv6NHTV1nSV1uWELmIFOV656Lai3rcXBnrkmpMHzN9lCTb61XEyhKlFMbHuxaEO
 DZnW3m/7694j4kjVdkQC4oomWeb+SxaZ14LnWfh4i/rmcmgDe2jZf/y12rXuGUA30Wru
 ZxPe70iybCiivFRx4papy7nfpkwn8VZRhbBDoa0k2G5dnYgsd6waS+MEUerEzfqdjzzF
 PbYM+0hhxsIRQKDkuI5j8OAXD1m96hNJNf1McwQGvY1vZTfMZQq8+GDoFQ0EnDQbD4P0
 DjfaXZS/1utoIK8kWHWIGnAsH7g32TqatnaUM11Uv/wD/DUmzbH5fRCezSoVBVSbkRQ4
 C66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105508; x=1795710308;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jRv5nJK7T1BA9ujH3+S3T27yJ1BkwQT3fSwIHeAX8Co=;
 b=WOl1JUgdd873xczFppacvEcNN9FpyXyFqxbYP4P66xTaiNZ2PdJAkqf//DBBQHBWlS
 fuxXBpUd/3Hi9LXR7U8nPPB9Xot2My3Bg+/mYjalPn0AnnYna03sidJvblTV9n44DSkV
 5EqP7Vj15RpZ9GoW4+3obsisyI6qu0wHvaDDU3Ur54QuMYUFv2Bjgt7OOjM8TVxby/Wk
 bnGxDwKdlv5oCSdYIc+D7PRghMxpQJ0qxQWyd+ipLpHEQhoFLkoCjBiwi2dulCL3ppCL
 dUbC8L/1lvqi30UvyXObffE0JtanF2ofFBDOOAlyZRTjJKGP0PVWqlEXSwZomf6c5fP7
 9FnA==
X-Gm-Message-State: APuU4Z88z8bGblpIq+7agKp4kVTCzk3BpmFyAa4kYXBfoc2fCQs0ECZA
 Al8q3axA/1oNipygoYeO8L0uu4Fqj/oCwc+OVxNpGDMpWk2DABoG77GFvk1/itH1MANJyhDewBD
 VskFx9jA0R1IZVXNHmbnL2TvK5fjMYPBOwaTBau5LXFruwKIEspl9mS4/H1ulOvCKgcY28qTbn7
 UZf8S0PPlszZra2jAJZRMraMnEN5jKprrAJ0B33hjidr+XfMY=
X-Received: from pjbme17.prod.google.com ([2002:a17:90b:17d1:b0:3b4:1926:6554])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c07:b0:3a7:9ec3:ea0e with SMTP id
 98e67ed59e1d1-3b409fecb67mr1043145a91.22.1795105507301; 
 Thu, 19 Nov 2026 08:25:07 -0800 (PST)
Date: Thu, 19 Nov 2026 16:25:04 +0000
In-Reply-To: <20261118063445.2137150-1-chihsheng@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118063445.2137150-1-chihsheng@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119162504.2947034-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sys_block_queue01: Accept plain "none" in
 queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On kernels older than 6.5, bio-based block devices (such as dm, ram,
zram, and pmem) expose queue/scheduler with plain "none" (without
brackets). Kernels 6.2 to 6.13 also print plain "none" for blk-mq
devices with BLK_MQ_F_NO_SCHED.

These cases were removed in kernel 6.5 (commit 6d85ebf95c44) and
kernel 6.14 (commit e7602bb4f3a1), but older kernels still fail the
test because TST_SYSFS_ASSERT_CHOICE() expects one bracketed token:

  TFAIL: /sys/block/dm-87/queue/scheduler has 0 selected tokens, expected exactly 1

Accept exact "none" on kernels older than 6.14. Newer kernels keep
the strict check.

Fixes: f35242c9cc22 ("testcases: sysfs: Add sys_block_queue01")
Signed-off-by: Darren Chang <chihsheng@google.com>
---
Changes in v2:
- Accept plain "none" only on kernels older than 6.14, using
  tst_kvercmp() in setup() (Cyril)
- Drop the comment in check_scheduler() (Cyril)
---
 .../kernel/sysfs/block/sys_block_queue01.c    | 42 ++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/sysfs/block/sys_block_queue01.c b/testcases/kernel/sysfs/block/sys_block_queue01.c
index 38564139a..68af8462c 100644
--- a/testcases/kernel/sysfs/block/sys_block_queue01.c
+++ b/testcases/kernel/sysfs/block/sys_block_queue01.c
@@ -16,11 +16,22 @@
  * - read_ahead_kb, nr_requests and discard_max_bytes are non-negative
  * - nr_requests is greater than zero
  * - rotational, add_random, iostats are boolean (0 or 1)
- * - scheduler is a valid bracketed-choice file with exactly one active scheduler
+ * - scheduler is a valid bracketed-choice file with exactly one active
+ *   scheduler, or plain ``none`` without brackets on kernels older than 6.14
  *
  * All checks skip gracefully with TCONF when a particular attribute is not
  * present, since the set of exported queue attributes differs between kernel
  * versions and device types.
+ *
+ * Kernels older than 6.14 report plain ``none`` in scheduler for queues that
+ * do not support I/O schedulers:
+ *
+ * - bio-based devices (dm, ram, zram, pmem), until commit 6d85ebf95c44
+ *   (``blk-sysfs: add a new attr_group for blk_mq``) in kernel 6.5 stopped
+ *   exporting scheduler for them
+ * - blk-mq queues with BLK_MQ_F_NO_SCHED since kernel 6.2, until commit
+ *   e7602bb4f3a1 (``block: remove BLK_MQ_F_NO_SCHED``) in kernel 6.14 removed
+ *   the flag
  */
 
 #include <string.h>
@@ -30,12 +41,30 @@
 #include "tst_sysfs_assert.h"
 #include "tst_path_defs.h"
 
+static int allow_plain_none;
+
 /* schedulers that have existed in mainline over time */
 static const char *const sched_allowed[] = {
 	"none", "noop", "deadline", "mq-deadline", "cfq",
 	"kyber", "bfq", "anticipatory", NULL
 };
 
+static void check_scheduler(const char *dev)
+{
+	char sched[64];
+
+	if (allow_plain_none &&
+	    TST_SYSFS_READ_STR(sched, sizeof(sched),
+			       PATH_SYS_BLOCK "/%s/queue/scheduler", dev) &&
+	    !strcmp(sched, "none")) {
+		tst_res(TPASS, PATH_SYS_BLOCK "/%s/queue/scheduler = 'none'", dev);
+		return;
+	}
+
+	TST_SYSFS_ASSERT_CHOICE(sched_allowed, NULL, 0,
+				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
+}
+
 static void check_cross(const char *dev)
 {
 	TST_SYSFS_ASSERT_LE_SUFFIX("logical_block_size", "physical_block_size",
@@ -50,8 +79,6 @@ static void check_cross(const char *dev)
 
 static void check_device(const char *dev)
 {
-	char sched[64];
-
 	tst_res(TINFO, "Checking block device '%s'", dev);
 
 	TST_SYSFS_ASSERT_POW2(PATH_SYS_BLOCK "/%s/queue/logical_block_size", dev);
@@ -68,12 +95,16 @@ static void check_device(const char *dev)
 	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/add_random", dev);
 	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/iostats", dev);
 
-	TST_SYSFS_ASSERT_CHOICE(sched_allowed, sched, sizeof(sched),
-				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
+	check_scheduler(dev);
 
 	check_cross(dev);
 }
 
+static void setup(void)
+{
+	allow_plain_none = tst_kvercmp(6, 14, 0) < 0;
+}
+
 static void run(void)
 {
 	DIR *dir;
@@ -101,5 +132,6 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = run,
 };
-- 
2.56.1.708.g77570a6a1d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
