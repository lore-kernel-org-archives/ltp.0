Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C2EB64DC
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 18:31:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60CB73CD7FB
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 20:31:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E70923C99AD
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 20:31:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2F00200938
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 20:31:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 914E8218B1;
 Tue, 27 Jun 2023 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687890678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VbeQYjjgvM6DtnWX8l1zSLC88h+ZTFFqYF61X3PNR6M=;
 b=FpEnk0AP1XxGS74mdaRg0dcXCvaTJBduNBlq+pIruS5Yak33GLBb1kxdFAC7TO622s9cdb
 opFNr1puoSzG5FujrX4T+yMggVND9RtMAfN5lJnoidV+lUEzV20E9/cN2AcZA2tYHEeovW
 sizSYPoIQr+A+o7rtAq/q+awu4iXNKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687890678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VbeQYjjgvM6DtnWX8l1zSLC88h+ZTFFqYF61X3PNR6M=;
 b=XGVgaEUVvssGrIjgSI0B/0BEMCivlw8g+DCMi9Furm4aZcZnBPBie0FEkhacbf/DkOkqWP
 QMIWQvbqJqB+dkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5489413462;
 Tue, 27 Jun 2023 18:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ApSxD/Yqm2TUAwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 18:31:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 27 Jun 2023 20:31:14 +0200
Message-Id: <20230627183114.89536-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc/C-API: Move .min_mem_avail below .min_cpus
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

From: Petr Vorel <petr.vorel@gmail.com>

Required minimum of CPU and RAM are related topics,
it's better to have together.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index dcb6e1ba8..9106758d7 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2328,7 +2328,13 @@ both V1 and V2 feasible.
 Some tests require more than specific number of CPU. It can be defined with
 `.min_cpus = N`.
 
-1.38 Test tags
+1.38 Require minimum size of MemAvailable for a testcase
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some tests require more than specific size(MB) of MemAvailable. It can be defined
+with `.min_mem_avail = N`.
+
+1.39 Test tags
 ~~~~~~~~~~~~~~
 
 Test tags are name-value pairs that can hold any test metadata.
@@ -2370,7 +2376,7 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
-1.39 Testing on the specific architecture
+1.40 Testing on the specific architecture
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Testcases for specific arch should be limited on that only being supported
 platform to run, we now involve a .supported_archs to achieve this feature
@@ -2406,12 +2412,6 @@ static struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
-1.40 Require minimum size of MemAvailable for a testcase
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Some tests require more than specific size(MB) of MemAvailable. It can be defined
-with `.min_mem_avail = N`.
-
 2. Common problems
 ------------------
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
