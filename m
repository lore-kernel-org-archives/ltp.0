Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ECDFB44A6
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 06:06:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6916E3E4A71
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 08:06:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E9853E2571
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:05:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 972A260010A
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:05:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC7736A866;
 Fri, 24 Apr 2026 06:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777010747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+a6r7NZVkRCp9bkYHtRUVZFDQBHBnqwQSO1GjswVxU=;
 b=n7is2gV2xxU4d8mwj++lQpsJUzpsXxTK2e629bba5UeTtpdL1JBob9r92vMeyfxaaRY706
 dlwFw7zuorDs3JuVy4RUpJYDtvg40DJBSh/7ZENo+eTDAd6TxaVHCFXPJgr9ght99AaTJA
 hhQH82Nhlhp+hQeEOYgZT4RDCVuUslY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777010747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+a6r7NZVkRCp9bkYHtRUVZFDQBHBnqwQSO1GjswVxU=;
 b=Sy4/Tl1mxZqOR867vFkXSD+l3TGsLtEEWrvhlmyg9GlVzggRps99v8WZvha1RApbGyjZNl
 y3g9/Vmer5nv1JBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777010746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+a6r7NZVkRCp9bkYHtRUVZFDQBHBnqwQSO1GjswVxU=;
 b=sggjp0/KWRLX8UEBwigV1du9vlBPG/T0LjCeZzKrL5iStnHoXu7CUxNpnd0JrHJ3z8nazt
 R8facjtZRbsWjVkeR3nOhLG/876+gZoRZZhvjYIbuS0gXI2OtGmIvda5+F88cWZLh1mzPd
 CGPcFjhTnHyzOCs+Up+YreN4/CSVAL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777010746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+a6r7NZVkRCp9bkYHtRUVZFDQBHBnqwQSO1GjswVxU=;
 b=9XYBfFCScA7ZBeKCTE9AIEHNdJpDr2nIr3rsuAfLfEdkK464qFaVO7f60mbozBaqczhBY2
 1Ez3RLR8WH+svCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9A0A593AE;
 Fri, 24 Apr 2026 06:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5OspKDoI62nWdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 06:05:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 08:05:43 +0200
Message-ID: <20260424060543.462475-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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

Kernel commit ab89060fbc92e ("pidfs: return -EREMOTE when PIDFD_GET_INFO
is called on another ns") from v7.0 was backported into stable/LTS
kernels v6.18.14 (7446125afb6d9) and v6.19.10 (2920abaf56c09).

Reported-by: Wei Gao <wegao@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 0f24d4741f..cc66d54cf4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -54,7 +54,7 @@ static void setup(void)
 	if (!ioctl_pidfd_info_exit_supported())
 		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
 
-	if (tst_kvercmp(7, 0, 0) >= 0)
+	if (tst_kvercmp(6, 18, 14) >= 0)
 		err_nr = EREMOTE;
 }
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
