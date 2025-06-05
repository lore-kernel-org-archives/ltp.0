Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F92C5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749111943; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=aWcFOSUnaLb8Ulxr+FitcF/gm22Bye/zr8kccxF4qjg=;
 b=bsbJjluCSoJMpGFIHR/bFo6V6YrNxXf8R1ACB8+CkguI/5PDQWjW4puvqA0N4/iOtKikS
 la7YDWKhHsgUOx0GUlpvuGP23dP6zbVoUrV78nhc5YRcULHTAmQkKPMOJfq2jUhetgkZSEH
 7nZxAugsowpcMbZVhneHbec6L1rsbKY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172463CA31A
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 10:25:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F091E3CA280
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 10:25:21 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA4EF60071B
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 10:25:20 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so378321f8f.3
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749111920; x=1749716720; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OkokvZu1HSQ35Dy1eyAorvBCrf+RRvMraaFRyaSKNVg=;
 b=I3BO3D480jmWmPbR9iye0btt2n68z11e+UuEK9v96mmzlgf5kXk58wS+2d4FfEgrln
 XFiEDE5vabbSizo25s7/nSRe0A4EleVHcx9lk1g6lRSp8ba1ybJm1wcHmdSzi+j1YNp0
 WlpUJRL9GJMCKsElF60ohK8CdcmD6dRzIt8vHG1pPv/tXj7XS1M6kXTeunF76PRl75J6
 qZk3V9uZiSsXigmHGRI+k12ePevmynDKipTNqV492i3JQkPlB2WKTEyN8fvceEwOcxer
 8ju7MdRCNHpTeFjzOiZqbP4ZdTC5TphewdVhoXwMex/VZuKmJ/JxQIiwkluXTbt7DrLZ
 novg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749111920; x=1749716720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkokvZu1HSQ35Dy1eyAorvBCrf+RRvMraaFRyaSKNVg=;
 b=SPqYgn36RpDhGRwMdji906HE89jk7TOyYNz9ObKXjP75mJ/OHfjfvHukO8+y2ljJ2t
 1ECED4z7qVU+GTJxDv2E9ao9O1UuTulPy0ELJgfZigezqBzDsHadiY30koUc0XkUzoN0
 1SNhN4gBxTaDIL9e2D4d6xcyGY9Hij9967r2/Io1u7Ab8ceUwoivYuF4/rF+nPz6MN76
 giVqHXg1H7gQR5WPen47+LsIMRmSn3JfGK94e56MzslOMpejkFJ1OFj+dwfMg+e+5+mQ
 KTchEjU/IKc/x4OjRomQ6E6PeBvMSPxiTaUVGIl6tW1lKhpL+u5PxiCno/z23Knq9epM
 WduQ==
X-Gm-Message-State: AOJu0YxU/4LhhyZrxJzZZ7K67ytsVUO2VxQSx4+MuN8E2pUtjc/yHZSE
 z4Liwb452idFez33HeqE7u+Hx0L4w/4EcKr+96BhxUvV6Ukx8mT2XhEqDXFXph9A8oI=
X-Gm-Gg: ASbGncs7PVcDDgBVkS0dFilXkiE/H1pqCQVF1aku1yAjXMoTDzhjryv3wwISKij8tfL
 z6XIRPO2Av18FxgNEK439IJ88sGf0fI9WHwR6MisXWcuW0Iz2ByWDSCCTCoRDwegP+FdXDh4VwO
 4yv1B1ku4gxN32l441gJ3+oxB0LP6dlM49h7FSVP/xs3kuCSZXbxPTUSu6K6u6S6qYqsMOFeBzO
 O6c8bJstk3AN92GYKdZK7tHJsz/h1yQfPJfmWqOUeEWYSTR+CTAhych4a9ZTiRRKqD+co7K+2jp
 uE3buE4G5PDcbChdcbA4zKbr3sHsflzgkTWZZR7fNywoQqFHOIV2kt0rpszgay713CG+mI15yft
 D3Kzy9mfeVCpgOVeLJfLljopAfIoRSK4CzQQfSwrq2ApfoB9Ddhl0YXJSnAIKhzcgmGLoiIIw09
 JKdwrkfixiZz+sKgeBsvOLF1Ns
X-Google-Smtp-Source: AGHT+IEpSVoHolvm9692NZ3jDiaMRs9r9Du7svC1ED1HSCfbchMJqSwIkMg/k5Lw6HgnfsY9JY2sFQ==
X-Received: by 2002:a05:6000:402a:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3a51d9223ebmr4710229f8f.13.1749111920232; 
 Thu, 05 Jun 2025 01:25:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afe96474sm12380152b3a.22.2025.06.05.01.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:25:19 -0700 (PDT)
Message-ID: <f920262e-0668-4dc4-8e2e-a75b1ef4c449@suse.com>
Date: Thu, 5 Jun 2025 10:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-7-602b7097e722@suse.com> <20250605081309.GD1190804@pevik>
Content-Language: en-US
In-Reply-To: <20250605081309.GD1190804@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 7/7] Add lsm_set_self_attr01 test
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
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> FYI The test fails on this check on current Tumbleweed with new
> 6.15.0-1-default. It worked on 6.14.
>
> Looking at 6.15 landlock related changes (added Landlock audit support and
> Landlock signal scope fixes) test might needs to be updated.
> https://kernelnewbies.org/Linux_6.15#Security
>
> @Andrea could you please have a look?
>
> Kind regards,
> Petr
There's already a patch in queue fixing the way we are checking errors.

About Tumbleweed: I'm already working on it.

- Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
