Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBC3C4345F
	for <ltp@archiver.kernel.org>; Fri,  3 May 2024 15:40:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD9DC3CC67D
	for <ltp@archiver.kernel.org>; Fri,  3 May 2024 17:40:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3A1A3CC114
 for <ltp@lists.linux.it>; Fri,  3 May 2024 17:40:28 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21D38141CE76
 for <ltp@lists.linux.it>; Fri,  3 May 2024 17:40:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95FE6219BD;
 Fri,  3 May 2024 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714750826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSYWZqfAlTDCjlVRcce8EOt4fEfSz1mkavoZib3Ie7A=;
 b=vKq+JmGeoxaR/Jfe+YvTaHgaoB5l5QECIkjtNrXOgsGiR6Mvfbps8vlQurac0pgRhUpKdu
 NWXCpEv3KvkRkMOPxVa+Oq1QuCFM4mw52FyT+TwuVrTYpZFdEZ9CYqfgRY2pRLUkv0r+1R
 a5ecVJasEsf9LLtQVtpZtyHrl9nTvdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714750826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSYWZqfAlTDCjlVRcce8EOt4fEfSz1mkavoZib3Ie7A=;
 b=S7qD6Y3edMvWVwnUXuFEH3LNNhVKlQYxQM+g7G/pXut+9AABfdkLVlY31P4A6GhckilvKZ
 RdZwrxPc1/1m4qAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714750826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSYWZqfAlTDCjlVRcce8EOt4fEfSz1mkavoZib3Ie7A=;
 b=vKq+JmGeoxaR/Jfe+YvTaHgaoB5l5QECIkjtNrXOgsGiR6Mvfbps8vlQurac0pgRhUpKdu
 NWXCpEv3KvkRkMOPxVa+Oq1QuCFM4mw52FyT+TwuVrTYpZFdEZ9CYqfgRY2pRLUkv0r+1R
 a5ecVJasEsf9LLtQVtpZtyHrl9nTvdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714750826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSYWZqfAlTDCjlVRcce8EOt4fEfSz1mkavoZib3Ie7A=;
 b=S7qD6Y3edMvWVwnUXuFEH3LNNhVKlQYxQM+g7G/pXut+9AABfdkLVlY31P4A6GhckilvKZ
 RdZwrxPc1/1m4qAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F1C139CB;
 Fri,  3 May 2024 15:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PNjMHmoFNWauMAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 03 May 2024 15:40:26 +0000
Date: Fri, 3 May 2024 17:39:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZjUFORqe8TF3WNyc@yuki>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-2.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TAGGED_RCPT(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,linux-m68k.org,gmail.com,landley.net,physik.fu-berlin.de,lists.linux-m68k.org,vger.kernel.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/31] Remove UCLINUX (nommu support) from LTP
 legacy C API
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
Cc: Giovanni Lostumbo <giovanni.lostumbo@gmail.com>,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with a one patch on the top that removed the configure check for
UCLINUX:

Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Fri May 3 17:23:44 2024 +0200

    m4: Remove now unused ltp-nommu-linux.m4

    Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

diff --git a/configure.ac b/configure.ac
index 15a5847fa..638a64bc9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -385,7 +385,6 @@ LTP_CHECK_KERNEL_DEVEL
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
-       AC_CHECK_FUNCS([fork daemon vfork])
-       UCLINUX=0
-       if test "x$ac_cv_func_fork" = "xno" ; then
-               UCLINUX=1
-               AC_DEFINE([UCLINUX], 1, [Target is running Linux w/out an MMU])
-       fi
-       AC_SUBST(UCLINUX)
-])


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
