Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779EDFA3735
	for <ltp@archiver.kernel.org>; Fri,  2 Jan 2026 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767354871; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=1sD6IPIzmvAhnynQzPJZCBvpYu/IdXugjXAYuWNGVw0=;
 b=WPKCcKf5Pjafnoq+yQeXu2bMnfUOcYOZClJ/I2OOotSsiarx0mv9wjbHabp3iLqr+2QnI
 BbKXrh8I+PR6KK69K4Q3nV28PZF0JGKuofKcfyGh+4tgkWTd/18cNgyOtYv2ak+esw5OThD
 QXB9Bqs4xr4ENOsQbdE5DwYutj4KbuQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C63F23D03CA
	for <ltp@archiver.kernel.org>; Fri,  2 Jan 2026 12:54:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32B023CF780
 for <ltp@lists.linux.it>; Fri,  2 Jan 2026 12:54:08 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2876660027D
 for <ltp@lists.linux.it>; Fri,  2 Jan 2026 12:54:07 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 639983FF71; 
 Fri,  2 Jan 2026 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767354846;
 bh=4IZYxM4MHxJjDm/xQBS5S+qPgzlAqkB7kT7u1f7rkVQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AXrBJe18uMg2f9JmxBjK+G8doYVGUpDJJelP5smDAJDmrsXR1GSPbQX1ARX29NHvL
 KSZ3dNl7kcQLy65PKmlQ3U7B+CDyFmO3D+e7IDG6aGrrEtwakj7ZDFDquCnfuWFy9A
 VYG7PnAylSdiTArGg2ZlcLpXDNxZiHsllIOndCFFV5EAb3eJHSDiWLNyqVOG/b1bCy
 X8XY+m1UQ4OSuL6w9lOqlXwl49Bsyd9usWxlQRE2ASxK67SWB/I0ijZzso1gw9R4Gb
 5tF4FKNGFD/KpqfMpedAUSssC/UQImKbrV3w0tYe5fIUGgcg5KV7Y1/12rZF7JK2v/
 1TnZrLHCiQgf+G3cCGv6tNz0Alf4rt43K4RF4SgH8lh/wd8RObgIE27HQ3srUV4Of/
 XRFnJP1f2++t/yw/C9inSlBIw7/xyPDQ+d0AFWGP6hc47Ftm/S/QoGDOrEdJ1BCoiR
 7i7uBd06kB6uumfzpe+WB9PzvyrS3DRqu+ImnIkOjI8HeBWDOkc/RmC0Rm65Fa3bir
 XHu0BdON+hNqdlQmmYEkm0F3frCX/gq+jWoSe03/oAAxZabhSaZkpO0TaLCfffrLlz
 TrcJ9Co24aAri9xrFeuwVHFghHDKxq2zDgjv9VrURtupm5P9bfqcWlXxh6ApTRFKC3
 V31904phKIerG65yG8G4xuug=
To: ltp@lists.linux.it
Date: Fri,  2 Jan 2026 19:51:47 +0800
Message-ID: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] listmount04.c: update struct mnt_id_req support to
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

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/listmount/listmount04.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 2b8b49101..34789353b 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -20,8 +20,8 @@
 #include "lapi/syscalls.h"
 
 #define MNT_SIZE 32
-#define BEFORE_6_18 1
-#define AFTER_6_18 2
+#define BEFORE_6_17 1
+#define AFTER_6_17 2
 
 static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
@@ -84,7 +84,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
-		.kver = BEFORE_6_18,
+		.kver = BEFORE_6_17,
 	},
 	{
 		.req_usage = 1,
@@ -95,7 +95,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EBADF,
 		.msg = "invalid mnt_id_req.mnt_ns_fd",
-		.kver = AFTER_6_18,
+		.kver = AFTER_6_17,
 	},
 	{
 		.req_usage = 1,
@@ -154,10 +154,10 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	if (tst_kvercmp(6, 18, 0) >= 0)
-		kver = AFTER_6_18;
+	if (tst_kvercmp(6, 17, 0) >= 0)
+		kver = AFTER_6_17;
 	else
-		kver = BEFORE_6_18;
+		kver = BEFORE_6_17;
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
