Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2932C87FD3
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 11:01:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5662C3CA699
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 13:01:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3455C3CA3C9
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 13:01:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8EC4E14002D5
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 13:01:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15E9022DC6;
 Fri,  8 Aug 2025 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RanPnYaiFfoHzRPoBzQaKOzU8ZpJBUrlqTEWaxQcdRA=;
 b=bIPe2VogDYl0KcCCzT6+aZDbrdJN7EJ2D7PjpF8f8wcX9EdoEWBpskWCp3ametsmvscUGa
 Bv8l9Zn3/a7g5JsxoIHAxNWtKf4LBFrqLOQ1KLLGWq/E4BtlrVsajQfOs019MIjTPSzmhO
 Enu/AfYgqbwfD6K7gfM7Lv8RS0MNUiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RanPnYaiFfoHzRPoBzQaKOzU8ZpJBUrlqTEWaxQcdRA=;
 b=kIKzKHAw/Zuil9BU3NgRnmP6mnxi3XLSKhJrQNyTnhmorYmSGAK7gre6Mo4en73kwC/CWL
 HqWOrDZUtprau5Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RanPnYaiFfoHzRPoBzQaKOzU8ZpJBUrlqTEWaxQcdRA=;
 b=bIPe2VogDYl0KcCCzT6+aZDbrdJN7EJ2D7PjpF8f8wcX9EdoEWBpskWCp3ametsmvscUGa
 Bv8l9Zn3/a7g5JsxoIHAxNWtKf4LBFrqLOQ1KLLGWq/E4BtlrVsajQfOs019MIjTPSzmhO
 Enu/AfYgqbwfD6K7gfM7Lv8RS0MNUiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RanPnYaiFfoHzRPoBzQaKOzU8ZpJBUrlqTEWaxQcdRA=;
 b=kIKzKHAw/Zuil9BU3NgRnmP6mnxi3XLSKhJrQNyTnhmorYmSGAK7gre6Mo4en73kwC/CWL
 HqWOrDZUtprau5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD0613AFB;
 Fri,  8 Aug 2025 11:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IFWsM/LYlWgHcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 11:01:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 13:01:01 +0200
Message-ID: <20250808110102.454689-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808110102.454689-1-pvorel@suse.cz>
References: <20250808110102.454689-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] m4: lapi: Drop check for old libcap-devel
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

Upstream fix [1] was released in libcap-2.17 released in 2009.
Even old SLES12 we still use for testing has newer libcap,
we can remove the check.

[1] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=012bca3265ed0d84b57531919a390645052d810e

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Fix compilation error missing endif
 include/lapi/capability.h |  8 --------

 m4/ltp-cap.m4             | 17 +----------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 14d2d3c12c..d3cc121fc1 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -10,14 +10,6 @@
 
 #ifdef HAVE_SYS_CAPABILITY_H
 # include <sys/capability.h>
-/**
- * Some old libcap-devel(1.96~2.16) define _LINUX_TYPES_H in
- * sys/capability.h that makes ltp-lib cann't include linux/types.h
- * essentially. Here undefine it if include such old header-file.
- */
-# ifndef HAVE_NEWER_LIBCAP
-#  undef _LINUX_TYPES_H
-# endif
 #endif
 
 #ifndef CAP_NET_BIND_SERVICE
diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index 4981e843da..6b26e7d15c 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -1,6 +1,6 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) Cisco Systems Inc., 2009
-dnl Copyright (c) Linux Test Project, 2019
+dnl Copyright (c) Linux Test Project, 2019-2025
 dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
 
 AC_DEFUN([LTP_CHECK_CAPABILITY_SUPPORT],[
@@ -14,19 +14,4 @@ if test "x$cap_libs" != x; then
 	AC_DEFINE(HAVE_LIBCAP)
 fi
 AC_SUBST(CAP_LIBS,$cap_libs)
-
-AH_TEMPLATE(HAVE_NEWER_LIBCAP,
-[Define to 1 if you have newer libcap-2 installed.])
-AC_COMPILE_IFELSE([AC_LANG_SOURCE([
-#include <sys/capability.h>
-#include <linux/types.h>
-int main(void) {
-	__u16 a;
-	__u32 b;
-	return 0;
-}])],[has_newer_libcap="yes"])
-
-if test "x$has_newer_libcap" = xyes; then
-	AC_DEFINE(HAVE_NEWER_LIBCAP)
-fi
 ])
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
