Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B9C5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786603281; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=DlqUNPkB9QG5S4AxKAmAEn7MAF6DnmYDcK5cmcmvTkTfSjJTrrnixruTGRS6bm1Vynupi
 uUkvErVZ3JZgQQdujXM/iulqkMhZyCAeP+DDeGUOfTkIgl06cnMww3IUQRG22fZhL+COJ2X
 75GH4x9U+SlYX7jYYulGVsJcKYYS+m8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DFB43E6BEA
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:41:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0BD3CB4C4
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:41:01 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A576C10001B7
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:41:00 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so1050104f8f.1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786603260; x=1787208060; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fwGsvZy+xj2pyFL8qfeTqIcLlTPuxT1bTQrOlY1Yd7M4+n51uk1mW1ALNlBWhqoNya
 Du72db9cv5w/3sOOqkxOuHuEQh6Sa3AXqKgHFcBo0qxK13Hom83iPRmB+Nu1AvSCMAt7
 IAlNEeW1ebxLz2IedU93F8zRclTVkPQXAwD6f17uQepl3N0wRwtHp8Wzez6GJQSmukCZ
 Dv8K0RNgDAgleAVGiKwDM9xtSP+oRpAq6HF4QIRi/BSyLmbZQU9wgVgPF+KrL3PhdRXk
 CdASa9oelDhELtCii0BruEdEaPx22S+zJsH+XTApHqTe1a6bi7Q4i4dkBx6HtdNnBruf
 jbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603260; x=1787208060;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Vs2tHCOJZYvnKEcZLDbgNvfky2/TBiT0MhfvJbgBXuRCGCd3CC+gOTFRLL+tY1locq
 LmxWQXvgBa3dTdqrSYqY1IBVA8w4Z7TdGieHa0+zOZBKJdo6l2HCmAFNZJYg+B6Ya3qZ
 FvvuSSnRhelFcsW+ovgJJC9HECHO+1xUsPKeKTWzAmXF41pNgfy86BPi7WGKYn+y4+gY
 Lic0yywFZz/Z4i6mAzxoQGmhejIBvyGLyMFphBWdmzoalNqgDd4z3abZDh8Qaa9UsKL+
 31bN3r32NeiZQWUj1hcWB0eBCCgx9x2ANTG/pgFd7AT5Go1uWEy2d1p+JUbwbfH1gnBC
 1Rjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCtAKQdOG1eS2DX3yuop7/yCT9TqsBlchHkSJC/2rRYZmyr2HeAgcoQFucgqQVrysUHuM=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/NMJvPBmP9pkXwN3dWJaIJuCyfXwQige/8xmd5LL5JJwtDv2H
 LZUaInxBRF4OoTjmVKgbj6lp3aishTJEydjZjVlgPRbtY/uG9EgNM/LNmEFSJyoU4H1/yqnE00R
 UvVqPtBU=
X-Gm-Gg: AR+sD12f47ZcLVj/x4rvaTfh5YOsKavbVXnMacOiT/JjzBRksUsOvjweNYT4Zn0yZxA
 kl3VyyOseTFDt1R5zej1nkgZMq36tiLqnSIAQizvSQPXDVixsaR48H0Ovk2yvPAEk2vMMHaoqwA
 8i9dprGUncis1pcGUwDgUkrfjydqYMbjZcBHW1n/dyJQugXMBJiGkm4G9UxMZKiMbu9w4sgijNI
 tFlea32U8uDCGbwF+7h7a+PHE5hgENsgLHkddZWXMw/KIOWfuadU7ATnSQkfvS+xriPlg0nZ/La
 BQoJCoPKrTBynJGwOTJ82V4AHbzugTCsw3a78qk71wSAlWH28mzx1kwEtK6fnZ8z58RpATos0p5
 V8BiRqrMKkiei2PpBXkk/2rUwgyXdqDa1yX15nyDKFR8VVvvxpbKYTfw4QT4Dch8lxqYomZvCrX
 lxWkecHpDIse88cPMaAptARt0XsKDnhebsM6Kx2mpdAAsZOv/8n1sMSS5B/4moPmLJi0iF9nA=
X-Received: by 2002:a05:600c:6298:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-49982113bddmr36607025e9.0.1786603260081; 
 Wed, 12 Aug 2026 23:41:00 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499820c2897sm71114835e9.0.2026.08.12.23.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:40:59 -0700 (PDT)
Message-ID: <6a7d66fb.5dfca4bd.db133.ff38@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anyG6Znxcjw9smBM@yuki.lan>
Date: Thu, 13 Aug 2026 06:40:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] test macros: Fix TST_EXP_FD_OR_FAIL()
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
