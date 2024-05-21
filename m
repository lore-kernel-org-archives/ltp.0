Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DFFC25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 07:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CC113C0313
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 09:51:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5491F3CFF60
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F9A01A00984
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B647A345B6;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716277801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCrlhbiuPPL3XCdDDhMwn8D4n01XFj7bq2qybMIihw0=;
 b=ovgi2XVhGrWii/9xYEPKBlwYYz7k4fMmi7u3vjds0P8+JHjNEylFQihHuHmhXcjdR9RGTA
 IOdcG2DMBQUMLVb/rYCdydcaEdKjItpEuaQd2S5ZdUfw2ucJYoEAKBOt/kZacNYZ9aOGi7
 mhop+E/mEwQg/tVdke8gP7nxOW1e7kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716277801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCrlhbiuPPL3XCdDDhMwn8D4n01XFj7bq2qybMIihw0=;
 b=J/s9ialX8Digv8MZCn8ASmiq3pEb6gNnnOUTOvnYWigI4/UAQUtOjQAsLVZO9qfE9oMDqf
 6RQ/B8OzkU5mh5Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716277800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCrlhbiuPPL3XCdDDhMwn8D4n01XFj7bq2qybMIihw0=;
 b=Jb9JmI2gDPTIzjM1KlMa4tp8NgFARSEAZwNS9dKw9CYom/gOWfoFhvYEM031Z1Y6F6Mp0+
 v3YZ9P/GqkPBjEHbkeL16d+sc3mLDzSqRFK67iuYM1h7/Ups4aeBTegXGv+5XIm5vN6vL8
 HSe5lvbzDcscuE2Lusj9E8jNVe11Zqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716277800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCrlhbiuPPL3XCdDDhMwn8D4n01XFj7bq2qybMIihw0=;
 b=eAlOMrphfcM6sJEcvbXMsXEwbexhZ8w0yOTSKWLmM5MG3GdNW0wVgBRiI3DJ2Vt5pmJO8G
 ZAnMfesHRzboSwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83BB513A21;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFPvHihSTGYMFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 07:50:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 09:49:54 +0200
Message-ID: <20240521074955.78675-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521074955.78675-1-pvorel@suse.cz>
References: <20240521074955.78675-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] libswap: Fix tst_max_swapfiles() for SLE12-SP5
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

SLE12-SP4 backported kernel commit 5042db43cc26. It's now EOL, but
SLE12-SP5 is still supported, this fixes swapon03 on it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Don't swap 5.19 and 6.2 conditions (Cyril)
* Separate whitelist changes to "libswap: Split long lines
  (readability)"

 libs/libltpswap/libswap.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 0066ca734..e587f315e 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2014-2024
  * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
  */
 
@@ -251,19 +252,25 @@ int tst_max_swapfiles(void)
 	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
 	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
 	struct tst_kconfig_var marker = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
-	struct tst_kern_exv kvers[] = {
+	struct tst_kern_exv kvers_marker_migration[] = {
 		/* RHEL9 kernel has patch 6c287605f and 679d10331 since 5.14.0-179 */
 		{ "RHEL9", "5.14.0-179" },
 		{ NULL, NULL},
 	};
 
+	struct tst_kern_exv kvers_device[] = {
+		/* SLES12-SP4 has patch 5042db43cc26 since 4.12.14-5.5 */
+		{ "SLES", "4.12.14-5.5" },
+		{ NULL, NULL},
+	};
+
 	tst_kconfig_read(&migration, 1);
 	tst_kconfig_read(&memory, 1);
 	tst_kconfig_read(&device, 1);
 	tst_kconfig_read(&marker, 1);
 
 	if (migration.choice == 'y') {
-		if (tst_kvercmp2(5, 19, 0, kvers) < 0)
+		if (tst_kvercmp2(5, 19, 0, kvers_marker_migration) < 0)
 			swp_migration_num = 2;
 		else
 			swp_migration_num = 3;
@@ -273,14 +280,15 @@ int tst_max_swapfiles(void)
 		swp_hwpoison_num = 1;
 
 	if (device.choice == 'y') {
-		if (tst_kvercmp(4, 14, 0) >= 0)
+		if (tst_kvercmp2(4, 14, 0, kvers_device) >= 0)
 			swp_device_num = 2;
 		if (tst_kvercmp(5, 14, 0) >= 0)
 			swp_device_num = 4;
 	}
 
-	if ((marker.choice == 'y' && tst_kvercmp2(5, 19, 0, kvers) >= 0) ||
-		tst_kvercmp(6, 2, 0) >= 0) {
+	if ((marker.choice == 'y' &&
+	     tst_kvercmp2(5, 19, 0, kvers_marker_migration) >= 0)
+	    || tst_kvercmp(6, 2, 0) >= 0) {
 		swp_pte_marker_num = 1;
 	}
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
