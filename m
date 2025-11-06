Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96662CCF9F8
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:35:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5E8F3CEDA2
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:35:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296C53CED74
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8737A6006CD
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 776BF211F1;
 Thu,  6 Nov 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIzgt26MsIhEPt62jT3wT5N/OQfRrN9a8UXaeBSxA54=;
 b=qXqiz9v7T0ehYu2T8KFFBDEFwKDSIRzfTZRdjdXWP3/zVm33SFnD9j/gyRyqhb0RuNkYsi
 J4dFLezwsXKrgzxDrydil1KEyD8r88NnWlUGccwKywTDPOTm1WVF/9I/7OPIRm2xgODhTH
 xk3ef15Rc8Py2ypmb6d7IVNtrFOwZ34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIzgt26MsIhEPt62jT3wT5N/OQfRrN9a8UXaeBSxA54=;
 b=Pt4Y9YBUD3tI9/B+Nbt4bYva7+Ttyg92tbDAwkEm+HpTh7qDDQPhe8jMZutxar2hTC2ARX
 /+qJBUdCI84d5sBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIzgt26MsIhEPt62jT3wT5N/OQfRrN9a8UXaeBSxA54=;
 b=qXqiz9v7T0ehYu2T8KFFBDEFwKDSIRzfTZRdjdXWP3/zVm33SFnD9j/gyRyqhb0RuNkYsi
 J4dFLezwsXKrgzxDrydil1KEyD8r88NnWlUGccwKywTDPOTm1WVF/9I/7OPIRm2xgODhTH
 xk3ef15Rc8Py2ypmb6d7IVNtrFOwZ34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIzgt26MsIhEPt62jT3wT5N/OQfRrN9a8UXaeBSxA54=;
 b=Pt4Y9YBUD3tI9/B+Nbt4bYva7+Ttyg92tbDAwkEm+HpTh7qDDQPhe8jMZutxar2hTC2ARX
 /+qJBUdCI84d5sBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0C8713A4B;
 Thu,  6 Nov 2025 16:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4H0jMznODGkHRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:35:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Nov 2025 17:34:56 +0100
Message-ID: <20251106163500.1063704-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106163500.1063704-1-pvorel@suse.cz>
References: <20251106163500.1063704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] swapon03: Don't create swap file twice
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

MAKE_SMALL_SWAPFILE(TEST_FILE) call is not needed, because the file is
created by is_swap_supported(TEST_FILE) call.

Fixes: c240726a62 ("libswap: Use {SAFE_,}MAKE_MINIMAL_SWAPFILE()")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 testcases/kernel/syscalls/swapon/swapon03.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index d6445d5fc4..01a3b6d8ac 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -61,7 +61,6 @@ static int setup_swap(void)
 		tst_brk(TFAIL, "Failed to setup swap files");
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-	MAKE_SMALL_SWAPFILE(TEST_FILE);
 
 	return 0;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
