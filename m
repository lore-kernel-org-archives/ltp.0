Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E95CC3DA7F
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 11:02:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A83223D1C9F
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 13:02:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 729263CF2B4
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 13:02:00 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A80C61BC66FD
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 13:01:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27AD91F8A4;
 Fri, 26 Jul 2024 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721991718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nriEdu+CLnrS79UuTnnRkeBKgqpGsbvykPZEXsnYcvQ=;
 b=3G6o63T0AXJjMnoPtNYnpiba1gUNmj6WRO4QHMuj2dvyTxdGOGQtz3mo3c09VC4iURnPWs
 NtCL31waq7YDeozxZsrkiVwm51uPTjqlgqUUfpnsn019lhZfTdE6ZLee9JN3kAui300reg
 IsTpLSRMqee/APHoDJiER27PjsXcxzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721991718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nriEdu+CLnrS79UuTnnRkeBKgqpGsbvykPZEXsnYcvQ=;
 b=VHwzZ1uKe/2j3vn6j7+kbZj3Hqt6zzK9s2PZwErWv+TPmOdGZbdDHlXqn9QZp8InL48N4m
 uHbAVlSJnflAiiDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3G6o63T0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VHwzZ1uK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721991718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nriEdu+CLnrS79UuTnnRkeBKgqpGsbvykPZEXsnYcvQ=;
 b=3G6o63T0AXJjMnoPtNYnpiba1gUNmj6WRO4QHMuj2dvyTxdGOGQtz3mo3c09VC4iURnPWs
 NtCL31waq7YDeozxZsrkiVwm51uPTjqlgqUUfpnsn019lhZfTdE6ZLee9JN3kAui300reg
 IsTpLSRMqee/APHoDJiER27PjsXcxzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721991718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nriEdu+CLnrS79UuTnnRkeBKgqpGsbvykPZEXsnYcvQ=;
 b=VHwzZ1uKe/2j3vn6j7+kbZj3Hqt6zzK9s2PZwErWv+TPmOdGZbdDHlXqn9QZp8InL48N4m
 uHbAVlSJnflAiiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0881A138A7;
 Fri, 26 Jul 2024 11:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPiMACWCo2ZQYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 11:01:57 +0000
Date: Fri, 26 Jul 2024 13:01:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240726110139.GC1062794@pevik>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-1-66f5a1c0c693@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240725-landlock-v4-1-66f5a1c0c693@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 27AD91F8A4
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/5] Add landlock03 test
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: mic@digikod.net, gnoack@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> +static struct tst_cap dropadmin = {
> +	.action = TST_CAP_DROP,
> +	.id = CAP_SYS_ADMIN,
> +	.name = "CAP_SYS_ADMIN",
> +};
> +
> +static struct tst_cap needadmin = {
> +	.action = TST_CAP_REQ,
> +	.id = CAP_SYS_ADMIN,
> +	.name = "CAP_SYS_ADMIN",
> +};

I dared to merge this with very minor change:

+++ testcases/kernel/syscalls/landlock/landlock03.c
@@ -26,16 +26,15 @@ static int ruleset_fd = -1;
 static int ruleset_invalid = -1;
 static int file_fd = -1;
 
+#define ID_NAME(x) .id = x, .name = #x
 static struct tst_cap dropadmin = {
 	.action = TST_CAP_DROP,
-	.id = CAP_SYS_ADMIN,
-	.name = "CAP_SYS_ADMIN",
+	ID_NAME(CAP_SYS_ADMIN),
 };
 
 static struct tst_cap needadmin = {
 	.action = TST_CAP_REQ,
-	.id = CAP_SYS_ADMIN,
-	.name = "CAP_SYS_ADMIN",
+	ID_NAME(CAP_SYS_ADMIN),
 };
 
 static struct tcase {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
