Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5965C433F5
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 12:38:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42F413C96B9
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 13:38:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 511743C21D9
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:38:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 645D7200C0A
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:38:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73F22218D9
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642682319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LRmmrwpBnUD1BRISA4GLGeqFnFN8r6KSe/Vc56O65Js=;
 b=b+YU6igMetUYTp1zJGnzYNqsIC16OXGBANUhEERQH80d7x9KlYSLY7ZVMbKXVJp/Kovs4l
 ppVgQHRe4r7Lddy6o+YhzilkYVRkoweyp0v6dbWcRXfMG+1I/AnQv8U0pVTIALMS58dYA3
 R8ucsS39IwcWpyd704BjHdxEUwm9tXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642682319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LRmmrwpBnUD1BRISA4GLGeqFnFN8r6KSe/Vc56O65Js=;
 b=/7Apoxs+RJ7KNLK/Q4h8lQ8vbznToO/ePRBSckuu9kaRT28IROMwLzglabMhWU72QF3Wyv
 a2ctyziNvfDnqgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5822A13E9E
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 12:38:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9m/kFM9X6WEEZAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 12:38:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jan 2022 13:40:23 +0100
Message-Id: <20220120124023.17469-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] configure: Fix summary for --disable-metadata
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

This changes the m4/ltp-docparse.m4 to skip the detection and sets the
corresponding variables so that we get correct summary when the metadata
are disable by users.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 m4/ltp-docparse.m4 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/m4/ltp-docparse.m4 b/m4/ltp-docparse.m4
index 88d2e08e4..9514e5e1e 100644
--- a/m4/ltp-docparse.m4
+++ b/m4/ltp-docparse.m4
@@ -35,7 +35,13 @@ with_metadata=no
 with_metadata_html=no
 with_metadata_pdf=no
 
-if test "x$enable_metadata" = xyes && test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
+if test "x$enable_metadata" != xyes; then
+	enable_metadata_html=no
+	enable_metadata_pdf=no
+	with_metadata_generator=none
+fi
+
+if test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
 	AX_PROG_PERL_MODULES(Cwd File::Basename JSON LWP::Simple)
 fi
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
