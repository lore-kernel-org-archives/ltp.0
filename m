Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E56C25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 09:49:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BD753D006D
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 11:49:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8ABD3CFCF8
 for <ltp@lists.linux.it>; Tue, 21 May 2024 11:48:59 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3381C1A00A58
 for <ltp@lists.linux.it>; Tue, 21 May 2024 11:48:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0C502224F;
 Tue, 21 May 2024 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716284937;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFFHmAsfJbLHY/Cf75S/qlV9jkbOMn8wuSy0r2jCSzw=;
 b=Rm8MrZYilbYV4EcEIOCjR8HsBx98JH0dHQSKeV7HYFiyNWarNvdW6zF5A2YQItO/DfsZIt
 TumbDdJyOX/BgJB4Dp0uoKKdO4Bp0qDttUg5A3Ay1rTKlUpovdaYAj7+ezZTAjobSLO/b+
 ES7+j0oPfz3VzwvajWQlNdOfzKaYpHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716284937;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFFHmAsfJbLHY/Cf75S/qlV9jkbOMn8wuSy0r2jCSzw=;
 b=+j3aPrpERfyEnHBvDb1l3XlO6/IGW4cEDjhhuyxqocvzlnfxNhzMAhiFU3X3PyAVfZ+eyN
 yLx8jf63Kkq5sNCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=teBiauLL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cLweTWna
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716284936;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFFHmAsfJbLHY/Cf75S/qlV9jkbOMn8wuSy0r2jCSzw=;
 b=teBiauLLmhZbS3WUPmhF/8eamuLxMJbdUzLbrLBl4V2JcewoyWoiLcMGO0ksVMEuRLdJVX
 KakM2pwYaxSIJ6O2jCH3va/aiHF2AXjjO/3mrIplQm8FNWxNvMsY4iw/8rR3sfEuhCmEAF
 lZ/OEpR7ryofeQvnrC0p68L3mbcyZ+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716284936;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFFHmAsfJbLHY/Cf75S/qlV9jkbOMn8wuSy0r2jCSzw=;
 b=cLweTWnazBGg+0GRnw/co62xY4NsJ+rq3EQHfyDtRZZ5dEaJycyoc5refCgjl8PSkkHhwk
 Sa+MgQso6v+NpRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87AD113A21;
 Tue, 21 May 2024 09:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8h1XIAhuTGYCbQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 09:48:56 +0000
Date: Tue, 21 May 2024 11:48:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240521094855.GA113562@pevik>
References: <20240521074955.78675-1-pvorel@suse.cz>
 <Zkxjf2t23ccNDx-B@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zkxjf2t23ccNDx-B@yuki>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B0C502224F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] libswap: Fix SLE12-SP5 + cleanup
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

> Hi!
> > * Don't swap 5.19 and 6.2 conditions (Cyril)
> > * Separate whitelist changes to "libswap: Split long lines
> >   (readability)"
> > * Add new commit "libswap: Remove function description"

> The libswap patchset looks good to me now:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks a lot, merged!


> > @Cyril any change I could rebase and merge this patch (Li acked)

> > * libs: Remove 'libltp' prefix from libs source directories
> > https://patchwork.ozlabs.org/project/ltp/patch/20240419110230.191809-1-pvorel@suse.cz/

> Can we please do that after the release, it's quite late now.

Sure, I'll postpone that.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
