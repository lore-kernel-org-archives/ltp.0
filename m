Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEEAD3B98B
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 13:08:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB2683DB156
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 14:08:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 967703DB051
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 14:07:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA7AC6637CB
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 14:07:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77ADB1F74C;
 Tue, 26 Nov 2024 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732626470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOXJ98XfkbUOjEtfVlGGRas/yyUEr9DDl7LEyypw9lM=;
 b=EjgL9nT+YoCl6tPfJfSuUJ1pny4h4j9yy+0agbbjuMviQcVU6c7E1iyTxoaHffBQfWt1Si
 wgyJtycIDyZN5P8z6USMe0Q3jI5xoXWYtlTDkKZ0FV3lAmZdskYl1VqVgaKLcub/f1i6S7
 zD9N7Xea2U9mvBP90GGlXGBGKuprCY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732626470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOXJ98XfkbUOjEtfVlGGRas/yyUEr9DDl7LEyypw9lM=;
 b=vXIplmic9bbo7fgZZlyGGbRqOvhmfEqWv6M3ChnGjt18fxcXExfdXS1SRePrCx2lSx9i49
 TcjgQVC9j3eVxNCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732626469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOXJ98XfkbUOjEtfVlGGRas/yyUEr9DDl7LEyypw9lM=;
 b=fvIVVTZwm0Ifn0wnURs9lnZl0LDW/vw1W0n9n1LsNQHuebBDtl1ziMmfDEhR0Ek7sC0rmY
 FrNP3+6V5H6GAe0jtQMqT95ohZRi22mx6b5inCBsnBS1S7SSmgMz1Yq9AVn08ggit53XNV
 J7iSrASGzAnL1IOICO6pbxb0n7+qoO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732626469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOXJ98XfkbUOjEtfVlGGRas/yyUEr9DDl7LEyypw9lM=;
 b=3nYg4xynx5XpFGo7dcCKU3GCe+vEcO+dbmpw7TQuKPCZUJ4yQgmElmffZQBDcTikUgIGOJ
 4YNEAlRCzF94dkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E3613890;
 Tue, 26 Nov 2024 13:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 78zUNCTIRWe4XAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 13:07:48 +0000
Date: Tue, 26 Nov 2024 14:07:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241126130746.GC50810@pevik>
References: <20241114172911.362197-1-pvorel@suse.cz>
 <Z0W4DaEQVbqNwz_2@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z0W4DaEQVbqNwz_2@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl01: Workaround segfault on ppc64le
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> Looks good.

Thanks! I'm going to merge with this change below (using exit(0) instead of
_exit(0).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/ioctl/ioctl01.c testcases/kernel/syscalls/ioctl/ioctl01.c
index e4f32330d0..d7886f3586 100644
--- testcases/kernel/syscalls/ioctl/ioctl01.c
+++ testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -73,7 +73,7 @@ static void test_bad_addr(unsigned int i)
 	pid = SAFE_FORK();
 	if (!pid) {
 		verify_ioctl(i);
-		_exit(0);
+		exit(0);
 	}
 
 	SAFE_WAITPID(pid, &status, 0);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
