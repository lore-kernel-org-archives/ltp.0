Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E9CCCD19F
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 15:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19F633CEEB2
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 17:41:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9781E3CEB19
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 17:41:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E32A60073F
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 17:41:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5724E21D44;
 Fri, 17 Oct 2025 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760715701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SszNK7wE8nu/2NsOVm20/gdBOkzy2CK4CwcTONwciss=;
 b=dZcGsLw1JT+dk83XKVwp9zVe4YMjt7QQbs6PllZnjjulFlzKtd9mMZvHzlo3c5miUQfb0m
 /MMKFofwEQS/6XmozVH7gwNKrgGL7lWe7tXLOu5WVJ/AH5igaIRg45+HoSZD3RaARiR4PR
 f4O63vAKSN2lP9eif01seC8lmMiWutE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760715701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SszNK7wE8nu/2NsOVm20/gdBOkzy2CK4CwcTONwciss=;
 b=OaRywRkj4HhiEOwSGJB88b/rksLKTYG49X+bE1OqBEMUUPh6JWmnh8wsiRAT/5AKCkeAPW
 BDKbBQ7gMcnYk9Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dZcGsLw1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OaRywRkj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760715701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SszNK7wE8nu/2NsOVm20/gdBOkzy2CK4CwcTONwciss=;
 b=dZcGsLw1JT+dk83XKVwp9zVe4YMjt7QQbs6PllZnjjulFlzKtd9mMZvHzlo3c5miUQfb0m
 /MMKFofwEQS/6XmozVH7gwNKrgGL7lWe7tXLOu5WVJ/AH5igaIRg45+HoSZD3RaARiR4PR
 f4O63vAKSN2lP9eif01seC8lmMiWutE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760715701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SszNK7wE8nu/2NsOVm20/gdBOkzy2CK4CwcTONwciss=;
 b=OaRywRkj4HhiEOwSGJB88b/rksLKTYG49X+bE1OqBEMUUPh6JWmnh8wsiRAT/5AKCkeAPW
 BDKbBQ7gMcnYk9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F114F136C6;
 Fri, 17 Oct 2025 15:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fg12ObRj8mg5IAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Oct 2025 15:41:40 +0000
Date: Fri, 17 Oct 2025 17:41:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251017154135.GD339521@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-4-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017101011.3811-4-wegao@suse.com>
X-Rspamd-Queue-Id: 5724E21D44
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] tst_run_shell.c: Add new function handle
 new needs_cmds
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

Hi Wei,

>  testcases/lib/tst_run_shell.c | 61 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)

Also here, any change you would add a test for a new feature (as a separate
commit in e.g. testcases/lib/tests/shell_loader_cmd.sh).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
