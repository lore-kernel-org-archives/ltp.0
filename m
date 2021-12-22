Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F0AC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 16:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81A493C9284
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 17:49:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7431A3C015A
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 17:49:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5C9C1400F49
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 17:49:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DEF7A210FC;
 Wed, 22 Dec 2021 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640191780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0UYUV5GUN0Ys8n5dLYgaFYEBJaMpIu5VB7Ne6TtRn8=;
 b=kkw3zep6FjdSdk0PIFpfqysVeOMWSgrhRmhAuw8OLpI0rEdBEvpcnZmIKUnvt0fTOYWXnV
 He9z5ZcpUo7SzXZ5dPXQTbGJdFL9Z9q4MtyTjkOHHO9aeWcjTBzdkSLGBcvu2o68KK7Gnb
 Xlz4ZJ2WaWRaiOYjEVQZZXJFgiryrlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640191780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0UYUV5GUN0Ys8n5dLYgaFYEBJaMpIu5VB7Ne6TtRn8=;
 b=ZOnZ/B/ag4JwHl5z0ZFDewLq6PAxg3lNG0oXbt8/0g8kAhjmLZZRJOgOEwcbVW7sBW9Wem
 eiDL9aCZjzqIskBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F8ED13D5E;
 Wed, 22 Dec 2021 16:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rqQBJCRXw2GbJAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 16:49:40 +0000
Date: Wed, 22 Dec 2021 17:49:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YcNXIlOPmE05cGLT@pevik>
References: <20211220212756.13510-1-pvorel@suse.cz> <YcG2blRMnG/x6zAU@yuki>
 <YcHChO+A8Cc8ZDqv@pevik> <YcM6CZnV5v/UpvI6@pevik>
 <YcNLv9eu1EwG5wft@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcNLv9eu1EwG5wft@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Eric,

> Hi!
> > OK, this would not work for af_alg03.c, where false positive TCONF would be
> > printed:
> > tst_test.c:1426: TINFO: Timeout per run is 0h 05m 00s
> > tst_af_alg.c:81: TCONF: kernel doesn't have aead algorithm 'rfc7539(chacha20,sha256)'
> > af_alg03.c:24: TPASS: couldn't instantiate rfc7539 template with wrong digest size

> Hmm, so af_alg actually passes wrong data to the tst_have_alg() on
> purpose.

> I guess that if we want to move the TCONF to the library we either have
> to add a flag to the function or split it into a two. Not sure which one
> is actually better.
I was thinking of both (preferred split), but wasn't sure if it's worth of just
just to filter out "tst_fips.c:22: TINFO: FIPS: on" output.

> Maybe we should split it into two functions, one that wouldn't do
> anything but return the errno and one that would switch over that errno
> and print messages as well. Something as:


> int tst_try_alg(const char *algtype, const char *algname)
> {
> 	...
> 	int retval = 0;

> 	if (ret != 0)
> 		retval = errno;

> 	close(algfd);
> 	return retval;
> }


> bool tst_have_alg(const char *algtype, const char *algname)
> {
> 	ret = tst_try_alg(algtype, algname);

> 	switch (ret) {
> 	case 0:
> 		return true;
> 	case ENOENT:
> 		tst_res(TCONF, ...);
> 		return false;
> 	case ELIBBAD:
> 		if (tst_fips_enabled())
> 			return false;
> 	/* fallthrough */
> 	default:
> 		errno = ret;
> 		tst_brk(TBROK | TERRNO, ...);
> 	break;
> 	}
> }

> The the af_alg03 can call tst_try_alg() and check if the retval is
> ENOENT.
This looks good, thx! Simple enough to merge directly, but I'll send v3.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
