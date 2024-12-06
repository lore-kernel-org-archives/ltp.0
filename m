Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4E8E77179
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 09:50:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2113E6863
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:50:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24D193CEFC7
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:49:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3CD9D1034D62
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:49:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D3C11F394;
 Fri,  6 Dec 2024 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733478597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ey1oe6zdyy+mXOXW/sdDdmXXCl266X4GW0KF+5btraI=;
 b=d6tzUHnP+OluW+i4WiN1sakmafhBcBpq/OyWXdQnp1hYT5EXSE7WAaDcc38r0cxWMrCu3h
 vpiCewr926BbtEPBw3wHAuqlLkmHNgG4ilASF42TPIhiIHDgqgynzztNeQj1UgmRosAY4c
 fKUCLwquQad5Pruuven0TPKzU6uM6OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733478597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ey1oe6zdyy+mXOXW/sdDdmXXCl266X4GW0KF+5btraI=;
 b=YZlgAc7sH1YmtYc98M11l0aKQNdfAFN3KJXPfSvLg1aqx2FUCAKAfpaLLNlDQ2SYhLgD2a
 XWVC+mXNFQtB4BAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d6tzUHnP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YZlgAc7s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733478597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ey1oe6zdyy+mXOXW/sdDdmXXCl266X4GW0KF+5btraI=;
 b=d6tzUHnP+OluW+i4WiN1sakmafhBcBpq/OyWXdQnp1hYT5EXSE7WAaDcc38r0cxWMrCu3h
 vpiCewr926BbtEPBw3wHAuqlLkmHNgG4ilASF42TPIhiIHDgqgynzztNeQj1UgmRosAY4c
 fKUCLwquQad5Pruuven0TPKzU6uM6OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733478597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ey1oe6zdyy+mXOXW/sdDdmXXCl266X4GW0KF+5btraI=;
 b=YZlgAc7sH1YmtYc98M11l0aKQNdfAFN3KJXPfSvLg1aqx2FUCAKAfpaLLNlDQ2SYhLgD2a
 XWVC+mXNFQtB4BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56FD713A79;
 Fri,  6 Dec 2024 09:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APBaFMXIUmehEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Dec 2024 09:49:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 Dec 2024 10:49:36 +0100
Message-ID: <20241206094938.92895-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206094938.92895-1-pvorel@suse.cz>
References: <20241206094938.92895-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7D3C11F394
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] Makefile: Add target to run shell loader
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
 Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index ae0247761c..5066789349 100644
--- a/Makefile
+++ b/Makefile
@@ -188,6 +188,7 @@ ifneq ($(build),$(host))
 	$(error running tests on cross-compile build not supported)
 endif
 	$(call _test)
+	$(MAKE) test-shell-loader
 	$(MAKE) test-metadata
 
 test-c: lib-all
@@ -202,6 +203,12 @@ ifneq ($(build),$(host))
 endif
 	$(call _test,-s)
 
+test-shell-loader: lib-all
+ifneq ($(build),$(host))
+	$(error running tests on cross-compile build not supported)
+endif
+	$(top_srcdir)/testcases/lib/run_tests.sh -b $(abs_builddir)
+
 test-metadata: metadata-all
 	$(MAKE) -C $(abs_srcdir)/metadata test
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
