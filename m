Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2C4CEBF8A
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 10:02:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 892143C52C3
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 12:02:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E62C63C4F76
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:02:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1BBED600909
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:02:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32D721FD9F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 10:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727431358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HwStErXnJqHDNz+i/XC0GxB/D3kln2PUdJqamCFf0Sg=;
 b=seJXl54vALY6UMgghqU/6BMcd8Ed5gvx71ywoIqPVcE1ea59b/uWWfVCiUghQTvYVuQWrP
 z3j7+02oRQxrwnMwtH66Y9tAP9kthy+HB7q+7iKObPI5M55gWzrBlJLhhxCt0cBENt827j
 JoeasKQiI1R6RgV7eDv3T5WqXLGgiKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727431358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HwStErXnJqHDNz+i/XC0GxB/D3kln2PUdJqamCFf0Sg=;
 b=VI0mP8NvUliV9MS8temJXsafwz932Kgt0QYehQ/xb6JY+oG1nz1BA7IgBHXga1ryowbn5q
 GJpsegVZ9VE9hmDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=seJXl54v;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VI0mP8Nv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727431358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HwStErXnJqHDNz+i/XC0GxB/D3kln2PUdJqamCFf0Sg=;
 b=seJXl54vALY6UMgghqU/6BMcd8Ed5gvx71ywoIqPVcE1ea59b/uWWfVCiUghQTvYVuQWrP
 z3j7+02oRQxrwnMwtH66Y9tAP9kthy+HB7q+7iKObPI5M55gWzrBlJLhhxCt0cBENt827j
 JoeasKQiI1R6RgV7eDv3T5WqXLGgiKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727431358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HwStErXnJqHDNz+i/XC0GxB/D3kln2PUdJqamCFf0Sg=;
 b=VI0mP8NvUliV9MS8temJXsafwz932Kgt0QYehQ/xb6JY+oG1nz1BA7IgBHXga1ryowbn5q
 GJpsegVZ9VE9hmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2135613A73
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 10:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xj4xB76C9mb2UQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 10:02:38 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Sep 2024 12:01:35 +0200
Message-ID: <20240927100135.12271-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 32D721FD9F
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] realtime: Install run.sh script
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

The README describes how to run the testcases using the run.sh script
but the run.sh script was not installed at all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/realtime/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/realtime/Makefile b/testcases/realtime/Makefile
index b90ecf8c4..4d783b01d 100644
--- a/testcases/realtime/Makefile
+++ b/testcases/realtime/Makefile
@@ -28,6 +28,9 @@ LIBDIR			:= lib
 FILTER_OUT_DIRS		:= $(LIBDIR)
 LIB			:= $(LIBDIR)/librealtime.a
 
+INSTALL_DIR             := $(srcdir)
+INSTALL_TARGETS         := run.sh
+
 $(LIBDIR):
 	mkdir -p "$@"
 
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
