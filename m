Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111F5C55822
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:50:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C0F73E2D03
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:50:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24FC33C713B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D8ED7600BD2
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48DF27FD43;
 Wed,  5 Aug 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYyF1VBukJo+xcuZ2dgoamMh+aBJW3/BpMbGBiKIjTk=;
 b=23DOosbc7y+hvsMEmQ+CiegUIBuGItMEN0d4n/WKKXsDchYwNGswIrGc3ku6K/V+3U1kK6
 fm1/XrVp22H5b1vQs1If+hfrN7Hkt9o8AbE9oI9YaWJJRATpNhKE2c5TFQP3KqcRy5SSbz
 ybsZdPib+x2c71X0533y+ROT8i2PUUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYyF1VBukJo+xcuZ2dgoamMh+aBJW3/BpMbGBiKIjTk=;
 b=hEmlPN2nibwR/Wu+Lvc1qOFn49cq8BzIb5CtKQNSfEeqmiy/YomqHi7Xu5bmUIB0/9rtQ+
 fnG2e0fCft7XujCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYyF1VBukJo+xcuZ2dgoamMh+aBJW3/BpMbGBiKIjTk=;
 b=khtXEtRRWz66q3oaAUQheIlCmZ+ZYluRpOVzSfK3ocnxLBjDm8gpAPMdLJbu0IRGCNT8eW
 OZIvNyJj7WiNPFa3bul1b/xbuZuY1vY/NdgG2asx2Mp+NlHe1IwNFtFizeZaVVLaIDn98u
 bZgppB866ujg+hkD69SNJlHLmuiSLK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYyF1VBukJo+xcuZ2dgoamMh+aBJW3/BpMbGBiKIjTk=;
 b=IpjCbPI8LIcOM1oKdIWKY081k7jfsrEZ9hiipxiXWZsmYOZbSL3m2qwgqksAk/DjnyqyFR
 AZrKGoE8/dD3n8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07698779C3;
 Wed,  5 Aug 2026 09:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ACSMOzMHc2rvSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 09:49:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 11:49:33 +0200
Message-ID: <20260805094935.448896-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805094935.448896-1-pvorel@suse.cz>
References: <20260805094935.448896-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] doc: Reduce default sphinx verbosity with -q
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

Guard sphinx -v opt with V=1 make variable. This will be useful for
linuxdoc update which uses Sphinx logging in this version.

Actually '-q' is needed because even without '-v' the output would get
over thousand of kernel-doc INFO level messages like:

    include/tst_test_macros.h:811: [kernel-doc INFO] : prototype --> '#define TST_EXP_EQ_LI_SILENT(VAL_A, VAL_B) \'
    include/tst_test_macros.h:815: [kernel-doc INFO] : scanning doc for: function 'TST_EXP_EQ_LU'
    include/tst_test_macros.h:817: [kernel-doc INFO] : section: @VAL_A
    include/tst_test_macros.h:818: [kernel-doc INFO] : section: @VAL_B

which would easily hide a real error.

While at it, use this also for 'spelling' make target.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
index 1da240530c..76248c3ed4 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -8,6 +8,13 @@ include $(top_srcdir)/include/mk/env_pre.mk
 PYTHON := python3
 VENV_DIR := .venv
 
+ifdef VERBOSE
+OPTS := -v
+else
+# linuxdoc 20260504 is too verbose by default
+OPTS := -q
+endif
+
 # only fish and bash/zsh supported
 VENV_CMD := if [ "x${FISH_VERSION}" != "x" ]; then . $(VENV_DIR)/bin/activate.fish; else . $(VENV_DIR)/bin/activate; fi
 
@@ -24,10 +31,10 @@ ${abs_top_builddir}/metadata/ltp.json:
 	$(MAKE) -C ${abs_top_builddir}/metadata
 
 all: ${abs_top_builddir}/metadata/ltp.json
-	$(RUN_VENV); sphinx-build -v -b html . html
+	$(RUN_VENV); sphinx-build $(OPTS) -b html . html
 
 spelling:
-	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
+	$(RUN_VENV); sphinx-build $(OPTS) -b spelling -d build/doctree . build/spelling
 
 clean:
 	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
