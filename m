Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC999C3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D1C3D1AEE
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:17:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D552C3D1ADE
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 459F7206C42
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C165D1FB96;
 Wed, 17 Jul 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmtGXl/TocvQgBtiHfLZFvZZ7zfcLEF62TqQweo897c=;
 b=cdDD6DmB50YdS5EgCN9r2iDZUaKA33hv97aZuTAYyY0h5LzIXEhaFF7bROnsxQ1u8uH3H2
 3iC8V2swl2JfDqH4nAN2G4mgEqHdCEWY7lJ16gVAQvjz6/54WY2Hci9jspY59U5ohZRdxQ
 9tvz1KEPequX78b9Ye4Db7TZVuDeEwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmtGXl/TocvQgBtiHfLZFvZZ7zfcLEF62TqQweo897c=;
 b=9MRWi2vrjiFH56cGFD/6JjsxauKni54OqYyCE7iNeRSddl6XRA99HqxHfKEFcXSZfkIyYq
 /WIp8atHCfTJLHCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cdDD6DmB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9MRWi2vr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmtGXl/TocvQgBtiHfLZFvZZ7zfcLEF62TqQweo897c=;
 b=cdDD6DmB50YdS5EgCN9r2iDZUaKA33hv97aZuTAYyY0h5LzIXEhaFF7bROnsxQ1u8uH3H2
 3iC8V2swl2JfDqH4nAN2G4mgEqHdCEWY7lJ16gVAQvjz6/54WY2Hci9jspY59U5ohZRdxQ
 9tvz1KEPequX78b9Ye4Db7TZVuDeEwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmtGXl/TocvQgBtiHfLZFvZZ7zfcLEF62TqQweo897c=;
 b=9MRWi2vrjiFH56cGFD/6JjsxauKni54OqYyCE7iNeRSddl6XRA99HqxHfKEFcXSZfkIyYq
 /WIp8atHCfTJLHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F39E1396E;
 Wed, 17 Jul 2024 17:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IH7ZGZ78l2ZQOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:17:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jul 2024 19:17:11 +0200
Message-ID: <20240717171713.687339-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717171713.687339-1-pvorel@suse.cz>
References: <20240717171713.687339-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C165D1FB96
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] configure: Enable realtime testsuite by default
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

This is needed because sched_football will be added to runtest/sched
as well.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac              | 7 +++++--
 include/mk/features.mk.in | 3 ---
 testcases/Makefile        | 4 ----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index a8e40a5fc0..6fea710a05 100644
--- a/configure.ac
+++ b/configure.ac
@@ -369,7 +369,7 @@ fi
 # TODO: testcases/realtime requires bash and python.
 AC_ARG_WITH([realtime-testsuite],
   [AS_HELP_STRING([--with-realtime-testsuite],
-    [compile and install the realtime testsuite])],
+    [unused, kept for compatibility reason])],
   [with_realtime_testsuite=$withval],
   [with_realtime_testsuite=no]
 )
@@ -447,7 +447,6 @@ cat << EOF
 TESTSUITES
 KVM testsuite: $have_kvm
 open posix testsuite: ${with_open_posix_testsuite:-no}
-realtime testsuite: ${with_realtime_testsuite:-no}
 TI-RPC testsuite: ${with_tirpc:-yes}
 
 LIBRARIES
@@ -466,3 +465,7 @@ metadata generator: $with_metadata_generator
 HTML metadata: $with_metadata_html
 PDF metadata: $with_metadata_pdf
 EOF
+
+if test "x$with_realtime_testsuite" = xyes; then
+    AC_MSG_WARN([--with-realtime-testsuite has no effect and is kept for compatibilty reason. It will be removed in the future.])
+fi
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 73a2f66587..2fc5230d49 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -39,8 +39,5 @@ WITH_METADATA_PDF		:= @WITH_METADATA_PDF@
 # Enable testcases/open_posix_testsuite's compile and install?
 WITH_OPEN_POSIX_TESTSUITE	:= @WITH_OPEN_POSIX_TESTSUITE@
 
-# Enable testcases/realtime's compile and install?
-WITH_REALTIME_TESTSUITE		:= @WITH_REALTIME_TESTSUITE@
-
 # Enable testcases/kernel/kvm compile and install?
 WITH_KVM_TESTSUITE		:= @WITH_KVM_TESTSUITE@
diff --git a/testcases/Makefile b/testcases/Makefile
index 662d4b1edd..d98d79f3c1 100644
--- a/testcases/Makefile
+++ b/testcases/Makefile
@@ -15,8 +15,4 @@ ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
 FILTER_OUT_DIRS		+= open_posix_testsuite
 endif
 
-ifneq ($(WITH_REALTIME_TESTSUITE),yes)
-FILTER_OUT_DIRS		+= realtime
-endif
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
