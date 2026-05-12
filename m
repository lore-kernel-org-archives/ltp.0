Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC8ACD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778573927; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=sxQFFhCv1/mjG/mgHplakIPmmhrxPDZ89mSFkfkacBk=;
 b=Bc/QdAK73ZqWMmPDxufRmWSIp9RxcevT1III3JURycsOVbFzfFLCjiXPMglQE2GMnseYu
 3Do0wMU0U/X1/oY6KhUUk5Q8JKdIGJdHD43KdESSR+ZoyWJXHTmFMcYc9nhH2zyYMnR/2ae
 nhqJaxoEtZTwdZ8mj2bTTQBjbmgoPok=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12A183CF78D
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 10:18:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3311E3CF08C
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:18:23 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34D491A003D1
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:18:23 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so3777556f8f.1
 for <ltp@lists.linux.it>; Tue, 12 May 2026 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778573902; x=1779178702; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4Cnmf8NjNskZifHxHA2GfBQ5Gtt8avxEeZMcw33FBXA=;
 b=Onr/M6gdyxbA6YyQca70b8k53y9hGd38GRFUnDkzCeWQg6v2ElnJgLdwkVaPBwFzEm
 UnlMM2A9CmS8TnoK0k7MOUV2p3YCPzSZ7io/5T5z4jglCEls2tlLPfavr5a4PaEYsHDs
 NOjTbPEfXo0UzNszO+ooUe7u7Y0KO1N8ZQjRmOOU3lpWAuD/lhFa8R4PDc3WM67/1ki4
 AMzpdWte0hkDEBN3hTUvFUBnHIkuemAr9885td+WsRjc8ujz0/vhFMEyfO+6ZOFd79cL
 E+TbRegHqFR39DagnhWOGDO3umYvo1XbbIGvSeXcIdkj8L2tRK9jA3LpK81ricUrP6yG
 vwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778573902; x=1779178702;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Cnmf8NjNskZifHxHA2GfBQ5Gtt8avxEeZMcw33FBXA=;
 b=cB3iGngvo1V7nRi9V4LHU8p6SEHvoezllvkqa+onj2KW9u5WhrUR1E8/J0OKiZw9yO
 ZV2LISv3/mf2JnRdPlHRyKV32Z5s5KkwpWpclI8h25NcCj6HxPC6Ljg8iHKMGDT+6uZK
 b51mMCirc2UpU22W9hH+IrIP2ySnrpJXcsxeFRIKe4Iv0fSSE2nmcEpECGPofASSkJ9n
 LiT7vsKj4B5vW46HlhrAAenny/AuewNL+Lzwinu+2c8KRyz87gRpkfQAZAQ2Kqc9OFD0
 bbt5YpyzIVXaHGoNtQWeG/KtMOlfo9+NTO41Grdl01oeiEtzFaqS6yQB2EtQRcW26JiC
 BXGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mjXThyrnLUW1GcZMXlusuLKuUKm9UY0XEqPtol3IHxhCNDMPDWasiQmTQrxO7Ntv2G4Y=@lists.linux.it
X-Gm-Message-State: AOJu0YwcSLeV07cpjxJ1HgcXt1ku1/xsVSBmSxQhmem6mFlDhgGUWsVw
 UEcD/8+FNEdUl+xXY6C1Eu64tWmuhhsKSclodeCNOa1pV7JVJTNm1ft5JRD52KtGjqU=
X-Gm-Gg: Acq92OFGaFjsC+FCTuBHEg9RygCi9Q8tU3v15U+3ZT0Uf0yDTT+AU9teFBNdu1wuf7N
 JHScz2z6f4dGpZ1SKYAVznpLZOb8nJvx49N9lvDjAPwn0/L9RonUIIDx1FMkKg8c/bUSFcPWxpZ
 2BreV9mlpeAwOCUq6e0et5Vtg9TQeaP45ZQ7fVfYc6/VksFEioYnfCz5IciozaeQRd+oECiMlBe
 nYZG8wqOXq4vtSsksKov1APHoEpN+cF5hml6py28nvX4ZCaYj9oCzORB2LW0TYd8yI8prmRDaaw
 JoxQlEvishmK5Iv/e3wrioS7Lgntlc6Lv35oCLmZZiSTNu+KLF7bB658wFc9JFhz+fMNN//Joo7
 Oi/wbTfYlfN9eozGUgXjezD6DdQYW6M7H3cBLbe2Cfq5cm+D0C5D8OuP+/PMhR/U0LKWzosy8rC
 Te3fWA4GWMLjWZqVMk0H4Wg3hlI/i3VE16YCWQw83jw3EUoRA9BAH6RVyPnNinn6d5OQTxm7Hlx
 b+8uwnCnPy3dIeU4L5zmesxEdUfoNDJc5tRIW8gkwMx9g==
X-Received: by 2002:a05:6000:40da:b0:43f:e452:f391 with SMTP id
 ffacd0b85a97d-4515b056a89mr45566445f8f.6.1778573902433; 
 Tue, 12 May 2026 01:18:22 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120f1f9sm31256326f8f.24.2026.05.12.01.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 01:18:22 -0700 (PDT)
Message-ID: <6a02e24e.5d0a0220.c20fc.ba61@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260512080815.3976-1-linuxtestproject.agent@gmail.com>
Date: Tue, 12 May 2026 08:18:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Allow 0 return value when detaching or joining
 joined thread
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

Hi Wei,

if it's ok for you, I can merge it with Signed-off tag.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
