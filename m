Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5ECC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256C93CF842
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:31:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D5763C0333
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:31 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C9B45208E0C
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7A515CD1B;
 Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ+LMX+tgNmKeY60cpK7W4k9yvVxMxPf8hvsxdOrulk=;
 b=P/DOotjj2I79g9hku2bZPeP3eGMW32RcdEvitCAjUV2SK2Sxx2Ng3LBVxjVq9AOWMm7Gwr
 uGYv5neC32yuwUONoaRuk0rKpKHkg7CCOyzKfhpJctCJsUNXqO3A3l+RPLJD+/84LHTBAP
 M206Lbhek+vSb9VV+GBCfk2bsYfgrGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ+LMX+tgNmKeY60cpK7W4k9yvVxMxPf8hvsxdOrulk=;
 b=928ALzLULEbGSS6Bmwmna4BlHlM/aQyvKi+tT1YzlOWTZB3YfX+FiCjWX+N5d5v5VzKsyo
 9tnNx2+ohLAGryDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="P/DOotjj";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=928ALzLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ+LMX+tgNmKeY60cpK7W4k9yvVxMxPf8hvsxdOrulk=;
 b=P/DOotjj2I79g9hku2bZPeP3eGMW32RcdEvitCAjUV2SK2Sxx2Ng3LBVxjVq9AOWMm7Gwr
 uGYv5neC32yuwUONoaRuk0rKpKHkg7CCOyzKfhpJctCJsUNXqO3A3l+RPLJD+/84LHTBAP
 M206Lbhek+vSb9VV+GBCfk2bsYfgrGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ+LMX+tgNmKeY60cpK7W4k9yvVxMxPf8hvsxdOrulk=;
 b=928ALzLULEbGSS6Bmwmna4BlHlM/aQyvKi+tT1YzlOWTZB3YfX+FiCjWX+N5d5v5VzKsyo
 9tnNx2+ohLAGryDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E4401386E;
 Thu, 11 Apr 2024 14:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YN+kIAX0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:29:55 +0200
Message-ID: <20240411143025.352507-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.83 / 50.00]; BAYES_HAM(-1.82)[93.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A7A515CD1B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/31] m4: Remove UCLINUX (nommu detection)
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

nommu detection was written for UCLINUX distribution, which is not
active any more.  While there are still some used nommu kernel
architectures (m68k and other), there is missing support in the new
C API and nobody from the community did not stand to implement and
maintain it. Therefore removing all UCLINUX/nommu related code in this
and following commits.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac          |  1 -
 m4/ltp-nommu-linux.m4 | 14 --------------
 2 files changed, 15 deletions(-)
 delete mode 100644 m4/ltp-nommu-linux.m4

diff --git a/configure.ac b/configure.ac
index 1d7e862d8..1d7e7628f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -384,7 +384,6 @@ LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
 LTP_CHECK_LINUXRANDOM
-LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_SELINUX
 LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_SYSCALL_EVENTFD
diff --git a/m4/ltp-nommu-linux.m4 b/m4/ltp-nommu-linux.m4
deleted file mode 100644
index 7471ddd06..000000000
--- a/m4/ltp-nommu-linux.m4
+++ /dev/null
@@ -1,14 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2010
-dnl Author: Mike Frysinger <vapier@gentoo.org>
-
-AC_DEFUN([LTP_CHECK_NOMMU_LINUX],
-[
-	AC_CHECK_FUNCS([fork daemon vfork])
-	UCLINUX=0
-	if test "x$ac_cv_func_fork" = "xno" ; then
-		UCLINUX=1
-		AC_DEFINE([UCLINUX], 1, [Target is running Linux w/out an MMU])
-	fi
-	AC_SUBST(UCLINUX)
-])
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
