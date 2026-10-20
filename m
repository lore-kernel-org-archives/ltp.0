Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2A606A320
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vt6vWXPZ;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DJNNCvbY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vt6vWXPZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DJNNCvbY
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CEDF3E9AC8
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 18:43:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34ACA3E707E
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:42:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29EFF200275
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:42:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19E8F1F7BD;
 Tue, 20 Oct 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792514567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIh1XjZ+X+3lLeNATu1VmoMd4P/tTBlGDg9HKnS4BjU=;
 b=vt6vWXPZI6AeQL2wyNhVvbzYlpyK3OPGadwnp4SvsTYUdRM7lmqcKWfHhHFGnKoeLBHYAz
 uj5n5Ig461ek3EMr4MIfi6aLx3k6M0+Fk4l/9gI+8o6QfZzwrHGUN4o2OLvYsIsWMhrkqR
 drWDNDuYdU634FlbHM25v/vrSXoW3LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792514567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIh1XjZ+X+3lLeNATu1VmoMd4P/tTBlGDg9HKnS4BjU=;
 b=DJNNCvbYnq7agV643hUeYDEySoo8M821hKy4ZWh4PKZkRbdJRJJoChGzhTpYRggiyTNtLf
 d6fFT6sitxhHsYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792514567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIh1XjZ+X+3lLeNATu1VmoMd4P/tTBlGDg9HKnS4BjU=;
 b=vt6vWXPZI6AeQL2wyNhVvbzYlpyK3OPGadwnp4SvsTYUdRM7lmqcKWfHhHFGnKoeLBHYAz
 uj5n5Ig461ek3EMr4MIfi6aLx3k6M0+Fk4l/9gI+8o6QfZzwrHGUN4o2OLvYsIsWMhrkqR
 drWDNDuYdU634FlbHM25v/vrSXoW3LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792514567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIh1XjZ+X+3lLeNATu1VmoMd4P/tTBlGDg9HKnS4BjU=;
 b=DJNNCvbYnq7agV643hUeYDEySoo8M821hKy4ZWh4PKZkRbdJRJJoChGzhTpYRggiyTNtLf
 d6fFT6sitxhHsYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F940136CC;
 Tue, 20 Oct 2026 16:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fMmFGwWa12r7TgAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 16:42:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 18:42:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-build_system_optimize-v2-2-b527ac7cf835@suse.com>
References: <20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com>
In-Reply-To: <20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514565; l=1727;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=oC3CF3f1PSHgt3o4CFZV4iuax69Aui6N7LrY8XeWVsY=;
 b=a6szqtTwLCYK7O6u9kaZct7vGxfUPz3XCN+9iFOBUnw1EkQQCTPxizFa4U+VlKUpmkWyB8aUs
 IALrvaF5Ah5DvR4COParGMZu7UGqK2lGo+LIEtkGnpAFAraREj8BywX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] build: Build shared libs once on subtree make
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
index f9db7896a..eff7fa33c 100644
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
+$(abs_top_builddir)/libs-all:
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
