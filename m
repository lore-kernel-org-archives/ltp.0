Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAC0CA101F
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 08:32:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 288723CD87F
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 10:32:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311E23C1AEE
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 10:32:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A62EB1400141
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 10:32:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 586F133BB6;
 Fri, 12 Sep 2025 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757665934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R76R3vRvgcrqcH8MTLi7wNquMnGDjQu9IgweugebAuc=;
 b=HjtPeExcP+XyWPxaXlBjMZMbLPBf6YZoW20jYK0j3SlQrrY+xAq50jVRRpUJFUz+2LpBhf
 AVYPf7/IjujlesC166o9epQb85rq+GbP+ZIbWzb9TQ39SWQIpoM5/DlrzMbjPT8KPbUYx+
 UefFoOw8PIkLZ5HfUK1ZpBT0FZ47G64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757665934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R76R3vRvgcrqcH8MTLi7wNquMnGDjQu9IgweugebAuc=;
 b=8sOMxQdx+Y17svvG7Xhx6Q+sH7890SUUKtItVx591PvIzogcZDIj0lRFJvTmaJ8qUuJKoT
 rV33ehHtu/vh2FAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757665934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R76R3vRvgcrqcH8MTLi7wNquMnGDjQu9IgweugebAuc=;
 b=HjtPeExcP+XyWPxaXlBjMZMbLPBf6YZoW20jYK0j3SlQrrY+xAq50jVRRpUJFUz+2LpBhf
 AVYPf7/IjujlesC166o9epQb85rq+GbP+ZIbWzb9TQ39SWQIpoM5/DlrzMbjPT8KPbUYx+
 UefFoOw8PIkLZ5HfUK1ZpBT0FZ47G64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757665934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R76R3vRvgcrqcH8MTLi7wNquMnGDjQu9IgweugebAuc=;
 b=8sOMxQdx+Y17svvG7Xhx6Q+sH7890SUUKtItVx591PvIzogcZDIj0lRFJvTmaJ8qUuJKoT
 rV33ehHtu/vh2FAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EA5313869;
 Fri, 12 Sep 2025 08:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HuIjDo7aw2giLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Sep 2025 08:32:14 +0000
Date: Fri, 12 Sep 2025 10:32:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aMPassdfnt_bEjpC@yuki.lan>
References: <20250911085700.27540-1-chrubis@suse.cz>
 <20250911093448.GA20035@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250911093448.GA20035@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/cachestat01: Fix num_shift calculation
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Closes #1258
> very nit: I tend to use a regular link, i.e.:
> Closes: https://github.com/linux-test-project/ltp/pull/1258
> 
> Why? in case project project will be moved elsewhere (gitlab?) and one will need
> to figure out the link (whether it's an issue or PR).

Updated the Closes: tag and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
