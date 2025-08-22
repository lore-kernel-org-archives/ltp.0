Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FAECA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 06:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755844438; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nMkOhYLYm1XGdUOTTrOo99opxGkEwcv/1BSC3zFRRTY=;
 b=lR3tkBLjtADptx63bLOlFBChFiCbFpFfvZPorVLRI7FEwahgc5aHO+fWwHzj/tmkJa4QF
 TZcKcyqlOO/yxwI/hIJQTMDtLv0gymRtbXw4Ybl4/x+XVetLtpKGVelMhEDg3m+43UYCDOV
 rYCz2ZstTOFzSGTq/XFAwH6j79fBdAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDFBC3CCC94
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 08:33:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 461AF3CCC6B
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 08:33:37 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D548600067
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 08:33:36 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so257924266b.2
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755844416; x=1756449216; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeaBSq5lDM6flpsRMiTSouwOSyZyW5ESI+bHpyBQ03Y=;
 b=AqYaIoNftNMTQ/9vFb7V33LlnsdiVdJbadDs68r8v2DVby4r7CUUQEyuEx0bvkYOOt
 5Ip3AbLCMcva5VqRfMRGqWZmpKBrQegmOS78IJKuUAv0R7uT66p9NhyoDFmPHzmqa3EO
 Ew/RIW6h3UBs4D5CSP9ioHaUSSvFf/OzvHbC/7NDvpf1OflVPWeImuAQssXXzK+id9Cn
 7yaC+y8bKyPzkoThw2VCK/imeqtSIm80f9A3tgDE7GrJkUNhnPZNANaLwzIvOXoEgQhP
 4efWuw4/ahBgiyrqLdKjdH5sHUKVP1uBe8R1VgseR6yRRvDLheSYNVvC6JIdU6FwiI9/
 SaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755844416; x=1756449216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeaBSq5lDM6flpsRMiTSouwOSyZyW5ESI+bHpyBQ03Y=;
 b=EPCvNtbRS51/j9g0v78mF6/QenRHhdOSWR9NaIh6ebV43w9iQZx/LuxfZqRmfV8Vi4
 oUbNONzbt/z78CyAWuIffVhH50r+GduNTihIqZEB7TygMXSW/uhR1ryNbB9GpLFjrU+C
 tuyyLK/9InFD7obES9Bynj1H6qdC0WSS1ueun0y0QO/8aHWztq4L7J1OqIbntYHI4WNP
 zk+UZdPoSCQaFO9jvVTww87aLtpIQbDfdrzM45g6JOKOAOOF2dau9hUpQ7G3ITSgXxep
 LSgEVB7vlDuVkWRpTjm+gQxqanH5po+Q7q5bFBP132lSZrdWPT+gPpnohenHWitT8Fnd
 t1Og==
X-Gm-Message-State: AOJu0YzjcNhVJst3K7vahkT0adRZx8bkqquFa9UFSIH2kcol1hXCt1ak
 fvtyLcfN+32vpOkzc40Ru31ZJwfZOO5HEUPJ30bLGvo+4FOqOc9JIyECu3DegMaNrcq7Rx0ranj
 gcJY=
X-Gm-Gg: ASbGnctxgYWS/9AWo7sLBDpH73JJM26k2T4y4lkWRt5iTHea/7J3amgew3/J3FiRyoH
 BjGYnHp166tD/Cmy0MLKJGgc3vzHMbOsJLLz+IB8FKhYDCpv2j3LgKhhVjRLZ2ADFeLMLB8mGAN
 nvfVFs91XWI/AU2nEM0u/nMinFCZMLn7mMoC3jf9ERtT/0ZQI945I0ajm+4naF7Ndk5aRliQikh
 oIkJwzFXqfNOFUS6NrIiQoZ62mwosf/tAcxpRyRXpZnIJCRII8MMdHjq6COd4t+eceTYbrHT6Vf
 zWcO4MmFGAR5uAUYk0XLu2WoX0z20Eb92EckAoQBUVN3OwG0oPNTAFfbxHFvkUr04vYbEuDoVJD
 t1Ob30z19sMNcDwZc8nszIL2ae7WCX8hbfjuu+PWVMj8=
X-Google-Smtp-Source: AGHT+IHHAp1wCJXitmG0aKhDzjojS3chqC5Hp/jrwm4M0t7Al//SY7JGD5muNqtzvAYoF/l62Lw38w==
X-Received: by 2002:a17:906:c149:b0:afd:d9e3:9541 with SMTP id
 a640c23a62f3a-afe296e8705mr152410366b.65.1755844415734; 
 Thu, 21 Aug 2025 23:33:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afe018f1943sm357755266b.87.2025.08.21.23.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 23:33:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 06:33:05 +0000
Message-ID: <20250822063331.28886-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822040501.28640-1-wegao@suse.com>
References: <20250822040501.28640-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] fspick01.c: Check mount point was really
 remounted read only
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  tst_device.c: Add tst_is_mounted_ro/w check mount option
  fspick01.c: Check mount point was really remounted read only

 include/tst_device.h                        |  2 +
 lib/tst_device.c                            | 48 +++++++++++++++++++++
 testcases/kernel/syscalls/fspick/fspick01.c | 19 +++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
