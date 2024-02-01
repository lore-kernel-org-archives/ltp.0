Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF185C4828D
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 15:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68CA23CF629
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 16:31:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0A843CE090
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 16:31:30 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC7A3200047
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 16:31:29 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3CAC2213A;
 Thu,  1 Feb 2024 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706801489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cb073mf5de6gqN2NwlQvGZx3cehoSaPnxT2C71mINWY=;
 b=dA4/zKhAfC5Ca+Z7/mhqwwnczmUHrvk4gBjnhZbAFAmo05MzNmD1CbefKtBsBlqBMBjaym
 YOYTdQ4NvSEK45/cwL72hJ/6UsuHRnojH85I6sjiFa4lFHDd/u6Oh/gOsfDlD7k1iWKz6L
 OA3n3nmYLgNhS7nLMIkod6cR0xKF+/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706801489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cb073mf5de6gqN2NwlQvGZx3cehoSaPnxT2C71mINWY=;
 b=9ze3nCpd24GQ64ehbLrpFh9sIsGzt04Jg6yb99PmML52e0CNZ+Ymg4etcxdhRSDnvpw3gi
 G2iupn/YvM8mDHAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706801489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cb073mf5de6gqN2NwlQvGZx3cehoSaPnxT2C71mINWY=;
 b=dA4/zKhAfC5Ca+Z7/mhqwwnczmUHrvk4gBjnhZbAFAmo05MzNmD1CbefKtBsBlqBMBjaym
 YOYTdQ4NvSEK45/cwL72hJ/6UsuHRnojH85I6sjiFa4lFHDd/u6Oh/gOsfDlD7k1iWKz6L
 OA3n3nmYLgNhS7nLMIkod6cR0xKF+/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706801489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cb073mf5de6gqN2NwlQvGZx3cehoSaPnxT2C71mINWY=;
 b=9ze3nCpd24GQ64ehbLrpFh9sIsGzt04Jg6yb99PmML52e0CNZ+Ymg4etcxdhRSDnvpw3gi
 G2iupn/YvM8mDHAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8836013594;
 Thu,  1 Feb 2024 15:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 0Up/H1C5u2VkMAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 01 Feb 2024 15:31:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  1 Feb 2024 16:31:25 +0100
Message-ID: <20240201153125.113659-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[47.29%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] github: Add issue template
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
Changes v1->v2:
* Added info what to report (suggested by Cyril [1]):
+You should report there: kernel, libc, distribution and LTP version.
+Also relevant logs (dmesg, test output).

=> feel free to correct my wording

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YwY5eWJesAkKNQ2M@yuki/

 .github/issue_template.md | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 .github/issue_template.md

diff --git a/.github/issue_template.md b/.github/issue_template.md
new file mode 100644
index 000000000..aa87fb1f8
--- /dev/null
+++ b/.github/issue_template.md
@@ -0,0 +1,7 @@
+Issues are *not* support forum.
+
+Bugs in the distro/kernel should be reported to your Linux distribution.
+You should report there: kernel, libc, distribution and LTP version.
+Also relevant logs (dmesg, test output).
+
+Issues are *only* for reporting bugs in tests.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
