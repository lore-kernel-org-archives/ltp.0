Return-Path: <SRS0=YkbW=OY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165DC433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 18:02:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84C760FBF
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 18:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E84C760FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D51E3CAB8F
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 20:02:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E32273C6EA3
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 20:02:35 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3A2F60066C
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 20:02:34 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 g193-20020a1c20ca000000b0030d55f1d984so50835wmg.3
 for <ltp@lists.linux.it>; Mon, 04 Oct 2021 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to;
 bh=qBqo/Bu+11mnPiT/ecyfowDH+il5bZItcP881icIC4E=;
 b=BOkkXGDn5gv4YKOoXiTECw/fFvfXl4VnrPgpahziEuH0ue4ELXpZ66NO7fQEoT6tPv
 9xblnTiMa+xI+DUvw3hwMqSLiZLhHp/BU1I4XiW96m1GmEvA01JgD6OEt0t7BUkacOuL
 lJ+Snf4f9gIaXNnOhw9BFMTGpQRSOOKRS/L1wtyKgKJ6MRZRo6+jbfmC3WfmtA4kpMxX
 juDqDo+WqIatS5SExzZxs0DZnuNcNJXmjJzeamNyOpkAoY32kV2zkNbGS3H4YhaHsZQm
 GzBtalaxsM+8EN8v0OuG7aOniCOZRbckI2oLo55XxJpu27U3MsE717uJysFjL51PnZMR
 Z4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=qBqo/Bu+11mnPiT/ecyfowDH+il5bZItcP881icIC4E=;
 b=YRb9bvY8w+wDE2sTKPpE5EbHqZEPQnDawaMWyAlZ6dm2KbitWNWKgzvo11uw+G4Nwq
 4JMB/Co6Wui36DcOWWRhuJoIl87jOuIUA6Lesqv+enGvmBXjjhZoS0uKlMacpTg64hNp
 dAT5HNu1o4uLKISmldXXziNWAniT0Nim/rK+aLUbKDclS4m1iBfTUJvUO1x++9c/45o7
 ZFMUJZjakXRf5s7np0Dj24uuz4TnbDEf2TddXA2akfaYh0pOnJNP1aLkR4ZLNIBvkV0X
 p4VP5J7Ue+6yac8JH1iMLlx960kanPHkZpsDe08dz/6wyjnZV1RojVqv8NAj2KTvcyoO
 YHMw==
X-Gm-Message-State: AOAM532iHnu1v7CFi8oSQWsA358TOPGp+/6SG8na1NcF3gY0XieYxicc
 QDF+1Xm3HbhArmhPryFKCtQ=
X-Google-Smtp-Source: ABdhPJxMEuejtzTSXqKveJNbXbNpqEhtq4CEIi8fSRSNF25lQ/w4GDPh5QpturFPr11ZlAdnJrMCKA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr19648986wmb.112.1633370554351; 
 Mon, 04 Oct 2021 11:02:34 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id c5sm5301213wml.9.2021.10.04.11.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 11:02:33 -0700 (PDT)
Date: Mon, 4 Oct 2021 20:02:31 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Sandeep Patil <sspatil@android.com>
Message-ID: <YVtBt+WeskISn5+9@pevik>
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
 <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: Sandeep Patil <sspatil@google.com>, ltp <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Sep 29, 2021 at 1:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi,

> > from 20210927 LTP release:
> > > * Testcases were fixed not to expect certain users and groups to be
> > present on the system
> > >   - some tests were expecting bin, daemon and similar groups and users
> > to exist on the system
> > >   - now LTP depends only on user 'nobody' and group 'nogroup'

> > At least some tests (e.g. fchmod02.c, chmod07.c) require other groups
> > ('users',
> > fallback to 'daemon' which is on AOSP):
> > ltpgroup = SAFE_GETGRNAM_FALLBACK("users", "daemon");

> > @Sandeep: is 'nobody' on AOSP or do we still need SAFE_GETGRNAM_FALLBACK()?


> AID_NOBODY seems to be part of the AOSP already[1], so I think that might
> work.
> I dont have a way to test this immediately right now, so adding others who
> may be able
> to verify in CC.

I'm sorry, I was wrong, I meant GID "nogroup". Looking into the source, there is
no "AID_NOGROUP", thus we need to keep using GID "daemon" for AOSP instead
"nogroup". IMHO instead SAFE_GETGRNAM_FALLBACK() this should be set somewhere in
the library, so that it's for all tests.


Kind regards,
Petr

> - ssp

> 1.
> https://cs.android.com/android/platform/superproject/+/master:system/core/libcutils/include/private/android_filesystem_config.h;l=183?q=AID_NOBODY




> > Kind regards,
> > Petr

> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
