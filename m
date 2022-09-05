Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC58ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 07:43:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1D23CA925
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 09:43:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 398C83CA91D
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 09:43:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31DD51400BEA
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 09:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662363820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cy7JbIP9+OMzuRyTMiIdy9u6gzPjWoPeFEju1yfr7ts=;
 b=EmXpmKTkOc+Eb0gFNM0Xnxb6QKTBY8Ppk4QPrYak5Y9/bGOAE8YWmbXguzww7ivxhfJxRQ
 2FPCfcMFqZ688SAM3+T3iiaO2E2bSsOS7ScJQC2ZAnEUTVRS+sGareq/W9/6O6noeHlgMw
 lNCKbWbkvhOZIcUyQxOMYr7oUQE6wS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-sdQmg3wEOL6Jb8J4IBC_aA-1; Mon, 05 Sep 2022 03:43:39 -0400
X-MC-Unique: sdQmg3wEOL6Jb8J4IBC_aA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20EA9811E80
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 07:43:39 +0000 (UTC)
Received: from ovpn-12-203.pek2.redhat.com (ovpn-12-203.pek2.redhat.com
 [10.72.12.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 447E9C15BB3;
 Mon,  5 Sep 2022 07:43:36 +0000 (UTC)
From: Xiao Liang <xiliang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  5 Sep 2022 15:43:30 +0800
Message-Id: <20220905074330.24989-1-xiliang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] zram03: unload zram when it is loaded during test
 run
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
Cc: xiliang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 testcases/kernel/device-drivers/zram/zram03.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index b9867a573..98eb61e1c 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -187,16 +187,15 @@ static void setup(void)
 
 	 /* zram module was built in or being used on old kernel */
 	SAFE_CMD(cmd_modprobe, NULL, NULL);
-	if (access(ZRAM_CONTROL_PATH, F_OK)) {
-		file = SAFE_FOPEN("/proc/modules", "r");
-		while (fgets(line, sizeof(line), file)) {
-			if (strstr(line, "zram")) {
-				modprobe = 1;
-				break;
-			}
+	file = SAFE_FOPEN("/proc/modules", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "zram")) {
+			modprobe = 1;
+			break;
 		}
-		SAFE_FCLOSE(file);
-
+	}
+	SAFE_FCLOSE(file);
+	if (access(ZRAM_CONTROL_PATH, F_OK)) {
 		if (modprobe) {
 			tst_res(TINFO,
 				"rmmod zram before test on old kernel without zram-control interface");
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
