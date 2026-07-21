Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED315C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:49:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB8E3C1B73
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:49:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677B13C1B73
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:49:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 111C71400972
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:49:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF2717A181;
 Tue, 21 Jul 2026 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784623766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKl86XVnOc2B93+1N9FNy1JAyIw+AeG4p+VmGglsw3s=;
 b=cYdT9Ro1CWtv5dGIHTxHuRJ4I53HuXvJalCl0K0KHc0cgde3hb2H7AEzinzP2K3rvfZHSM
 GW+6F50l2ZVhpffjUogKTdmJSpRXt7xJFy4Tt+2BbXQmATAOQRDPXLbietO/MQ0M8Lvjbn
 R6MMVFcKQYr3y2geb8658TgNccCKR/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784623766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKl86XVnOc2B93+1N9FNy1JAyIw+AeG4p+VmGglsw3s=;
 b=/NSCDjtdlrgTw3w9M7OI3JqduFf/FZtdv43/jhlTxR3NYYkRbAjn9V2qLv+agnbTB7Kuyt
 SmcxwjESqhXElGCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784623766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKl86XVnOc2B93+1N9FNy1JAyIw+AeG4p+VmGglsw3s=;
 b=cYdT9Ro1CWtv5dGIHTxHuRJ4I53HuXvJalCl0K0KHc0cgde3hb2H7AEzinzP2K3rvfZHSM
 GW+6F50l2ZVhpffjUogKTdmJSpRXt7xJFy4Tt+2BbXQmATAOQRDPXLbietO/MQ0M8Lvjbn
 R6MMVFcKQYr3y2geb8658TgNccCKR/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784623766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKl86XVnOc2B93+1N9FNy1JAyIw+AeG4p+VmGglsw3s=;
 b=/NSCDjtdlrgTw3w9M7OI3JqduFf/FZtdv43/jhlTxR3NYYkRbAjn9V2qLv+agnbTB7Kuyt
 SmcxwjESqhXElGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF22A779AA;
 Tue, 21 Jul 2026 08:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBeQLZYyX2qPbwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jul 2026 08:49:26 +0000
Date: Tue, 21 Jul 2026 10:49:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <al8ylEF4xxeSfQkA@yuki.lan>
References: <al4_WWeLFMSvL0tS@yuki.lan>
 <6a5f1e79.9b582779.3dac65.e696@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a5f1e79.9b582779.3dac65.e696@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_kconfig: add module mappings for
 ingress/matchall/pedit
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > > index 44eacc7c2989a5af3347b8f7ed16393fde0122a6..277ac606895046e072cf8f86076ecf7d79f9b1e6 100644
> > > --- a/lib/tst_kconfig.c
> > > +++ b/lib/tst_kconfig.c
> > > @@ -162,6 +162,9 @@ static struct config_module_map {
> > >  	{"CONFIG_CAN_RAW", "can-raw"},
> > >  	{"CONFIG_CAN_BCM", "can-bcm"},
> > >  	{"CONFIG_IP_SCTP", "sctp"},
> > > +	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> > > +	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> > > +	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> > >  	{}
> > >  };
> > 
> > This is still missing the additions to the CONFIG -> module map.
> 
> That's achieved in the just commented code :-) feel free to add RB tag,
> I will merge the patch then.

Sigh, sorry, I shouldn't have doing reviews in the late evening. Let me
do a proper review now.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
