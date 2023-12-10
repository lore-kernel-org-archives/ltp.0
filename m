Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B02C4167B
	for <ltp@archiver.kernel.org>; Sun, 10 Dec 2023 16:25:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C88613CD85C
	for <ltp@archiver.kernel.org>; Sun, 10 Dec 2023 17:25:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23A013CB7D9
 for <ltp@lists.linux.it>; Sun, 10 Dec 2023 17:25:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B992200BA5
 for <ltp@lists.linux.it>; Sun, 10 Dec 2023 17:25:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8D7121B2F;
 Sun, 10 Dec 2023 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702225500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wS/WBfoNiNX5y6V244Ygerp8yaUXZ6xibNUR6Z0OeSs=;
 b=mpYxxKhDaFW4RdjcvcW9vqRDbAnGdSSOx4e2rQuLxlAQ0G5yauO2eRQrv9nucvwInuuRbA
 h0rE9055NXy582otFRHNMAbc3YQ4FksNLcU1VBfkTRHiPzynS6vnBzR/Zddryr8leGINut
 jFSdsPDwbhvWy+3GbDMyZUQ0ywdDRNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702225500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wS/WBfoNiNX5y6V244Ygerp8yaUXZ6xibNUR6Z0OeSs=;
 b=RaY1xmvcqI9DUwNOBeKhTfnhyUz1rcDjaOH25rKvJKh25gUeABOX8TKHnOdFiyEOebnNSj
 h1laYZFRyYMfFACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702225500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wS/WBfoNiNX5y6V244Ygerp8yaUXZ6xibNUR6Z0OeSs=;
 b=mpYxxKhDaFW4RdjcvcW9vqRDbAnGdSSOx4e2rQuLxlAQ0G5yauO2eRQrv9nucvwInuuRbA
 h0rE9055NXy582otFRHNMAbc3YQ4FksNLcU1VBfkTRHiPzynS6vnBzR/Zddryr8leGINut
 jFSdsPDwbhvWy+3GbDMyZUQ0ywdDRNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702225500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wS/WBfoNiNX5y6V244Ygerp8yaUXZ6xibNUR6Z0OeSs=;
 b=RaY1xmvcqI9DUwNOBeKhTfnhyUz1rcDjaOH25rKvJKh25gUeABOX8TKHnOdFiyEOebnNSj
 h1laYZFRyYMfFACw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 640F313A9F;
 Sun, 10 Dec 2023 16:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id VcV4FVzmdWUragAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sun, 10 Dec 2023 16:25:00 +0000
Date: Sun, 10 Dec 2023 17:24:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231210162457.GB381401@pevik>
References: <20231011160822.578637-1-pvorel@suse.cz>
 <20231011160822.578637-4-pvorel@suse.cz> <ZXM-KwDvvNOpm64O@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXM-KwDvvNOpm64O@yuki>
X-Spamd-Result: default: False [17.78 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAM_FLAG(5.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all:c]; DMARC_NA(1.20)[suse.cz];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; NEURAL_SPAM_SHORT(2.99)[0.996];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: B8D7121B2F
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mpYxxKhD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RaY1xmvc;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] libltpswap: TCONF on EPERM
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
> > +		if (fibmap == 1) {
> > +			if (errno == EINVAL)
> > +				tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
> > +			if (errno == EPERM)
> > +				tst_brk(TCONF, "No permission for swapon() on %s", fstype);

> I'm not sure if we actually need to print the filesystem type in the
> case that we do not have a permission to do swapon.

> Also this kind of works because the fibmap ioctl() fails as well,
> however I guess that this should really be:

> 	if (errno == EPERM)
> 		tst_brk(TCONF, "Permission denied for swapon()");
> 	else if (fibmap == 1 && errno == EINVAL)
> 		tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
> 	else
> 		tst_brk(TFAIL | TTERNO, ...);

Ah, that's actually better, thanks!
Tomorrow, I'll modify it and merge with your RBT.

Kind regards,
Petr

> > +		} else {
> >  			tst_brk(TFAIL | TTERRNO, "swapon on %s failed", fstype);
> > +		}
> >  	}

> >  	TEST(tst_syscall(__NR_swapoff, filename, 0));
> > -- 
> > 2.42.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
