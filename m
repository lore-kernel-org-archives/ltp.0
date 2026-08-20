Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7369C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD0F3CDBEC
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:45:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E48C3C0224
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 650CF1000989
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ABEB284F98;
 Thu, 20 Aug 2026 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=IMK2tXxsqrX4pebXpilI5Q9hamXzYhunRMpUVz2Kvca2HeIZ0YXpS21KPiKFbszQISBpLe
 aDCTEp6sFditps3XsWEsouK9oDrpKtjGWhEEEuaUxWs94aZkIfCsP5ndFsczVMRLyiD+8v
 TLvjYz4FAwgILN7gl2PN4+PJeXMiki4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=riPBu4FuUOWpvTs6b9VNAP4tiRP4Yzmamqkopn4GrrgkbC9Sj/v4Rsnd1OUhCMPTkxC6I+
 BrAL3DUu5Ao+EoBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fOk47XiJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xDlx3TbZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=fOk47XiJAl0IfMqidmSE2ZXVgYhKxo88wV7tLNYD+DnJTpPhE9HZLoUXut7wUgzft0WNwN
 dBPSTXcMHa/fz5ZSg3jk87hx2gTuIzC1W4qEoq361ymC9mGGB14L0+J1gh+diKATReJIuQ
 Z8+AoPtjUfMHTKE6t3Y2KzCqXzyVq/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=xDlx3TbZOTFpRo+JOGTp8MLmJW/WKl+LwgydwViezB89M/LOv1OZyUCQ6ZCUqOt1ni7ddR
 gtjYlJ0EhsC6tqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AC0D367A;
 Thu, 20 Aug 2026 07:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8DfgGmywhmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:43 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-3-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=801;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3EHGosZsiUsvPbtWv+YgPdQhXcWeCKJec/0bk4ipppw=;
 b=AmRtWjGYYEeD9w2S1XD2QU0HCcZeK9iqI7ngOgIuOBVFxfFgO+ipFTWWnk0dT53WbyDLxh8K9
 dRp05mjYjPoC2UyfEt9L06M20Mw5ad/wyHXltJxr4tRnePxKxFxLs5Q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ABEB284F98
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 03/16] lapi: fallback fchroot() parameters
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

Add to fcntl.h fallback definitions:

- FD_PIDFS_ROOT
- FD_NSFS_ROOT
- FD_FAILFS_ROOT

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/fcntl.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 6a9ef11ce..d70954ea7 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -144,6 +144,19 @@
 # endif
 #endif
 
+/* Roots of kernel internal pseudo filesystems, usable as fd sentinels */
+#ifndef FD_PIDFS_ROOT
+# define FD_PIDFS_ROOT		-10002
+#endif
+
+#ifndef FD_NSFS_ROOT
+# define FD_NSFS_ROOT		-10003
+#endif
+
+#ifndef FD_FAILFS_ROOT
+# define FD_FAILFS_ROOT		-10004
+#endif
+
 #ifndef FALLOC_FL_KEEP_SIZE
 # define FALLOC_FL_KEEP_SIZE 1
 #endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
