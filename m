Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA7CAC58D
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 09:35:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6985A3CD807
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 11:35:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AA993CAD56
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 11:34:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E5A302002B2
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 11:34:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCB23FB85;
 Thu, 11 Sep 2025 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757583290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J075LX8MHy442VqMp6D6ZAvmvSMjYnk4hFIZVAuYSMc=;
 b=qzv++NLIRsV7EdeAvOMElufp5lMVKdrmGkz/f+vOtK9G/fh0mx3KyzfEDZcbmR4C76regY
 zRz5jZGNBoll4Qg8UiGlbh7V7xw97CbAOIZnEq93cljLak9wIXBHHhDDF94+9AJXWdXcnB
 AJACOOcMwXYowxKNRzOxvda6SdUydxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757583290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J075LX8MHy442VqMp6D6ZAvmvSMjYnk4hFIZVAuYSMc=;
 b=ZEGIJcxAAdQgYTyCck3iM1eNAzsKBr/D9WX5+69uB4Yqkp7SrBx+xkxgEpmJ0kFvMuDw20
 ax8f5yMWdr+Z5pDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757583290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J075LX8MHy442VqMp6D6ZAvmvSMjYnk4hFIZVAuYSMc=;
 b=qzv++NLIRsV7EdeAvOMElufp5lMVKdrmGkz/f+vOtK9G/fh0mx3KyzfEDZcbmR4C76regY
 zRz5jZGNBoll4Qg8UiGlbh7V7xw97CbAOIZnEq93cljLak9wIXBHHhDDF94+9AJXWdXcnB
 AJACOOcMwXYowxKNRzOxvda6SdUydxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757583290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J075LX8MHy442VqMp6D6ZAvmvSMjYnk4hFIZVAuYSMc=;
 b=ZEGIJcxAAdQgYTyCck3iM1eNAzsKBr/D9WX5+69uB4Yqkp7SrBx+xkxgEpmJ0kFvMuDw20
 ax8f5yMWdr+Z5pDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64FF113301;
 Thu, 11 Sep 2025 09:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id POiPF7qXwmgCCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Sep 2025 09:34:50 +0000
Date: Thu, 11 Sep 2025 11:34:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250911093448.GA20035@pevik>
References: <20250911085700.27540-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250911085700.27540-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> The calculation added in commit 8422d46 works only for 64k page size.
> This commit fixes the calculation so that it properly detects maximal
> num_shift regardless the page_size.

Thanks for fixing this!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Closes #1258
very nit: I tend to use a regular link, i.e.:
Closes: https://github.com/linux-test-project/ltp/pull/1258

Why? in case project project will be moved elsewhere (gitlab?) and one will need
to figure out the link (whether it's an issue or PR).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
