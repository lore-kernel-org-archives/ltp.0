Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B39C54E58
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 11:51:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 729013CFEC9
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 12:51:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57E473CFECF
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:43 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B17C600CE9
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 248105C61C;
 Mon, 25 Mar 2024 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711367442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIVP2IpKuRWgIHFrZNfwxga2Frmb3bcT73WhcNtAz9o=;
 b=X52p75ppKzt0n9Mn3EiIu57yAffg2uOxCM5e4vYFVDDi7JEqKV/LrpgEmweV9TR0PxqetN
 5awv8rRv39CCznaEWKOxdpWoMDfwg63fML8hHHhWHG5E+sh2xbibbworPWy5vhEavP+RKh
 2mcXoCA+VZk5PUgCV53UL85EUDmNBpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711367442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIVP2IpKuRWgIHFrZNfwxga2Frmb3bcT73WhcNtAz9o=;
 b=Sp5wj9PHRQN+/Qri8tZH6oS0c+BzeGnwL/cxndtCx4uuAB8CFccvaeMSZDG8xb4J2mfA9V
 Xm8bA8BhtM39aVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711367441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIVP2IpKuRWgIHFrZNfwxga2Frmb3bcT73WhcNtAz9o=;
 b=PB7jURGrHYK3YrtIg0VK/ASOsucQPzCCnOfed+diun+hPRJsBt1IoqpVQOIC9ytG5mO6Kp
 jJ3Bp8UqdPr56wCI56GDYyEQ5veFcw2XON8ph64mTREUe6/v82sq6szauDWRYzuQf9Ou5G
 sYa+u8sdx8eco2GmjKt3shenpZWgxh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711367441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIVP2IpKuRWgIHFrZNfwxga2Frmb3bcT73WhcNtAz9o=;
 b=c0FyARmVsM1E8QMxpYlbCnygmio1uc4IYJwlMrj6GwD0OXvyNkyXyBuW9EW/S1Yk5iQvlH
 1kJ2zdr/7v8uwhCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C9A013ABC;
 Mon, 25 Mar 2024 11:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6LDsARFlAWZSCQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 25 Mar 2024 11:50:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Mar 2024 12:50:34 +0100
Message-ID: <20240325115034.643892-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325115034.643892-1-pvorel@suse.cz>
References: <20240325115034.643892-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SUBJECT_HAS_CURRENCY(1.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] lib: Improve doc related to $TMPDIR default
 value
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

Link C and shell API related parts to $TMPDIR.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_defaults.h    | 3 ++-
 testcases/lib/tst_test.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/tst_defaults.h b/include/tst_defaults.h
index 083427b7e..abe1e6956 100644
--- a/include/tst_defaults.h
+++ b/include/tst_defaults.h
@@ -8,8 +8,9 @@
 
 /*
  * This is the default temporary directory used by tst_tmpdir().
+ * used when TMPDIR env variable is not set.
  *
- * This is used when TMPDIR env variable is not set.
+ * If changed, update also shell API in testcases/lib/tst_test.sh.
  */
 #define TEMPDIR	"/tmp"
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 0d2fccb95..b595bb5ea 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -734,6 +734,8 @@ tst_run()
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
+			# Default value if TMPDIR not set.
+			# If changed, update also C API in tst_defaults.h.
 			export TMPDIR="/tmp"
 		fi
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
