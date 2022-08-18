Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CADFC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:06:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97A5C3CA1B8
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 13:06:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 584C13CA0C6
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:06:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6916E1A00882
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:06:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71B0A3EF26;
 Thu, 18 Aug 2022 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660820781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3fKgmoXc4O6LmJqduAUiIoRF8eDUI+q5OHxFpTEKD8=;
 b=hgZ61TyY1B9jjwS2EmRulXBmrGncQwZJnmDi6MmRRqkZq9Hqls3K1RyC1JusqwFqtTa7/b
 fi5gLoD2T520bW/LjIaa3zJ05P3EpSJwPQm6zFVAsqeN9W9w0CunAvWKYOROEJRw2AVsGP
 +pot37fc2CPDzcjDhoHIwh8GXTvpuhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660820781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3fKgmoXc4O6LmJqduAUiIoRF8eDUI+q5OHxFpTEKD8=;
 b=L0bKwP+SmwypSsS5gbmo5PhzkrCHwN2U4AyLIcNmbmhQhgBGBa7CeRWIQiO9HyEu55/VXj
 jIgJsC0uuvb4f0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C224133B5;
 Thu, 18 Aug 2022 11:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X7aRFS0d/mJsIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 18 Aug 2022 11:06:21 +0000
Date: Thu, 18 Aug 2022 13:08:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Yv4dons8AYcqE9gU@yuki>
References: <20220818100945.7935-1-pvorel@suse.cz>
 <20220818100945.7935-2-pvorel@suse.cz>
 <CAOQ4uxhvf11FxVJcGiy_GpVHALXNnC4qFc0azTi2Qn_FS3oqyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhvf11FxVJcGiy_GpVHALXNnC4qFc0azTi2Qn_FS3oqyw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_device: Increase DEV_MIN_SIZE to 300 MB
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Previous default 256 MB was not enough for mkfs.xfs since v5.19.0-rc1
> > [1] which refuses to create filesystems < 300 MB. Although the
> > limitation can be workarounded by setting three environment variables,
> > it's better to increase the variable.
> >
> > [1]: https://lore.kernel.org/all/164738662491.3191861.15611882856331908607.stgit@magnolia/
> >
> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  lib/tst_device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index c34cbe6d1..8419b80c3 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -44,7 +44,7 @@
> >  #define LOOP_CONTROL_FILE "/dev/loop-control"
> >
> >  #define DEV_FILE "test_dev.img"
> > -#define DEV_SIZE_MB 256u
> > +#define DEV_SIZE_MB 300u
> 
> Subject is wrong - it is saying DEV_MIN_SIZE
> 
> It really looks weird that DEV_SIZE_MB < DEV_MIN_SIZE
> What am I missing?

The DEV_MIN_SIZE macro is used in a LTP test library API test that
checks that test can override minial device size so it has to be greater
than DEV_SIZE_MB which is the size used by the test library when
loopback devices are created.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
