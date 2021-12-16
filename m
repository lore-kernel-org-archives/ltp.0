Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3EAC433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 13:25:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8673A3C8F51
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 14:25:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 606243C2236
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 14:24:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D37A01A0199E
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 14:24:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1B7B210E6;
 Thu, 16 Dec 2021 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639661091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1vLlYzYCVttTn2IUe64m2Z1fBcPxgc5NjUEhdNqn+ho=;
 b=qqq6eko+5lf7u4vdn493KXkF8FdphrMl9MYJrZeq05/3p36reuNGqfVe/dsIpWZoDjycdU
 MejSGGAYWSVyBklJkYp7QfJUTFEST68BTekyGBhltCugtdRCFslWm8ZjQ6gXfhGhjp8MAI
 RMUYgU//fkWn2dipVFjmeBNBqH3Jtw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639661091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1vLlYzYCVttTn2IUe64m2Z1fBcPxgc5NjUEhdNqn+ho=;
 b=cSA2g3mROE1lb8uDFsilszXeX4f701G1mgSUsxeQAB6XXEbp3sYeYIGHKXC4SWfbT+rcVV
 yIG4J3h+9KuDI8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCC1213E18;
 Thu, 16 Dec 2021 13:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xe6IMCM+u2H7bgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Dec 2021 13:24:51 +0000
Date: Thu, 16 Dec 2021 14:24:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ybs+IvVwMdjUtVjZ@pevik>
References: <20211216125456.6760-1-pvorel@suse.cz>
 <Ybs6L1f9qcYMaEfw@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ybs6L1f9qcYMaEfw@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_af_alg: Another fix for disabled weak
 ciphers
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
> > e.g. md5 and sm3 on enabled FIPS (fips=1 on cmdline) on SLES 15-SP4.
> > Similar fix to 4fa302ef9d. It fixes:

> > tst_af_alg.c:84: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'md5': ELIBBAD (80)

> That's strange choice of errno, ELIBBAD usually means corrupted ELF
> file, it looks like this comes from kernel fucntion crypto_alg_lookup()
> if the __crypto_alg_lookup() returns alg structure but the
> CRYPTO_ALG_LARVAL bit is not set. Unfortunatelly I have no idea what
> that really means. Have you confirmed with someone who understands the
> code that these cipers are intentionally disabled and that this errno is
> to be expected? And even if that is so we should skip the test on fips
> mode only...

Yes, is the first time I saw ELIBBAD, thus I'll check with developers.
Showing only on md5 and sm3 was "proof" for me it's correct on correctly
configured system with fips=1, but you're right it's better to double check.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
