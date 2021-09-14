Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F184DC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:09:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD6C61130
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 17:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBD6C61130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A59373CA4AF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 19:09:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0EAD3CA4D3
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 19:09:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA2D420090C
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 19:09:00 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D18741FD29;
 Tue, 14 Sep 2021 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631639339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yLEALOHM06a3MjZpWW9miIG8BaBc2UHxP8J265juOM=;
 b=D1vS5i4ApOLcvXrJUDlchqPfMrXWwkWyN1IheK+BPKwHhDvNjt1CJAw1tDuG21fbUkaTnD
 CvYCHQbB2mmgBaiwX9o8ul3v7b2cf/Ce65Up71jm92xk26E5I0EGJKp+Na+1i39tODKXe3
 w2ERjkiEbZg4aYv+lQ/vd+tovvxnj/k=
Received: from localhost.suse.de (blezhepekov.udp.ovpn2.nue.suse.de
 [10.163.45.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9D697A3B91;
 Tue, 14 Sep 2021 17:08:59 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 20:08:47 +0300
Message-ID: <20210914170851.22931-2-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/6] rt:pi-tests::sbrk_mutex: return actual exit
 code
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
Message-ID: <20210914170847.n6rtQQ3g5l3ViFW3tq1XcBfWiEcxEWBeeIbrA0QNf3c@z>

The original version always returned 0.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/sbrk_mutex.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/sbrk_mutex.c b/testcases/realtime/func/pi-tests/sbrk_mutex.c
index 7ed7969d9..34e4e9666 100644
--- a/testcases/realtime/func/pi-tests/sbrk_mutex.c
+++ b/testcases/realtime/func/pi-tests/sbrk_mutex.c
@@ -97,7 +97,8 @@ void *worker_thread(void *arg)
 
 int main(int argc, char *argv[])
 {
-	int m, ret, robust;
+	int m, robust;
+	int ret = 0;
 	intptr_t t;
 	pthread_mutexattr_t mutexattr;
 	setup();
@@ -123,7 +124,8 @@ int main(int argc, char *argv[])
 		if (!(mutexes[m] = malloc(sizeof(pthread_mutex_t)))) {
 			perror("malloc failed\n");
 		}
-		if ((ret = pthread_mutex_init(mutexes[m], &mutexattr))) {
+		if (pthread_mutex_init(mutexes[m], &mutexattr)) {
+			ret = 1;
 			perror("pthread_mutex_init() failed\n");
 		}
 	}
@@ -140,11 +142,13 @@ int main(int argc, char *argv[])
 	/* destroy all the mutexes */
 	for (m = 0; m < NUM_MUTEXES; m++) {
 		if (mutexes[m]) {
-			if ((ret = pthread_mutex_destroy(mutexes[m])))
+			if (pthread_mutex_destroy(mutexes[m])) {
+				ret = 1;
 				perror("pthread_mutex_destroy() failed\n");
+			}
 			free(mutexes[m]);
 		}
 	}
 
-	return 0;
+	return ret;
 }
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
