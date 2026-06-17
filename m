Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E05CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781709569; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RMyXr0/0QSPVfkeFieLaIqoZWdkjqGQwiOaHls+Wn4g=;
 b=ER1dt5FOTs5hkEN4DnSDpGN8FJ1AScOHy+WUFit0U0qe/uV7bQKtwwOI26fjb7JJgwRhm
 qsxN9E1ed9I/AxIe+wQXptoMxKNGlTpE7UqLPoNpNP572Wk5M1yCc74IZFyJWIghCVFSht2
 CWxlGOtZJ9pCuNftoUDF0OAIhtGtwfI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B4963E5944
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 17:19:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F9F63E5920
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 17:19:09 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 380ED1A00A2C
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 17:19:09 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so782777f8f.3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781709548; x=1782314348; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TpvyQctqUqRuMgM6A8gg49xgw0QOwjPq0cNSearLLHE=;
 b=Sio21ICxpVglB9wmA/GROP1iZEj8huJRT+7Ff7QgY7fDE8hS8fGpi4IvNObxvJRsB0
 pnoYL9eTNfC+AwM9uB+9A0d4T5uSlkQ6OSMLqamMWmOYORvkUPks46E0LsQSAsCS3mp5
 gMISTfpevr7vOJDYWi59Vu/21aScuVj8JPGFUfUuXqYPBRoZ11KQ580QPsuc3kDrf6nX
 MIdHh7d91p09BP9IRR9fnjV1Q3LBk6zhOetBo0zQomP/D0sc2Yy2mmDiROY2CUKXrk2a
 K0ANFmcxFfOyDx0XPHe9mhTgPDMDn7bb82QDzbsVS+PMBBdOXFVhM3aham3YnpirKicr
 ljrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709548; x=1782314348;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpvyQctqUqRuMgM6A8gg49xgw0QOwjPq0cNSearLLHE=;
 b=ECrv7/aAWPNZB73SI4Cz9EzoNtwfrSqZsEDnTCnplJ93cRH5i7XgsMWUu5+N7nR+/o
 DbHl2SseZ3yjgqCM56sKAn7G1OJfxzrXrylLph37URth2D2Q4RHkkeJRDJxu3b1CjTME
 XdE8rsKhvjQTergvd5c+vjY+sUu7MUhxpx8AfYze3uHbqySYFJHCnBW9mM/YB3hzYTjc
 5l+2VQQ2NCGG3I8Nxp+zLt1BSSpp2Ja6Ze+OAdnxX0OVha/VgkZ00KkhwEhvoay286Ze
 31MfT76KirdJaBx2kfYOWnmp8eviPWMJZXGZMj0yLW9cKsmN4PEr74PBcZ3ayPlKxh4E
 vFJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0b3OC2AGttYaQsNuUy9FfVslUxOWCsqiCwbeNZUOiAuTFDcWIXE4CrxoK5FPzUIWKhhE=@lists.linux.it
X-Gm-Message-State: AOJu0YxMnDBRSLhoFFl1Cja9j4MHwEh0vCtgm/PLy/2aPnA8DFpum5jY
 QN+Pv64+6WJfncWq4qMi/xZgQ3diMDl1nkd19ncFVlIE/PNalcyphPc0ie6fvAexcYk=
X-Gm-Gg: AfdE7ckuXDMrNkujMgOn3mVFmI5+9T434SGwtJwUviT+QrmdNz2UhkKqtwHruchd47/
 xWVD3Q+ed6TjbJQZTBo+91Y01H8oGe9jn0xNIGd4I1zwR/YQEKGxCgPPFp+JzV0TRlNYhF4di+G
 ah0Jktl52U536ejV6/NUpBaBVXL4CHtcU3q5ZE/xD2iTzRAiBuc7UE9krC4zh+Ns3Yt8JglOXrP
 AfFV/9kOXUenLVj/8288j+A6KXXX6bzAq+BE/fAqhXHOKKnnGuUhwaOfZtFRsfTGcZDzzl8mXzO
 kgup3zoc+WDoF3LyuPughNUktk4t22brnxXKrgwiigur9xx0qdzeoiZ8eiNaEirKkEr4tkUCZTn
 A5elWhyOp78P+vbWDoFCOUO5jsvUlw+eLrqQp8O1Xj+s/1SilNt2QzwtYJuLIaykO0qco3o4zwv
 e6xZGstnx/MogZUqMwH6aF+1/2sjkxLIdsahU1gT8Vz0AX7kgulWTpl9fv9utF1w==
X-Received: by 2002:a05:6000:41c7:b0:461:a169:fdbc with SMTP id
 ffacd0b85a97d-4623627630amr7725113f8f.16.1781709548400; 
 Wed, 17 Jun 2026 08:19:08 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d1c7sm11490276f8f.7.2026.06.17.08.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:19:08 -0700 (PDT)
Message-ID: <6a32baec.95d0a0ea.22b4a3.6ffe@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a32b644.f32a6769.150c63.1270@mx.google.com>
Date: Wed, 17 Jun 2026 15:19:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I'm just wondering how to implement it better.
> 
> First of all, we should mention the commit that introduced fallocate()
> support into exfat inside the patch commit message.
> 
> Secondly, since the code was already working before v7.1, maybe we should
> fill the file in exfat only for kernel >= 7.1. But I don't want to touch
> the core library.

Second update: .swap_activate is not implemented in the linux kernel
for exfat and the commit causes EINVAL only for swap allocation. That
is caused by bmap() due to the generic swap activation.

So instead of working around the issue, we probably should have a feature
in the kernel along with fallocate() support in exfat.

Probably a kernel bug/missing feature.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
