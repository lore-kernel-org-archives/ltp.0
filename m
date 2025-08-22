Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FBCCA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755834166; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=OrHkI/u/xmk6HgAKhVdglHukcBcr3AvikCzjrbAZZDA=;
 b=JXBAtnA8PKSfKFYSh+CzRMsNrSlKDgoF7ZfHwOaewkkt+oLSPZpI4KDO6zv5rc033TibY
 1k0+FaMf1PsVzFcx/DpoY7WWTyKplOP4GJ5QM/2ZF96YBPe93HuQJ0z3ApCD+fY1gx7fNU0
 RiRPS/LYF7OkLqtE1gYOi5+GPf/7kQA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 654A53CCBE3
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:42:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC9283C2E97
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:42:24 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C6CA7200239
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:42:23 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61a8c134533so3443551a12.3
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755834143; x=1756438943; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GRlHT8CvNhM6l7RXO2rliKKkmI8z2pcKCnm086Gerk=;
 b=O6FcQzsiRP3qUsEhnIPr6+aFPY2KdvtZgp7MONQVlrOl2Gcb9yntXVPNCovBVEgqLZ
 P+qJsCReD3i8KSoOPEdY4eqoELLh3ojlpo0oNrUvnLE6x6X4909yGVZl8Sj019y/KehV
 /YruoV7Q02drxWbcBXrfW9CyPhQjBoIJNrQJUEHhre7hjjnXHNvYsrmvhA5TvHJjgqbT
 F/31GfozbkEjonR2yiTKdZECEUhL+SOicbm+NGn5m3LTWMyOATDMYaBrQranGLyb6NaO
 Re9KQZJ/6fZpLd/ARQJdVGup97UquD/IQI9ROZMrwJuB4ooLryghFWwovqbwwU42+jbP
 on5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755834143; x=1756438943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GRlHT8CvNhM6l7RXO2rliKKkmI8z2pcKCnm086Gerk=;
 b=kcLnylKRLT6e/19TDT8H30+7SPXwrnvfL95G1O0bOFlFFzv2ZdN5qFNG3BnVXdx8JB
 Qq/yBraLPCderfalQmhvNAelJofQPGQMPwDLq2+mhDZ/lkm+IH0m7tiIgKu2vFVUGbbg
 xs94SOw9iP8kevSAgaJfH3LilqjQWKa9j2MbBXKrntMoUR6xNQoSLacVvrv5LGAcvkZf
 Z02mpFlYdlD9xFbt8tyBUZjT+l5zFzXdyF5a/PN6ut+8sefLKHZ/ZNLrMD2gJKXJVDp2
 6qSgBgJx3p1c5a3Hdz47E5RaISSKsmEXAd0A0G93NER4k5pmMOoFgDxbtEivayuEP/yZ
 plnw==
X-Gm-Message-State: AOJu0YweNxSRr5OKPbYdUhKUJIXkjmDX+g9BnEL8ZFFaZ0b4vFarTZ4t
 JC/p1Vt83OmbsMkyvC12A5KCmbfXi5xMkl3CUfGnaUy7o4B3VJsTyKdrMfDWjFlevo9QguruzFC
 bODw=
X-Gm-Gg: ASbGncvRyUMc+RkTqRVlAWq7o/QVW2P30M9LjdU/+79lIFrjaKev4dVwUzQM6W8ak9T
 nDGpMk7006VXSGr4UhbsPbzUYPgOfJboPTiUUnXL3M90yC5DDFKhQRvPEipZC1JSC3RWaW6669S
 ESOW4M19fM0cAIiqPe+iExE0TGxKhzVnowE5COa00YMbu0ttrjho5+yaCVN/g2nk9BzEDYiiGnG
 GYK2kNVGxzDIGfLuJH44T+d5OjVGtqEBmkr2T1BpfZjj9U1sVpgJns4DgQ5Z+mfkYI66vw/NhQc
 6S/IeIlBfpOJ47jibUCj0quTiBV81JMj5b57sC6DNrlwNuaqiXqWKQGfPws9YKaBhwBdm5dLoCa
 jcfcN0OamQnHXBI+PtsNPE7bl9UeRLAospNnortuB8eY=
X-Google-Smtp-Source: AGHT+IGxyQJezLfdO8CDwFWCPncROf2hV4/IFxZJ6qQjnJtMP6Vn1ANKiC46hKMuR5rNL76HLEMgmQ==
X-Received: by 2002:a17:907:94cf:b0:ae1:c79f:2b2e with SMTP id
 a640c23a62f3a-afe295ce820mr128736466b.40.1755834142870; 
 Thu, 21 Aug 2025 20:42:22 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afdf63c85efsm428689666b.10.2025.08.21.20.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 20:42:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 03:41:38 +0000
Message-ID: <20250822034215.28533-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820002556.26865-1-wegao@suse.com>
References: <20250820002556.26865-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] fspick01.c: Check mount point was really
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

 include/tst_device.h                        |   2 +
 lib/tst_device.c                            |  42 +++++
 testcases/kernel/syscalls/fspick/fspick01.c |  23 ++-
 ver_linux                                   | 191 --------------------
 4 files changed, 66 insertions(+), 192 deletions(-)
 delete mode 100755 ver_linux

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
