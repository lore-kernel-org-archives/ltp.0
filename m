Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E19E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 20:22:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF0253E90C9
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 21:22:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E0943E6553
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 21:22:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 916F6101AEA7
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 21:22:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3514321171;
 Tue, 10 Dec 2024 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733862153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scZA+vcM61c0A4kzISx7FRkBkgDLEA++QsZj3TcWX/g=;
 b=XHqItByu75+maOpaqnUDB3aXdptNoZmTeapYGhUckOuQCUza2XNfSefyvteqxtWIYYt/9l
 jANYdb9VTpErP1cNvjtNxtkwL7mZsHpKf4Os3BZYjy8+8kaOSDqE/BJCYStH5HyW/rMw20
 dN+AVRv3+E4I9+Q3Z80vuzJayDWmDYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733862153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scZA+vcM61c0A4kzISx7FRkBkgDLEA++QsZj3TcWX/g=;
 b=o4KBmAOyBAhUO12ZqIHeq2iSnPwzN+f4zv707BTXiJ9O0L8UfWhtSBxKLMyFvMfAGsdlnH
 zzYLrYDgzaOGtpDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733862153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scZA+vcM61c0A4kzISx7FRkBkgDLEA++QsZj3TcWX/g=;
 b=XHqItByu75+maOpaqnUDB3aXdptNoZmTeapYGhUckOuQCUza2XNfSefyvteqxtWIYYt/9l
 jANYdb9VTpErP1cNvjtNxtkwL7mZsHpKf4Os3BZYjy8+8kaOSDqE/BJCYStH5HyW/rMw20
 dN+AVRv3+E4I9+Q3Z80vuzJayDWmDYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733862153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scZA+vcM61c0A4kzISx7FRkBkgDLEA++QsZj3TcWX/g=;
 b=o4KBmAOyBAhUO12ZqIHeq2iSnPwzN+f4zv707BTXiJ9O0L8UfWhtSBxKLMyFvMfAGsdlnH
 zzYLrYDgzaOGtpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5A3C13A15;
 Tue, 10 Dec 2024 20:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nFpXLQijWGfuAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 20:22:32 +0000
Date: Tue, 10 Dec 2024 21:22:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241210202231.GA349775@pevik>
References: <20241210-fix_input_suite-v1-1-f8bb1d80d2fc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241210-fix_input_suite-v1-1-f8bb1d80d2fc@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Verify virtual device availability
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

Hi Andrea,

...
>  static void setup(void)
>  {
>  	fd_send = open_uinput();
> +	if (fd_send == -1)
> +		tst_brk(TCONF, "Virtual device is not available");

Thinking about it twice, how about renaming the function safe_open_uinput()
and add tst_brk(TCONF, ...) there?

Function is not used in library where tst_brk(TCONF, ...) would be problematic,
therefore I would not even bother with having SAFE_OPEN_UINPUT() which would
evaluate open_uinput().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
