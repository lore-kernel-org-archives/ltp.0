Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E82C02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 11:29:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FB193C7A40
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:29:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1612A3C1BCE
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:29:24 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 664931BDC8C2
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:29:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE6322116A;
 Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736854164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+WXyKE2K3p5EG+WHjfaMCB+mhIvRAATFDUklAB18hQ=;
 b=qfSIUHazWkYs8e2IUgCNOvGIjhtNQ62CqNoIEE9FfVddsG8ZGHltt6BfFt4D4i6D3U9ja3
 HpThJQZ9WwcMP651fp3PqU6bq37QZklB4pLf/atBWc8EkhjJOP0mpEqnGRLWsvkJhU8HsG
 jWeIGmwBfYR+5WV15xpFuUwlbY0o9O0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736854164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+WXyKE2K3p5EG+WHjfaMCB+mhIvRAATFDUklAB18hQ=;
 b=D5/6G9fC0mT9GorqmxEtjTR6qseKxX0y+CzC/nQuJUWPSwZQxFACGRhDCXj45rqxKfomQJ
 wY035S05Z2P35+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736854163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+WXyKE2K3p5EG+WHjfaMCB+mhIvRAATFDUklAB18hQ=;
 b=rZ2g2InxisYGDWjiI1XQfs38/2QzNYRa4Ps2MLqa3K7FREk4fGJxQigyKidbu2wsZHpykJ
 sck1nM2HfEaUZoTQpwTpj9ia2me/jGicwR+SorZSj1Klq7JdheAzVFeeuVquCTvIonRhGD
 sLJZy1nWb0doh/acPQNxBJ3NTbaLWdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736854163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+WXyKE2K3p5EG+WHjfaMCB+mhIvRAATFDUklAB18hQ=;
 b=P8ESsQFmtroA7bKRS/qCzhBea2G/8Wd9385iVV4uMSeb7oTvFszzZDfB419wUXUUz6ilfU
 mA1FXDlCM3UnAQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A48D3139CB;
 Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2NNVJpNKhmeMIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 12:29:07 +0100
Message-ID: <20250114112915.610297-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/10] IMA: Add TCB policy as an example for
 ima_measurements.sh
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Taken from IMA docs [1], removed dont_measure fsmagic=0x1021994 (tmpfs)
as suggested by Mimi.

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/datafiles/Makefile |  4 ++--
 .../ima/datafiles/ima_measurements/Makefile   | 11 ++++++++++
 .../ima/datafiles/ima_measurements/tcb.policy | 20 +++++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy

diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 200fd3f4d3..0f2b4fdb11 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2019-2020
+# Copyright (c) Linux Test Project, 2019-2025
 # Copyright (c) 2020 Microsoft Corporation
 # Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
@@ -8,6 +8,6 @@ top_srcdir	?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS	:= ima_kexec ima_keys ima_policy ima_selinux
+SUBDIRS	:= ima_kexec ima_keys ima_measurements ima_policy ima_selinux
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Makefile
new file mode 100644
index 0000000000..6317f2bf85
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2025
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_measurements
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
new file mode 100644
index 0000000000..1e4a932bf0
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
@@ -0,0 +1,20 @@
+dont_measure fsmagic=0x9fa0
+dont_measure fsmagic=0x62656572
+dont_measure fsmagic=0x64626720
+dont_measure fsmagic=0x1021994 func=FILE_CHECK
+dont_measure fsmagic=0x1cd1
+dont_measure fsmagic=0x42494e4d
+dont_measure fsmagic=0x73636673
+dont_measure fsmagic=0xf97cff8c
+dont_measure fsmagic=0x43415d53
+dont_measure fsmagic=0x27e0eb
+dont_measure fsmagic=0x63677270
+dont_measure fsmagic=0x6e736673
+dont_measure fsmagic=0xde5e81e4
+measure func=MMAP_CHECK mask=MAY_EXEC
+measure func=BPRM_CHECK mask=MAY_EXEC
+measure func=FILE_CHECK mask=^MAY_READ euid=0
+measure func=FILE_CHECK mask=^MAY_READ uid=0
+measure func=MODULE_CHECK
+measure func=FIRMWARE_CHECK
+measure func=POLICY_CHECK
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
