Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C810C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:57:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C21DF3CDA77
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 08:57:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07AE63CBDC8
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 08:57:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 845B41001F3F
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 08:57:35 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB02A218F8;
 Tue, 28 Nov 2023 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701158253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FMmpIQhmKNRuIvkUtG78JOSdl1yje6XSQpPKTbhGss=;
 b=TEa9+Prk0kX96ZvXNR8+c0aTEg+RZGlsKSy1Og7voKws2gjyTTsmQwCkmk4rQa2tzZTpaN
 GnqaAqIjwow3Bd2QJU5FWwG8Y9tcJQcnZSIHZLtCc5RoUVsZtPPHjLK2llcJlOtlM8Hccq
 El0+Bj/iJ+Gsc7i5ar69aLqNrB1kKWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701158253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FMmpIQhmKNRuIvkUtG78JOSdl1yje6XSQpPKTbhGss=;
 b=dOUC/HphSipN2lmRcQ0EDsBazkHSlqDTnDxc23D/Tz1/vCT4x7c4VYdcUV+M0O+DcxRkx6
 0trtBZq/JftCcpBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5423133B5;
 Tue, 28 Nov 2023 07:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 1zBnK22dZWWaNwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 07:57:33 +0000
Date: Tue, 28 Nov 2023 08:57:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
Message-ID: <20231128075732.GA303912@pevik>
References: <20230921054821.12855-1-akumar@suse.de>
 <20231009080131.GA370124@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231009080131.GA370124@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.40 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.10)[65.47%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mmap04: Validate mapping perms in
 /proc/self/maps
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> Hi Avinesh,

> > Validating the various combinations of prot+flags arguments in mmap()
> > call and parsing the /proc/self/maps file to verifying resulting mapping
> > has the permission bits as requested in mmap() call.

> LGTM + you fixed all Cyril's comments.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ...
> > +	if (!strcmp(perms, tc->exp_perms))
> > +		tst_res(TPASS, "mapping permissions in /proc matched: %s", perms);
> > +	else
> > +		tst_res(TFAIL, "mapping permissions in /proc mismatched,"
> > +						" expected: %s, found: %s",
> > +						tc->exp_perms, perms);
> Very nit: I wouldn't split the string. IMHO it's better to have easier git
> grepping, than follow 80 line rules. Also checkpatch does not complain on this:

> 	else
> 		tst_res(TFAIL,
> 			"mapping permissions in /proc mismatched, expected: %s, found: %s",
> 			tc->exp_perms, perms);

> This can be fixed before merge.

Merged with this change + changed commit subject (rewrite to new API is
important info).

Thank you!

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
