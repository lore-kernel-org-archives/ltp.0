Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C09FC5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:01:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2FB33E6CE4
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:00:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590403CFEB3
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:00:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B4041A006EA
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:00:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ABE4F82309;
 Wed, 12 Aug 2026 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786539630;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RaGsh89O5BLL054ILPwmuAiNk05IL6Yalv176hLEHhI=;
 b=WdmNODO2ziylaNuUWfVI60uBV3B8hlWE4D2zI6L1oI+3GE0sGeaPUOYo3d7ghYSkxUFXOU
 +xDsXKOqQhKUY+gTJtJYHtGBRlI+Q4L2xUp7hxKDY22wfjyTR4DtU+IrkzB8Li+GvcEEtA
 DFlemFnc4H8VszOJfaGGbFEyU6K5l4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786539630;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RaGsh89O5BLL054ILPwmuAiNk05IL6Yalv176hLEHhI=;
 b=1la7tUd+IN48zwW9TUXC9k5mxYmMnfdxomau5e42RY8XfEDK2/EwQ0c1NG6TPvR2T6JjZ3
 gp+SNbuQN9+7a8AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786539626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RaGsh89O5BLL054ILPwmuAiNk05IL6Yalv176hLEHhI=;
 b=Jg1qMebPZ57+kHTZbKUTQTEXLSf4QZeIBztJfw4YN4z0oaWo8S4LA5prmc8D5iAjWqSHsP
 vCr4zIEw0xN7AeNpfFrA7dZjSx/arr9QMl2L7mTUIe/m1Y4lFesJeYSULLgqizg4xbNFTH
 Wbc5XikpS/43OwI5aHu6+CTKlDVE6pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786539626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RaGsh89O5BLL054ILPwmuAiNk05IL6Yalv176hLEHhI=;
 b=aU/9LTTDWbvX08ldfW/qfvuJ3K8y670K7EPT7fVWI6uQ3wi3NGcvdTDCYVKaLvq2VLRDRb
 En02zuRoNneG39CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87997779B1;
 Wed, 12 Aug 2026 13:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jXlZIGpufGpnSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Aug 2026 13:00:26 +0000
Date: Wed, 12 Aug 2026 15:00:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260812130025.GB1758016@pevik>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTyVyeeMo6EQfG@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anxTyVyeeMo6EQfG@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index c69362485e..30c32b844e 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -280,6 +280,9 @@ struct tst_ulimit_val {
> >   *
> >   * @min_kver: A minimum kernel version supporting the filesystem which has been
> >   *            created with mkfs.
> > + *
> > + * @max_kver: A maximum kernel version supporting the filesystem which has been
> > + *            created with mkfs.
> >   */
> >  struct tst_fs {
> >  	const char *type;
> > @@ -292,6 +295,7 @@ struct tst_fs {
> >  	const void *mnt_data;

> >  	const char *min_kver;
> > +	const char *max_kver;

> Also I would consider not adding this, it may feel like we are
> completing something, but in reality we are adding interface that is
> very unlikely to be ever used.

You're probably right. When I started this there were 3 tests and I thought there
would be more. I also thought this would be useful info in the metadata.  But
in later versions it turn out 2 of them are to be removed. Now I double checked
"tst_kvercmp >" code and it looks like none of them applies to .max_kver usage.
I agree that a single test is not enough as a reason to have it in the metadata.
Maybe there will be more in the future, but really just a few.

=> I should probably send yet another version where I implement the skip in the
setup. Could you please comment these 2 commits (I would not resend them)?

* [v5,4/7] creat07: Avoid timeout on the test failure
https://patchwork.kernel.org/project/ltp/patch/20260810160048.1040517-5-pvorel@suse.cz/

* [v5,5/7] creat07: execve04: Remove version check, add linux-git
https://patchwork.kernel.org/project/ltp/patch/20260810160048.1040517-6-pvorel@suse.cz/

I also find things related to min_kver (will be a separate effort unrelated to
this):
* ioctl10.c: tst_kvercmp detection for old kernels might be solved by
replacing to kconfig check => need to check.
* statx04.c is skipping on btrfs based on tst_kvercmp(). This could define
.filesystems instead of .skip_filesystems (btrfs with .min_kver).
* unlink09.c as well (tmpfs with .min_kver)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
