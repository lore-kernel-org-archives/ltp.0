Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3408EC25B6B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 23:15:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40ED93CF913
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 01:15:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D062F3CCC4D
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:14:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EDB9A10007B9
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:14:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D97F21A3E;
 Wed, 25 Oct 2023 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698275690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cLbxwzKTZY88tK/wE+nfXCjD0aSenK5OKBAM+VlPfE=;
 b=EQV5uYpOzFhFu81YOnX87hIQpRW3BbLr1EWWkxVN4+BpM5JIUwt0D4yLc9twhEvrwAK59y
 zgRzswMm3hIjGaRp5zQOgAxN2YZcb2rsHCn5wAhouu2Lprc3WUkecxdG8STRrLcmrZG3Ep
 iCZwn/PRuh2/ciLN7jvvh6f8SRkn77I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698275690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cLbxwzKTZY88tK/wE+nfXCjD0aSenK5OKBAM+VlPfE=;
 b=gkQM4X63WPUYSzrF8apf6jWFxfH6N91TiSb4fvVvk2WPv2XGA1qftYud5CFfPLUn/dPdXn
 2u8ctZeANujbYwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 443EA13524;
 Wed, 25 Oct 2023 23:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q+InD2qhOWXdUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 23:14:50 +0000
Date: Thu, 26 Oct 2023 01:14:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231025231448.GA510491@pevik>
References: <20231024084923.217110-1-pvorel@suse.cz>
 <ZTjgBkVwwvqgbWm1@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTjgBkVwwvqgbWm1@rei>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-9.96 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.66)[98.49%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] stack_clash: Guard functions used only in
 64bit
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
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Pavel Boldin <pboldin@cloudlinux.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > To avoid "defined but not used" warnings when compiled on 32bit.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/cve/stack_clash.c | 4 ++++
> >  1 file changed, 4 insertions(+)

> > diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
Hi Cyril,

> > +#ifdef __x86_64__
> >  static void force_bottom_up(void)
> >  {
> >  	FILE *fh;
> > @@ -134,6 +135,7 @@ static void force_bottom_up(void)
> >  out:
> >  	SAFE_FCLOSE(fh);
> >  }
> > +#endif

> Maybe I'm blind but this function does not seem to be called from inside
> of #ifdef __x86_64__.

force_bottom_up() is called only inside do_mmap_placement_test(), which is also
wrapped with #ifdef __x86_64_.

I did not notice that, compiler pointed it out :).

Can I merge with your RBT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
