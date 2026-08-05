Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E384C55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785938953; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=XOgetI6COfIHO4LumG9+Rm91F10rv7S1KZbXb6oKWtM=;
 b=CJrb11phlWlb7pKLRpDQduZPWzSxQ8ySN6VdAboSBGQ+VZp7lrK4q2ILpTTg5uB7xbKpp
 QJY4gQX9JXBjaijC3VMRxZdRO/IslRCr1o8KX+PruOJQPtk+yi016BjHNNHYnkoijLTJhGG
 EdUygnCGCfQlpPf+VG2prkAoNbSKHr8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8EF23E715C
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 16:09:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3BF43E707E
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:08:11 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28FF41400E17
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:08:11 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso11105885e9.0
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785938890; x=1786543690; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1/ZRBePq4TLsoxBaidahN9DfBfr97y2nGIfvfzu1Lv8=;
 b=PeGZWc+6QTGPTF9PyXA8BbJ8kgfADMp8WnyOEF51+EqlSvw1mDIeRddnnXlFthaJup
 4DM9ywjLPdCuDcGYIjoa+4+AW2tarXZMiNdEhPXJLaOqOq0uIPQQE/39XA+oYyE3e7qT
 t7pxEI0Rh9In8kBL5eXrjpGAk6/gqIFAlIkj2eCbADVk8Q6FSJYtwNEqScK0doJMnvjS
 PBoRfRy22bH+CMN08jxA8GnS8C/TshAzdTT7TLK46OUNGiHNsIfH0fpCaLyPy1foa99l
 p6qKfnIHTi7jrELPubEH7sg248qINbu8v6gt7rxwO9YKgWUntpFRyKnrEixvbCgiGUgS
 WNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938890; x=1786543690;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1/ZRBePq4TLsoxBaidahN9DfBfr97y2nGIfvfzu1Lv8=;
 b=bddc3aTEU1mOwXHbAg+TqxT+qaJ40K00bCiAc6+93jUcZtE3JEuKPNjnI6Jh/y/oAT
 AshaYUz4OrY394BM/XVjgxsJNLufEndoADOZ2EAnt6DM9YQ/pzjnJtFbwfjSYnEUeGlj
 GJ0VCJgIFjw9Pd6S7yaPitpM834wwkk2yNSmdjAUjAfR5SLuNK2D1PJ5ra4ZKQGwsvFF
 tFayqAX9msVQ4Z6jEDt3mci1mHQtL6Ypf4OHXyWP0KF+z/IlE5fJIW2UQdbG3NBeyzCp
 pdeHFuWplChH9pdvaDaGfx34ZOzXHFWlLD2zV2pP+mVBgzf4QlH/OkC3fnDZQKFn8nuR
 LApw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHitSJIRH2Lhvnlc7LzE/PFAlXFd8h4QsUjpUn0IwFqIqbH+smrKadYldTY+2hHy5Hy90=@lists.linux.it
X-Gm-Message-State: AOJu0YxoPkfgqI/Vfv73lxSnr2oMmOnGeCr47wg6LWl9MDCV2se9+5ot
 MfZRUyjsgSIqqdlSzwBdxvW5jF6K6JVftcRfy6p5yjdUMB1e6y8QfSAWtl6F6hiv09s=
X-Gm-Gg: AR+sD12t57iL9Ba9d1P1bQDvop979Mz7rDHcRFNK48FSFrdXK5ueju5F2oUFNzN1l2+
 hZIDUFNKGbgjOYFrDlK/3G5g0o5U7wcJHOLJML7RSuLvtSX27Kb7EWOIIlwx3k7scRuQXdaeNmX
 5bNzHQ9z9JAE80TnpId1cLOBSjr9CRPsRwpZaDAIUsRozWP8ZG0xeLil+d3EGSqHFl+ug1zfd6R
 Wex6e/Uc+b7RRgHbL8xtWqvFt9eAXsoEcMf6M8Sow3i4wyqLmRwyrvF15gn4yApkaufbgCXqiTs
 yey1ZWlFM5gmCJ64EXfU9ME/UUfxr/EFQXqi3vuOYvS9nrmGVpgDoqkOvKaKNiLd0mCeXDaSgDh
 ZfID+h38HXJSmVCXq9bMPql8x4LgwVbEanEaXrxt3tRsMUBL3ST9Mr4ZuQufR761EHmic7DiHSa
 dV2oC5cAU6+AxSHEbO2e42DJ3JEi5JxfEbM6NTRBnwH9BmIcbgckN89WbzWah+7GQBFouKHPGSt
 bG1rvBHWn+R4FItna+8kRlYFqQwWV3BYMj0P9EF8YkAg/12PDAEwKYDEV/vnF61HGapprCyWezb
 8a9SF7Lx+nSpGqEaKPQxD+3ZzvQt9ZB948/p1fBrwqx6KTDf
X-Received: by 2002:a05:600c:a47:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-4994e718f78mr83755335e9.5.1785938887932; 
 Wed, 05 Aug 2026 07:08:07 -0700 (PDT)
Received: from p200300ef2f1109007d27a2191b5ea63b.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994dff10a4sm98096285e9.8.2026.08.05.07.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:08:07 -0700 (PDT)
Message-ID: <6a7343c7.80d8f3ad.1a3e52.d22f@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260805111213.GA543284@pevik>
Date: Wed, 05 Aug 2026 14:08:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> I deliberately wanted to fix it before updating linuxdoc + document the reason
> even in the source code. But, if preferred, I can swap 2rd and 3nd patch.

that was just a suggestion, feel free to merge like it is now.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
