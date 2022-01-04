Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95614C4167D
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 08:26:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27B0C3C90E8
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 09:20:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B846E3C9013
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4EEC8100035C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F007E1F3A0;
 Tue,  4 Jan 2022 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641284325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaOLdDF2S9D4LFu71zCrs5mMDHdKumz8RI8jREGVC6M=;
 b=YBHj5ZLQFV3fpEb+c/YQwLX1+Tdpm3PxanGXQluUHzIrmrsGPIsBqtZnbVrYm07UWaL759
 N+OoLXxuyuTFmuBKnzFBCIRc9JUCNqq8dqHI0/KOWpet5WfszqOCxQBgqyEp/JCsF9GDyP
 OlurOB4B+1/iW+UViUyUNZxdDSOo/hY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FFAF13AB9;
 Tue,  4 Jan 2022 08:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eKJdI+UC1GGeZwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 04 Jan 2022 08:18:45 +0000
To: ltp@lists.linux.it
Date: Tue,  4 Jan 2022 09:18:36 +0100
Message-Id: <20220104081836.22827-11-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104081836.22827-1-andrea.cervesato@suse.com>
References: <20220104081836.22827-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 10/10] Define watchqueue testing suite in runtest
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/watchqueue      | 8 ++++++++
 scenario_groups/default | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 runtest/watchqueue

diff --git a/runtest/watchqueue b/runtest/watchqueue
new file mode 100644
index 000000000..badf7afb0
--- /dev/null
+++ b/runtest/watchqueue
@@ -0,0 +1,8 @@
+wqueue01 wqueue01
+wqueue02 wqueue02
+wqueue03 wqueue03
+wqueue04 wqueue04
+wqueue05 wqueue05
+wqueue06 wqueue06
+wqueue07 wqueue07
+wqueue08 wqueue08
diff --git a/scenario_groups/default b/scenario_groups/default
index 1dc2987d5..68bd5300d 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -30,3 +30,4 @@ cve
 crypto
 kernel_misc
 uevent
+watchqueue
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
