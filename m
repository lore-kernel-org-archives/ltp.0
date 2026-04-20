Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB451F588C6
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 13:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 708163E5411
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 15:48:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A5FA3E2DD1
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 15:48:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 820A1600961
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 15:48:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E14ED5BCE0;
 Mon, 20 Apr 2026 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776692892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/aqhJa6zBh+yBb4w+TFvraO9l5si3ITeC6rmkI1z5U=;
 b=I/tRyY6V3Ixi2WUx68XdGLl1/n2vgdCiXC2OqOVy6W0dBCQl1RzZZPjuMEdQ54itaQSgxD
 XDQhUoN6mCmfRhMw8LA0OUsqPmxJIB6kkAPsqui/WOv67Zwz3dd/jVgLcFwhf1l521sxa5
 XKsZ3G6aBdho8Jt3aJVWFtLXfjIoQ90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776692892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/aqhJa6zBh+yBb4w+TFvraO9l5si3ITeC6rmkI1z5U=;
 b=9P0cunbBHllWRq9ZLB+yFTN53qldBIad2BH0J9h+TGhzv9+5mHZP9BwfghBJQucBAWMOlH
 vNWQMLAx/PBDThCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776692891;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/aqhJa6zBh+yBb4w+TFvraO9l5si3ITeC6rmkI1z5U=;
 b=xzqmP8zPOevcYSibSLhWuAMnXu8w3oI2pw/id7854rLkLNmUCzbkdygj5fhYLlUExmD5Nw
 bzvkmi+A4WkSyou6eH5UnJt/psU5UevJ5iShsiacuCGXzNnTqR8HUW8EMjJkBk5ih4h658
 HQ00NDfpCLXyhGRIjhoqoDgBMgTC5gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776692891;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/aqhJa6zBh+yBb4w+TFvraO9l5si3ITeC6rmkI1z5U=;
 b=7ZRm5yZawsMP4LA2wse6iIHnyHvv180kWBRIARja5HuC/ddbIjV6VmyNIYVrShK124XjXe
 2aK4BbN31oRBSAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466B1593AE;
 Mon, 20 Apr 2026 13:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id spVWDpsu5mmgQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Apr 2026 13:48:11 +0000
Date: Mon, 20 Apr 2026 15:48:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260420134805.GC477476@pevik>
References: <CANgNiRx-Om37TC8DYjGWqB++AGoxZCrXam_Vt5+H1d9j-YaNzA@mail.gmail.com>
 <69e0ca15.050a0220.37714b.e02d@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69e0ca15.050a0220.37714b.e02d@mx.google.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,suse.de,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] patchwork: Use last successful run timestamp to
 avoid missing patches
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I sent this patch 3 times and all the times (even with v2), patchwork
> is not recognizing it. It's not the first time that happens...

It's long time ago I notice it. BTW even big patches, which are refused by lore
due size are handled well by patchwork, e.g.:
https://patchwork.ozlabs.org/project/ltp/patch/20260323205547.19058-2-pvorel@suse.cz/

I suppose you tried both b4 (which you usually use) and git send-email. Other
option would be try to send email "manually" with your email client.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
