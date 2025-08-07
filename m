Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D1C87FD2
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 06:30:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8636D3C8FDF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 08:30:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF1E13C7386
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:29:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0563720023E
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:29:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE15F1F7F4;
 Thu,  7 Aug 2025 06:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754548184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpdC6dPgIaomOwrg3qSohnqcu4E5wG7hgf8N+chrsd0=;
 b=1me9yymc8B4vsOqphwdp9TDTRrGOHyjAGzLjgzU5yLurcF+ZA8YGIxrb7LqYqw7RO97xwN
 2g6cMx5Km/5j+x7dIU0gkFhDEN1YvzisgRpQn7old2Ct74vIckci2cB72P7fQ9ft/PIwfx
 TORNPViIFtGbBWoSs9N6TrfLDCenACI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754548184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpdC6dPgIaomOwrg3qSohnqcu4E5wG7hgf8N+chrsd0=;
 b=DgPJsTTNG8iOxDI35bmOwG7tItK5p5K3inEGI9nLt4wgf75jeE8G4KPJ2CsjQ1k72YoLpD
 0WPwPbIVOcZDQkBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754548183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpdC6dPgIaomOwrg3qSohnqcu4E5wG7hgf8N+chrsd0=;
 b=VFMNOhWj5t58PCNGpUPCSMxdXt5aCFt4SBmOp5/vVqyVarazE7nm7Cgx0Kpj4Xz1E/JPRj
 AAAFtpcx+b1P13cKj09uZO6vyMCxbjTL8hH+rM9yZZ69l8i5FMKKs1o6WwC1rC021ECIuW
 1wyVWZwjytUWsp+t4AHNhhZ+GFRc6Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754548183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IpdC6dPgIaomOwrg3qSohnqcu4E5wG7hgf8N+chrsd0=;
 b=Jg70OT11M9BSwMLxB8Nh4+oByDNomUMw2ereKdYZ/W6bWBOVNprpsywWXWsPtP3opzgRFI
 Uc8WLVDA46FzgIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDB47136DC;
 Thu,  7 Aug 2025 06:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bV81LNdHlGjoBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 07 Aug 2025 06:29:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Aug 2025 08:29:40 +0200
Message-ID: <20250807062941.348971-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] Makefile: Add kernel modules related make
 targets
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

LTP contains few kernel modules and tests which are using them.  These
require to be built with the same kernel headers as the running kernel
(SUT). Sometimes the best way to achieve this is to compile them on the
SUT.

Add 'modules', 'modules-clean' and 'modules-install' make targets to
make it easier to build them.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

Link to v3:
https://patchwork.ozlabs.org/project/ltp/patch/20250806211420.445452-1-pvorel@suse.cz/

Link to v2:
https://patchwork.ozlabs.org/project/ltp/patch/20250801100935.974351-1-pvorel@suse.cz/

 INSTALL  | 10 ++++++++++
 Makefile | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/INSTALL b/INSTALL
index cbe27f32ea..10c19d4105 100644
--- a/INSTALL
+++ b/INSTALL
@@ -165,6 +165,16 @@ PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./c
 * Arch Linux
 PKG_CONFIG_LIBDIR=/usr/lib32/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
 
+Kernel modules
+--------------
+
+LTP contains few kernel modules and tests which are using them.
+These require to be built with the same kernel headers as the running kernel (SUT).
+Sometimes the best way to achieve this is to compile them on the SUT.
+
+'modules', 'modules-clean' and 'modules-install' make targets are shortcuts
+to build just these modules and tests.
+
 Android Users
 -------------
 
diff --git a/Makefile b/Makefile
index eab40da8a6..cdad8b10ce 100644
--- a/Makefile
+++ b/Makefile
@@ -212,6 +212,27 @@ endif
 test-metadata: metadata-all
 	$(MAKE) -C $(abs_srcdir)/metadata test
 
+MODULE_DIRS :=  $(shell \
+	dirname $$(grep -l 'include.*module\.mk' $$(find testcases/ -type f -name 'Makefile')))
+
+
+.PHONY: modules modules-clean modules-install
+modules:
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir); \
+)
+modules-clean:
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) clean; \
+)
+modules-install: modules
+	@$(foreach dir,$(MODULE_DIRS),\
+		echo "Build $(dir)";\
+		$(MAKE) -C $(abs_srcdir)/$(dir) install; \
+)
+
 ## Help
 .PHONY: help
 help:
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
