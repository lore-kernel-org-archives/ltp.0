Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE728C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809E460E97
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 809E460E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642513C9278
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 17:31:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8611C3C1DD3
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 17:31:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7EABF600B08
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 17:31:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A433220001;
 Mon, 13 Sep 2021 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631547084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qu+vyq/VNWR57GuO4JaPJ6tDSZl8XLh/bs/yn2WDhdg=;
 b=eAgYrHWG3NUK27onwTax/fhu1M8v3VjKg3kaha1ROQ28iI+2axm37fJ7Jwzz5igSA07ccT
 rKRkPsQH+Cx3Pn8F8s3AkqCwXS6XAmsXBnCrL0U8cAYmgraJxVwpG3y8aAtNbrvI2BJz5a
 /r/rlsVIFm4/ujz7ajve/UnYeglbc7Q=
Received: from blezhepekov.udp.ovpn1.nue.suse.de (unknown [10.163.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6FAD6A3B92;
 Mon, 13 Sep 2021 15:31:24 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 18:31:18 +0300
Message-ID: <20210913153118.25002-1-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] realtime:matrix_multi: main function to return
 exit status
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913153118.XkyfOemZYoMswAlSg1INLBaza60goxpVNnqe79c9vRk@z>

The original version always returned 0.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/matrix_mult/matrix_mult.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
index 61ab887fc..e702c0ff9 100644
--- a/testcases/realtime/func/matrix_mult/matrix_mult.c
+++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
@@ -188,7 +188,7 @@ void *concurrent_thread(void *thread)
 	return NULL;
 }
 
-void main_thread(void)
+int main_thread(void)
 {
 	int ret, i, j;
 	nsec_t start, end;
@@ -308,7 +308,7 @@ void main_thread(void)
 	     criteria);
 	printf("Result: %s\n", ret ? "FAIL" : "PASS");
 
-	return;
+	return ret;
 }
 
 int main(int argc, char *argv[])
@@ -319,7 +319,7 @@ int main(int argc, char *argv[])
 	numcpus = sysconf(_SC_NPROCESSORS_ONLN);
 	/* the minimum avg concurrent multiplier to pass */
 	criteria = pass_criteria * numcpus;
-	int new_iterations;
+	int new_iterations, ret;
 
 	if (iterations <= 0) {
 		fprintf(stderr, "iterations must be greater than zero\n");
@@ -348,7 +348,7 @@ int main(int argc, char *argv[])
 	printf("Number of CPUs: %u\n", numcpus);
 
 	set_priority(PRIO);
-	main_thread();
+	ret = main_thread();
 
-	return 0;
+	return ret;
 }
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
