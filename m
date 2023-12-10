Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6635C4167B
	for <ltp@archiver.kernel.org>; Sun, 10 Dec 2023 16:22:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 225253CF8AC
	for <ltp@archiver.kernel.org>; Sun, 10 Dec 2023 17:22:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D045B3C81E3
 for <ltp@lists.linux.it>; Sun, 10 Dec 2023 17:22:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF6E06008A6
 for <ltp@lists.linux.it>; Sun, 10 Dec 2023 17:22:32 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66632220ED;
 Sun, 10 Dec 2023 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702225351;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aq8mVMPTwMZ++Cr/Rvg50F5lYnyde/gBKLtBvtUU4+c=;
 b=Srp31WI8POC92i8C50nXwyLMCKjPTcDNkdMhHcHhMkdlE5GHobw0lXlLuij58FVWz326by
 T0FND7vKHB9WeTm7F7dT+zmmIUeWjBbRR84wjYLovTpKvNnicWzHlwYRa1hl/pN/BSMl1D
 Y1L8SLWEjpxjF6UCdAsybYJY0IlMb0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702225351;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aq8mVMPTwMZ++Cr/Rvg50F5lYnyde/gBKLtBvtUU4+c=;
 b=/DTc0Z5Kpx1htNSX/EL6UB3h09T6JPCoOfGvYlraRQAhy7Gru+Ia613wmWxCBPWDl557Eu
 mvO/vUIIVUoOTnDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702225351;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aq8mVMPTwMZ++Cr/Rvg50F5lYnyde/gBKLtBvtUU4+c=;
 b=Srp31WI8POC92i8C50nXwyLMCKjPTcDNkdMhHcHhMkdlE5GHobw0lXlLuij58FVWz326by
 T0FND7vKHB9WeTm7F7dT+zmmIUeWjBbRR84wjYLovTpKvNnicWzHlwYRa1hl/pN/BSMl1D
 Y1L8SLWEjpxjF6UCdAsybYJY0IlMb0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702225351;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aq8mVMPTwMZ++Cr/Rvg50F5lYnyde/gBKLtBvtUU4+c=;
 b=/DTc0Z5Kpx1htNSX/EL6UB3h09T6JPCoOfGvYlraRQAhy7Gru+Ia613wmWxCBPWDl557Eu
 mvO/vUIIVUoOTnDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3141613A9F;
 Sun, 10 Dec 2023 16:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id pH3kCcfldWXFaQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sun, 10 Dec 2023 16:22:31 +0000
Date: Sun, 10 Dec 2023 17:22:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231210162229.GA381401@pevik>
References: <20231011160822.578637-1-pvorel@suse.cz>
 <20231011160822.578637-2-pvorel@suse.cz> <ZXM6tgJPx9vzUxMj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXM6tgJPx9vzUxMj@yuki>
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Srp31WI8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/DTc0Z5K";
 dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [8.68 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[18.39%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 NEURAL_SPAM_SHORT(1.85)[0.616]; NEURAL_HAM_LONG(-0.96)[-0.961];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,suse.de];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 66632220ED
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_ioctl: Cleanup the code
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!

> >  	if (ioctl(fd, FIBMAP, &block)) {
> >  		tst_res(TINFO | TERRNO, "FIBMAP ioctl is NOT supported");
> >  		close(fd);

> This should be SAFE_CLOSE() as well, since we are doing the conversion.

Good point, thanks. I added missing license and merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
