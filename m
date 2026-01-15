Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3681CD44C43
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768482169; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Bqg1y0943Db4rTRNSzACp23YHCxGdSZgNLkumBtIW1M=;
 b=V691MozfdoLt5LHfBgbUr8RX+Vnklfb+BLQTKllbHb1hgC8HfRWRR3GNM5bjPYgsGv0t/
 wqJuG1EZvEW1NbBwINJDwQbkNtZaKcfTZ3UZwKsk4IcQbDHleadZmBRu7Fn+t2AWvNFrHeu
 7HrJxjz5w5Ii+0WlaKoHBWumGzms6kI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA96A3C9F6B
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 14:02:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B29B3C4DCE
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 14:02:25 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8555D2000EF
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 14:02:25 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so9392015e9.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 05:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768482145; x=1769086945; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHvx010gwi9rR83/KGvy/e8btRE5xe31KhShK8l2OFo=;
 b=A7bJ51G85l2E0DqjoyGazHE31ZMUz1124NXYyyFvWdex6AUqcylMHnExm1rQOH2T2F
 RHXcmiAtqj+BjcDiFOGDPxIVRIsLhLasG9vgeRacxjJAjBPOgVD27GKHl1Y+9Yi88z4O
 ymF2roF3a299kk9QIuCEDhrlNz7/R6+jAZpB9JUtkb54jxVKpNSzZiqqlNvGKUfDMSUS
 DzX27bpWj+9mykaScMaKK1vZ4UYNpBaWLmFc6AdNPR6J7LBqSgLdAekWRU+CPsAfu7wt
 LriScB4gbc/nlwr2J6KQhx6y/m1BCQT/ZUwRVDxuS5TMYk2MKy7wpsYv+Efw4cGsINbf
 a4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768482145; x=1769086945;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHvx010gwi9rR83/KGvy/e8btRE5xe31KhShK8l2OFo=;
 b=nSwX0CKfeKGzYzvI+XaTDTkXKXIsMJQpwR0LFbYVhbkfZwAlXeO3+cDDR/u1piKDjU
 rTKsaIbrGFQEvkrsJjS/4OiIUNxJGhu3GtPpTSXSt1s8dLLNdUZt5NzgkTIaoa/Uk8aH
 mGYZEGWK7dAXV70JIsPk6o1aMZhHNwTMIZHjaMF2KZU+RfVQZI2o017cODzb41UYDxcn
 yGaITc69wXrwPjNIHEEJGOyu+DZ3clOS/XwqeeTBKapGONb8oDhRuSfz6JgRbly/BLxD
 idj4KsBCUrYdZsGhboXFsk5giy+oCl5HQKe9+iZRJT2PCBt/oBRsn2GardstDBjnnYtx
 IQPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgXl1aI/PDdMRkujPSjikXh8gPF95rTdCYeS293LNDx4Q38RKH+yzvnNd8UFTdlhdq+Fc=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/YKp2e0UTUzfHVegcFrEaOd6aDi+i1cb7n3Yk1p0MDY1Zv1e3
 rTJSrWvKqwyN+y6UZRtU/PsGYj1kM3mbbVY6VGE/HXWWnmSHvjbxs7tjXzCHSSgcb7o=
X-Gm-Gg: AY/fxX70t89fIoFmray31MaTVfjMwFpZOE8Ikd7m04CpAGAgKWTjSOzw88+TZkRVTtg
 ojDaLfYUk+IEHVUHTMsdixB8ZYrIpHs7wtF2DSkshw3WlK5zjnKpJqTc0PTHVwYkUQmzWbsfc7l
 /NpjATYHuHq6PhFoQi/XPj4oX69Ae7z0S2on516QU7nmBOeILdcSCErf7972eRGSO7527JGrMkI
 D3Qvek0WldI16hpxEh5zfVFmhUprvm+ppD5TUiVM+AONsBke3Hp/IHxwzjLwRFWz3uvMEWnb/Nk
 afKfuvm2lMCOBGu6WEgupy8cR8HvhQ7gyreAz2ngTFkGi/QgBb2SRYGPZQsDytKtlB+i+lvf68Y
 SJZLshrmhd6Ho71Rd/i8BFHndE+lvU68k8bPkTG9omFYJPYAopaii5nCsyTUDe+w+QEzj0xduhC
 L9j7rRTzhEN4+q
X-Received: by 2002:a05:600c:3e08:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-47ee32fd8d1mr74891235e9.15.1768482144921; 
 Thu, 15 Jan 2026 05:02:24 -0800 (PST)
Received: from localhost ([88.128.90.18]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428bb0b5sm46009505e9.8.2026.01.15.05.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 05:02:24 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 15 Jan 2026 14:02:23 +0100
Message-Id: <DFP6LKYFDHBJ.2NJJ4I23PIGP9@suse.com>
To: "Li Wang" <liwang@redhat.com>
X-Mailer: aerc 0.18.2
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
 <DFP30EO5EZ9M.1UTS5YNH9SX7J@suse.com>
 <CAEemH2c0CpvpTNgoSn9WPGU1MQkgPWjiZ4fOmFpaxgziEZjnUg@mail.gmail.com>
In-Reply-To: <CAEemH2c0CpvpTNgoSn9WPGU1MQkgPWjiZ4fOmFpaxgziEZjnUg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I updated kirk master branch, if there are no more requests, I could
create a v3.2.1 during the pre-release process of LTP.

I will wait and see if there are more bugs to fix and eventually create
a new release.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
