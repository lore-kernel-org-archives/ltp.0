Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B8DC54FD2
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C292A3E7242
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:54:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11F663E49EA
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:54:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4ACC3140044A
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:53:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 674BD3E97;
 Thu, 30 Jul 2026 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785401632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWzUzVAmERuSpJqhFofVt/tCBIHeRJTUmo7cpMZouRs=;
 b=2vYnkvISNjuhxymU7MYPGB0N7c76WO3mNOpW9zyxlkj8Sj0WE85O/GTTTDdLAcX5VAaNm2
 BrgIRErwZfs2gJJKfODjc4mN82iEcZDLalitOOUtBfEuP5pGiwOx48zP8tEkqmKmdX/7cB
 Cds4IegdOG4SXJuWNpJH2rm2aEZ9TLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785401632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWzUzVAmERuSpJqhFofVt/tCBIHeRJTUmo7cpMZouRs=;
 b=gqig04Nn0O/DBFHGE4VzUbmcJfYEQWKhloeCOfbC7AyDnCo62SqjZESYKKgY6ZzPaHKoB0
 oEksNVy0LYDiUiCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yQkSEKXd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kGY8cKOU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785401628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWzUzVAmERuSpJqhFofVt/tCBIHeRJTUmo7cpMZouRs=;
 b=yQkSEKXdfp3s322qrWHOTkzI9AfsyQZPhbXMDn6DMa2MfRetE4jVE5M8hcywk9UJvRJnCm
 ZlildEZwM59T1fyzVZbtNVba0FYeA7GFm2TQE/D0fdREFeirl7wgaQ5k/Qkf7dGaQ2C0UN
 2wsyoZW2zAuI3BRcCvFPMRWGcnb7Q0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785401628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWzUzVAmERuSpJqhFofVt/tCBIHeRJTUmo7cpMZouRs=;
 b=kGY8cKOUJblhcormolZncZSOypTy/a+rl5RA9eArxYuL0TFgQSmBa64bpVZtb2TA9l4Tqo
 wfuZAs4C3ouSnJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56C0D779CC;
 Thu, 30 Jul 2026 08:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NUb6ExwRa2otUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 30 Jul 2026 08:53:48 +0000
Date: Thu, 30 Jul 2026 10:53:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amsRGxrUfMnjDlFT@yuki.lan>
References: <CAOB9oOZaAan2bKWzu2XLeGkZVV1RO39YWuucmQK0tvvgVE4rUA@mail.gmail.com>
 <6a57ad4a.c799ffc2.29dc52.6d38@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a57ad4a.c799ffc2.29dc52.6d38@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 674BD3E97
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,huawei.com,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 Hongtao Zhang <zhanghongtao35@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > We recently confirmed this commit does cause a flood of I/O errors on
> > the root filesystem in our testing, leaving the machine unusable until
> > reboot.
> > 
> > Given that, we'd appreciate the community helping to decide soon
> > whether the revert is warranted.
> 
> Are you 100% sure that is caused by the patch you want to revert?
> Because the patch looked ok to me when I reviewed. We need to have
> more context and info around the issue which has been generated in
> order to avoid any workaround for a system/kernel bug.

AFAIK the testing module grabs first device available on the system and
uses it for testing. Which means that if you are unlucky it's your
network card, or disk controller and you force reload it on a live
system.

And honestly the PCI test should be either rewritten and cleaned up to
do something more sensible or just removed. As it is it's too fragile.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
