Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF437D1D47D
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767889039; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=7NGEiGTw5zKe9d+6YnwBGfgjqT/7CRU75RbM93FWGbM=;
 b=MCEz1rbYz5aFhhe5n8iCXmaunk0Lk8BURZfFNtTlm8hona/Rt50SUg0uFFaec1y4soCsZ
 iSfSxN5d6QwVteBW5UeOxY7A7Qeo1ZGn94w/ol9aOsA9Lht3qGxjJ2mtLtz0ZJLF8uIVbVU
 CggWThZDCFVOqVwj06oGXv7zj0Tapq0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852873C65DF
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 17:17:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBDD93C2789
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 17:16:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 226BA1000929
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 17:16:52 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4905740273; 
 Thu,  8 Jan 2026 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767889012;
 bh=78QlZHGjozzBflYcw9KEWI5PFK9DbdOXabrtwpNO3cs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fM83xOIYm0o4Akq5hey0FJEzx6bvmNMbyuSXaFvvPzP04NKc6zhEdNgSNvi5EPuw2
 2HML9YOb23Yr/bjJoccGB6SN82i8llAR5HjCxvZjyK+XKijUlAtsQZY9gNOmM1BKJI
 AJS7QAA72OhyKxIBFWirjLTcoRKi4Pp/ERPG1GfdfdNJuZgOyfm2ZRusmj7/unG2uU
 NPJEFpSGY9Po5uEAlozNhak2qemakmc8k6ald0XDFTWk6I9yHFlAlxpdc4kcB3ZDUp
 A1gDq271achICwQLJXqzB/9F5U/qoJyHY4pS4WBtfiPQyBaygOGiH8LGxIDpEwdxYS
 Ye0K8qUKDaMzMPdqm7itf+TUplbeS3AcwrNbPwto6wa6jueLhad6IBcUQ30mpp/Kh1
 BJZM6RgQi9MM0W7K5XrEJ12W1wwQkPe01VIkepI3uama+g7dr+R+tms1j43KdgDYIk
 MoXm/fnggbWG3AxsTapjdHp52eR2F68nsIWHPlp06w4jOCLfqQlSFVgi7fJdgQQzyO
 lyiwS4+3fVf3/1AlAUpQvMcRig+ywSOF/E0lk/F6/YnfNpGXagVhQtIC05jelyy72Y
 vTwqeRKh5vCe1T27JQ99jwO8V6PguiFHBFPqp0Il470L4x6s6hig+SoJ9NmehAB5Uf
 cKLjMZSB1wPWb+XBd42unCqY=
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 00:16:18 +0800
Message-ID: <20260108161618.103229-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCHv3] listmount04.c: update struct mnt_id_req support to
 kernel >= 6.17
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The kernel change 78f0e33cd6c93 ("fs/namespace: correctly handle errors
returned by grab_requested_mnt_ns") from 6.18 has been ported to upstream
6.17.9 [1][2].

Therefore change the expectation from >= 6.18 to >= 6.17 accodingly.

[1] https://lwn.net/Articles/1047684/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.17.9&id=8ff97ade

v2: add comments for this change into the code.
v3: correst RST syntax and move comment as suggested by Petr Vorel.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../kernel/syscalls/listmount/listmount04.c   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 2b8b49101..919f4c854 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -7,6 +7,7 @@
  * Verify that listmount() raises the correct errors according with
  * invalid data:
  *
+ * - EBADF: invalid mnt_ns_fd
  * - EFAULT: req or mnt_id are unaccessible memories
  * - EINVAL: invalid flags or mnt_id request
  * - ENOENT: non-existent mount point
@@ -20,8 +21,12 @@
 #include "lapi/syscalls.h"
 
 #define MNT_SIZE 32
-#define BEFORE_6_18 1
-#define AFTER_6_18 2
+/*
+ * For commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
+ * by grab_requested_mnt_ns") from v6.18-rc7 backported to v6.17.9.
+ */
+#define BEFORE_6_17_9 1
+#define AFTER_6_17_9 2
 
 static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
@@ -84,7 +89,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
-		.kver = BEFORE_6_18,
+		.kver = BEFORE_6_17_9,
 	},
 	{
 		.req_usage = 1,
@@ -95,7 +100,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EBADF,
 		.msg = "invalid mnt_id_req.mnt_ns_fd",
-		.kver = AFTER_6_18,
+		.kver = AFTER_6_17_9,
 	},
 	{
 		.req_usage = 1,
@@ -154,10 +159,10 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	if (tst_kvercmp(6, 18, 0) >= 0)
-		kver = AFTER_6_18;
+	if (tst_kvercmp(6, 17, 9) >= 0)
+		kver = AFTER_6_17_9;
 	else
-		kver = BEFORE_6_18;
+		kver = BEFORE_6_17_9;
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
