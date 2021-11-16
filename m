Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C9C433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:32:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38F663219
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F38F663219
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 093043C873F
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 11:32:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D831A3C7CBA
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:32:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61F191A00258
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:32:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A8303218E1;
 Tue, 16 Nov 2021 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637058747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRZq2cXGsHc7xwSh1c2gvMwRNN+THEhlqaG8A5UTzTw=;
 b=t1oABs09dJrG/WiojuEAzlEJUbDKN9iPgFvLo7Ug3lH4GLK3HhLa8fsTHqt+N9lQWIJaLx
 gU3zijBlPyMNepNjSbM6L8vAK9GPMMKHbFEn5IJXmrIlXlgmJUQek8I7V32pvRI2bHYghf
 HrLrI/f/NQy80Fkp2WHsuZdHcYND0fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637058747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRZq2cXGsHc7xwSh1c2gvMwRNN+THEhlqaG8A5UTzTw=;
 b=7YOKy1nz7pX/igI6O8opgKE1oUz8x/m32Ai0/SSYmqP4QE25CEcOWY/pbnzoBQvaoOPtiJ
 3G9+EWpsmxwZxEBg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 67A16A3B8C;
 Tue, 16 Nov 2021 10:32:27 +0000 (UTC)
References: <20211109130910.1583233-1-liwang@redhat.com>
 <YYqdxmnJi5je9DvV@yuki>
 <CAEemH2fJHN5i0W9poB6H2JWXUNRBjriXp21VG4x8r5n4oMvhbw@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 16 Nov 2021 10:30:29 +0000
In-reply-to: <CAEemH2fJHN5i0W9poB6H2JWXUNRBjriXp21VG4x8r5n4oMvhbw@mail.gmail.com>
Message-ID: <878rxobdc5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

>  
>  > +#ifndef TST_ARCH_H__
>  > +#define TST_ARCH_H__
>  > +
>  > +enum tst_arch_type {
>  > +     TST_UNKNOWN,
>  > +     TST_I386,
>
>  I would still probably name this TST_X86, Linux does not support i386
>  anymore, the remaining 32bit distributions usually require at least i586
>  or i686...
>
> Sure, If go with that TST_X86, we just need to do modifications based on
> V4 like below, right? What else am I missing here?

Cyril made another comment about static keyword usage on patch 2. Could
you please roll a V5?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
