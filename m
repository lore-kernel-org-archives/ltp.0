Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D6CE9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771500546; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CJ4+lzwq5c/ssBkgxahx9FnLsRfMBhWZrFarlqIHLn8=;
 b=cboKhWtAvEfsC0OQ7uaSZr0RvHy2lC0LGMvUdngBezGRfQsiaDgtoWZVkVf5koUAji9DW
 cFV32pdNjsYxf1PDC7NToG1GRpLsN5+/Qvfd4dZ0WBfO5rt3b1hfoqe3o/rZXvBam3/7XDq
 fM80h9eRqfn3sN1QbhbtFsu6xPivrTo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 943C53D072A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 12:29:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BDE53CA4ED
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:28:42 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C5F82009C8
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:28:39 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so548246f8f.0
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 03:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771500519; x=1772105319; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smOwen8WG8OIDIG8ziqE2FZtkqDcxMsW1nIro6FJiAY=;
 b=VyLRBIytEO+cyDY8j+7J9/2WI0gXGCiQTzZb64gKxGzxHamNtwyxoJU9m9lcbT1g5q
 slLb3UM63bihcKgmMaXmKfXYwaHvZwiHHKLNrzwb2JxebaVmDMyNftFuhnL/gAX99ugl
 +vRhSY/n5K1kApICRkYsJaS4qZiOtGcuR1mZfCwLBud7zP1FsNH/jJniVMtYuFR7KD+z
 G8rqxpMg2hNHDb5miuv80Hw/j88OatYJ96JYL+A+B5xr8V+0TCtamPzw7lc87gFn2Zr4
 2Yj02jpy53Qg6biHaDfgavsK+Sop2nsKtruEE5SPLpzGsRFzP3nJFKnGDuUR581K7XWM
 ML/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771500519; x=1772105319;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smOwen8WG8OIDIG8ziqE2FZtkqDcxMsW1nIro6FJiAY=;
 b=dkos9X4eF532i1oG9R6/SDEpiY+S9kwOD6w+joFO07/6W2lp8SWC4E0ZJY4VYaLkpx
 r+9xNnND+/wb/lhElkzfoiftcfR9IBvOqJc7FL58SWTfkm8VEOQL5p4K6e6H1QAfG1gx
 iMVIbWhmMmJLAG8otV49Oit3WeMjLwR/HP6hkdiNb3pqelmTvt+hHoEvsZaG3ERI0kVy
 UFdxKduoU3m6ehRNb/P5foGGNzEAzvshRWq8YX3iVcZofol3W/p9CTVHdpcRz4RXpBMw
 Mbb/eCw2MuRf545Snv6PjnDZVUD5F+Ks3T/ghofwG0+uHU2CrCGoV/YC7DVTYxpFA0Za
 7mMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX79qkx1qeN8FwUBzpq2LNn7z8TFCR8B62KqtwVs0domVyYdhAbzKIpFEtLvgR4qACj+ds=@lists.linux.it
X-Gm-Message-State: AOJu0Yxr6sIxcxQW+Jq0N2vAfw6htw0u9Fo6zl2TjDGR7lCzpJvUP5di
 CznZgvQv0qWjrobyl9F2t+NyCoFhsQzbi0mZZpGqWabPBo9g+XlP6Fn7mlqqinP5Gn4=
X-Gm-Gg: AZuq6aLp21d0uKSlrphSFcQazO5D1cA1MqlMI/hf5LCWGaAVKuPmhxERSB/Tap2o4Dp
 u+FQqQ0neQpgK1aKII+xaz/TmDHBivz6GUhn1N1mdwradt6i8TKPFCylpmCVKPP5gaj46nqopzY
 c2kfUVBvh4nR0Ltv/SAebHtSgMigf0UbesWxyDWWgIR+MZRq1tcu/rUyJLs6FXxaR4DyBOznvua
 jy0JCyMyazASubPsuyxPdxaO7QXRHByvzciICxvPM9908hMkYfVqLtDn994grW7MNhNb3Hlw11K
 K+nIU4oKHIXDdD09ccse8IzJChAx9MBMek75LSa7T63iSlsurTjZNyzLps/Jf7Y8bNLFGh9i7XU
 x3TA2hiuL5e0na+6nCiH5aY0qTl7ZI8AKbjdDwlAm+Ysm4jk3ERm84SZTGA3iWzsN9zY2DiuNzU
 DuFzRyUqlGWPL675MScD2rNWar
X-Received: by 2002:a05:600d:6409:20b0:483:96d8:9f75 with SMTP id
 5b1f17b1804b1-48396d89fafmr73984355e9.28.1771500518827; 
 Thu, 19 Feb 2026 03:28:38 -0800 (PST)
Received: from localhost ([88.128.90.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm449327885e9.15.2026.02.19.03.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 03:28:38 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 19 Feb 2026 12:28:37 +0100
Message-Id: <DGIWIUQKM6Y6.OPA1D526RIVV@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260218135026.159676-1-rbranco@suse.de>
 <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com> <aZby3eA2UvAnpWzd@yuki.lan>
In-Reply-To: <aZby3eA2UvAnpWzd@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> This one is wrong, volatile is correct for variables changed for syscall
> handlers.

If this is wrong, we should verify checkpatch.pl configuration.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
