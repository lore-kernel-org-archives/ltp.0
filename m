Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051E3C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:35:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CB713C12C2
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:35:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42DC33C91BA
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:47 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B57411BB9056
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7CE121163;
 Thu,  6 Feb 2025 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7K0RA4oahXvmWqZqpIsaWuM+nuFi2SGyLZZCJBUp1k=;
 b=ixbi95K1Lc2HMQIFhLiD8DMoki7yiQLHREnruRTY1452SLGsEb148P2NdyVWaeTU1d1H1f
 Uu+noHOYa/51ZEYaNxFXpJZFkTS8TH8k8kK4sqXG242q09VdfmDok8r4BYPBsVafM3jKxO
 dG6ANfjpD73FpSwB+va1IO1J3jxETOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7K0RA4oahXvmWqZqpIsaWuM+nuFi2SGyLZZCJBUp1k=;
 b=BehjXXnwlA+Dpa4eOgwTcCBZvYrV/kKPNHwoVjYa6D19QlJOA0K7ffPndXtCI9s27Pq520
 tgid6sLqQGAENmCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7K0RA4oahXvmWqZqpIsaWuM+nuFi2SGyLZZCJBUp1k=;
 b=ixbi95K1Lc2HMQIFhLiD8DMoki7yiQLHREnruRTY1452SLGsEb148P2NdyVWaeTU1d1H1f
 Uu+noHOYa/51ZEYaNxFXpJZFkTS8TH8k8kK4sqXG242q09VdfmDok8r4BYPBsVafM3jKxO
 dG6ANfjpD73FpSwB+va1IO1J3jxETOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7K0RA4oahXvmWqZqpIsaWuM+nuFi2SGyLZZCJBUp1k=;
 b=BehjXXnwlA+Dpa4eOgwTcCBZvYrV/kKPNHwoVjYa6D19QlJOA0K7ffPndXtCI9s27Pq520
 tgid6sLqQGAENmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63E3B13694;
 Thu,  6 Feb 2025 14:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oOWUEoXIpGfvJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 14:34:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 15:34:16 +0100
Message-ID: <20250206143421.1571918-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206143421.1571918-1-pvorel@suse.cz>
References: <20250206143421.1571918-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/7] configure: Ignore --with-{bash,python} knobs
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

9e7f5688a7 disabled requiring python and bash for realtime. Previous
commit documented the dependencies, let's ignore the configure options.

Fixes: 9e7f5688a7 ("configure.ac: Fix --with* options")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac              | 14 ++------------
 include/mk/features.mk.in |  2 --
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6992d75ca3..afcbd1a5ef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,15 +253,10 @@ AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
 # Bash
 AC_ARG_WITH([bash],
   [AS_HELP_STRING([--with-bash],
-    [have the Bourne Again Shell interpreter])],
+    [unused, kept for compatibility reason])],
   [with_bash=$withval],
   [with_bash=no]
 )
-if test "x$with_bash" = xyes; then
-    AC_SUBST([WITH_BASH],["yes"])
-else
-    AC_SUBST([WITH_BASH],["no"])
-fi
 
 # metadata
 AC_ARG_ENABLE([metadata],
@@ -327,15 +322,10 @@ fi
 # Python
 AC_ARG_WITH([python],
   [AS_HELP_STRING([--with-python],
-    [have a python interpreter])],
+    [unused, kept for compatibility reason])],
   [with_python=$withval],
   [with_python=no]
 )
-if test "x$with_python" = xyes; then
-    AC_SUBST([WITH_PYTHON],["yes"])
-else
-    AC_SUBST([WITH_PYTHON],["no"])
-fi
 
 # TI RPC
 AC_ARG_WITH([tirpc],
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 2fc5230d49..0a8a405acf 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -25,8 +25,6 @@ WITH_EXPECT			:= @WITH_EXPECT@
 
 WITH_PERL			:= @WITH_PERL@
 
-WITH_PYTHON			:= @WITH_PYTHON@
-
 METADATA_GENERATOR		:= @METADATA_GENERATOR@
 WITH_METADATA			:= @WITH_METADATA@
 WITH_METADATA_HTML		:= @WITH_METADATA_HTML@
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
