Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520ADC46467
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 17:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A7E13CDEB0
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 18:51:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82E3C3CCEA0
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D88A600543
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7070633E34;
 Tue,  3 Jan 2023 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672768265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B244FQsduYbgftdpSSPBul7VCMGrKu4L2QxoeVWBHPg=;
 b=Az2HHf1VZSLDam82xJLsKqfHh054fSiRXfuW6azdm0N1Rr8uABwW2S21GmkkEABCIMpIbJ
 oVsNiOhiGS4Lr3CZjW018xvPDyB8V5dRWHo63W5TAs9x/dgv8dIS36/BpUTi6XcydQLlK8
 sNSFQavGrMARGeYRuB/ctD0VdDWY4dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672768265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B244FQsduYbgftdpSSPBul7VCMGrKu4L2QxoeVWBHPg=;
 b=NnIpGOYKCXrWuta69pe0FF9oY2Tf4UkhjZEW9JJ3P4HIHZq0EX1q00LBAsCs4in38HHEvK
 YgG+07Xj3bKU+ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D914B1390C;
 Tue,  3 Jan 2023 17:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AHQsLQhrtGOHNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 17:51:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jan 2023 18:50:57 +0100
Message-Id: <20230103175059.16328-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103175059.16328-1-pvorel@suse.cz>
References: <20230103175059.16328-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] doc/c-test-api.txt: Update tst_kvercmp{2, }() use
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index bc2d479452..a3ee9cab47 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -584,8 +584,21 @@ positive means that it's newer.
 
 The second function 'tst_kvercmp2()' allows for specifying per-vendor table of
 kernel versions as vendors typically backport fixes to their kernels and the
-test may be relevant even if the kernel version does not suggests so. See
-'testcases/kernel/syscalls/inotify/inotify04.c' for example usage.
+test may be relevant even if the kernel version does not suggests so.
+
+[source,c]
+-------------------------------------------------------------------------------
+if (tst_kvercmp(5, 19, 0) >= 0)
+	tst_res(TCONF, "Test valid only for kernel < 5.19");
+
+static struct tst_kern_exv kvers[] = {
+	{ "UBUNTU", "4.4.0-48.69" },
+	{ NULL, NULL},
+};
+
+if (tst_kvercmp2(4, 4, 27, kvers) < 0)
+	/* code for kernel < v4.4.27 or ubuntu kernel < 4.4.0-48.69 */
+-------------------------------------------------------------------------------
 
 WARNING: The shell 'tst_kvercmp' maps the result into unsigned integer - the
          process exit value.
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
