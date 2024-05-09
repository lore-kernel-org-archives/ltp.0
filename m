Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D98C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 09:55:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2E0D3CE185
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 11:54:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 055C43CE07E
 for <ltp@lists.linux.it>; Thu,  9 May 2024 11:54:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6367D1400158
 for <ltp@lists.linux.it>; Thu,  9 May 2024 11:54:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24EAA38214;
 Thu,  9 May 2024 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715248482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mh5+ZEhm84CMBgH+fMGKpa+2DxTSu9lru7ZWAztf4Qk=;
 b=WjhZ6NN4+oBh2NnDJu2FpkuG1T6hsgLSeseVRNlU098rCh+eiZ//sWGF1CcWyOu2n2/Z0L
 AhuNyQnSW+fCuNYMm+kH40N4qvfu4v2nd6dU3efwDlSqJdRhXRsSs7rIscukhQeAxxleGK
 624V7/ZF8Ctaz8IdeC3WiePAuqmBmzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715248482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mh5+ZEhm84CMBgH+fMGKpa+2DxTSu9lru7ZWAztf4Qk=;
 b=bZ9VCzWRbyLyiQ0nV3Dcd3XYI7eGYXOIhg/qtaxNfVw54udLe+wUnm2D21WVB7WW9mKYfG
 qgP4AANV1HHzt5Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715248481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mh5+ZEhm84CMBgH+fMGKpa+2DxTSu9lru7ZWAztf4Qk=;
 b=ooXmTmecHhpy1ttYw3AnMG9Jp5K1vgdIk7LntfeiikPelZFXp2aHJUJQBphGFXMXCt43S8
 EijtgV2QFwXjL+VzpNucPA9aH+ouh4F6/RzxwQ1FtcrhQD8GqtuowIaFtRVo+ap6xhPZyP
 JapQP2Wy/7VIR7AAHtPX3eqwOCYJpOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715248481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mh5+ZEhm84CMBgH+fMGKpa+2DxTSu9lru7ZWAztf4Qk=;
 b=C+DhHDRf2VYO21gNniPbSDxAy3IWFIh2DwIPEUBQyHDPwWFxTvlvhWmzNiKGgap3ovTgiO
 xzEDsFGNSq9AMvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE21813941;
 Thu,  9 May 2024 09:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1CApOWCdPGYhNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 09:54:40 +0000
Date: Thu, 9 May 2024 11:54:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hui Min Mina Chou <minachou@andestech.com>
Message-ID: <20240509095439.GA263661@pevik>
References: <20240509090717.1342778-1-minachou@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509090717.1342778-1-minachou@andestech.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,andestech.com,gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND] [PATCH] hugemmap15: Support RISC-V to do
 __cache_flush.
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
Cc: tim609@andestech.com, cynthia@andestech.com, az70021@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hui,

thanks, merged!

BTW how are the other RISC-V results in syscalls?
Do you run other runtest files?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
