Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726F2CA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 09:05:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB5D13CD4E4
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 11:05:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F25BF3C2D89
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 11:05:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B47A6002B4
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 11:05:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82A1F44F4;
 Fri,  5 Sep 2025 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757063103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO33BZEZU3BR+Kw7dViGw2GY2NIs0nsAT37QX/pPYtU=;
 b=xpwrGmfxKe94UGP7ht0fq5dAEVfEC4ffRiDhEOMBk5ko+G9K0y2shsxPAiWJkfyy9IZGAw
 lV955MfKLbFLL9CcJ7Ts4WS5NmfnjL5Fdn7/UJBU5VTxV9QRc+vYPmd0XzjAx5K+Jk0vb6
 J4h8E5fAfc92uBWVXvnG9nZ8GQfWRpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757063103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO33BZEZU3BR+Kw7dViGw2GY2NIs0nsAT37QX/pPYtU=;
 b=OeGuD4VlI4IkEKmvhmDyza3LdZtNywKfdsqhgUmDmDk+4iAwGlD6Gp4WGlmEVBQZgd8mEJ
 kcvOXaBAxsPzhOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757063103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO33BZEZU3BR+Kw7dViGw2GY2NIs0nsAT37QX/pPYtU=;
 b=xpwrGmfxKe94UGP7ht0fq5dAEVfEC4ffRiDhEOMBk5ko+G9K0y2shsxPAiWJkfyy9IZGAw
 lV955MfKLbFLL9CcJ7Ts4WS5NmfnjL5Fdn7/UJBU5VTxV9QRc+vYPmd0XzjAx5K+Jk0vb6
 J4h8E5fAfc92uBWVXvnG9nZ8GQfWRpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757063103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SO33BZEZU3BR+Kw7dViGw2GY2NIs0nsAT37QX/pPYtU=;
 b=OeGuD4VlI4IkEKmvhmDyza3LdZtNywKfdsqhgUmDmDk+4iAwGlD6Gp4WGlmEVBQZgd8mEJ
 kcvOXaBAxsPzhOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D82B139B9;
 Fri,  5 Sep 2025 09:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GfEAGr+numhDJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 05 Sep 2025 09:05:03 +0000
Date: Fri, 5 Sep 2025 11:05:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250905090502.GB4185@pevik>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <aLqbaZKE2TNvHSgK@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aLqbaZKE2TNvHSgK@localhost>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi all,

> On Mon, Sep 01, 2025 at 12:20:07PM +0200, Cyril Hrubis wrote:
> > Hi!
> > It's about the time we start to prepare for the September release. As
> > usuall I will go over the patches in the patchwork in the next week or
> > two. If there is something that you think should be part of the release,
> > please point it out so that I can have a look ASAP.
> I would like add fix for current openqa failed case cpuset02. Futher
> more fix is simple and should not trigger side effect.
> https://patchwork.ozlabs.org/project/ltp/cover/20250904015920.7432-1-wegao@suse.com/
> Thanks.

Also Wei's patch for ioctl_loop01.c [1] is IMHO worth to get into the release.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20250902111809.6071-1-wegao@suse.com/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
