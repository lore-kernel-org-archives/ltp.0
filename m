Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B991FC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:09:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5776113B
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB5776113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F65C3CA4A0
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 19:09:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C6193C9256
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 19:09:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6363200751
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 19:09:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4BA9822135;
 Tue, 14 Sep 2021 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631639343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=km9GwAC0/7wQxJ5Knt6D/VmMhAFMLJzglfb/kQRhXt8=;
 b=deqo1WAIDHNvzDY4fp6JhHqFPh1diWPryWmwYN34lPiq9VAXHUKspdudbwTMrl7bfW53wU
 d2lO7L4YAxzmrkAbWb/R47rvGofatfZ9fhYB4yqT2PoWT2z/ZcoT5OVjfrjlKrUdEj24xI
 0qhtMnApAbAegze8QD5Ftmq3MAyj/4g=
Received: from localhost.suse.de (blezhepekov.udp.ovpn2.nue.suse.de
 [10.163.45.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1885FA3B9C;
 Tue, 14 Sep 2021 17:09:03 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 20:08:50 +0300
Message-ID: <20210914170851.22931-5-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 5/6] rt:pi-tests:testpi-5: return exit code
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
Message-ID: <20210914170850.Zfhafg_TMW2368HTVU8yFYuarsEFj36B-yawpykgq2k@z>

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/testpi-5.c | 24 ++++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index a52486417..538be1e44 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -68,29 +68,37 @@ int do_test(int argc, char **argv)
 {
 	pthread_mutexattr_t mutexattr;
 	int retc, protocol;
+	unsigned int err = 0;
 
 #if HAS_PRIORITY_INHERIT
 
-	if (pthread_mutexattr_init(&mutexattr) != 0)
+	if (pthread_mutexattr_init(&mutexattr) != 0) {
 		printf("Failed to init mutexattr\n");
+		err++;
+	}
 
 	if (pthread_mutexattr_setprotocol(&mutexattr,
-					  PTHREAD_PRIO_INHERIT) != 0)
+					  PTHREAD_PRIO_INHERIT) != 0) {
 		printf("Can't set protocol prio inherit\n");
-
-	if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
+		err++;
+	}
+		
+	if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0) {
 		printf("Can't get mutexattr protocol\n");
-	else
+		err++;
+	} else 
 		printf("protocol in mutexattr is %d\n", protocol);
-
+		
 	retc = pthread_mutex_init(&child_mutex, &mutexattr);
-	if (retc != 0)
+	if (retc != 0) {
 		printf("Failed to init mutex: %d\n", retc);
+		err++;
+	}
 
 	create_other_thread(child_thread, NULL);
 	join_threads();
 
-	return 0;
+	return err > 0 ? 1: 0;
 #else
 	return 1;
 #endif
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
