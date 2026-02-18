Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A07E9A02C
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 21:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B5CB3CF582
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 22:09:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71BE3CB063
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 22:09:31 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ECD861000998
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 22:09:30 +0100 (CET)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-8954c53259dso276396d6.3
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771448970; cv=none;
 d=google.com; s=arc-20240605;
 b=WUgQa7Mk/dS02q2ADLAkkBjkwMMShoA0zUZJr2cspuu89quJLsOsx55WJECDlrhH88
 uLKa5NdPEBiAaAn78chp+JJFQj/I0S5T3W0OSchD9n1JeZSM6jA7wHwW5I5mtV/THBYD
 tMnwXFRj+dwGY2mhXkHqvTEO9yOei4VomcN72YdFyvDaTvFK5/HsxG7G9rlUfsbyc88t
 +jHOn2BmFqoMbo5kyniIC2lUp5stBKr4Hd2mwWKl4TgPCq42WYmfLWzC2P8/hi77IHHF
 dmdnJSmH66oSGlpp+6tTNB/VlVR/uHYve8PUrxbvQ/llmM/ZBA11hqL4ATNb15P6vUFd
 L0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iXif4YZY4fmpmcOouqRrDZyw8FAaMdxd2xD87l1ALis=;
 fh=s/l8os1LGmN/swe6HunaMCg0uvrBVqulQBCR9prm324=;
 b=T1KDUnGUS/oeGUhoIHy2TDdHlww/8frFm60kQhu9p7fIbjUopR1Z5G96EChm5Bg1/q
 O7cOsnHxtWg/Um8E0cVo1oAy9CU+iJriVFOAwTIWuBfnqTPbxs1qbEqeKXmDq0C1KEWa
 0gGrZW6rjlU8AStdaXe0Zro0DmsdyCIYnyDZaTI4GErut/jay8xfiihhoXcxGnG/EaCD
 HAqDWZDg3zf4IoGEU12eW4KHsuE0xqLxpCRoVSgL5lGmkBT6geNb5ciE9WvDE67yRpF/
 Gk40o95kOx7rnma2g6hyZIPFpMrryZiUksMuSMaZ//6VHdjcBEHV4qRmnAPgwYSbMRn6
 hscw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771448970; x=1772053770; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXif4YZY4fmpmcOouqRrDZyw8FAaMdxd2xD87l1ALis=;
 b=tupCjP+xpFhYWoSvLVEvOlNmNx3T3FQh3PgubZiL6+LHchhomQcivTaEPf2pGMIbYA
 A40DUHvkOwtbhCAcOHFLdkzV0E/T8SVim36FPNbGSqduIz+E7GKeXCAJ2bYE4Wosp//+
 4iEIvIa7HKjWIIh+RbAxCiLs3QfCwfDNF6lpqcYYppNIH54UIFwzXFDPD43i1U4pmmiE
 qh3sp6jrVoPaB/Pz2Xhqw8/72MGKMNa/SJh/6m7v1vrNBfeze2w0p9+LJ+DlrMXyCOSp
 ECJaTtpgpCLQuA3p6re2izbemtGLYHfWqmuiuxixkTBM6ECfnsfn+9Km8U50JwqO7UgK
 hU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771448970; x=1772053770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXif4YZY4fmpmcOouqRrDZyw8FAaMdxd2xD87l1ALis=;
 b=bngC1dsNZu6SeYEYS+I3IQKpWh606zCmOff8ZM1uYGvIEXp/rlJ9lihmYcteuPzzCu
 O29FOM75jnnO/HFgcQFr34ApTEsey5L1SlW8Yz/KmyJr3ny1mffgm3YYNQVwtlBc1u/T
 rxxk2kgwg/tOMTPFjYtwFttVhXa+g+DgAUQMQuPgjZWpqiZeej6EBV/IRpCc/IA/psBI
 Yhbxr+wd2R0KkUmvL8T84PFAxWE69RMbOi2bxOLuVQ5bUf3VX7u5bL9C/0rhzKc4yiMm
 SZ8NODRvhaHJ3eSbV+Rk7TisSm2VlGvGGOlTbMohws2LeCaPPQa1txA9eZ7dQwQlThZn
 Xjng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGvb/wEQ4VA5r74zARe6+Y44BUKKshP/RikZd0+vL+g8qqFqYG1dRoGh1Et05q5py/n7M=@lists.linux.it
X-Gm-Message-State: AOJu0YzCYS4CW7vBRi6xvpoCg6ornP3F2PJ4hwybFn0S5Pvy/UkkFN8B
 N6WAnRQ2yO4MuAc9MzM0Js+LXcdn7klgtEPkupbWI8FospQDV/a/DVGf8RZkIEexW//Lx+D/DY3
 6qoHfYqIP58uYEBS0OgetJDKI5M6/QU0ECVhUPFSpkQ==
X-Gm-Gg: AZuq6aLhcJAh0QIiccQmzVvpG+ifwmnvGbuYY64WCmHebBls4Wqh4uKXkFZHoDT47uK
 IBqFpcW0zBITD5VQ5rXyHoJiipj9iUcUJJwjk18z2LYA/hNbI59BqkiLtYZk/35n412gHk3Gfep
 PTFswn8h6+BjSOkR0Spm66ZumDLUgN6ougIyaSgbI6tKfwBCEBGxWOtSyKv1dNWcq8dishWgRTS
 WUup2AbWTWgEhnOOzKYp6XNyTryOn4Z0XQFDrsB5nkhNtM4bj/DzICC2YLCoq7VyMhcTGDAf+Ns
 sgedwljO//hJ5qqO/mWwg8aDmfE=
X-Received: by 2002:ad4:55ca:0:b0:899:5565:efac with SMTP id
 6a1803df08f44-8995565f010mr36185476d6.3.1771448969568; Wed, 18 Feb 2026
 13:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-4-pvorel@suse.cz>
 <aZQ1C5aOlD-6qIce@yuki.lan> <E8C09635-59E1-4DB0-A223-7D05616029E4@gmail.com>
In-Reply-To: <E8C09635-59E1-4DB0-A223-7D05616029E4@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 18 Feb 2026 22:09:18 +0100
X-Gm-Features: AaiRm52L2XkUf-qjSzMztOb3x0BfFvapgRYOWCeNI6E1xVQH-yA8ThZfb6a6Tcs
Message-ID: <CADYN=9JyZdFvFJYF+pnmxin=2_ND0Kmfm90XO726v1LFNdB0KQ@mail.gmail.com>
To: "Enji Cooper (yaneurabeya)" <yaneurabeya@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/6] runltp: Remove
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAxNyBGZWIgMjAyNiBhdCAyMzowMSwgRW5qaSBDb29wZXIgKHlhbmV1cmFiZXlhKQo8
eWFuZXVyYWJleWFAZ21haWwuY29tPiB3cm90ZToKPgo+Cj4gPiBPbiBGZWIgMTcsIDIwMjYsIGF0
IDE6MjnigK9BTSwgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+ID4KPiA+
IFJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgo+IFJldmlld2Vk
LWJ5OiBFbmppIENvb3BlciA8eWFuZXVyYWJleWFAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IEFu
ZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJvLm9yZz4KCkNoZWVycywKQW5kZXJzCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
