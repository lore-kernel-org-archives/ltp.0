Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B342C004C0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 13:35:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72BDD3CECF1
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 15:35:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC5A13C8223
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:35:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06BA368723B
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:35:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68F4021AE8;
 Mon, 23 Oct 2023 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698068123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jdr4XZzhAjEcWDn2WwpOm1exqKMJYNVHjaDEP2oVSV0=;
 b=VBFwYPJet+Qt/i/LjSTzCzDPPZTFlJzTs2ggF5beOCot3bhXdeGufvsT6qxdnSrOTRIya3
 5vEQPbFDcx02QtoITyvAGetfQfimPgSDm7USM27fVbyHt3YfR2CjuSCBUFL7m90B2MUKce
 ZSUMJn1v/k2KzFZBFLcjx7ZvkVYnJhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698068123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jdr4XZzhAjEcWDn2WwpOm1exqKMJYNVHjaDEP2oVSV0=;
 b=JGe7RRDBlV1K4Q4u4dNshIaQcrNwOAgHd1dvG90t5RoXTolJywRX+SFcIXXcgh79d5bqX9
 3rVBmosxipHFkfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 383AB132FD;
 Mon, 23 Oct 2023 13:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BG9uDJt2NmXTUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 23 Oct 2023 13:35:23 +0000
Date: Mon, 23 Oct 2023 15:35:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20231023133521.GD23219@pevik>
References: <20231020150749.21165-1-mdoucha@suse.cz>
 <20231020150749.21165-3-mdoucha@suse.cz>
 <CAOQ4uxgV-PoXQ6Aeimn8T5tUbXX_8RRMwXtAqzUix7ro=BmV-g@mail.gmail.com>
 <5f74b10f-2a97-9cdc-69c0-5e90f1d5d986@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f74b10f-2a97-9cdc-69c0-5e90f1d5d986@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.59 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.29)[74.63%];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: Improve check for unsupported
 init flags
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > > -       if (fan_report_target_fid_unsupported && tc->init.flags & FAN_REPORT_TARGET_FID) {
> > > -               FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
> > > -                                           fan_report_target_fid_unsupported);
> > > +       if (tc->init.flags & ~supported_init_flags) {
> > > +               tst_res(TCONF, "Unsupported init flags"

> > suggest to preserve the information printed by
> > FANOTIFY_INIT_FLAGS_ERR_MSG, you can use tc->init.desc
> > the for the flag name string.

> tc->init.desc gets printed by the TINFO message at the start of the patch
> chunk. The return value from fanotify_init_flags_supported_on_fs() is not
> preserved anywhere by the new fanotify_get_supported_init_flags() helper
> function so I have nothing to pass as the second argument of
> FANOTIFY_INIT_FLAGS_ERR_MSG().

You were faster than me. I don't know if it's worth to do mapping with function
similar to *tst_strerrno() in lib/errnos.h and print info about unsupported flag
(as string) in fanotify_get_supported_init_flags()).

BTW original error message does not print problematic flag in init (e.g.
FAN_REPORT_DFID_NAME_TARGET), but the corresponding one in the test
(FAN_REPORT_DFID_NAME_TARGET).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
