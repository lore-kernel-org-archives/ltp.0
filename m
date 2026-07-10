Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1320C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:57:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CE993E26D9
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:57:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31B2F3E286B
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 83A516001B6
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8303A76603;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI3QI+wdKfQj1l+LR/vmyRs/T7+AIK2WrgnHaGlKx0Y=;
 b=XABJUJmI/pL9y4GmxlqmzDVKSVbzfdYFlI5L/A84mcmsZ0vo1GQWPY9Kkca6AsN3bAtt0O
 9eCAPgrWdxJPNceBhT05r6+7te9qfH5Cx+PVt18mrXAx/8mqQByyWQrDm8aLhHurIoB2VR
 KeI0vKdpKMwYPwgpKN/a8/EziOSpirE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI3QI+wdKfQj1l+LR/vmyRs/T7+AIK2WrgnHaGlKx0Y=;
 b=5+DbkNpPv4Wt41rwcj3G/FQZwcTMfBu45+4ICkdaxWtDrnif4djHpnZlRq0TigDiEVXOWI
 h/Gk7IdllFIdE2AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI3QI+wdKfQj1l+LR/vmyRs/T7+AIK2WrgnHaGlKx0Y=;
 b=XABJUJmI/pL9y4GmxlqmzDVKSVbzfdYFlI5L/A84mcmsZ0vo1GQWPY9Kkca6AsN3bAtt0O
 9eCAPgrWdxJPNceBhT05r6+7te9qfH5Cx+PVt18mrXAx/8mqQByyWQrDm8aLhHurIoB2VR
 KeI0vKdpKMwYPwgpKN/a8/EziOSpirE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI3QI+wdKfQj1l+LR/vmyRs/T7+AIK2WrgnHaGlKx0Y=;
 b=5+DbkNpPv4Wt41rwcj3G/FQZwcTMfBu45+4ICkdaxWtDrnif4djHpnZlRq0TigDiEVXOWI
 h/Gk7IdllFIdE2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 582DD779BE;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDOrE3CJUGp7TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 05:56:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 07:55:52 +0200
Message-ID: <20260710055556.1109220-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710055556.1109220-1-pvorel@suse.cz>
References: <20260710055556.1109220-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/8] metadata: test.sh: Add support for building
 out-of-tree
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

NOTE out-of-tree build is supported only from the top level directory,
otherwise it requires to set METAPARSEDIR variable by user (similarly to
other tests run via testcases/lib/run_tests.sh).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Fix out of tree build
* Try to detect out-of-tree build without specifying variable

LTP running internal testing is implemented for every directory
differently. It would be nice to unify it.

Also much of the complexity is done by out-of-tree part. I really wish
one day we migrate to meson (which is faster, support out-of-tree
modules and de facto standard for userspace nowadays).

 Makefile               |  2 +-
 metadata/Makefile      |  2 +-
 metadata/tests/test.sh | 11 ++++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f1b59609a5..2efbe8c6c0 100644
--- a/Makefile
+++ b/Makefile
@@ -213,7 +213,7 @@ test-metadata: metadata-all
 ifneq ($(build),$(host))
 	$(error running tests on cross-compile build not supported)
 endif
-	$(MAKE) -C $(abs_srcdir)/metadata test
+	METAPARSEDIR=$(abs_builddir)/metadata $(MAKE) -C $(abs_srcdir)/metadata test
 
 MODULE_DIRS :=  $(shell \
 	dirname $$(grep -l 'include.*module\.mk' $$(find $(abs_srcdir)/testcases/ -type f -name 'Makefile')))
diff --git a/metadata/Makefile b/metadata/Makefile
index 7e4ee38d2e..af194bcc94 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -16,6 +16,6 @@ ltp.json: metaparse metaparse-sh
 	$(abs_srcdir)/parse.sh > ltp.json
 
 test: metaparse metaparse-sh
-	$(MAKE) -C $(abs_srcdir)/tests/ test
+	METAPARSEDIR=$$METAPARSEDIR $(MAKE) -C tests/ test
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/metadata/tests/test.sh b/metadata/tests/test.sh
index a9ebc768f9..89a7857ad2 100755
--- a/metadata/tests/test.sh
+++ b/metadata/tests/test.sh
@@ -2,9 +2,18 @@
 
 fail=0
 
+METAPARSE="${METAPARSEDIR:-..}/metaparse"
+
+cd "${SRCDIR:-.}"
+
+if [ ! -x "$METAPARSE" ]; then
+	echo "Error: $METAPARSE not found (wrong PATH? out-of-tree build without specifying \$METAPARSEDIR?)" >&2
+	exit 1
+fi
+
 for i in *.c; do
 	printf "* $i "
-	../metaparse $i > tmp.json
+	$METAPARSE $i > tmp.json
 	if ! diff tmp.json $i.json >/dev/null 2>&1; then
 		echo '[FAIL]'
 		echo "$i output differs!"
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
