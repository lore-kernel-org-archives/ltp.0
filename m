Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFE9C48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 15:21:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A64793D137D
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 16:21:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA0D3D0476
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:21:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72D501408715
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:21:10 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5714821E3F;
 Mon, 19 Feb 2024 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708356069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHAVadsi6p3sKod2SuwPEIve1RtExsYia547awLxJ9g=;
 b=NOEQyTAa9XhRxdwGRG/czEyDf90SToO5VRH1HJKI8iEEiK5UL/Z4RTt8I6FjrreoTzNKDf
 XvNkCkygZoNa890eTPQdacrQytJCePIBpsAC7GJE26/ZKkirHkWYnzzr3kitLBUCtKR+eO
 ndviAW0dAlWjNgHNPjxaX/QNSJXOG/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708356069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHAVadsi6p3sKod2SuwPEIve1RtExsYia547awLxJ9g=;
 b=rkuf3vBS5z75MovnQCNQzqvtUTwS+9XsBcrhOoDW1oAhxVb/SWDmq4oXXAxSkm5gtnGvb2
 Ni07WoPbr/PvBPAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708356067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHAVadsi6p3sKod2SuwPEIve1RtExsYia547awLxJ9g=;
 b=DiN3fe5qHC4UPNM6LkNnnziR1V9pBnQlOnbFTHVrBb7KbIfZX5P0KoPTFFUmUsKNYXhmhr
 rvjE9Q+1b6fr03VoU1SjaSUoRBM62gsiRoyH1v1U5/R3plcDdiUdU7Wa8vxECKEo51qpbJ
 qHoTxnXbNUpjw5XRrd7RXqwltJ25qo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708356067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHAVadsi6p3sKod2SuwPEIve1RtExsYia547awLxJ9g=;
 b=j3ocffxFNeNnDMdfBzO+ihjCDt9bLz3yuwxYZnEzDUTSqIFb/JsFJOK6xeep0E0Fplf54B
 Wu8Vir5WOE8eg2Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BCA6139C6;
 Mon, 19 Feb 2024 15:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id TrWJBONx02WpIAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 19 Feb 2024 15:21:07 +0000
Date: Mon, 19 Feb 2024 16:21:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20240219152105.GA1021019@pevik>
References: <20240205022857.191692-1-pvorel@suse.cz>
 <20240205022857.191692-2-pvorel@suse.cz>
 <CAEemH2dZn4jRjQbEX492uhb4DMHCOMq+C4zvYeq_0N1x8X_mPA@mail.gmail.com>
 <20240205110042.GA201808@pevik> <20240212193025.GA637011@pevik>
 <8f10a26a-6808-4694-a3a4-48b366f978ef@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8f10a26a-6808-4694-a3a4-48b366f978ef@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.65 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-2.35)[96.97%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on
 tmpfs
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr, Li

> > Hi Li, Yang Xu,

> > this is invalid, replaced by:

> > https://lore.kernel.org/ltp/20240212192612.636901-1-pvorel@suse.cz/
> > https://patchwork.ozlabs.org/project/ltp/patch/20240212192612.636901-1-pvorel@suse.cz/

> > Could we please merge this simple fix before Yang Xu cleanup patchset:

> > https://patchwork.ozlabs.org/project/ltp/list/?series=394113
> > https://lore.kernel.org/ltp/20240208100517.1974-1-xuyang2018.jy@fujitsu.com/

> > I'm sorry, that would mean to send rebased version, but IMHO better include
> > simple fix.


> Now, can I send v4 patchset for maxswapfiles since Li's patch (fix 
> snprintf return value problem) has been merged int master?

Yes, please.

Kind regards,
Petr

> Best Regards
> Yang Xu
> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
