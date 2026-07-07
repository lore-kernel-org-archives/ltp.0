Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A95C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 14:54:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98DF33E5D31
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 16:54:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 204A83C72CE
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 16:54:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A3EBB10000EE
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 16:54:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BAC675D93;
 Tue,  7 Jul 2026 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783436040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rq10MZj5QD8Q35hwsGVE/aDuFk529T4kwf+/QzI3vJA=;
 b=lERavOHL0IWTcXi7T97mbb3Z77Qx/2gLpSYC2c9+6TUrgnsAJluT+39pT44BEevLPYg05O
 Ma+0Nd00i3OXgMGBLUjutNshxfEM8Lr0y84wpSj8MjU6wQh8NOFCG1PXbLRsSXSAZbZS4H
 qS65U9omCkeBC192fuyGdi5Ci+K4BuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783436040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rq10MZj5QD8Q35hwsGVE/aDuFk529T4kwf+/QzI3vJA=;
 b=TkX6udi+QM3mXmBrRT13RNmBQX6TKCNQQBIizP/T1RDsKGLSa3sgoml371l2QRF0NsuFOI
 wRyhc15m6y35DVDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mOVugGcP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CffayCQF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783436039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rq10MZj5QD8Q35hwsGVE/aDuFk529T4kwf+/QzI3vJA=;
 b=mOVugGcPnzFPtv0z/wmXQiky7nYJXBWQoM9VIQ5GqxqaFc84u6roCUR3uAQlg3ynpB4vPb
 GrGCUJfJimrWYivk+cm1YN66sQF4p7iy22l9CdN3SB2PicwIZ08pQCKNmA3ytyh3prMLM/
 W5YYXqMZuHO5qbxT0rfqMKlekXexIdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783436039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rq10MZj5QD8Q35hwsGVE/aDuFk529T4kwf+/QzI3vJA=;
 b=CffayCQFuZSZ5S0L/zx8lw4WvYy7/pnTP9qQ9+KNpYw2Q9eji9i+5ZuyMIA4i5Nj2Y9ONu
 cet54S2apR9KWFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21601779AE;
 Tue,  7 Jul 2026 14:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BhucBgcTTWoUBAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Jul 2026 14:53:59 +0000
Date: Tue, 7 Jul 2026 16:53:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <ak0S_L8YmeaH9X-E@yuki.lan>
References: <20260707-cve-2026-46331-v3-1-3f6f1d697eec@suse.com>
 <20260707142810.4143-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260707142810.4143-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3BAC675D93
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_cls.h fallback
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>   TCA_PEDIT_UNSPEC  = 0
>   TCA_PEDIT_TM      = 1
>   TCA_PEDIT_PARMS   = 2
>   TCA_PEDIT_PAD     = 3   <-- 3 is PAD, not KEY_EX
>   TCA_PEDIT_PARMS_EX = 4
>   TCA_PEDIT_KEYS_EX  = 5
>   TCA_PEDIT_KEY_EX   = 6  <-- should be 6
> 
> With value 3 the kernel would receive a TCA_PEDIT_PAD attribute where
> TCA_PEDIT_KEY_EX is expected and reject the filter with "Unknown
> attribute, expected extended key".
> 
> This also breaks the test in patch 4/4 which uses TCA_PEDIT_KEY_EX
> as a netlink attribute type.
> 
> > +#ifndef TCA_PEDIT_PARMS_EX
> > +# define TCA_PEDIT_PARMS_EX		4
> > +#endif
> > +
> > +#ifndef TCA_PEDIT_KEYS_EX
> > +# define TCA_PEDIT_KEYS_EX		5
> > +#endif
> > +
> > +#ifndef TCA_PEDIT_KEY_EX
> > +# define TCA_PEDIT_KEY_EX		3
> > +#endif
> > +
> > +#ifndef TCA_PEDIT_KEY_EX_HTYPE
> > +# define TCA_PEDIT_KEY_EX_HTYPE		1
> > +#endif
> > +
> > +#ifndef TCA_PEDIT_KEY_EX_CMD
> > +# define TCA_PEDIT_KEY_EX_CMD		2
> > +#endif
> 
> All five of these are anonymous enum values in the kernel header, not
> preprocessor macros. A #ifndef guard tests the preprocessor symbol
> table, which does not include enum constants. So every one of these
> #define lines executes unconditionally even on systems that already
> have the full kernel header -- the enum values are silently shadowed
> by the macros.
> 
> For the four correctly-valued ones this has no observable impact
> today, but the guard gives a false sense of safety. For
> TCA_PEDIT_KEY_EX the wrong value makes the situation permanent on
> every system.
> 
> The correct approach for enum-valued constants is to use
> AC_CHECK_DECLS in configure.ac, the same way this patch already uses
> AC_CHECK_TYPES for the two enum types:
> 
>   AC_CHECK_DECLS([TCA_PEDIT_PARMS_EX, TCA_PEDIT_KEYS_EX,
>                   TCA_PEDIT_KEY_EX, TCA_PEDIT_KEY_EX_HTYPE,
>                   TCA_PEDIT_KEY_EX_CMD],,,[
>   #include <linux/tc_act/tc_pedit.h>])

Maybe we can use the TCA_PEDIT_MAX:

#if !defined(TCA_PEDI_MAX) || TCA_PEDIT_MAX < 4
# define TCA_PEDIT_PARMS_EX 4
#endif

#if !defined(TCA_PEDI_MAX) || TCA_PEDIT_MAX < 5
# define TCA_PEDIT_KEYS_EX 5
#endif

And we can use the same pattern with the rest of the enums. 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
