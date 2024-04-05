Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E516BC67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 14:08:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AECE3CEF21
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 16:08:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8F6C3CC8A5
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:07:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 889B3100289A
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:07:56 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E905A21A96;
 Fri,  5 Apr 2024 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712326074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22TsX/XZiupElg54oBPuMLbY45vEUos3L/Sk7kw5mog=;
 b=eJKcbV5MESJkSBxy+MzfAWLOLqe/fHCXJuopU1eQAdqX5FcHgowEdlaWvr66svtTsoxQHV
 Um/75E/A4LYua4EFGrD6kQEmQ31bSEI9nnArmTMTwpO/W1/hHJ5fNDURJ5VOjFY8NEWUAp
 8zQAfMSTWN+4EUK2ZuDzeHsIy+fbecY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712326074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22TsX/XZiupElg54oBPuMLbY45vEUos3L/Sk7kw5mog=;
 b=BhbianF6FMhOaduHXmd63LAqIyj6fOmhUhEtx5sBgR4h2jSUYp39tgFgQHnoiDWsDFAn6K
 +iOYovVjEdJngHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712326073;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22TsX/XZiupElg54oBPuMLbY45vEUos3L/Sk7kw5mog=;
 b=zO+MU7bZe6noKoiAnY/60bMyAtKRU9RgxLKbmeL8EYD80OijZHOFbXfDhxzp/jR+x7fkSS
 LpS7wO5qM8Bk05+5gWBELNMoXJtMGAKd3Wg+V/0Y6AyFRUvKD/6DkEGgjc+la6QriGtvEp
 q8M9wQkqGB8u4VWy1537Mq8Dr2PW+FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712326073;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22TsX/XZiupElg54oBPuMLbY45vEUos3L/Sk7kw5mog=;
 b=zY8PFyIS+OTHVk83cPJy/31swHgFZgb9NB4n/JbroKXDNglfywusKdEDGadc86KxUcChWj
 rF5I6JfaoXo1O8Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C6F17139E8;
 Fri,  5 Apr 2024 14:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id IN8yL7kFEGYsPQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 05 Apr 2024 14:07:53 +0000
Date: Fri, 5 Apr 2024 16:07:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20240405140744.GB637302@pevik>
References: <20240404131954.27706-1-andrea.cervesato@suse.de>
 <20240404133744.GD503552@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240404133744.GD503552@pevik>
X-Spamd-Result: default: False [-3.47 / 50.00]; BAYES_HAM(-2.97)[99.89%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] New LTP documentation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Cyril,

merged the docs, thanks!

I also deleted .github/workflows/wiki-mirror.yml (there were 2 failures in CI
after the move). Also, for some reasons some build CI jobs fails on some jobs in
make install, but that should not be related. Hopefully restart fixes that.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
