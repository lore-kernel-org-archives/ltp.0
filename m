Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC2C433FE
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:38:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1585860EFF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1585860EFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E08C3C927F
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 18:38:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C57D3C929E
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 18:37:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CFC761A0110D
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 18:37:52 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 67E7321FA7;
 Mon, 13 Sep 2021 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631551072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPUMtg2Lointp6mRSMf3FTSCY6iVWSKY0Anj9O0AaBM=;
 b=qZeEoSm+Ztey6Gd2ZXJ/34f3swcvuplfe7197Ndqsuj+Lqt9H59vdNjvVKHvNf9MIrsl3j
 Ydd6hjNrv6sfemMVW5Ai6Ik4k5vdZjAYacyG1NvlWRAmjDGC04AFn6fh8TIeiqPTC7+Xip
 U+IBUVIWBTSRuBDy149RPtRC+vjcGoI=
Received: from blezhepekov.udp.ovpn1.nue.suse.de (unknown [10.163.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 352BAA3B8E;
 Mon, 13 Sep 2021 16:37:52 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 19:37:45 +0300
Message-ID: <20210913163745.28108-3-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
References: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] realtime:profiles: support hrtimer-prio
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
Message-ID: <20210913163745.8gDJufUUXg6fsWJuwSxIgmki2i0XwQk8ukqC8UoG-6I@z>

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/profiles/default | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/realtime/profiles/default b/testcases/realtime/profiles/default
index b0bb6b890..440096fbe 100644
--- a/testcases/realtime/profiles/default
+++ b/testcases/realtime/profiles/default
@@ -46,11 +46,15 @@ func/matrix_mult		matrix_mult -c 0.75
 # Default maxduration=0.5 s
 func/thread_clock		tc-2 -c 0.5
 
+# Pass if maximum timer latency is less than criterium (us).
+# Default latency=10 us
+func/hrtimer-prio       hrtimer-prio
+
 # The below tests have no pass/fail criterium.
 func/gtod_latency		gtod_latency
 func/sched_jitter		sched_jitter
-func/periodic_cpu_load		periodic_cpu_load
-func/periodic_cpu_load		periodic_cpu_load_single
+func/periodic_cpu_load	periodic_cpu_load
+func/periodic_cpu_load	periodic_cpu_load_single
 func/prio-wake			prio-wake
 func/sched_football		sched_football
 func/pi-tests			testpi-0
@@ -60,4 +64,4 @@ func/pi-tests			testpi-4
 func/pi-tests			testpi-5
 func/pi-tests			testpi-6
 func/pi-tests			sbrk_mutex
-func/rt-migrate                 rt-migrate
+func/rt-migrate         rt-migrate
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
