Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55D2C46467
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 12:45:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D16B33CDEA5
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 13:45:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A6EE3CB6A2
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 13:45:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 00EAA6005DD
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 13:45:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D3904671E1;
 Tue,  3 Jan 2023 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672749910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0xSsADy4l5iGvi3an6i1+42R4NhxNEvzJF8WOa1GOBo=;
 b=oNYomeouC3/WTKbyR1kO+RYR2/H8Fq3zxsyD8F6IC6mIlI/L890XrYRG+B3pXHWIeEO/LI
 c/JDNwYk/K3kx8B+GMfbk9Ydjr4LaplrZDLrdgCwQT1lo2Q8je7uYPZP/b99yGvDtd5Z3F
 hXIqmzjaCLrcyiQipTIWaRU4nvCF9GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672749910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0xSsADy4l5iGvi3an6i1+42R4NhxNEvzJF8WOa1GOBo=;
 b=5yeI+sOdQ2pzQTLonHnQBbjmncPDi38uH2bEbF758eWKJ4pfaMXUA28mqZuYyaNL9Jzwb5
 lLbLCmJYKWss8dBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A87841392B;
 Tue,  3 Jan 2023 12:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qfegJ1YjtGMZEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 12:45:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jan 2023 13:45:04 +0100
Message-Id: <20230103124505.6611-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] configure.ac: Require 2.64
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
Cc: Mike Frysinger <vapier@gentoo.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

autoconf 2.64 is required by m4/ax_check_compile_flag.m4
(for _AC_LANG_PREFIX and AS_VAR_IF).

Testing on old distro (CentOS 6) with autoconf-2.63-5.1.el6.noarch
make autotools fails:

aclocal -I m4
configure.ac:397: error: Autoconf version 2.64 or higher is required
m4/ax_check_compile_flag.m4:39: AX_CHECK_COMPILE_FLAG is expanded from...
configure.ac:397: the top level
autom4te: /usr/bin/m4 failed with exit status: 63
aclocal: autom4te failed with exit status: 63
make: *** [aclocal.m4] Error 63

Fixes: a08cbaea73 ("Add AX_CHECK_COMPILE_FLAG() autoconf macro")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1ab7cc60da..c2b0f48e79 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,4 +1,4 @@
-AC_PREREQ(2.61)
+AC_PREREQ(2.64)
 AC_INIT([ltp], [LTP_VERSION], [ltp@lists.linux.it])
 AC_CONFIG_AUX_DIR([.])
 AM_INIT_AUTOMAKE
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
