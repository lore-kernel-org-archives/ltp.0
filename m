Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06211EB64D8
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 09:40:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A364F3C9D84
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 11:40:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EFF63C9B67
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 11:39:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B4636002C9
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 11:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687426794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bqO/uuHoBBCuMj2SKSKsEnl+0uK9AuO385GqiQpx9RQ=;
 b=CdaZMy+xUsUGTFKUdHxd5PKrfV09zo5SOl0VuqPIXnOeRsFa9o8+LZkRmxF7GN30wOzLdF
 wtXfWcPGqcJq/GJPjMLk5Gt88VdswnoQrZOkYpVe2Wz/gPmUNIZ44gknhMzmKs5m0zmJ1f
 whtddFm3ZMFeFqmJQw5n9il+uwyrhTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-rdqlBgk-PEusF1hRqxinjA-1; Thu, 22 Jun 2023 05:39:53 -0400
X-MC-Unique: rdqlBgk-PEusF1hRqxinjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C848188D124;
 Thu, 22 Jun 2023 09:39:52 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 742D42017DC6;
 Thu, 22 Jun 2023 09:39:51 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 22 Jun 2023 17:39:48 +0800
Message-Id: <20230622093948.530764-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tunable: make use of save_restore
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

SAFE_ACCESS requires the pathname is exist otherwise TBROK.
so let's use TST_SR_TBROK in save_restore.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/tunable/max_map_count.c   | 18 +-----------------
 testcases/kernel/mem/tunable/min_free_kbytes.c |  8 +-------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 82a69a61e..f33095473 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -53,21 +53,6 @@
 #define MAP_COUNT_DEFAULT	1024
 #define MAX_MAP_COUNT		65536L
 
-static long old_max_map_count = -1;
-
-static void setup(void)
-{
-	SAFE_ACCESS(PATH_SYSVM "max_map_count", F_OK);
-
-	old_max_map_count = get_sys_tune("max_map_count");
-}
-
-static void cleanup(void)
-{
-	if (old_max_map_count != -1)
-		set_sys_tune("max_map_count", old_max_map_count, 0);
-}
-
 /* This is a filter to exclude map entries which aren't accounted
  * for in the vm_area_struct's map_count.
  */
@@ -205,11 +190,10 @@ static void max_map_count_test(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = max_map_count_test,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/vm/overcommit_memory", "0", TST_SR_TBROK},
+		{"/proc/sys/vm/max_map_count", NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index dd07a0323..19da409e8 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -218,21 +218,15 @@ static void setup(void)
 	default_tune = get_sys_tune("min_free_kbytes");
 }
 
-static void cleanup(void)
-{
-	if (default_tune != -1)
-		set_sys_tune("min_free_kbytes", default_tune, 0);
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.max_runtime = TST_UNLIMITED_RUNTIME,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = min_free_kbytes_test,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
+		{"/proc/sys/vm/min_free_kbytes", NULL, TST_SR_TBROK},
 		{}
 	},
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
