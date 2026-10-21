Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D38606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WQ77A5gw;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nmLAmx3d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WQ77A5gw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nmLAmx3d
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23CC53C20C2
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:13:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C474A3CADF1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:12:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA9EB1A001C7
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:12:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DFB11F749;
 Wed, 21 Oct 2026 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792570322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/iGTPJZ2rBDz2hvAHNYM19Ft4WXz5UWzckDxLfVWvc=;
 b=WQ77A5gwjea0aerMGUsZZnVodnvTiKGpYOpdaQTcDoc2L2ztqgPGFGKCGvf9Qds9QDGyQq
 1uhAprknUweeFrXAONf0PY9+EfvOnAd9k8qAnPQwazpdTT+WnWA4c7w042HxsnDeI7knFX
 XE6JVp85TN4lkPLDMeO7ESa4qBLs0Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792570322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/iGTPJZ2rBDz2hvAHNYM19Ft4WXz5UWzckDxLfVWvc=;
 b=nmLAmx3dA8gq1x9ct+1znNbDTu1Euxr3vRV6MQySrYeSyXt4u56WVkwAzTFcIAE6HVhI5h
 MNtiDgcukjLwsGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792570322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/iGTPJZ2rBDz2hvAHNYM19Ft4WXz5UWzckDxLfVWvc=;
 b=WQ77A5gwjea0aerMGUsZZnVodnvTiKGpYOpdaQTcDoc2L2ztqgPGFGKCGvf9Qds9QDGyQq
 1uhAprknUweeFrXAONf0PY9+EfvOnAd9k8qAnPQwazpdTT+WnWA4c7w042HxsnDeI7knFX
 XE6JVp85TN4lkPLDMeO7ESa4qBLs0Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792570322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/iGTPJZ2rBDz2hvAHNYM19Ft4WXz5UWzckDxLfVWvc=;
 b=nmLAmx3dA8gq1x9ct+1znNbDTu1Euxr3vRV6MQySrYeSyXt4u56WVkwAzTFcIAE6HVhI5h
 MNtiDgcukjLwsGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 373601351D;
 Wed, 21 Oct 2026 08:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ggQsKtFz2Go9QgAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Wed, 21 Oct 2026 08:12:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Oct 2026 10:11:29 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
In-Reply-To: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570321; l=1744;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=EmK640FPkOSPklSuyWK3740fqiKvumEkGjHdiBfHYPc=;
 b=4PO0kW0Y+F6JQQlIkM+Bwri3+sKvroGexgGI/G1gtPxvpzl7qtXNcLPIKBeeypIiNNo/VW1My
 /4tIhjK486lDUEs04sghzSKMgiDP0axQGGG2JmDs7yzSh6vLaJ1SdYa
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] build: Build shared libs once on subtree make
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

When make is invoked directly in a trunk subdirectory (MAKELEVEL == 0),
build shared prerequisites (libltp.a, libs, and libkerntest.a) once
via MAKE_DEPS before launching parallel subdirectory builds.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/mk/generic_trunk_target.inc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index f9db7896a..aa8e500e1 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -36,6 +36,29 @@ RECURSIVE_TARGETS		?= all install check
 
 $(eval $(get_make_dirs))
 
+ifeq ($(MAKELEVEL),0)
+ifneq ($(filter $(abs_top_builddir)/testcases%,$(CURDIR)),)
+MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a $(abs_top_builddir)/libs-all
+
+$(abs_top_builddir)/lib/libltp.a:
+	mkdir -m 00755 -p "$(abs_top_builddir)/lib"
+	$(MAKE) -C "$(abs_top_builddir)/lib" -f "$(abs_top_srcdir)/lib/Makefile" all
+
+.PHONY: $(abs_top_builddir)/libs-all
+$(abs_top_builddir)/libs-all: $(LTPLIBS_FILES)
+	mkdir -m 00755 -p "$(abs_top_builddir)/libs"
+	$(MAKE) -C "$(abs_top_builddir)/libs" -f "$(abs_top_srcdir)/libs/Makefile" all
+endif
+
+ifneq ($(filter $(abs_top_builddir)/testcases/kernel/%,$(CURDIR)),)
+MAKE_DEPS += $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a
+
+$(abs_top_builddir)/testcases/kernel/lib/libkerntest.a:
+	mkdir -m 00755 -p "$(abs_top_builddir)/testcases/kernel/lib"
+	$(MAKE) -C "$(abs_top_builddir)/testcases/kernel/lib" -f "$(abs_top_srcdir)/testcases/kernel/lib/Makefile" all
+endif
+endif
+
 .PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
 
 $(SUBDIRS): %:

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
