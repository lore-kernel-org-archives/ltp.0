Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5EEC54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:52:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0CAE3E4ABB
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:52:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713073E121E
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:51:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 06BF214002A6
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:51:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F3113E0B;
 Wed, 29 Jul 2026 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785318708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls+rvYEYggYZZt6Sot4Q91eEG+9QUji4OtUJ7n98Deo=;
 b=25y5Na1e9Y8mWc5XNiriTMmROW/f5+CMLRkUQ0xg0mxQ+iPtLSBNDxOQMdgLG+MN6mwR7t
 63ueiQyCJ2V7H4t8T2MkPRIOa47JaUSC67FnToavwVAnxTpGbFwRZt+FF9YdgxAecVuv5D
 xS4W+gZdD4QDgzCNpRMnniDWxwiH5Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785318708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls+rvYEYggYZZt6Sot4Q91eEG+9QUji4OtUJ7n98Deo=;
 b=yuPllItsTS+kq0Plhm+2uGZcCo0d/IKyi0CtoBqHST6wL964/ZCOXRqiq46R0KN3ynXdPz
 Aukq2PwFXL01hACw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785318704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls+rvYEYggYZZt6Sot4Q91eEG+9QUji4OtUJ7n98Deo=;
 b=kqVsetbeVLMeHz53LdowQGAdDCqIbC5cArr1YC01y1zymSHqZ3CtzOEO54gfIm/hsHOFxR
 LQEPu5EIAIsOayWhFI+Mx/xfcX+60sFFbIQGQ64ZlPjatcCn8nAyJikmxWjpuvLw3v60dx
 N+T0U2jTrGMCdB2i7iEmZ86+ng5Xs9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785318704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls+rvYEYggYZZt6Sot4Q91eEG+9QUji4OtUJ7n98Deo=;
 b=BEWcpC89I7RAWRgJfuraRW2Tfmd1CoNJJHZ1+1bbbF2+V1+jGFuyw8k2jG4OLb0rBIFtpT
 hW0+tUD/gkuEB4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CA73779A1;
 Wed, 29 Jul 2026 09:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ae2JFTDNaWokIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:51:44 +0000
Date: Wed, 29 Jul 2026 11:51:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20260729095142.GA24216@pevik>
References: <20260729091717.23042-1-pvorel@suse.cz>
 <20260729091717.23042-6-pvorel@suse.cz>
 <wexuhnkssz5j5kswcmsj73l7i6yrhpsvg36t4hg2e3flxvp4l3@5jczb6r55haj>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <wexuhnkssz5j5kswcmsj73l7i6yrhpsvg36t4hg2e3flxvp4l3@5jczb6r55haj>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,suse.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] fanotify20: Skip on v7.2
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
Cc: Amir Goldstein <amir73il@gmail.com>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed 29-07-26 11:17:17, Petr Vorel wrote:
> > fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> > FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> > reporting pidfds for thread IDs, so this combination is expected to
> > succeed.

> > The test that these flag combinations are allowed:
> >                 FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
> > 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
> > 			   FAN_REPORT_DFID_NAME),

> > Because the above flag combinations are already "tested" by the tests
> > that use them and we don't have any tests that >= 5.10 has support for
> > FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

> > Reported-by: AnonymeMeow <anonymemeow@gmail.com>
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> I agree with the intention. I just think that if the option is called
> max_kver, then this suggest this is the last version where the test should
> be run. Not the first version where the test shouldn't be run. So the name
> is a bit confusing to me.

Good catch ...

> 								Honza

...
> >  static struct tst_test test = {
> >  	.setup = do_setup,
> > +	.max_kver = "7.2",

... it was supposed to be:
.max_kver = "7.1"

FYI .max_kver is a new implementation (part of the patchset, I just did not want
to bother you with LTP internals, that's why you're Cc only on fanotify20.c
patch) and works exactly as you suggested (run on kernel <= 7.1, skip on >= 7.2).

If there is no other objection with with the patchset, I'll fix this before
merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
