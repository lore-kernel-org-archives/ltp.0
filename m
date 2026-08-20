Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D208C5DF85
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F2D63CE52A
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:20:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27D653C0574
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:19:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 920F91000772
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:19:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA0843ED2;
 Thu, 20 Aug 2026 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787235582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va+0A1dLswMq2XJuD5ELEBiFib7g9SjnnIXAPMWl7Z8=;
 b=dcBmwleZEeufpeKab4914+T7RINGKuE1+aN8aKL4vGvdwNgRm4cbAQmQqcvUold8Bxmbdf
 UWcFOTOIby3/XHUO6rKBdwDg+AjGtXrpMqo69PNZmYhPiKqwgFTVC0rzZS0GU4HrGBupyd
 3vWAMk2x308ti0ivq+x8MY8DokvWjN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787235582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va+0A1dLswMq2XJuD5ELEBiFib7g9SjnnIXAPMWl7Z8=;
 b=c1uO8wlnDH2XiKT8GUyiUoQKUOc/GkvVGvMaBPpFDgNSuLHoPLxozOvDpH6GBLbNeLmZzw
 pdN1PKa6TW2nEHBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787235577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va+0A1dLswMq2XJuD5ELEBiFib7g9SjnnIXAPMWl7Z8=;
 b=FGIcxkZVsYhu4hKG27VD1TjV9V8i0AxP0Thv4qQ55L9V78u4rCkpe4iFhXYFz1HRbKDz/y
 6kpRdYnUlvS/WGE6k9Q7HY/dReArgSi9kgw/O1Ozoi0OYYZSNbK/2UZXVhLZxyE0WHoTNq
 6vpS+q3BD/rFDKGl1yLMOYnejt02+us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787235577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va+0A1dLswMq2XJuD5ELEBiFib7g9SjnnIXAPMWl7Z8=;
 b=FL52whQW29CG7EX2B8fVftXgWojQzPbgb/6+hG3+QtNUTsjQExfmZemqIXTDH2jYeQdldf
 MvCFQiGGx49NmpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7997351D;
 Thu, 20 Aug 2026 14:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5dqKL/kMh2qyYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Aug 2026 14:19:37 +0000
Date: Thu, 20 Aug 2026 16:19:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aocM-vVTSlaqdXve@yuki.lan>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
 <20260820-fchroot-v2-6-062ed20957a0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260820-fchroot-v2-6-062ed20957a0@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 06/16] fchroot03: test fchroot()
 permission checks
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Verify that with a regular directory fd the kernel first checks the
> execute permission on the directory and then CAP_SYS_CHROOT: an
> unprivileged process with an accessible directory fails with EPERM and
> a process without execute permission fails with EACCES.

Here as well, the order of the checks is subject to change.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
