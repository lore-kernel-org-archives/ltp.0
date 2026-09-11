Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A64C88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 19:52:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 453073EA332
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 21:52:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38ECF3E925C
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 21:51:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D2746007AC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 21:51:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A878021BA8;
 Fri, 11 Sep 2026 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789156306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3BOg2eJdm8l6I98O59unvBjgYlTn9AyTmiOlDk73WQc=;
 b=UeoEerwz8Qa2Gv5cyO2xVlFDbhRmAWq/Du+xkQ3gJqMeC5IKMGNGC6hYOmRFgd0YTmx1BL
 cM7tIfViFiJUbCkUj6tS1Mv0iSsUuU62gA8LdBH/jmo96dD58xktQNoz2AUIu+AFaRSd5g
 0i4Mw1JYKy5A08j0DIPP+5y71nz2OVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789156306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3BOg2eJdm8l6I98O59unvBjgYlTn9AyTmiOlDk73WQc=;
 b=icac/J4lb5gPt+HdZu8gEzsPKQEJmLJgbsOeaVM+Yip2IT+hAmwcbCg8hVQHn2SkIuh3Lt
 uTyEixC8yhkx7DBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SwQLRbHI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4zxeoiYt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789156302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3BOg2eJdm8l6I98O59unvBjgYlTn9AyTmiOlDk73WQc=;
 b=SwQLRbHIx8Qko/2VUM9r6HyAoFCXR4udyUS7o5FqpzAp/zi2Al2NGYS2z/RB6+dCl5nXga
 UUUZfyChDvy6yFF+Co/ZeCeQEzQTYx3AB34inuiyhfLuXqori/ODcIC1mzfZo2Xprw7ogc
 XBbzNHyjmdDVmnkDqTx1ah6f60lr3Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789156302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3BOg2eJdm8l6I98O59unvBjgYlTn9AyTmiOlDk73WQc=;
 b=4zxeoiYt/ZlyPqjLB9HIvEyFikEEBoJn5pNvZTqNXrxeMZR+BmowN4BCBfUOy64KghKBVw
 SqfiLm3d9uvFtgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AB15132D3;
 Fri, 11 Sep 2026 19:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBIyFc1bpGoFRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 19:51:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Sep 2026 21:51:33 +0200
Message-ID: <20260911195133.278281-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: A878021BA8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email, suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] include: Restore kerneldoc for tst_cmd() and
 TST_CAP()
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

This partly reverts ef4c5c61f8. We want to have the doc included,
because both the structure and the function is documented properly
there. We need to use c:func: and c:type: in references, but that's ok.

Fixes: ef4c5c61f8 ("include: Fix kernel-doc warnings in header comments")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Andrea, Cyril,

we agreed to have this functionality [1] but in the end you merged it
with it. Hence I'd like to revert back this part.

Best option would be, of course to rename the tst_cap struct.

tst_cmd() is indeed defined 2x in include/tst_cmd.h, due different args.
That could be solvable by moving legacy API definition into tso_cmd.h
which would import tst_cmd.h and itself be included only by test.h.
A bit impractical but should work. Other option is to find a way how to
tell sphinx to ignore the other definition.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/ah6csOP7O9R0L2hO@yuki.lan/

 include/tst_capability.h | 2 +-
 include/tst_cmd.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tst_capability.h b/include/tst_capability.h
index c38dcf3534..2e9a4dc55e 100644
--- a/include/tst_capability.h
+++ b/include/tst_capability.h
@@ -69,7 +69,7 @@ struct tst_cap {
 	char *name;
 };
 
-/*
+/**
  * TST_CAP() - Create a struct tst_cap entry.
  *
  * @action: What should we do, i.e. drop or add capability.
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 4829d0aed8..36d8751a2d 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -19,7 +19,7 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
-/*
+/**
  * struct tst_cmd - Provides details about a command struct needed by LTP test.
  * @cmd: The name of the command.
  * @optional: A flag indicating if the command is optional.
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
