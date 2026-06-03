Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A58CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 05:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780463669; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=y5N7aUU1O+G4PfFKcALLgmTh79RpP/I3FmzhB8+P9pM=;
 b=kT1NzHy8BHWcrwtCYi3U5j9d0g2I6CyuMUPf+Vw7UoeYjEogPSHUfKEu5dNuf8siCzDfC
 Abk3+QK3bsjV8DwVxtau3s2YxqMf+c62S/EdGtqr8XkFt0p+DFGiU4fqVzfnyM6/LufCooe
 iCV34oEhJ50ItTi1+RSdig8dwqDQV54=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5018B3E2C5E
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 07:14:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 964BE3D01C8
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 07:14:09 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D845C1A0009C
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 07:14:08 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c85dcdbe502so405908a12.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 22:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780463647; x=1781068447; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FJ+DfHrfPx6bLno0+0DSWu6nL0Whh6rzbIUAklqWkfs=;
 b=eDzS/kJhWq9P2C9+FaTQpAf+KBJr8kGrLZLuT12od7b9Q+1/1YEZghyZ8eQdk95ag1
 VEeKfigkY3JLNxdO0dECPE8mDc6BPBrBBfoEVnd9y3Au9G72Wopmnktcd5+NUMGl4N3n
 GG7cLqocCbA1u5D4AV0RNT3xuLAZ4eQcPTUrz+dEJTukZxYn/c6MHLOS+JY2T5kOFxbg
 jvR6McTZj8XHX6rgE6Y/bEV+yeFQDEIvPhC+ObVRSt8S94UrA8K/LQgmpvISPimlGtzU
 atx8FjYcC3QSTRFDloEf14MmPAIZ9QbRKRYNxMlHWvAHefVH7ienab0tRE+r4stahMRL
 +c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780463647; x=1781068447;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJ+DfHrfPx6bLno0+0DSWu6nL0Whh6rzbIUAklqWkfs=;
 b=TQxnB5BBASDf2gWeEDxurPv53wTgcpOvInPbgOa4jJtsArkFwTh16jUf4ZMYPwp+fq
 vOycnNOqRlf4MEeX0ocBCLgT6N07/doIKpf1Hqfaq6g/9CgXGNcjZYmfBAD2BEhrA0Pj
 Vm37sfHxSBAo5C/LFUMMHauEochcqtdsso21Y1GeRA7x/QVRVL/PhU/BoInwgMIYzXDN
 sxIhz5aYD8+MSXW57zcH/pJ9oZ6isbZlBqVmu5zIAiAGsVcvF/D9kNgQ+JyD24oCb5A3
 4J8zEjZX3gBB3/4LrhIGoUJKs+R5pKjj+ZubofJ8Hf6HqXRM4rmCW5exUzlUvJNYvsdd
 /r3w==
X-Gm-Message-State: AOJu0Ywj/QIpkcPpyDjiorh425oy5QfxCumhoPNOeO0G3JR0F0AVWCF4
 PBbOFh084MJSKx7kjkMyNtA55rFDN1z3r5Zj5yxZV2AUffpVKIeYpSnpQV4PIEWMbhfMiUWh48e
 mhUyIen2l7pPagZrLj2pay32VyTQujghfRjUwq8AXqm6oNJWjOB8xErWfxiKa/TiQtouA6jJkLi
 dodwv1jEgc50OxGyyXSjvP7UQBMvlWW4nGDEOx6odxYUPtB5I=
X-Received: from pfbki2.prod.google.com ([2002:a05:6a00:9482:b0:842:3d2d:1e7e])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:288c:b0:842:5777:71b7 with SMTP id
 d2e1a72fcca58-84284facf26mr1807352b3a.48.1780463646215; 
 Tue, 02 Jun 2026 22:14:06 -0700 (PDT)
Date: Wed,  3 Jun 2026 05:14:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603051401.658906-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/listmount04: Detect backported commit
 78f0e33cd6c9 dynamically
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
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
by grab_requested_mnt_ns") changed the expected errno for an invalid
mnt_ns_fd from EINVAL to EBADF. This was introduced in v6.17.9.

Currently, the test relies solely on tst_kvercmp() to determine which
errno to expect. However, this causes the test to fail on older LTS
or Android kernels (e.g., v6.12) that have backported this specific
patch. On these kernels, listmount() correctly returns EBADF, but the
test expects EINVAL purely based on the older kernel version number.

Fix this by introducing a runtime probe in setup(). By issuing a dummy
listmount() syscall with an invalid mnt_ns_fd (-1), we can check the
returned errno and accurately determine the kernel's behavior regardless
of its version string.

Additionally, rename the 'kver' variable to 'current_fd_err_behavior'
and update the macros to clearly reflect the expected errno behavior
(INVALID_FD_RET_EINVAL vs INVALID_FD_RET_EBADF) rather than relying on
version thresholds, improving overall code readability and semantics.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 .../kernel/syscalls/listmount/listmount04.c   | 51 ++++++++++++++-----
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 919f4c854..38eaffede 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -15,22 +15,26 @@
 
 #define _GNU_SOURCE
 
+#include <errno.h>
 #include "config.h"
 #include "tst_test.h"
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
 
 #define MNT_SIZE 32
+
 /*
  * For commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
  * by grab_requested_mnt_ns") from v6.18-rc7 backported to v6.17.9.
+ * Defines the expected error code behavior when an invalid file descriptor
+ * is passed to mnt_ns_fd (previously known as spare).
  */
-#define BEFORE_6_17_9 1
-#define AFTER_6_17_9 2
+#define INVALID_FD_RET_EINVAL 1
+#define INVALID_FD_RET_EBADF  2
 
 static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
-static int kver;
+static int current_fd_err_behavior;
 
 static struct tcase {
 	int req_usage;
@@ -43,7 +47,7 @@ static struct tcase {
 	uint64_t flags;
 	int exp_errno;
 	char *msg;
-	int kver;
+	int fd_err_behavior;
 } tcases[] = {
 	{
 		.req_usage = 0,
@@ -89,7 +93,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
-		.kver = BEFORE_6_17_9,
+		.fd_err_behavior = INVALID_FD_RET_EINVAL,
 	},
 	{
 		.req_usage = 1,
@@ -100,7 +104,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EBADF,
 		.msg = "invalid mnt_id_req.mnt_ns_fd",
-		.kver = AFTER_6_17_9,
+		.fd_err_behavior = INVALID_FD_RET_EBADF,
 	},
 	{
 		.req_usage = 1,
@@ -137,8 +141,9 @@ static void run(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	mnt_id_req *req = NULL;
 
-	if (tc->kver && tc->kver != kver) {
-		tst_res(TCONF, "Test not suitable for current kernel version");
+	/* Skip tests that do not match the runtime behavior of current kernel */
+	if (tc->fd_err_behavior && tc->fd_err_behavior != current_fd_err_behavior) {
+		tst_res(TCONF, "Test not suitable for current kernel's FD error behavior");
 		return;
 	}
 
@@ -159,10 +164,32 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	if (tst_kvercmp(6, 17, 9) >= 0)
-		kver = AFTER_6_17_9;
-	else
-		kver = BEFORE_6_17_9;
+	/* 1. If kernel is 6.17.9 or newer, it definitively has the new behavior */
+	if (tst_kvercmp(6, 17, 9) >= 0) {
+		current_fd_err_behavior = INVALID_FD_RET_EBADF;
+		return;
+	}
+
+	/* 2. Runtime probe for older kernels:
+	 * Check if commit 78f0e33cd6c9 was backported by manually issuing
+	 * a syscall with an invalid mnt_ns_fd (-1).
+	 */
+	mnt_id_req probe_req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ns_fd = -1,
+		.param = 0
+	};
+
+	tst_syscall(__NR_listmount, &probe_req, mnt_ids, MNT_SIZE, 0);
+
+	/* 3. Set global behavior flag based on actual kernel response */
+	if (errno == EBADF) {
+		tst_res(TINFO, "Detected backported commit 78f0e33cd6c9 (returns EBADF)");
+		current_fd_err_behavior = INVALID_FD_RET_EBADF;
+	} else {
+		current_fd_err_behavior = INVALID_FD_RET_EINVAL;
+	}
 }
 
 static struct tst_test test = {
-- 
2.54.0.1032.g2f8565e1d1-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
