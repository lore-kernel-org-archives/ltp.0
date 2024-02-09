Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C65C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 23:06:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC573CF4F6
	for <ltp@archiver.kernel.org>; Sat, 10 Feb 2024 00:06:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90AAC3CB1BF
 for <ltp@lists.linux.it>; Sat, 10 Feb 2024 00:06:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 43D601A00E40
 for <ltp@lists.linux.it>; Sat, 10 Feb 2024 00:06:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 279911F83E;
 Fri,  9 Feb 2024 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707519962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p0ozYUXfF7PyRSzvcpMHo2m6giljntz6NlNmL/Dfj0=;
 b=20n3VxbFufVqgLuYOf+uVk5gCgDkdqQ2wN21fXlmtXn2szGGRkOkCgywdqTTgES2y8/W5M
 ntPVygeOjt7xpjGp0vnzjTBbCSrqnyymJOiBoecdHpCkhrToSrE81NF1erLqP2qCO/9rYn
 qF19mQT760CI0c9Gy1DDQ/4Ol1DgiCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707519962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p0ozYUXfF7PyRSzvcpMHo2m6giljntz6NlNmL/Dfj0=;
 b=4fmxI4SFNX0t7Br2jzTdnVx8+dvR0UPHwQxWliUix1R4SSaG8VPuRoB7M6waaz1E6NwcZ1
 iCOh6hNI9J0zYCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707519962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p0ozYUXfF7PyRSzvcpMHo2m6giljntz6NlNmL/Dfj0=;
 b=20n3VxbFufVqgLuYOf+uVk5gCgDkdqQ2wN21fXlmtXn2szGGRkOkCgywdqTTgES2y8/W5M
 ntPVygeOjt7xpjGp0vnzjTBbCSrqnyymJOiBoecdHpCkhrToSrE81NF1erLqP2qCO/9rYn
 qF19mQT760CI0c9Gy1DDQ/4Ol1DgiCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707519962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/p0ozYUXfF7PyRSzvcpMHo2m6giljntz6NlNmL/Dfj0=;
 b=4fmxI4SFNX0t7Br2jzTdnVx8+dvR0UPHwQxWliUix1R4SSaG8VPuRoB7M6waaz1E6NwcZ1
 iCOh6hNI9J0zYCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0005913353;
 Fri,  9 Feb 2024 23:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y5MVOtmvxmXPfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 23:06:01 +0000
Date: Sat, 10 Feb 2024 00:05:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240209230556.GA376121@pevik>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
 <20240208100517.1974-3-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240208100517.1974-3-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=20n3VxbF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4fmxI4SF
X-Spamd-Result: default: False [-3.46 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.45)[78.98%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 279911F83E
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/7] syscalls/swapon03: use tst_max_swapfiles()
 and GET_USED_SWAPFILES() api
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

Hi Yang Xu,

> +	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
> +		tst_brk(TCONF, "swap not supported on tmpfs");

This is based on my patchset:
https://patchwork.ozlabs.org/project/ltp/patch/20240205022857.191692-2-pvorel@suse.cz/

I still wonder why this is needed. Some problem of the loop device on tmpfs or
what? Also, as it's a separate unrelated change, shouldn't we merge my commit
instead?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
