Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A690C67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 10:28:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C649E3CEE80
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 12:28:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66C253CE379
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 12:28:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E450B6181D8
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 12:28:31 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D6F41F789;
 Fri,  5 Apr 2024 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712312910;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhKkdO4Ud+z2ajK/3+PmZZjmpWaeBadqvDAaPm5Feio=;
 b=bZiGrTYUwV3ZufN2lCRWZtTU+bwTgA8jFYwyKowiXpuTML09RqKq0c2GirpJW7vqwRlykv
 IX44AygNJILYYd02eajn9DRz+83TgRY6xtz1r2mufhpalJVKERk86KNr9gdojkQXVIUkfH
 Ao+ALEyFrPiTtTQKhNa64fpq+vqmtfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712312910;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhKkdO4Ud+z2ajK/3+PmZZjmpWaeBadqvDAaPm5Feio=;
 b=33r8jqX3clmz1XYgBdautS45sRTDwNdUe0wA5zdh6HEsL/TOcU3NPfSmUCabhIOdNs2CZW
 TFO5bxPOEJ3tX4CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712312910;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhKkdO4Ud+z2ajK/3+PmZZjmpWaeBadqvDAaPm5Feio=;
 b=bZiGrTYUwV3ZufN2lCRWZtTU+bwTgA8jFYwyKowiXpuTML09RqKq0c2GirpJW7vqwRlykv
 IX44AygNJILYYd02eajn9DRz+83TgRY6xtz1r2mufhpalJVKERk86KNr9gdojkQXVIUkfH
 Ao+ALEyFrPiTtTQKhNa64fpq+vqmtfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712312910;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhKkdO4Ud+z2ajK/3+PmZZjmpWaeBadqvDAaPm5Feio=;
 b=33r8jqX3clmz1XYgBdautS45sRTDwNdUe0wA5zdh6HEsL/TOcU3NPfSmUCabhIOdNs2CZW
 TFO5bxPOEJ3tX4CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E8F1139E8;
 Fri,  5 Apr 2024 10:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id /vlIDE7SD2a9bQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 05 Apr 2024 10:28:30 +0000
Date: Fri, 5 Apr 2024 12:28:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240405102828.GA622461@pevik>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
 <20240403032859.3826-2-wegao@suse.com> <Zg6wV8Xb004kAqkK@yuki>
 <20240404160151.GE503552@pevik> <Zg-8HwWdC5eOZseY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zg-8HwWdC5eOZseY@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
> > > This one looks good, I would wote for merging it now, however the
> > > subject suggests that the TST_EXP_PASS_PTR_* functions are implemented
> > > here as well, which isn't the case.

> > > So I propse to fix the subject to include only EXP_FAIL_ and merge this
> > > then add the EXP_PASS_ variants in another patch.

> > Sure, I'll fix that before merge.

> > BTW I fix that in the v6 patchset which I sent (and I Cc Wei and you) before Wei
> > sent his v6 (my only change was adding everything into test_macros02 and use
> > macros to shorten the code as more macros will be added to it in the future. I
> > suppose you prefer the original code as you acked this).

> I'm simply lost in the number of iterations for this patch. Also I do
> not think that reducing the duplication in the library test is that
> important, but feel free to push that with my reviewed-by as well.

Thanks, merged with that extra commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
