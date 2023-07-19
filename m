Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB95EB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:01:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FBA73CDCEA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 13:01:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2183C98EA
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03761600A36
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 141801FE7D;
 Wed, 19 Jul 2023 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689764456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sG5HQeH9ccmdjRSN+hv3JzWX9xKsedTzFN+xAI2ZPg=;
 b=Iaf5EwxYxM1ttKYs5Gb0i9VM1iE0lgnY1ubqgMClDAD8+6QeurLwAoV3ybLxJrBKF+bX51
 xJGvGscxKUeDCvSH3yVJJlUuvDuOldG7Ajlst6pGd2Xt9SktSyz+ADilAs6yD1mRyGJmMD
 nstpJ+beNSMd175ctbusMkERddJpctI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689764456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sG5HQeH9ccmdjRSN+hv3JzWX9xKsedTzFN+xAI2ZPg=;
 b=Sl/e/jNoJg+wqXschTNviWv2MxmPnoym3utgiM62GY+VOWbBbhc3p3RFE9bXpHCBCDTd7a
 tiO7kKzkDxndAyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 981671361C;
 Wed, 19 Jul 2023 11:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SIWEIWfCt2RtUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 11:00:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 13:00:48 +0200
Message-Id: <20230719110051.1237775-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719110051.1237775-1-pvorel@suse.cz>
References: <20230719110051.1237775-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] Makefile: Add C header with generated LTP
 version
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

From: Cyril Hrubis <chrubis@suse.cz>

It will be used for printing LTP version in C API.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/.gitignore     |  2 ++
 lib/Makefile       | 13 +++++++++++++
 lib/gen_version.sh | 16 ++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 lib/.gitignore
 create mode 100755 lib/gen_version.sh

diff --git a/lib/.gitignore b/lib/.gitignore
new file mode 100644
index 000000000..1bd967e2f
--- /dev/null
+++ b/lib/.gitignore
@@ -0,0 +1,2 @@
+/ltp-version.h
+/cached-version
diff --git a/lib/Makefile b/lib/Makefile
index 9b9906f25..ac1f62048 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -20,6 +20,19 @@ pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
 
 INSTALL_TARGETS		:= $(pc_file)
 
+tst_test.o: ltp-version.h
+
+ltp-version.h: gen_version
+
+MAKE_TARGETS += gen_version
+
+.PHONY: gen_version
+gen_version:
+	@echo GEN ltp-version.h
+	@./gen_version.sh
+
+CLEAN_TARGETS += ltp-version.h cached-version
+
 $(pc_file):
 	test -d "$(@D)" || mkdir -p "$(@D)"
 	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
diff --git a/lib/gen_version.sh b/lib/gen_version.sh
new file mode 100755
index 000000000..5d4250755
--- /dev/null
+++ b/lib/gen_version.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+touch cached-version
+
+if git describe >/dev/null 2>&1; then
+	VERSION=`git describe`
+else
+	VERSION=`cat $(dirname $0)/../VERSION`
+fi
+
+CACHED_VERSION=`cat cached-version`
+
+if [ "$CACHED_VERSION" != "$VERSION" ]; then
+	echo "$VERSION" > cached-version
+	echo "#define LTP_VERSION \"$VERSION\"" > ltp-version.h
+fi
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
