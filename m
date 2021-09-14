Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78604C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:10:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078D161130
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 078D161130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1EC53C9264
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 19:09:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 181DA3CA4D3
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 19:09:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9BAB1200751
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 19:09:04 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4890F22137;
 Tue, 14 Sep 2021 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631639344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bypL7Q+CYNEzUVkj+The4FxAjTD2JfsxzJlWxS0sscA=;
 b=oO8iVTJ6LlWI8dN8tFvs3UwYrYlF/wPoXzHRe5lIPIiPLZiEV2pCWjFQP3E6RRnV73LXMO
 rErHBqaYk+3VicG+6T7OYmMHM+VpYUsm2udolmEh9jbZnubNco0lbbwK99MVaS8yY1pI8S
 idhNcxJAwhg5T9VqL4BgWHDPY4Y7Q7w=
Received: from localhost.suse.de (blezhepekov.udp.ovpn2.nue.suse.de
 [10.163.45.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 153D0A3B9C;
 Tue, 14 Sep 2021 17:09:04 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 20:08:51 +0300
Message-ID: <20210914170851.22931-6-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 6/6] rt:pi-tests:testpi-6: return exit code
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
Message-ID: <20210914170851.se9olWhjB2kOFYM23_Kwk1qL5vEyadx99HgjLnACncI@z>

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/testpi-6.c | 22 ++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-6.c b/testcases/realtime/func/pi-tests/testpi-6.c
index 637d38355..bc271f242 100644
--- a/testcases/realtime/func/pi-tests/testpi-6.c
+++ b/testcases/realtime/func/pi-tests/testpi-6.c
@@ -69,27 +69,35 @@ int do_test(int argc, char **argv)
 {
 	pthread_mutexattr_t mutexattr;
 	int retc, robust;
+	unsigned int err;
 
-	if (pthread_mutexattr_init(&mutexattr) != 0)
+	if (pthread_mutexattr_init(&mutexattr) != 0) {
 		printf("Failed to init mutexattr\n");
+		err++;
+	}
 
 	if (pthread_mutexattr_setrobust(&mutexattr,
-					   PTHREAD_MUTEX_ROBUST) != 0)
+					   PTHREAD_MUTEX_ROBUST) != 0) {
 		printf("Can't set robust mutex\n");
-
-	if (pthread_mutexattr_getrobust(&mutexattr, &robust) != 0)
+		err++;
+	}
+		
+	if (pthread_mutexattr_getrobust(&mutexattr, &robust) != 0) {
 		printf("Can't get mutexattr protocol\n");
-	else
+		err++;
+	} else 
 		printf("robust in mutexattr is %d\n", robust);
 
 	retc = pthread_mutex_init(&child_mutex, &mutexattr);
-	if (retc != 0)
+	if (retc != 0) {
 		printf("Failed to init mutex: %d\n", retc);
+		err++;
+	}
 
 	create_other_thread(child_thread, NULL);
 	join_threads();
 
-	return 0;
+	return err > 0 ? 1 : 0;
 }
 
 #include "test-skeleton.c"
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
