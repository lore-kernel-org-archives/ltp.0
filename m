Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E70C35274
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 13:06:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DDCA3CD847
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 14:06:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DC623CB2AC
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 14:06:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 896B8208D54
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 14:06:19 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F102B1F832;
 Fri, 15 Dec 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702645578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GbZtzlE+Pf5WcdYVSPHzKLy7JuYsSdeMrSiVut8mKD0=;
 b=jLI+iPJUM9fwOJrxj6utZyRYqXZiw2WavpN8aooQ3tHYLDj+GPt+kWuORn/XxIxbKtSd50
 P3aNZ6nPsl2oGMgzA9mDYNovceuLPtG3XXNS8IXc+JHZeXtfP6KQcCfC7xxvmeT9hjilfp
 vlqUlY5EQ2WzpMUZ7T3DIaZ2Y9FLtTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702645578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GbZtzlE+Pf5WcdYVSPHzKLy7JuYsSdeMrSiVut8mKD0=;
 b=e1YInG4wsEKX12pVYwE+Aq1196QULuLQ33/Sj7Svh4EfnywiLuDQ/JAJ+ou7i4cU+F6jsC
 cYxbkGADu0wpFtAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702645576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GbZtzlE+Pf5WcdYVSPHzKLy7JuYsSdeMrSiVut8mKD0=;
 b=MQ4Vse5fzlVl772hThADFdtv2evhxYqAcpNzqTaVyPhjUfTRLiIW83FaqgUGaUAuABnNu/
 pivEmJJWlNQ3T6Zd7oG7W3dKORPBB2FJA92EMyQT1+fTJ7DG8El3R3b5s6eqhCFgUWYIB/
 uWuBi6QYzc4334qVluyXgcnU/LzXoT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702645576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GbZtzlE+Pf5WcdYVSPHzKLy7JuYsSdeMrSiVut8mKD0=;
 b=0+Qsrh1GTaduOA805KJxH63+nD/oFVHYdEV52ZQaQV9RiBo+znVdSCOB0BXb0N4ayubWo8
 H6uehFNLPcmqGRAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F0E213912;
 Fri, 15 Dec 2023 13:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id dYvpI0hPfGVeUgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 13:06:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Dec 2023 14:06:09 +0100
Message-ID: <20231215130609.14122-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[40.21%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] runtest: Merge runtest/connectors to kernel_misc
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

cn_pec.sh was the only item for runtest/connectors.
Some frameworks (e.g. openQA) start new VM for each runtest,
which is waste of time for only single VM.

cn_pec.sh is a netlink connector test, but there is no generic network
runtest, thus move it to runtest/kernel_misc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/connectors  | 2 --
 runtest/kernel_misc | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)
 delete mode 100644 runtest/connectors

diff --git a/runtest/connectors b/runtest/connectors
deleted file mode 100644
index 2c7aed474..000000000
--- a/runtest/connectors
+++ /dev/null
@@ -1,2 +0,0 @@
-#DESCRIPTION:Netlink Connector tests
-cn_pec_sh cn_pec.sh
diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index abb75ebaf..02b0ddd1a 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -1,3 +1,4 @@
+cn_pec_sh cn_pec.sh
 kmsg01 kmsg01
 fw_load fw_load
 rtc01 rtc01
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
