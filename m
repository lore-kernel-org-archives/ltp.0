Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2BC25B79
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 14:33:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 624B43CF7A1
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 16:33:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F13E83CF721
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:33:20 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A40EF2102EC
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:33:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D44FE207B8;
 Wed, 15 May 2024 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715783599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLzzq3lh5YdzxHq4wGpIdd9XN++CF86HXx91VruY+6U=;
 b=hVPeLUunf4e9CmpLJdAjJtaZc2jfAWX81KCUtcf3daaXusmLCkxo2JA2je495VXNyRG0L5
 TVh9ZmTQJzhGtc9RFAfERHOaGuQs1aPs+7zlgEpbCiY97BMU9ijuq39lt1D1qeW6aFJFoE
 jM2RMKW6aT9SvmN75d3qlf7/leqhZNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715783599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLzzq3lh5YdzxHq4wGpIdd9XN++CF86HXx91VruY+6U=;
 b=t4p2yDJrl4TknHN9MVQTS+5t2hqqayTbnKAXJdgA8TzwvPUtXVsFeeLrumUsjsDET8Mg79
 SXAY5CGbrquXDnDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715783598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLzzq3lh5YdzxHq4wGpIdd9XN++CF86HXx91VruY+6U=;
 b=Jhs7l/WVMzhn3WxX83mryS829Jjlr+l/8ZItAjBgxLyA3o1t7hbgwGo8lySYrlECdWX51N
 lie8pZoveIwM8ey466Kp2t6sZ9wFysjIFce5y7+VIOpNcxoJp4+pqLcamR6P0ycfwPVcv7
 NMaINjPzPRdyMWtC+Xf+xGTJzWqAQ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715783598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLzzq3lh5YdzxHq4wGpIdd9XN++CF86HXx91VruY+6U=;
 b=5lMV6813uk31Daz0lYvbW2EqVNUoBw6mHtqH03K+t6Xyokz5U5xTDdaHbehp/yCuLdavAk
 F2lIqbjTW0VKgnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B316B1372E;
 Wed, 15 May 2024 14:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jTgKKq7HRGZvBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 14:33:18 +0000
Date: Wed, 15 May 2024 16:33:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240515143317.GA232353@pevik>
References: <Zitm2aUAcydofMlF@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zitm2aUAcydofMlF@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release planning
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

> Hi!
> As usuall we are supposed to produce a release at the end of the next
> month, so let me start with the call for patches that should be
> included. I do plan to look at the patchwork next week and try to review
> and merge as much as possible, however if there is anything that I
> shouldn't really miss, please let me know.

There are more important fixes and new tests, but if you have time:

libs: Remove 'libltp' prefix from libs source directories
https://patchwork.ozlabs.org/project/ltp/patch/20240419110230.191809-1-pvorel@suse.cz/

This doc improvements are for the old library. I'll send v2 for new sphinx format
https://patchwork.ozlabs.org/project/ltp/patch/20240307232511.228396-2-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20240307232511.228396-1-pvorel@suse.cz/

I'd like to unify TMPDIR change in C API with shell API, thus I'd like to send
v2 of this
Remove double or trailing slashes in TMPDIR in C API
https://patchwork.ozlabs.org/project/ltp/list/?series=400258&state=*

I still hope to spend some time on LTP API docs, so that we can remove the old
format before the new release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
