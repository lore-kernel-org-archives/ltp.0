Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B734C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 12:26:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09F7A3C919E
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 14:26:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2921D3C1424
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 14:26:21 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B7A11000C01
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 14:26:19 +0200 (CEST)
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPSA id 88DF56000E;
 Thu,  9 Jun 2022 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1654777579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfmVHs2flaXGCxib32jiEIbIH5jh/x2edanOrYqwY50=;
 b=Ba5d/JPPXRlot6F4+TMmTB5RfBdACs3DU2PW0Qwww4tZ71RmPtfht6ATjNZrTf5tEIxUZL
 kSt6/7jctiQG6ZKTdSjtlkCButRaIkaM5gQDnzEPm0J2LTxqyqEpwg8CWp+6m8wctB5ahR
 nvrg7iSZppaVb+MPUzGqZPR0NYYBPfAoHZ+RK+9N6JPUHgHEdtMtZ1KTGaQqr0CJIBPvIy
 nvgQvjrigPt4qS6Yzmdg8yAwAz3vjsEbsqZEPV828jlSoZrP+PP1+Mnl0Ut5lHtyT0HkXX
 xH2pygRPzxfg6RJiLGbm1VYuQkIqU30wdK4pYXIx6FBQ2CGCMd9JDwUjbWIdNQ==
Date: Thu, 9 Jun 2022 14:26:16 +0200
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20220609142616.2483414f@windsurf>
In-Reply-To: <5d4a4e2b-4d1d-88d6-4905-67083c154775@suse.cz>
References: <20220606184320.8210-1-petr.vorel@gmail.com>
 <20220606184320.8210-3-petr.vorel@gmail.com>
 <5d4a4e2b-4d1d-88d6-4905-67083c154775@suse.cz>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] kvm: Fix undefined reference to
 __stack_chk_fail()
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
From: Thomas Petazzoni via ltp <ltp@lists.linux.it>
Reply-To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "Yann E. MORIN" <yann.morin.1998@free.fr>,
 Buildroot Mailing List <buildroot@buildroot.org>,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 9 Jun 2022 10:26:55 +0200
Martin Doucha <mdoucha@suse.cz> wrote:

> > diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> > index 8d5193d8e..bce1a4eb5 100644
> > --- a/testcases/kernel/kvm/Makefile
> > +++ b/testcases/kernel/kvm/Makefile
> > @@ -9,7 +9,7 @@ ASFLAGS =
> >  CPPFLAGS += -I$(abs_srcdir)/include
> >  GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
> >  GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
> > -GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
> > +GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fstack-protector  
> 
> We should use -fno-stack-protector here instead. Your patch probably
> enables linking of libssp despite -nostdlib which we don't want. The GCC
> stack protector may also break tests because bootstrap initializes stack
> manually instead of letting GCC handle it.

I agree. Assuming -nostdlib means you're building freestanding code,
then indeed, -fno-stack-protector is most likely what you want.

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
