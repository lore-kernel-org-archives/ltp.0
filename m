Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A7BFAD3EC
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 02:18:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78B103E580F
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 04:18:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D134B3E28E4
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:18:30 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54B3114002B0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:18:30 +0200 (CEST)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8b038a00370so47796366d6.1
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 19:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776910709; cv=none;
 d=google.com; s=arc-20240605;
 b=Y4IW10lCt8Y5LFn1Do0THgtB7UXn165XyE6GfemOe6smxwXKzYl2erWjLkGUcRn40O
 bvMhUtA9Yj+Fy7UfmQyDQdAus8t6p7cfWzOt1OqR2FHNUk6YuxjmN8+um70Nw58X3M6/
 MLL0DqNmWpvsS5F2YAr/M2dkrqYYKdn2GsGNEy8pXtzmITgw0T40Fbs2TPPEzQkmypIg
 ZIlY44jIXC0O2+Kifa5PGSc/Xqk6ZhGjT6+Uq0Ph8QrDx6SKq8HjChpspFyW4HIjs3Fw
 n9Tp5lqEiADxTFrR9qd17yBDoNK3QEPGvDJxHGWE9o25lE8IEiEWHCltB0xVXI1Nf9DD
 3nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R8wcclMwIy/TTWme280oP0g3kIGDTz5XXnk+DL82Aqs=;
 fh=JmHdkPNjCvPWjSmne5zolTUmv6wxZkErKji87HThK04=;
 b=D2y1Md7j4eRHbuZQOAHBBc+v5lyHSFNotAN0GHkMfnsxYjtCUuBetFOIWhMzYISlGo
 GUicB9tQuukIGb946AhzNrFTB+mGc+aps1HKpTef/0u9hJo7OhHa8dusIuBczHyOwx1e
 X/G+YyLc81ck+3TbcKaFMFsIbBKXJAM7+3l4+MEQ8sHVwpGBDcvF2tPHZBBWJV8x8RrB
 +IYmP46whqSR3bTOQbkZVFwQP5u1nuBuha5Pxo9YsBPvaUn763gduO1xYJvG05rfJ9Py
 c9ocJvz6RWqhtK/u79LTJrjHvPMg443nBUM1VbFU0XaLdDmMBuvsVsVqs2R2tobjwPFj
 2Qrw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776910709; x=1777515509; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8wcclMwIy/TTWme280oP0g3kIGDTz5XXnk+DL82Aqs=;
 b=PANYBk5ylVrBRBI1m4ivX9GgUdS12m0gjsoBiABnqX9QToMvnh+zkyCnGUz8uaFjAf
 KEjhQXzl9/C+T5V4tXt1W3xl9QYE7WMceUt8HAGaouKJCvtZPfdu9HtxJ0SA1t/GOuo4
 1YBbW7dY7rihnyEj885QragFSUo+2ApljRsGhZDg915kzPRo4ce8GbEeJIrjp1NHFC6Z
 t5tJ26gJhgeIEvMdz+maI0A+2Ldm3BE84Ty9JnJbB4n6T3k5wrrcUYjFOMaDGNx6Mp7S
 5VlwgJ7HUJsfMv0iSb+TyYSga2xoKHPvfpJ880jefKpZrr3G7Bb3Lwsb7DVJMkEkgEAs
 eysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776910709; x=1777515509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8wcclMwIy/TTWme280oP0g3kIGDTz5XXnk+DL82Aqs=;
 b=jCQkaJjUtZ2soVIdldFOxoGipi47SAX+sbU0qKmq8/r0c/F0yLbo15lF4egzVTB2RR
 qA2GdgsEDn/IYSFzVepkutMdNDGDXc2Y1AopDE/uU/M+hjOQhs84xdISjWsewRvG5Baa
 Nny/ASGboOxtCXl+Q3msGQ95D/4WsfObSQNHI7i8dxJqe99XoKtBWWIvcXxBDCtvNq/P
 ebk/ek3shJ5k5dsnam5jyTVU9lYkJ1rbnSYvabVwUGmjcoV5YxfAxHK36OfT1C05zNpu
 GBjr1FbNt8aYSEeQ/K4I/wP0NhiTYlvUyrod0PA0jc3HjnLr5mMqDLNeQiJPeA2ol2AT
 zg8w==
X-Gm-Message-State: AOJu0YzYpDL05CwN5Ql4OuZqZs3d56PwnTnj/op68qcagexEBoPpt8JG
 AlQo678remm20B5cxtavZbhrCST7E3twn3jtbiLuZBpU4BlIw6sit5BP7jKkadB2qB/duRwYoRs
 qmtRWrUCK/JE6V4zajUBLDpUHZ2eckg==
X-Gm-Gg: AeBDievnxOzT1FqhNCXRxb3p2YH9fqD2CMC1mQq0E8yoezmCyXPUmQ4K6TpjZWAiqN8
 a8X25iriInsKXmUsMn8V2Eb9EJ7++wXbBbdt0/cPaQ5UJ8c0/dkqSEiqca6V25wVJCHLYj5BCHH
 WtqK69IUdVsLveCxOGgEwKiP6vmiNo4CUECpCZW7CM9FeGoIfAsdZ7lIuimxoJr43LdaX28G40j
 IkR1MOfB51mhZusNoSfbZZqw51HerTbpzui9wEcWgvqNRjVQou1iSm68iaQlTwBGVytzY5EMrJF
 +jb8nsQpT8jGTMTe
X-Received: by 2002:ad4:5bce:0:b0:8b0:2d20:ff8e with SMTP id
 6a1803df08f44-8b02d2101acmr332603196d6.25.1776910709059; Wed, 22 Apr 2026
 19:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260422113136.416482-1-pvorel@suse.cz>
In-Reply-To: <20260422113136.416482-1-pvorel@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 23 Apr 2026 10:18:18 +0800
X-Gm-Features: AQROBzDUhsZEe_lR5oXG1M_cGOp3ooKmohF_YZhojeYli-n2pXnu7c2rap0xTDE
Message-ID: <CANgNiRycCiOmC6Ni+Da+s9cmYt64D_tbjTrhkVNsXPiD9zmVQw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] include: Remove 'make install' support
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:

> LTP headers aren't needed to be installed, they are unusable without LTP
> core library anyway (which is not separated from sources). Therefore
> newly added Makefile for 'make check' in 684cae7552 ("include/lapi: add
> leaf Makefile") did not support it. Remove it also from
> include/Makefile.

That's right, we don't need to install the LTP headers.

Reviewed-by: Li Wang <wangli.ahau@gmail.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
