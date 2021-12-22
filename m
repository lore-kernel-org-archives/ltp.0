Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067D6C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 19:01:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147173C9297
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 20:01:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 897AC3C08F2
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:01:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC114601419
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:01:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D928221135;
 Wed, 22 Dec 2021 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640199669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuUDEHMI9khWgRz8GkJnfohNJxUU8NrEF1LitcXB1aU=;
 b=KX9Jk7wZtwIb4cUzg9wNdK7E8+diYBKbtYaz/+OTHvY4qEmqVNmrl3uKuDOHqmg/FvqU+F
 ldej9S+EYW6GoNrXTAdF24O+dACb/3XJ/h2yfV/azPAy48HDUqJnP3k4IieXDIFI7ttjoT
 XrcgHAu7onp2DxOvIvAVWZJx9vqG9tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640199669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuUDEHMI9khWgRz8GkJnfohNJxUU8NrEF1LitcXB1aU=;
 b=SRf2bmbPbXVTbe5ePKJWAj/ze9D4D1nEaAbhZjK3wTPktcGJDT5eUYbEeN3CnWNPAbRlGq
 02X8WGZWW+YwejCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95EAE13D71;
 Wed, 22 Dec 2021 19:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XONpIfV1w2HvVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 19:01:09 +0000
Date: Wed, 22 Dec 2021 20:01:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YcN186MaudEJ8x4X@pevik>
References: <20211220212756.13510-1-pvorel@suse.cz> <YcNE2Yt4zLs4ayz7@quark>
 <YcNZ8TDUR8+V+t6g@pevik> <YcNnXzREFOMn86E1@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcNnXzREFOMn86E1@quark>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

> On Wed, Dec 22, 2021 at 06:01:37PM +0100, Petr Vorel wrote:
> > Hi Eric,

> > > On Mon, Dec 20, 2021 at 10:27:56PM +0100, Petr Vorel wrote:
> > > > tst_af_alg.c:84: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'md5': ELIBBAD (80)

> > > This seems like a kernel bug; shouldn't the kernel report ENOENT for the
> > > algorithms that fips_enabled isn't allowing, just like other algorithms that
> > > aren't available?  Have you checked with linux-crypto@vger.kernel.org that the
> > > current behavior is actually intentional?
> > It reports ELIBBAD. Am I missing something?


> It does.  I am asking whether it should.  The purpose of LTP is to find kernel
> bugs; perhaps it found a bug here?

Well, if I understand mainline kernel code correctly, although crypto/testmgr.c
in alg_test() returns -EINVAL for non-fips allowed algorithms, but that means
failing crypto API test. And the API in crypto_alg_lookup() returns -ELIBBAD for failed test.

But I'll check it with Herbert Xu.

Kind regards,
Petr

> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
