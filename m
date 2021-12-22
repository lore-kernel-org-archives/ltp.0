Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63C4C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 14:45:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56D893C9292
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 15:45:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1A963C06C4
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 15:45:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A545210005C3
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 15:45:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C60BF2113B;
 Wed, 22 Dec 2021 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640184331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qM9U+eGz8TP5kvqtI2IQKtniYBSILfpYhcA7XDPoG7o=;
 b=klIOTKbRgsC5aaSYwQg8ItUZ77xYsJyoSdfUf6zJy2mmLxSdZTJBzRlQ5gKjGD924zdoq9
 6bmzFBJnB1xdTDxQsCjU0xuvkgG5FvDCMDmXWpF5s8og61GZI8vh+VMDOe7sVG+VuXIIHx
 Gn96ic3U2dMlDT3OA4Vp4+bQoSb4zKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640184331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qM9U+eGz8TP5kvqtI2IQKtniYBSILfpYhcA7XDPoG7o=;
 b=NIfrdpQA4K3JNDx9XK+0dl77mQzV1OBMEAeCN2jXqltbKTWEc/ee+Qe3Fe7E6Om7efuvQG
 gYgm6unIqpXfU3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E15613D2A;
 Wed, 22 Dec 2021 14:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4FqKIAs6w2GdbwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 14:45:31 +0000
Date: Wed, 22 Dec 2021 15:45:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Petr Cervinka <pcervinka@suse.com>, Eric Biggers <ebiggers@google.com>
Message-ID: <YcM6CZnV5v/UpvI6@pevik>
References: <20211220212756.13510-1-pvorel@suse.cz> <YcG2blRMnG/x6zAU@yuki>
 <YcHChO+A8Cc8ZDqv@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcHChO+A8Cc8ZDqv@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > >  	if (!tst_have_alg("hash", hash_algname)) {
> > > -		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
> > > -			hash_algname);
> > > +		if (errno != ELIBBAD)
> > > +			tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
> > > +				hash_algname);

> > What about moving the tst_res(TCONF, ...) in the case of ENOENT to the
> > tst_have_alg() function?

> > That way we would have here just

> > 	if (!tst_have_alg("hash", hash_algname))
> > 		return;

> Hm, if I haven't overlook anything, it could work even for af_alg04.c,
> which uses it !tst_have_alg() once without TCONF:

>  28     sprintf(vmac_algname, "vmac64(%s)", symm_enc_algname);
>  29     if (!tst_have_alg("hash", vmac_algname)) {
>  30         sprintf(vmac_algname, "vmac(%s)", symm_enc_algname);

> Moved to tst_have_alg():
> tst_fips.c:22: TINFO: FIPS: on
> tst_af_alg.c:90: TCONF: FIPS enabled => hash algorithm 'vmac64(aes)' disabled
> tst_af_alg.c:94: TCONF: kernel doesn't have hash algorithm 'vmac(aes)'
> tst_af_alg.c:94: TCONF: kernel doesn't have hash algorithm 'vmac64(sm4)'
> tst_af_alg.c:94: TCONF: kernel doesn't have hash algorithm 'vmac(sm4)'
> tst_af_alg.c:94: TCONF: kernel doesn't have hash algorithm 'vmac64(sm4-generic)'
> tst_af_alg.c:94: TCONF: kernel doesn't have hash algorithm 'vmac(sm4-generic)'

> => I'll send v3.

OK, this would not work for af_alg03.c, where false positive TCONF would be
printed:
tst_test.c:1426: TINFO: Timeout per run is 0h 05m 00s
tst_af_alg.c:81: TCONF: kernel doesn't have aead algorithm 'rfc7539(chacha20,sha256)'
af_alg03.c:24: TPASS: couldn't instantiate rfc7539 template with wrong digest size

Kind regards,
Petr

> Kind regards,
> Petr

> > Other than these two minor things this version does look good:

> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> > >  		return;
> > >  	}
> > >  	sprintf(hmac_algname, "hmac(%s)", hash_algname);
> > > -- 
> > > 2.34.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
