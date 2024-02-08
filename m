Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CFCC48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 08:56:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3FF3CE32E
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:56:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47DE13CC46D
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:56:11 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C9F1601711
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:56:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED90722416;
 Thu,  8 Feb 2024 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Zn8I+OfvVXFzZ9sa9Q9kUNzZudSpi9Rpr80sA6DnuU=;
 b=EMyN1/iQ9/Qbs/e8TpkNf6XeaSkoFf6YuHTEXUsrVg7rAsMdgZZL7Qc9bE47FoW3HTtsRX
 SAZnkKhLHRpwTFcTmkTyaVarfHbi6wgcsc6HgL8xSmkryEm/DdhJQ/iZcgJ7lVX9bQdo3m
 LKgkmb/29kq6v+MQAFrQzO2z7CX/k2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Zn8I+OfvVXFzZ9sa9Q9kUNzZudSpi9Rpr80sA6DnuU=;
 b=GTLDsc27sonkYBMquk2ItG5r1aiYVQsi2yMeBCRTZZ9hDVQzALL8uUof/gdw5b0mautTvJ
 KgTdtoDxN8U2IJDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Zn8I+OfvVXFzZ9sa9Q9kUNzZudSpi9Rpr80sA6DnuU=;
 b=WoEKH5+sGYjbZjypoi1VSmcFA0pGy64vP9Yq076QnM3MeMDZrKlqMGNY20jav0SbnF2637
 J0TUwf8YqLODr6SUQNpOH+GIlDoS0ZzdpiEgVDXrI6IaW03YZ3JW6MDZhwnPU3yOZVyIJX
 9YUTMIrACFzLTl54um2yJoCDdpat21E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Zn8I+OfvVXFzZ9sa9Q9kUNzZudSpi9Rpr80sA6DnuU=;
 b=uQdQUIx6kfcUX67fGw+fJy5cUrGFeFV0E1q+xOtQMZoNCBk8lvn+K0Z/2HYibYN/vgMm2v
 dB3JBAYXXwrvdVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D73D813984;
 Thu,  8 Feb 2024 08:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GkzRMyiXxGX/DAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Feb 2024 08:56:08 +0000
Date: Thu, 8 Feb 2024 09:56:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20240208085607.GA180635@pevik>
References: <20240203051901.3000-1-xuyang2018.jy@fujitsu.com>
 <20240203051901.3000-2-xuyang2018.jy@fujitsu.com>
 <20240206111849.GD270992@pevik>
 <d35e3d03-6237-4c4d-80f7-7db8905393be@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d35e3d03-6237-4c4d-80f7-7db8905393be@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WoEKH5+s;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uQdQUIx6
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.09)[64.28%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED90722416
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] settimeofday02:Simplify test using TST_ macros
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang Xu,

> Hi Petr,

> > Hi Yang Xu,

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > LGTM

> > nit: subject could be "settimeofday02: Simplify test using TST_ macros"
> > (missing space behind : - readability)

> > nit: git metadata as you as author have \ escapes:
> > Yang Xu \(Fujitsu\) <xuyang2018.jy@fujitsu.com>

> > It looks like you had it long time ago:
> > https://patchwork.ozlabs.org/project/ltp/list/?submitter=81371&state=*

> > Could you fix it as it breaks also credit counting before next release?


> This phenomenon did not occur in January yet. Did the patchwork rules 
> change? I don't know what needs to be changed.

I have no idea, patchwork we use is the same version 2.2.0. Maybe check user
profil [1], but unlikely there is anything. But although I did not realize
before, it's probably patchwork problem.

If you want to fix it (feel free to ignore this, because you mostly merge your
commits yourself, so you will use your commits with correct metadata), you could
1) report it to github issue [2] or to ML [3] or ask either the maintainer
Jeremy Kerr (search kernel log for his email or ask me to send it).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/user/
[2] https://github.com/getpatchwork/patchwork/issues
[3] https://lists.ozlabs.org/listinfo/patchwork

> Best Regards
> Yang Xu

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
