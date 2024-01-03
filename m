Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B69BC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:48:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E64D3C8F97
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:48:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2C243C88E3
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:48:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 856821A00FCB
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:48:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDCEE21EE8;
 Wed,  3 Jan 2024 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704271708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Qv7rUqwWEBJNv6KkniUzFyp86kAf0/fd6pvXRsVxaA=;
 b=pA8LPzGmz+IfrNzzD6aCDWRHAlgUEI84kB4nqAQW1B5jsiufUUwy+ywGtDHTZ2eCHHlfEO
 p4hpnvUcLPD0+jvQEB3DryiEFWk0SYDUNwmfSNAWHgpV4IeXKyzBTOZBEVQVYOXw5sd00p
 uGtE4ZUlIYhzQL6WzLTC7s7GFkelhyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704271708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Qv7rUqwWEBJNv6KkniUzFyp86kAf0/fd6pvXRsVxaA=;
 b=gY8u1GwiGmi/uW//X4BLRuqsk8qnkXAsw7ye3PZAhq2gDXJjjRVehldKoKANmVKeOIapcT
 jXnShex3ldKw+pDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704271707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Qv7rUqwWEBJNv6KkniUzFyp86kAf0/fd6pvXRsVxaA=;
 b=RZpLeuKO45UJTCv1g1eA2fBm4rkFuKU5rbeO4gSIX9XW2eRFM3+51gfkQNSAfPYLOPJzAn
 MvXb4bGF1QA8Y/R8aavqMWDiZTHCiHIBcp3+q9stP94wW0XHFK5vKbjA8/FDkjB4l+c41V
 P/okV9zJmiINWFkPnGXcJDtEQ4zmEjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704271707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Qv7rUqwWEBJNv6KkniUzFyp86kAf0/fd6pvXRsVxaA=;
 b=qXLdaAO0MRjIcFADRnO8k5PpxN+pMOw5ONG3qtyiDDGRKitDUYhdpuhrSIspi9KfKo92m7
 gbnVQ3iyK+WgOwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB54B1340C;
 Wed,  3 Jan 2024 08:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BXP1LFsflWXQYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 08:48:27 +0000
Date: Wed, 3 Jan 2024 09:48:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240103084821.GC1073466@pevik>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik> <ZZUdUXAXNCp5HfQC@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZUdUXAXNCp5HfQC@wegao>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[33.59%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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

Hi Wei,

> On Wed, Dec 27, 2023 at 02:21:44PM +0100, Petr Vorel wrote:
> > Hi Wei,

> > > +{
> > > +	char *res;
> > > +
> > > +	errno = 0;
> > > +	res = getcwd(buf, size);
> > Why so complicated code? Why not just use TST_EXP_FAIL2() as you do in
> > tst_getcwd()? That would be way fewer lines of code. There is no problem to use
> > TST_EXP_FAIL2() with libc syscall wrappers.
> Current TST_EXP_FAIL2 can not handle getcwd (will return NULL). I remember in another
> email thread you mention maybe we need TST_EXP_FAIL_PTR.

Good point, thanks for working on it. It will use TESTPTR().

...
> > > +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> > > @@ -13,18 +13,26 @@
> > >   * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
> > >   *
> > >   * Expected Result:
> > > + * linux syscall
> > Well, I told you several times, that list requires separating by blank line
> > otherwise it breaks formatting. Could you please add it and check generated
> > docparse before sending a patch:
> > cd metadata && make && chromium ../docparse/*.html
> > We should check for it in metaparse.c or in testinfo.pl.
> The original code seems can not correctly handled by docparse since format is wrong,
> so acutally no any description item will appear in metadata file, same issue for 
> getcwd02/03/04. I will update to correct format in getcwd01 next patch.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
