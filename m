Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DF1C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:07:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17183CF92D
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:07:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 828583CE0C3
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0ED0C1A0C278
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A616C21E87;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQxcADVyUmXvtPKX+XNvgQUySMaBmf43/URdh285KGM=;
 b=UERrGaPAY27BZAMYRpzxsuQITGmS/8JBCdKgh46j1VTKh9+rIuXWHT9+jcTzbiVpiib6kl
 I9aFPjd/mtpk5ekBJLLWiQsBDPwZ40QCIRcnV2ZOn/cfMn1T0/VP88SQpAIKsZwXIbt/zT
 qAw56dx63i/80GqqJxoE755XjRc2LV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQxcADVyUmXvtPKX+XNvgQUySMaBmf43/URdh285KGM=;
 b=H3bb/wJWxQ6E6PxyDXU/bN2CYB77vuJR/O7/Mk+uwr/YyrdIvyjTgBm8gM2v3WM+JSm5nJ
 gHqomFISXQEfqoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQxcADVyUmXvtPKX+XNvgQUySMaBmf43/URdh285KGM=;
 b=UERrGaPAY27BZAMYRpzxsuQITGmS/8JBCdKgh46j1VTKh9+rIuXWHT9+jcTzbiVpiib6kl
 I9aFPjd/mtpk5ekBJLLWiQsBDPwZ40QCIRcnV2ZOn/cfMn1T0/VP88SQpAIKsZwXIbt/zT
 qAw56dx63i/80GqqJxoE755XjRc2LV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQxcADVyUmXvtPKX+XNvgQUySMaBmf43/URdh285KGM=;
 b=H3bb/wJWxQ6E6PxyDXU/bN2CYB77vuJR/O7/Mk+uwr/YyrdIvyjTgBm8gM2v3WM+JSm5nJ
 gHqomFISXQEfqoCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EBBB139FC;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id eNTMHUeMumUoIgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:07:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 19:06:59 +0100
Message-ID: <20240131180659.23587-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131180659.23587-1-pvorel@suse.cz>
References: <20240131180659.23587-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UERrGaPA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="H3bb/wJW"
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[20.93%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A616C21E87
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] doc/C-API: Update MNTPOINT related examples
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

MNTPOINT is defined in library header, no need to define it in the test.
Also actually use that definition instead of hardcoded value.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/C-Test-API.asciidoc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index 5dc9516cf..321f9c534 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -165,9 +165,8 @@ libc and other low level libraries.
 -------------------------------------------------------------------------------
 static int fd0, fd1, mount_flag;
 
-#define MNTPOINT "mntpoint"
-#define FILE1 "mntpoint/file1"
-#define FILE2 "mntpoint/file2"
+#define FILE1 MNTPOINT"/file1"
+#define FILE2 MNTPOINT"/file2"
 
 static void setup(void)
 {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
