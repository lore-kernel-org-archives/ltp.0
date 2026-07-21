Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9440CC44532
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:40:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBD703E5282
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 16:40:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9813C0F03
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 16:40:13 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A500A600826
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 16:40:12 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f3c172f5so6640342a91.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784644811; x=1785249611; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jUnNB3XflPxeixzPFTsguGzTVFkDgSa9Ho8RY+A9Yxs=;
 b=cbr9Bc8lHuV/Ko0NL4oeWYqLycpF6McmRebwi061TqRXh9vUadz61OlaK9HmJoPDpJ
 IiFwXGk1pUlcpkC31fJKcMIlZpQO18JVS5pOCyrMWDWwPOx22C10u0FMdjmGIj0DVM5G
 pWElGGjARojFS9/1gd7NJmICofJulBj7FR5zc/WnQuHsJpz+Tw6mnVEJ+6vaQDwtMPWQ
 sciCm/yscliluomb7+8WRSJlwVWgN0fw4an1ythvuNZ76Y+PPD//NrzBubZR5TAzx9O3
 HpEPo8zB7e9UudFOXmy+A+kpay7VqcC4ZWiAvkdCRCFLlQXGaHhRiFknYvosPBQ6h3B3
 XfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784644811; x=1785249611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jUnNB3XflPxeixzPFTsguGzTVFkDgSa9Ho8RY+A9Yxs=;
 b=Wy7n6IJNfMbOVbjI+tvPAk0WstR6mcmpAcwPaW0ZZI2S/PP0lSphsFI+QRtNAaMVXp
 l2hLOrkDvbQ2LQbh2wTAAhakq+HDfb00GOgpqDMhvxf7sv474xEsUekmXvlGuvN9eYUW
 CXXWJSOvf9eUBuWtujEX1JhWObS/W7V8fINhOWL88eLiK5ScWXLlWyxRHuja6EKL/ZKn
 J7sAR9DNRanHex3MxbEKEE4+zrp/VnHGRqlNBucdkH9XU6aHmh/bhEDmk8L4/L0tap21
 hjleOtVYZeqfxEbHc7i6QUaP4zCI3HFmXkecn673ICxEVUzQKMkLf9AViWHeu7L8hklp
 X/qA==
X-Gm-Message-State: AOJu0YwohsZdwEWQJHt7uUu16UzA8d467zwEA4UyngQBAVivdSTcMC/x
 rjgHdl4K2MS47GNfJfDwk90oqglejxBcDka4HSv216l9V5Jky37FW7/vxI50oYdj9wI=
X-Gm-Gg: AR+sD12G4SU+Y79E3cSZDnTEi07kyQcQWMWAGwv/szlgthHA75wfEka8Ucjlovh5aGG
 cGcDPGVypLgqp5zXZkHMZq3YeTT8HP2ACvWkJezfhNadPfcoWmWO3MbP93p4GBlvN58JbKYXdol
 B2O5s5Zvb4YCqYPHh8YAfBujF94V/PKCq9TX9z5yFoJkvkWB9PSAg7aCAZn2vpYrjy7sQhQCUon
 QGWNoVX1E0Q0EoeP2fH+/CdyKGJuajgszIeAAJPwCTvClkDwdjF/X5S+YqHcoOZMMWYdXgTHGCT
 yQkQg8fEonmlfxYiSFZBX42sUfwJ9YA1co3L0KmS4PwEm9SntTyQkdnuA6r2kTz+rDJsnYN6ALc
 paN1TIfREyfvmfesTNanrv8cOjLIOho/CC14j+JF4HRDUwyyIduhFEp9By2qjUhYftZlCwM/oqz
 JYfMRS/SkDCakLsTCXzwCnkcV1976zucf3BcXFfWS7wtY8RzuO9KyMHsd6QcSJ0ksyyhvZO+gu2
 Gm/6fwfjKQ51d1SGg==
X-Received: by 2002:a17:90a:d2cd:b0:38e:68ae:4d68 with SMTP id
 98e67ed59e1d1-38e68ae4dd6mr8782041a91.29.1784644810815; 
 Tue, 21 Jul 2026 07:40:10 -0700 (PDT)
Received: from
 runnervm3jd5f.q2j2p5ao4xuujhllopuiy3xqef.phxx.internal.cloudapp.net
 ([57.154.4.48]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2dcdsm44730038c88.1.2026.07.21.07.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:40:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Tue, 21 Jul 2026 14:40:08 +0000
Message-ID: <20260721144009.10807-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721135530.2882066-1-sbertram@redhat.com>
References: <20260721135530.2882066-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: tolerate SEM_STAT races under parallel LTP runs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

On Tue, 21 Jul 2026, Stephen Bertram wrote:
> semctl01: tolerate SEM_STAT races under parallel LTP runs

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
