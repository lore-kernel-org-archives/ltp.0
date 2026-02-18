Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EA3E9A03B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771419427; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IdXcDGMkFuh1nAUuF8RQ4EXHpvvu9/ATmMKrw6vJT4U=;
 b=AoooGafao5lE80A3s+hR22fbF49cU00fcR9P2rCM1Tw9kYMFnMUcM7muqRU0SRiscJ6QQ
 +VDYuXnN1d1vlbJMfpE3q3IvUnnHwFflSG+5jgjRQTgI4dXZKCEpETrcnC5pnr7Qnw/Wqje
 XOWpb+MmelOvQwcIGzicd1/8Br8hV4E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8550F3D06FB
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:57:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 750113CB063
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:56:42 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04C221A0014A
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:56:42 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso60732085e9.1
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 04:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771419401; x=1772024201; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9D/Gx6yrDsA6rkmx0fg3ggeeyyXzhnoc5tDPOv48Ek=;
 b=JuuC8UoBBfakSzd/NKf1LrUrladgRQAvxpcHK9fyxe9XHXFIqPjri+EG2r1ew2OkFJ
 jEZvLPIjmA9D4PVD+NxUmXYBI/PVdf4Jb1NsLR7bvZjEQcb/f7MU7F2/+ak8oaQkfUrp
 VwqPFN0v9z7fQ3l0ftDFjcdDAT/hj49lEzSHVD3whzFLqyWUKNhhsfUtrGMsH6uteVAg
 4dUNuiMeIKRNlSdp0WDDApBYLYf2IzvPKOLkYu/ZScCe5EdlcXKhzsbiIdY5WFrZvbx6
 hggvmJOs0QMnNcRCLQyVGdPT+eQbRllwkvL43CTwsMgCGuDlz3QMWxFI1Elx+55igZVr
 uJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771419401; x=1772024201;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9D/Gx6yrDsA6rkmx0fg3ggeeyyXzhnoc5tDPOv48Ek=;
 b=eT4gq22RcMdKTs9ghIX4IfUTaOs/ucyvERkErZQGJ4cPICBu3r7Tr6f4zv1aw6z5wE
 Qw2ASph7vr+D/dni7UNQsh0bSLg6xAox6H7d7T876ShmraU04XkVMdMMJuJLsQNKqGhp
 WQgzZxunEzlD9VnrGNMHlN+OI3ihXJpNIkFeS4h+7dp3mIkhgldnHWCXMN9MABHjwCss
 LDcDNkt1znkxLE1NR/oY063VXjtDsFYRJhQc6d6b9eTHQwQWPmQNwkQ11dsL9/Z+6ex8
 8pUIvYr9LpebPGN/EKpG9jfFxDDX0pCD3eo7FOsu1Xd0Tm/gaTF2eO/5c+fd8tTuR4Ao
 XjcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+LHnpTgknDx2GhMt2C8RQbDVnbBPRbg2hEZhN3BEJwTyM6UoCjUN+HykobG9DholeXzA=@lists.linux.it
X-Gm-Message-State: AOJu0YzKINs7ko0KnMrZ4FtcMkPEaTfaoBfVQoCCId8DfTjUkvWTvN2G
 ruLZ1Bp/uZ+g8DP8UB6ntxq4JT8QczYtLQJmYAvF8SkHC6Gk+qbyBpH6tsprqRNGUt8MHK+YV3N
 0PQJN3S8=
X-Gm-Gg: AZuq6aLoRwxEJqWbFTOrAfQRg3oGoCC6Mt5NZgwoiVHwDkrVybs5XBYrgj6NhW6do2h
 k3RUUbzTsE3y+C51Ux6x/XJACZpnzJDp0aFQku8+zlUMMqiyIUWbRekcWp1PJqeF5iuVFwQfJMy
 bEO9Sf+VJMOPby6aIUYdcdDPtWhLkRYBkPWCAJX4t5i3aAHzdt3HCkhQ7EPq7lO7VUUrmxDQivf
 ViftBQXsIBCmVeTJG4cZa+iH8ClbaMPhnj/dlVKMjxWSTovNXbTiOiUn2WT7AkVZmKyzeDxs2b3
 qt+Soc1Ob7yR5qWpgLDNo1ZWBdDjxo7lnmYYGvRkTtV4gSfIZEdF7bm8C67wMtXuosOOXSAQviu
 3sCmipPds26RGIdCVnY6p1amiMtk5NzqOIjWDJK6G0iZfmvGGLBPV0CW3JhVokWazljsOPj4/AI
 LjAVQCXj9YP2F180cIAVlTxd4ze8J2H9OUf03z6NItP6AtzM+VL25wKSWWQp0X2rMDvNTRfAISI
 7Vb/ecxIosLSv+oePU=
X-Received: by 2002:a05:600c:310d:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-48398b0acdcmr36609485e9.16.1771419401181; 
 Wed, 18 Feb 2026 04:56:41 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d8334a8sm617184535e9.12.2026.02.18.04.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 04:56:40 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 13:56:40 +0100
Message-Id: <DGI3RQ731YA4.YZWF2XPM0YMD@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>, "Linux Test Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260217-agents_file-v4-1-e71ae27ea2d9@suse.com>
 <DGI3O8O64JV0.3VFNYUAEVXXFG@suse.com>
In-Reply-To: <DGI3O8O64JV0.3VFNYUAEVXXFG@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] agents: Add AI agent configuration for code
 reviews
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I forgot to mention what models seem to work pretty well.

- Kimi K2.5: this is the Free option and it's ok. It catches most of the
  issues and the coding errors. Pretty effective
- MiniMax M2.4: Free and quite minimalistic.
- Claude Code: insanely good for many reasons, but it allucinate a bit
  or produce too much stuff that is actually un-needed

I didn't have the chance to try many models, but I would stick to Kimi
for now. It's good enough and it's free/open source. It learns pretty
fast and it doesn't allucinate too much.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
