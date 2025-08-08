Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD346C87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 11:01:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E5FC3CA4CE
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 13:01:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9B13C133E
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 13:01:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D359C200B23
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 13:01:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D52075BDBD;
 Fri,  8 Aug 2025 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/wPkWUslM3Kp+wuJp8cK6dMTiKAYduC/jtHLy2SPMA=;
 b=SfLk4FgGTk4fjDrJHWJZD4d5pES4Bel8EvvQy3y8fvg0thhSI4SRCitz/H8E5d8u1lJxxD
 vmRnqrFTauzAcCVBLXjA/neUYBuj7pCG9VBUyX2L3RuvpSk97OQErofx6nAGsXyvwdITwR
 ex+2KV30qmVkFcoLON31+itnbiH+Cb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/wPkWUslM3Kp+wuJp8cK6dMTiKAYduC/jtHLy2SPMA=;
 b=fzabR79VyoX0/CG96+rKP8ir8Y/2iM/t7yTGEdEfyo03LqdKMSY0A+2lEoPR5SqhDS0qd6
 IyekykqlWxmgTgDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/wPkWUslM3Kp+wuJp8cK6dMTiKAYduC/jtHLy2SPMA=;
 b=SfLk4FgGTk4fjDrJHWJZD4d5pES4Bel8EvvQy3y8fvg0thhSI4SRCitz/H8E5d8u1lJxxD
 vmRnqrFTauzAcCVBLXjA/neUYBuj7pCG9VBUyX2L3RuvpSk97OQErofx6nAGsXyvwdITwR
 ex+2KV30qmVkFcoLON31+itnbiH+Cb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/wPkWUslM3Kp+wuJp8cK6dMTiKAYduC/jtHLy2SPMA=;
 b=fzabR79VyoX0/CG96+rKP8ir8Y/2iM/t7yTGEdEfyo03LqdKMSY0A+2lEoPR5SqhDS0qd6
 IyekykqlWxmgTgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6AE913AB9;
 Fri,  8 Aug 2025 11:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +EejJvLYlWgHcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 11:01:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 13:01:00 +0200
Message-ID: <20250808110102.454689-2-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] Remove m4/ltp-signalfd.m4
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

HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO autotols check was used only in
testcases/kernel/syscalls/signalfd/signalfd01.c before it got rewritten
to the new API in a569202b6e.

Fixes: a569202b6e ("signalfd01: Refactor old case with new API")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac       |  1 -
 m4/ltp-signalfd.m4 | 17 -----------------
 2 files changed, 18 deletions(-)
 delete mode 100644 m4/ltp-signalfd.m4

diff --git a/configure.ac b/configure.ac
index db41175bf2..5362aaf1bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -414,7 +414,6 @@ fi
 AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
 
 
-LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
diff --git a/m4/ltp-signalfd.m4 b/m4/ltp-signalfd.m4
deleted file mode 100644
index 5aac395bd7..0000000000
--- a/m4/ltp-signalfd.m4
+++ /dev/null
@@ -1,17 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Red Hat Inc., 2008
-dnl Copyright (c) 2019 Fujitsu Ltd.
-dnl Author: Masatake YAMATO <yamato@redhat.com>
-
-AC_DEFUN([LTP_CHECK_SYSCALL_SIGNALFD],[
-
-AC_CHECK_FUNCS(signalfd,,)
-AC_CHECK_HEADERS([sys/signalfd.h],,)
-AC_CHECK_HEADERS([linux/signalfd.h],,)
-AC_CHECK_MEMBERS([struct signalfd_siginfo.ssi_signo],,,[
-#if defined HAVE_SYS_SIGNALFD_H
-#include <sys/signalfd.h>
-#elif defined HAVE_LINUX_SIGNALFD_H
-#include <linux/signalfd.h>
-#endif])
-])
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
