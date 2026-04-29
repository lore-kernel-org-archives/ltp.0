Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC33FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:04:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F3B93E2D48
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:04:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CBAC3E2169
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:04:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 19B7D1400DC1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:04:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0162B6A83A;
 Wed, 29 Apr 2026 08:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777449859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwx38gCBWLkWixjs3/25aBaFHft5tEmjJ6A7qOJ4kbk=;
 b=lQ2n5aBfyqEJD2JeQOjigIBe5QvGZZ0KCSHQ7jPZyNY7lGINS8FqA/no9Ck3tnJXeCvfQ5
 NIW68Yycu50LPuCjpPP781mWl2Fj0n3b22hGdF4YWbdjB6HfuxciTwORFf2SgMFCbj+TPs
 FcVJFjqwv1DBh0QD/i7WKFjMmH3oQFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777449859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwx38gCBWLkWixjs3/25aBaFHft5tEmjJ6A7qOJ4kbk=;
 b=hNeMvhylk4j9Di8UsdqDDgO2jI/YtHBaEtu8sbnvw/b6cheneoPCXZiSm+HHZI7uzDi5Pk
 InxcitNQ3AfxqKBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lQ2n5aBf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hNeMvhyl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777449859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwx38gCBWLkWixjs3/25aBaFHft5tEmjJ6A7qOJ4kbk=;
 b=lQ2n5aBfyqEJD2JeQOjigIBe5QvGZZ0KCSHQ7jPZyNY7lGINS8FqA/no9Ck3tnJXeCvfQ5
 NIW68Yycu50LPuCjpPP781mWl2Fj0n3b22hGdF4YWbdjB6HfuxciTwORFf2SgMFCbj+TPs
 FcVJFjqwv1DBh0QD/i7WKFjMmH3oQFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777449859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwx38gCBWLkWixjs3/25aBaFHft5tEmjJ6A7qOJ4kbk=;
 b=hNeMvhylk4j9Di8UsdqDDgO2jI/YtHBaEtu8sbnvw/b6cheneoPCXZiSm+HHZI7uzDi5Pk
 InxcitNQ3AfxqKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0837593B0;
 Wed, 29 Apr 2026 08:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7bGRMYK78WmfNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 08:04:18 +0000
Date: Wed, 29 Apr 2026 10:04:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260429080417.GA970790@pevik>
References: <20260428144259.3779-1-linuxtestproject.agent@gmail.com>
 <69f1b19b.050a0220.12d48.3521@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69f1b19b.050a0220.12d48.3521@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.de,lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0162B6A83A
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> > New Open POSIX testsuite headers should carry a "Created by: name <email>"
> > line and a brief description of the file's purpose in the copyright block,
> > consistent with the rest of the tree (e.g. helpers.h). Please add both.


> This is correct, I will fix it before merging it.
> Ping @Petr

Replied previously. BTW Agent removed "v2" from the title [1], therefore I did
not reply here because I did not want my reply to endup in old patch version.

It'd be great if Agent just keep the title to not confuse humans (people usually
trust the title instead of parsing In-Reply-To:).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260428144259.3779-1-linuxtestproject.agent@gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
