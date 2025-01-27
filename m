Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC15C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:10:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB9313C2C45
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:09:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD43A3C2C41
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52084644A1F
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8AFE121114
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBF3M4oZm9XQLylZpMWEzxxzzP2o7OfnoDeFCtClGls=;
 b=yDkRRmcON+u+ZLD0SzmWLzrEGheOB0+Ad3zubV6aVPzIBIioCcCuOn45XPd6H4Jb8x3y/U
 a6TcRH7cynrukJ6VWQ+TnMiTogCNgyLLxfB4HmizaVQ700VlMHl/uMc1HIxLG81+1te0Ma
 VuE1Q62AQy8oKtYdFzjXwMrwczoXrLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBF3M4oZm9XQLylZpMWEzxxzzP2o7OfnoDeFCtClGls=;
 b=uVUpIO7PGiw3yG0SN2Bff9lpd37ZrlHpExZOtzDZJzBX18xwL1fK5OeLiOCCRi/d12Tkg/
 pykFITV/gJXAz4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBF3M4oZm9XQLylZpMWEzxxzzP2o7OfnoDeFCtClGls=;
 b=n+WoJ5Zlnx9oi0ICdeL2Pdz4BZBTNcqKOgCp3aQjHaShq81FKSROZJx2gOwbKSxOtioBqj
 hKMuqOBRtIDMOOcLjHf8abXxIt1rTBjEWZUxNepifBP0cv0g2eX+wqFR/FBmyCiPH3BtEd
 osaCews/maEqBMai9Wv6TgpdWmgVUB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBF3M4oZm9XQLylZpMWEzxxzzP2o7OfnoDeFCtClGls=;
 b=B+FsJmF0/lYujJVvEs0bcPVcbzImk95J4BcDQ91CYGTp1Fc68sXnf9MgfDOmeCoyw1dhEw
 bTR2mE0CmWbdniCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 690B613876
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qMjHF1uTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:20 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-2-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=1315;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=aaiEyZ4BS5KChdbkgkvi0PhZwvuj6VT0GKBGh0RnQUw=;
 b=joO4dx9+fozL3lUeu0ZuKGwj20x1VkJuXpY+cvEYro6ru9yg3RSc3X0TNa/RS2QncgP+tLIS+
 CbM8dw4ycKbCtGW3uQfuqDdGHh2HNktn0U9Lk1+xN0a284RInNalvL+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/8] lapi: add struct xattr_args fallback
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  1 +
 include/lapi/xattr.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/configure.ac b/configure.ac
index 6992d75ca300ccc4cc21a45a916f6b3be1a3b8fe..eb1a966322313cf785c25af0f317700418186927 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,6 +247,7 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
+AC_CHECK_TYPES([struct xattr_args],,,[#include <linux/xattr.h>])
 
 # Tools knobs
 
diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
new file mode 100644
index 0000000000000000000000000000000000000000..b30b24ac0dce04ee225a7609e92fb7af8b545283
--- /dev/null
+++ b/include/lapi/xattr.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Linux Test Project
+ */
+
+#ifndef LAPI_XATTR_H__
+#define LAPI_XATTR_H__
+
+#include <stdint.h>
+
+#ifndef STRUCT_XATTR_ARGS
+struct xattr_args {
+	void *value;
+	uint32_t size;
+	uint32_t flags;
+};
+#endif
+
+#endif /* LAPI_XATTR_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
