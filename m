Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D77CA5FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 14:11:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03BA33E5CC4
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 16:11:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB4643E2DBB
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:11:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D0AD2002D4
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:11:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8796321DC7;
 Wed, 30 Sep 2026 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790777464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGTdbhWVOp/vl4ddbF025um9xhz2/edvmGQRAzH5dVA=;
 b=u32BlWEGzRXYLbxhzQrsZE3dOw4EyD40+GBSRB7SSqUeQyWofJcZymzElRJZTcxx4Ketyu
 EsEeA8VioDvUdWLE4MA4n1F9Q6klfJynek5XMuJIYnKeu/G+y7dU7pSMre2eZm4dnJI5Iz
 2EiLohDFHVXn0TUa8G+HbhiW1ufQb+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790777464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGTdbhWVOp/vl4ddbF025um9xhz2/edvmGQRAzH5dVA=;
 b=X5rcjQqghjSNekdVXbu48TqPK9JNkNClJMb8wMQ3dppo1VnduVAA3GnEB9nwhxvE8nUnJn
 m4JWy9WV7HboEFDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=etn16Zxr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SFVZlv83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790777460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGTdbhWVOp/vl4ddbF025um9xhz2/edvmGQRAzH5dVA=;
 b=etn16Zxr1vS9wDlMyWInaOsQY09z3LmGfS57CeLB/bQ/lpUePqCf+Td7xXNv9tY4f3iGuv
 iXgdZLBrvq6i9FupRHezb7BPZd9iUYheIREkKAVLSM3P05JJj1dzNmEuFqiBJ+s5X+Ym5v
 VeWjJN/OOgOf2w/wyAePSn9N/k+9l60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790777460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGTdbhWVOp/vl4ddbF025um9xhz2/edvmGQRAzH5dVA=;
 b=SFVZlv83Q24IGD+cD9zjkvX3/gVu1mQlmbEdhULIRD+4cbmpBK2Uc7tyR3+calj6ryvUBP
 Op3TXhn7XihN6ECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28A96136AD;
 Wed, 30 Sep 2026 14:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WICvOnMYvWrFYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 14:11:00 +0000
Date: Wed, 30 Sep 2026 16:10:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Message-ID: <20260930141054.GC2721643@pevik>
References: <20260928212733.2835408-1-anders.roxell@linaro.org>
 <20260930125347.GB2652589@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930125347.GB2652589@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8796321DC7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] accept02: Join the multicast group on lo
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

> Hi Anders, all,

> > The test joins the multicast group with interface 0. Then the kernel
> > needs a route to 224.0.0.0 to find a device. When we only have lo,
> > like in a QEMU guest with no network, there is no such route and the
> > test breaks:

> >   accept02.c:52: TBROK: setsockopt(3, 0, 42, ...) failed: ENODEV (19)

> > All traffic in the test goes over 127.0.0.1, so join the group on lo.

> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  testcases/kernel/syscalls/accept/accept02.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
> > index 17056625e933..09a1c35e2591 100644
> > --- a/testcases/kernel/syscalls/accept/accept02.c
> > +++ b/testcases/kernel/syscalls/accept/accept02.c
> > @@ -22,6 +22,7 @@
> >  #include <errno.h>
> >  #include <sys/socket.h>
> >  #include "tst_test.h"
> > +#include "tst_netdevice.h"
> >  #include "tst_safe_net.h"
> >  #include "tst_safe_pthread.h"

> > @@ -112,7 +113,7 @@ static void setup(void)
> >  	client_addr = tst_alloc(sizeof(*client_addr));
> >  	mc_group = tst_alloc(sizeof(*mc_group));

> > -	mc_group->gr_interface = 0;
> > +	mc_group->gr_interface = NETDEV_INDEX_BY_NAME("lo");

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> I tested that it really fixes the problem when no network and runs ok.
> But I'm not 100% sure that it did not affect the CVE reproducibility.
> Therefore I do not add my TBT.

And unfortunately this should be really verified if the change does not affect
reproducibility. Hopefully Martin will get time for that soon, but this will for
sure will not make it into the release planned for today.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
