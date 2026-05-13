Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6C0CD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778659194; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=qY01Jm7I7DilutBYpn3rCTbC8RvCbzpmymZDzF6soAY=;
 b=gTm16ueVvC+RWrVgBcJIQ4qByfKUGQQ76Iuwe6rgx1b6nBdtazDNEbfI8z5yAQVUtLY/1
 Y0W+N5aWzEKldcwXroL2agmHN4kRDZ6PVh0VX/bL+KOK3UTspOrUIIk1gAFySF5uochqKtA
 EInyiLUno0Y/E4Rl2q/Cugv4VjpjYgo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 205D63DF3FE
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 09:59:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7553DB2CC
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:59:28 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E3C31200254
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:59:27 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45562c41ec7so2958551f8f.1
 for <ltp@lists.linux.it>; Wed, 13 May 2026 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778659167; x=1779263967; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EAVHN+1/azNCvaLAPVutIVa+xwADksWyOoK5XY5zQBk=;
 b=dkJDEtglXa4EA7UJ+6CUhj+RYn/HNvEvzQUP7kH6Nc7MJJ7692RlAsq/3bpEB4H+My
 9v7+v50ZYEOesbOa4zYcTRhZZVeXNDF69EryyGC0xUMNgNFAUaI+04wwWX7Ar3fgswhm
 +e9tyFHrr1SjIa92wDXRwU2ps8haTNIn/Y825J23FR7OwLTAnwA4UoQDzdWmZ84g9DSb
 nrUImyL/lBR0EesYI1V+Z0kDQsMETRCbVmVutGH8ipkzsPYNEzG/s1wdD62/7M9NCZYt
 HxCQbUPKGae1B47TYpJmAVP2cfJHyikKznj3dSbLAUU/i2bHv7rtYZXgGiydFlP//v/H
 luBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778659167; x=1779263967;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAVHN+1/azNCvaLAPVutIVa+xwADksWyOoK5XY5zQBk=;
 b=IfhSpu2MbR/iXqXFq6AayIYh615N37BrjgH5yEs9l6PS9V0Y5VIWxn/zaKakGsDknO
 aC7hLj2g0Frd/l+e4W4WGXpgKlyGimBXmnB3XsXgUjiqyzNhdmaLuVm/T6frEZpGyruV
 PzbmizI7MYGg/323080NxriqN0N3XtKetusQCj+6gw+iDDohs7laXvlXT5QXLSK5hR0j
 RN1Nhht3hd0Sjuh5e/8IsT0Qk9EdtDoX01glmmw5b6ryDL+eQyCXmKMjxd3XV0NKluFa
 XNCS6ynPyVKtpi1C52KgJXoX1kShVJsOTYE746vXkLxZstyCqWD7Sm/xXwCzFl93BbQy
 sfQQ==
X-Gm-Message-State: AOJu0YxJWfWzvjSCVxiZnjNCfiB+/KlqsqCsLlZ1hC2ICXsM5H5AurmJ
 TVzOuowyXR/Vb49MiVSC4tWhvlP7qH31RhqlCIN9Jg5heMxRaU4NS6IDhAV0ljnyCmm25yPJpVs
 X6nl7kbs=
X-Gm-Gg: Acq92OGJ+vicKQR6+976Si1L/UbtAwBzjfK+tD/ho5hVpCSMaE2AR8UYgjNEhJgeGn5
 PG1PogrcnmD/i+JMoLtR9x4YJzE7kV37P7vnW9m23GdFGfsPNxhZEfeA29KNoKmUDrWrYXXc39H
 GpbNhBgt13xeZCTSmqqPXO7FbODzGMglNCJsHi+bg0OVxjdMzMCJvBKwB8ou3pJ0wEyM4N4RolQ
 8ddJJKyBmqgHa0CdrQf6hCt1N+42sllb+TR9gfl3SDc8rf+3yiLt8uMo78NAfrFzVtjV8J6ehbX
 WJm8hNwMCw1RPVk37cr/tT/ULWwACrV8a68qyu9Em6aVGP2jRjPEd/K5jz8cwhjFTYkr3rJVqch
 1YldMuV5AschOTZWrXyj0OEan/bbvBL9psRSyP7U7LmH7vexb6F9CiTWG9bjKRKB2LjnalY5iit
 pVLVDtpCcKKOlz/vsJdtpFP99NAZ78Ujx3/geUCBO0s9zQdlHAcZrxSKz5s3paUpTziM/bdeeDM
 9R9hTrwgwlcDUFG9Wn1WGcfC3qzOflaRPydwRpi7sLidw==
X-Received: by 2002:a05:6000:3101:b0:452:c9f:4b91 with SMTP id
 ffacd0b85a97d-45c57de9786mr2863020f8f.4.1778659166699; 
 Wed, 13 May 2026 00:59:26 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491da03a7sm39227667f8f.33.2026.05.13.00.59.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 00:59:26 -0700 (PDT)
Message-ID: <6a042f5e.df0a0220.ad398.c3f5@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260513021036.12127-1-wegao@suse.com>
Date: Wed, 13 May 2026 07:59:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] nm01: Fix BSD vs POSIX format comparison
 failure on Power
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

patch is not applying
https://patchwork.ozlabs.org/project/ltp/patch/20260513021036.12127-1-wegao@suse.com/

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
