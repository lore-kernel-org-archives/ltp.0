Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AB606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hN1RVDMr;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=koMRrLJw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hN1RVDMr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=koMRrLJw
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE3CF3CAB90
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:12:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7593F3CA3ED
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:12:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96F0720097E
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:12:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7461C1F461;
 Wed, 21 Oct 2026 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792570322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mgn4MsJy6AtxgpCj/NGvN3lU/hsyLQlcq5nKf7b6hZ0=;
 b=hN1RVDMrhwH5ST6r/+Oxbeiaq3Wxxad7fVmO8ycVzjnbhL/+Ll5mhExNlsxPOpyKRc7mHv
 91Otp79GjB43m0FFWDr8l+KWCWAzPnLzw8ZM/gXllPqceKm+1q5DEZuGyAJICF1eUYVvlz
 GCQDA7DCUK7xFvogpckxvrMrjbHJc78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792570322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mgn4MsJy6AtxgpCj/NGvN3lU/hsyLQlcq5nKf7b6hZ0=;
 b=koMRrLJw7YRRDWRjmF6OQZrqnOWnxg3wUaGc4HQDZ8Vv7LK74ppDBstl4erlZJPvoxxjB/
 nSuIBYqkLvG2yrDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hN1RVDMr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=koMRrLJw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792570322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mgn4MsJy6AtxgpCj/NGvN3lU/hsyLQlcq5nKf7b6hZ0=;
 b=hN1RVDMrhwH5ST6r/+Oxbeiaq3Wxxad7fVmO8ycVzjnbhL/+Ll5mhExNlsxPOpyKRc7mHv
 91Otp79GjB43m0FFWDr8l+KWCWAzPnLzw8ZM/gXllPqceKm+1q5DEZuGyAJICF1eUYVvlz
 GCQDA7DCUK7xFvogpckxvrMrjbHJc78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792570322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mgn4MsJy6AtxgpCj/NGvN3lU/hsyLQlcq5nKf7b6hZ0=;
 b=koMRrLJw7YRRDWRjmF6OQZrqnOWnxg3wUaGc4HQDZ8Vv7LK74ppDBstl4erlZJPvoxxjB/
 nSuIBYqkLvG2yrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11FAD13518;
 Wed, 21 Oct 2026 08:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ggQsKtFz2Go9QgAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Wed, 21 Oct 2026 08:12:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Oct 2026 10:11:28 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261021-build_system_optimize-v3-1-71a3c4c6f937@suse.com>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
In-Reply-To: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570321; l=2381;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=c82vNkmXcrdBrEqckl/bqIIffIeURmTjrOLvYhxPVss=;
 b=J8l5lF2hwxbGE+yo3G+rH2jDrwqa6xn5ChehpN+NDXOkDLgAgeM9MmYCw7SzbFUs/a3jyBIKC
 zd9GYXtvccBCua05fsmajLy6yvNZt1hmBViDRGfkvjMLGQ1Vx9AXo2Y
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7461C1F461
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] build: Fix library prerequisites in
 testcases.mk
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

Fix LTPLIBS_FILES to match the actual libltp<name>.a archive names and
only mark them .PHONY when MAKELEVEL == 0 so recursive leaf sub-makes
do not redundantly rebuild them in parallel.

Also make directory prerequisites order-only so directory mtime updates
do not trigger unnecessary archive rebuilds.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/mk/testcases.mk         | 14 ++++++++------
 testcases/kernel/include/lib.mk |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 2609535ce..5960d7485 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -12,11 +12,11 @@ LIBLTP_DIR	:= $(abs_top_builddir)/lib
 
 LIBLTP		:= $(LIBLTP_DIR)/libltp.a
 
-$(APICMDS_DIR)/tst_kvercmp: $(APICMDS_DIR)
-	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/tools/apicmds/Makefile" all
+$(APICMDS_DIR)/tst_kvercmp: | $(APICMDS_DIR)
+	$(MAKE) -C "$(APICMDS_DIR)" -f "$(abs_top_srcdir)/tools/apicmds/Makefile" all
 
-$(LIBLTP): $(LIBLTP_DIR)
-	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/lib/Makefile" all
+$(LIBLTP): | $(LIBLTP_DIR)
+	$(MAKE) -C "$(LIBLTP_DIR)" -f "$(abs_top_srcdir)/lib/Makefile" all
 
 MAKE_DEPS	:= $(LIBLTP)
 
@@ -27,13 +27,15 @@ LDLIBS		+= -lltp
 ifdef LTPLIBS
 
 LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/, $(LTPLIBS))
-LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),$(LIB)/lib$(LIB))))
+LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),$(LIB)/libltp$(LIB))))
 
 MAKE_DEPS += $(LTPLIBS_FILES)
 
+ifeq ($(MAKELEVEL),0)
 .PHONY: $(LTPLIBS_FILES)
+endif
 
-$(LTPLIBS_FILES): $(LTPLIBS_DIRS)
+$(LTPLIBS_FILES): | $(LTPLIBS_DIRS)
 
 $(LTPLIBS_FILES): %:
 ifdef VERBOSE
diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index 40a09b77e..c1a0c6d52 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -29,8 +29,8 @@ LDFLAGS			+= -L$(LIBKERNTEST_DIR)
 $(LIBKERNTEST_DIR):
 	mkdir -p "$@"
 
-$(LIBKERNTEST): $(LIBKERNTEST_DIR)
-	$(MAKE) -C $^ -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
+$(LIBKERNTEST): | $(LIBKERNTEST_DIR)
+	$(MAKE) -C "$(LIBKERNTEST_DIR)" -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
 
 MAKE_DEPS		+= $(LIBKERNTEST)
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
