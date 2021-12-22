Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C92C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 17:01:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 053E83C92AD
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 18:01:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4504C3C0B99
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 18:01:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D1B720113E
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 18:01:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86501210F4;
 Wed, 22 Dec 2021 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640192500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lhdp4Qt+UtVTDQ4ZKXylPx7PbpUOTaS9BuCkJ87TYX8=;
 b=1yd1gnpiWPHwn61wPxIVGH6rPpBhSLIxi2tdhpH7iEp7ru0Cregf5vJRdIGzfguY4qgBZt
 GYC0At1GcJMsmwrJDaEfnaCjl53zUCJxXeuqqJcTSGMlm8oPcu8WF5dpVi0CT1AGwNqPVK
 Jm+N2LIDiU+ZmzxOXC3QbtpG9AWdpBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640192500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lhdp4Qt+UtVTDQ4ZKXylPx7PbpUOTaS9BuCkJ87TYX8=;
 b=Wx6Emu1IVBwwo0t9txPo3Y2PbK3GqqcG6mAsQxdsvRYTvb4zr75/xtRosvkrGRUKM9KiED
 vpxW0f15rEwBamCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 450FC13D3A;
 Wed, 22 Dec 2021 17:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nvqiCvRZw2FoKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 17:01:40 +0000
Date: Wed, 22 Dec 2021 18:01:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YcNZ8TDUR8+V+t6g@pevik>
References: <20211220212756.13510-1-pvorel@suse.cz>
 <YcNE2Yt4zLs4ayz7@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcNE2Yt4zLs4ayz7@quark>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] tst_af_alg: Another fix for disabled weak
 cipher
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

Hi Eric,

> On Mon, Dec 20, 2021 at 10:27:56PM +0100, Petr Vorel wrote:
> > tst_af_alg.c:84: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'md5': ELIBBAD (80)

> This seems like a kernel bug; shouldn't the kernel report ENOENT for the
> algorithms that fips_enabled isn't allowing, just like other algorithms that
> aren't available?  Have you checked with linux-crypto@vger.kernel.org that the
> current behavior is actually intentional?
It reports ELIBBAD. Am I missing something?

> > @@ -77,11 +86,16 @@ bool tst_have_alg(const char *algtype, const char *algname)

> >  	ret = bind(algfd, (const struct sockaddr *)&addr, sizeof(addr));
> >  	if (ret != 0) {
> > -		if (errno != ENOENT) {
> > +		if (errno == ELIBBAD && tst_fips_enabled()) {
> > +			tst_res(TCONF,
> > +				"FIPS enabled => %s algorithm '%s' disabled",
> > +				algtype, algname);
> > +		} else if (errno != ENOENT) {
> >  			tst_brk(TBROK | TERRNO,
> >  				"unexpected error binding AF_ALG socket to %s algorithm '%s'",
> >  				algtype, algname);
> >  		}
> > +
> >  		have_alg = false;
> >  	}

> This function is supposed to return false if the algorithm isn't available; it
> shouldn't be skipping the test.
Sure, but split into 2 functions (add tst_try_alg() and use it in
tst_have_alg()) suggested by Cyril should solve it.

> > @@ -22,8 +23,9 @@ static void test_with_hash_alg(const char *hash_algname)
> >  	char key[4096] = { 0 };

> >  	if (!tst_have_alg("hash", hash_algname)) {
> > -		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
> > -			hash_algname);
> > +		if (errno != ELIBBAD)
> > +			tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
> > +				hash_algname);
> >  		return;
> >  	}
> >  	sprintf(hmac_algname, "hmac(%s)", hash_algname);

> Why treat this case any differently from any other hash algorithm that isn't
> available?
I'm sorry The addition is left over from testing, it should have not been here.

Kind regards,
Petr

> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
