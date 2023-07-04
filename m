Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F66EB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:20:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07AFF3CF03A
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:20:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C40F3CC155
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:19:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6391D1400458
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:19:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B2E92045B;
 Tue,  4 Jul 2023 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688462387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ce+PfJ8QwCM9KQEB3M8UC52AQSMrB06UCmoFX+If9wY=;
 b=UvQX5ollB5jg5GT9E9VyNAq7Mz/EmRyWrhgEzr7vqmW9vq8fvYijeYl1ccQV7c0VN+FodB
 57Z38tBebNLX5Vf54uLQYremhi584gpmicN5JBxpOrDT3vJKjdM6JFYZ1v8bZdftI5QA3N
 bCN5UdG7NiO4p78thLtGuoVHUzcV0Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688462387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ce+PfJ8QwCM9KQEB3M8UC52AQSMrB06UCmoFX+If9wY=;
 b=57nW5i7BVXQnttH7yPiJP2nV6p2nms60+TTFvRf8VYkfuyWWjkFr3QXexzr9pBOTggeDX4
 xChWaw5q+8SSHGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 798A1133F7;
 Tue,  4 Jul 2023 09:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mO+cHDPko2SLSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 09:19:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  4 Jul 2023 11:19:31 +0200
Message-Id: <20230704091933.496989-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704091933.496989-1-pvorel@suse.cz>
References: <20230704091933.496989-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
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

It will be used for printing LTP version in C API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .gitignore   | 1 +
 lib/Makefile | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 915d22104..49e42bb9e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -41,6 +41,7 @@ autom4te.cache
 /include/mk/config-openposix.mk
 /include/mk/features.mk
 /m4/ltp-version.m4
+/lib/ltp-version.h
 /lib/ltp.pc
 /pan/ltp-bump
 /pan/ltp-pan
diff --git a/lib/Makefile b/lib/Makefile
index 9b9906f25..1cac43cde 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -24,5 +24,9 @@ $(pc_file):
 	test -d "$(@D)" || mkdir -p "$(@D)"
 	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
 
+.PHONY: ltp-version.h
+ltp-version.h: $(top_srcdir)/Version
+	echo "#define LTP_VERSION \"LTP version: $$(cat $(top_srcdir)/Version)\"" > "$(top_builddir)/lib/$(@F)"
+
 include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
