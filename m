Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB97CA5FB3
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 12:30:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6068B3E280C
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 14:30:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27D963E2713
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 14:30:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7112E6019B9
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 14:30:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BC2D21CCD;
 Thu,  1 Oct 2026 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790857836;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAiWsmJqA+sXNbRWSTb6NT7KY4lfIdowLPO8MN6MYyY=;
 b=TnHMWxOqCghYVAFpg1NVh/Fys2RQf7b63J0VGSaSp5AYrdJ3K33Tj/XrUksEUScCMUtwWd
 eyxK1odnVdYFqoahsK2KXXnZVhTWgKoEc5laf8fzyyU8ebAlWpDhlcDSqzlo+Z8cTNc3nm
 A2bWWagJO673vG0y6XXPP9ad3gMxM58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790857836;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAiWsmJqA+sXNbRWSTb6NT7KY4lfIdowLPO8MN6MYyY=;
 b=VX8UN0WZ2Oh7mYev83YYWYiFIrVSXLlAjPYD6ryX3kW55GAmdC28EyaEneytFnsSvAwnIr
 mTMNicRjCjTWKfDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790857832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAiWsmJqA+sXNbRWSTb6NT7KY4lfIdowLPO8MN6MYyY=;
 b=0s2HE5HfYGeZHr2N/dAm4SiKjvRoHUt/k/GecfIFAQDremLJzm5tl++7dhW1giU1W21xLU
 IWyU9Q860I3Ka+4KJK5Wj3inuGL2RIDoGB3NcstqAGERSy5VmFfDVwBY4yebEfJk5U38B/
 KqElQwOStHyYk5MMIxDWS6dPHqswacw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790857832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAiWsmJqA+sXNbRWSTb6NT7KY4lfIdowLPO8MN6MYyY=;
 b=KRns4+YkDj3xVKKiKZxnCmMqcPixJkUne6RUypdTI40FQ1ee7ApZQM9jXjqUrs5S2nXm92
 kict/xPFcL3tZPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8E3C134B3;
 Thu,  1 Oct 2026 12:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hW4VKGdSvmqcbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 01 Oct 2026 12:30:31 +0000
Date: Thu, 1 Oct 2026 14:30:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20261001123015.GA3000799@pevik>
References: <20261001-fix_aio_suspend-1-1-v1-1-ac365dc874ef@suse.com>
 <c455d166-dcb5-41ca-9166-79c74aa2d015@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c455d166-dcb5-41ca-9166-79c74aa2d015@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Fix aio_suspend/1-1 completion race
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

Hi Martin, Andrea,

> Hi,
> removing the check defeats the purpose of the test. The proper fix is to
> block on a full socket instead, but aio_suspend() tests will also need a
> second thread that'll drain the socket while the main thread is suspended.

Martin, thanks to double check this, I also worried it would not be that simple.

And I hoped similar approach you already used for fixing aio_cancel() could be
reused. Thanks for describing a possible solution.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
