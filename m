Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A589CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 07:22:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4179C3CD09E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 09:22:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C1B3C84B5
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 09:22:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2F4E209A1C
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 09:22:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CB1F21116;
 Thu, 19 Oct 2023 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697700130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGPjOodX0K7iFNxUMNmxZvh966FV74whIgD/mSJamuQ=;
 b=DhDBwHCVZvfDPeUuY59SEdOM5oAA3NuSzcA/egkNoXEqJPmLL4a0CrJsuffY4xiKonvcSr
 F81QVsL7Hi67RrNGHrIuarTVBEJQxexHcRNYqSzCKHPhCQ2y9YhsXKkOXI38Vdri5caKaZ
 2vYuZ2b3/7F+W1KjfEsSGx18fRrIWIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697700130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGPjOodX0K7iFNxUMNmxZvh966FV74whIgD/mSJamuQ=;
 b=U8vnDHPf6JsBklshzEXp/rmsIiHb31SRRoQzHvdovv9dKHdKN/VjAd0V+fzsR/wBdREhKR
 xtvhfEFCrdVdzwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1958F139C2;
 Thu, 19 Oct 2023 07:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OUKnBCLZMGUvEwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 19 Oct 2023 07:22:10 +0000
Date: Thu, 19 Oct 2023 09:22:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231019072208.GB33886@pevik>
References: <20231016184408.879977-1-pvorel@suse.cz> <87r0lswdep.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r0lswdep.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.54 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.24)[73.01%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/7] Remove scsi testsuite + various
 testscripts
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

Hi Richie, all,

thanks for your review, merged.

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi,

> > cleanup of 2 old scsi testsuites and some of legacy testscripts.
> > IMHO the testsuites are not worth of fixing.

> Very good. My only suggestion is to leave a tombstone in the
> documentation (or github issues) any time we delete something big and
> the thing it was supposed to test still should be tested.

I understand the need of missing coverage, preferably over github issue
(we document missing coverage over github issues already).

I wonder what should be noted in this case. These test scripts attempted to test:
* autofs (run other tests on autofs actually)
* BIO (we still have testcases/kernel/device-drivers/tbio/)
* sysfs (but we have at least some sysfs tests)
* SCSI (I suppose these will be better handled elsewhere - xfstests have
  scsi_debug file, mention scsi in some generic and xfs specific tests)
* device mapper tests (there is something ruby based:
https://github.com/jthornber/device-mapper-test-suite from Joe Thornber from Red
Hat)

> Something like "There was a testsuite called X, it appeared to do
> Y, but we had to remove it because of Z".

> It could be useful when answering questions about test feasability and
> for SEO.

I'm not sure if this 20 years old code deserves this description (but feel free
to write it if you think so). But identifying missing coverage is of course
important. Maybe we could have a special wiki page which would link missing
coverage issues [1], but also highlight the most important ones (big subsystem
missing) and also point out what we consider being tested elsewhere or what
would be hard to test with LTP thus should be tested elsewhere.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/labels/missing%20coverage

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
