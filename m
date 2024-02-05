Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299A2C48292
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 18:13:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDEB93CF6FC
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 19:13:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B6D3CC69F
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 19:13:09 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F17111400FB6
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 19:13:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65F021F8D6;
 Mon,  5 Feb 2024 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707156787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qzBU5Mr1h89EEE6S69Fkc6j7It8x6cDuwoq1AkVw6mQ=;
 b=MIKtE6/hQ7YCnBR2j/k4Ye7xPaI+Em0jPNvkOrMSsWYdaCtQ7QVAXjg8COKJT9Xa5M/2oK
 VDzxZWwpr/1RXEgDw6Ixkcj+gWuVO5g/IaprJKCaTdloe6zM8qqFAQ3x+2tgvbwuwV1SAT
 H1mFoWVk6YoZN3wwq2zS2KZymMCbuuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707156787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qzBU5Mr1h89EEE6S69Fkc6j7It8x6cDuwoq1AkVw6mQ=;
 b=A+FQxjhRCox5CxMnY0NC1Wgm8R2CKku4syqfs3DbO0PUUOmxc6xMk2x2tehcumlH2iRf5/
 HhygbFf3VlzCj0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707156787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qzBU5Mr1h89EEE6S69Fkc6j7It8x6cDuwoq1AkVw6mQ=;
 b=MIKtE6/hQ7YCnBR2j/k4Ye7xPaI+Em0jPNvkOrMSsWYdaCtQ7QVAXjg8COKJT9Xa5M/2oK
 VDzxZWwpr/1RXEgDw6Ixkcj+gWuVO5g/IaprJKCaTdloe6zM8qqFAQ3x+2tgvbwuwV1SAT
 H1mFoWVk6YoZN3wwq2zS2KZymMCbuuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707156787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qzBU5Mr1h89EEE6S69Fkc6j7It8x6cDuwoq1AkVw6mQ=;
 b=A+FQxjhRCox5CxMnY0NC1Wgm8R2CKku4syqfs3DbO0PUUOmxc6xMk2x2tehcumlH2iRf5/
 HhygbFf3VlzCj0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11AD5136F5;
 Mon,  5 Feb 2024 18:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sQbmOjIlwWVEKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 18:13:06 +0000
Date: Mon, 5 Feb 2024 19:13:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <20240205181304.GC218023@pevik>
References: <20240130162813.20278-1-mdoucha@suse.cz>
 <20240205173452.GB218023@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205173452.GB218023@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="MIKtE6/h";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A+FQxjhR
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 65F021F8D6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid01: Test all standard deadly signals
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Martin,

> first this change (merged as ed5ccf6c1 ("waitpid01: Test all standard deadly
> signals") is failing on 6.6 on Debian:

> ed5ccf6c1 ("waitpid01: Test all standard deadly signals")

> waitpid01.c:88: TINFO: Testing child: raise(sig)
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236064
> waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> waitpid01.c:126: TPASS: WTERMSIG() == SIGIOT/SIGABRT
> waitpid01.c:143: TPASS: Child dumped core as expected
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236071
> waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> waitpid01.c:126: TPASS: WTERMSIG() == SIGALRM
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236072
> waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> waitpid01.c:126: TPASS: WTERMSIG() == SIGBUS
> waitpid01.c:143: TPASS: Child dumped core as expected
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236082
> waitpid01.c:113: TFAIL: WIFSIGNALED() not set in status (exited with 0)
=> FYI it's SIGFPE (it would help readability to either print tst_strsig(sig)
for each failure or as TINFO before testing).

I tested other Debian (5.10 and 6.1) and they work, I wonder what is the
problem.

Kind regards,
Petr

> ...
> waitpid01.c:88: TINFO: Testing child: kill(getpid(), sig)
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236165
> waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> waitpid01.c:126: TPASS: WTERMSIG() == SIGIOT/SIGABRT
> waitpid01.c:143: TPASS: Child dumped core as expected
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236176
> waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> waitpid01.c:126: TPASS: WTERMSIG() == SIGALRM
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236177
> waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> waitpid01.c:126: TPASS: WTERMSIG() == SIGBUS
> waitpid01.c:143: TPASS: Child dumped core as expected
> waitpid01.c:109: TPASS: waitpid() returned correct pid 236187
> waitpid01.c:113: TFAIL: WIFSIGNALED() not set in status (exited with 0)
> ...

> But it works on 6.8.0-rc1-2.gf4ba5db-default Tumbleweed, which I tested it
> before.

> Also patch does not apply. I had to patch waitpid01 myself, hopefully I did that
> correctly [1].

> Kind regards,
> Petr

> [1] https://github.com/pevik/ltp/blob/mdoucha/waitpid05/testcases/kernel/syscalls/waitpid/waitpid01.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
