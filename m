Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C1606A326
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=daSuMZOe
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9C083CDE26
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 01:38:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8124D3CD6FA
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:38:19 +0100 (CET)
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CE55600058
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:38:19 +0100 (CET)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f436312596so542911eaf.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 16:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793839098; x=1794443898; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cRK/AWUZFfrfc63HFvB2uHlEPdHGfG7DyGcoaMcp3d0=;
 b=daSuMZOedeOvHyffgMeJ4C9imghjmPyRLC/36xwJUTPFSUOMHOk4GccPlYTwomEXnF
 2gMsnma2EBdA+OalIdkOKOIgG+lE2Dux83LcqWQ+pml6bh98LNIKDHUnNUU+WONadFvH
 0j6a9TQi4CijGFeVJAdGCnkAooH9gaJ0IvX2/IydBZlRVkSNtJJsAKA4PtjUilq9m0cw
 JGnITW4yr8zezHdp93rgvXW9Cv8Sd/+r9l42GbpcxrGW3PKlOIBcw3zVlwJTer5GB+pV
 w9AJltx6AID5qv6N17hUOHp+RPEPRx30fEINEYzEXCctCbs6IAZ93W0be8VglPOmTdfB
 FBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793839098; x=1794443898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cRK/AWUZFfrfc63HFvB2uHlEPdHGfG7DyGcoaMcp3d0=;
 b=xDALsY78fuu1uOo6YMPany05xKB5dLfBVnkLbdTEMuww402l7tBhSrCNKNCFQypqt4
 e78FTynyK0Ln8tC4QO22Qa7v58ehl/4TBCb7Gztirg84pNyQyPa+3ZAx6RwtXRny5R5h
 npkp6gLl3GHHaC01Y6OOocdWsapGgCM6A7QuW9rqsWby7kFMyiyvQQvJ5O5KrYrmksNZ
 FBWxkAdMaSVPYmKH/rebkcYkpW/7s7OddToVzPKx3umsV9x/QSFJ2c026wBSCpKvC0np
 tZNsMD4nAgzp94I/MoCaovamZBNmojInqkFoE6ZF35XScHP4fgan76bHACgctF0A7oXg
 3p+w==
X-Gm-Message-State: APuU4Z+19PR2cTjTgBTWetDvshR1hYGWIXTmZ9QxpAzM83JnK4egvjTC
 sCfW31qJB/7HgQlvRGGMpkj5kOA7SjoN+w5vbbzgBOCQok0W9WmTVkuS
X-Gm-Gg: AYBFou2bR7uk1E2P34IWc6tTVcl0vo0gay6ej0dKlNPljcQfJnMM/pvi9NW2Z7Isk+B
 dAFsaFAXroxea9iIKIIzJ9Y8/gJFXbReLCdBSEtMP8/3UJdTeuhy9Imox9s64KnzPHOdptME3Mj
 6j4QL+7x314C2YGMJAgf42kCDDlMkF6HC5NA/V8oHWCsGiaSS5VV9UP6fZ9NyS5lrSyqmtZmanZ
 rSq08BppD8FAY/L3CaSWLLAqMdjVOLiqX2MmiCM3D2ZeKe5x9AAKhDJ0BiYt8JcNuLSJrpoI8V0
 +gAdAtAFDff8X8nvTb4QDgDpr4+kLLW0Q6Cve09qCsdSMOdbIAaEOScmem2MadlcG4IdL8gvAIh
 JDljerhV4XD30Y891Y7NBi9mslJi/kKuDCkOoD68bE+UGUoLUAoVkkffpQet1/HvRu8Te6mNFUP
 5VecsnTBeirX7umrnpy94S8TmBRtIz1AYm7fvh1cPspDyJC4eycBlwcz19Z9sNPWb4Rk7K6/gY4
 Z1TjK3JBvt1dJxNJOB2ipb4FfPR7lauk5DZby+YaOEEmj8wM/zS7+Do3lL/gVkt0t7mELsRb+/c
 UMhZhOV+yw3NbavCJOgEkldwaPyJpaZSBivdPqdqhXwdmdpm+N+yh1G9PWC3TnXJ6TC3sjM+0i5
 wWpJqFGOtpyGDlZU4FErkP+4jlCkHWgTiM9i9g3/sVkJl
X-Received: by 2002:a05:6820:3387:10b0:716:cd2c:e43e with SMTP id
 006d021491bc7-716cd2ce519mr1106818eaf.33.1793839097601; 
 Wed, 04 Nov 2026 16:38:17 -0800 (PST)
Received: from
 runnervmwuk1x.y3en5ldd3b2ebobdorhaggvslg.jx.internal.cloudapp.net
 ([172.202.174.102]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12d1f36sm2726662eaf.8.2026.11.04.16.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 16:38:15 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Thu,  5 Nov 2026 00:38:13 +0000
Message-ID: <20261105003813.3577-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104221453.1076748-1-avinesh.kumar@suse.com>
References: <20261104221453.1076748-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/ioctl_loop0[23]: TCONF when LOOP_CHANGE_FD is
 not supported
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Wed Nov 4 23:14:50 2026 +0100, Avinesh Kumar <avinesh.kumar@suse.com> wrote:
> syscalls/ioctl_loop0[23]: TCONF when LOOP_CHANGE_FD is not supported

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
