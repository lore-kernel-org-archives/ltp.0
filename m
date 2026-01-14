Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FE1D29FF9
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768394732; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=9n4A2aVblc28uHivHMqA0w3Ot7ojeKTXllyOGfH0kbY=;
 b=MROOnT19F+GbhUzSyzxdGbX4utfsLjySg922O+jtspkbWAptTvY31ZvgoJ9Sd5ZIkOcEc
 Jp/ohOHxSUC0EzbDxaafWkeKqyFkM8IiKW4z/UoZIl0XjMeivkoHe7O6CSdFLW28Zr6mVYz
 ry9UTr+xxzOmSwnI39mAWt3WkonUd9Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93D983C29E9
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:45:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575583C00FE
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:45:09 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 88A9B1A0065F
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:45:08 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso72949165e9.2
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768394708; x=1768999508; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HAKLwhimybHHViRhRiC47HyFCTYRdg4Qr6FWmEnzzk=;
 b=N4hiI8PGDoU6CpIeJsN+YElFfxK11MwKH9LMr72dneZjn0qt1dF+xulIgUjuiZ+3HF
 BUyfioBA7AdXhF/V5rcI5C/ouPtKAVqZc0cUxpXd8iXGQrdLtB+9M05ezQPwly+cTWMt
 hjmBz/ys7VTdaKfY3hlLhkmKTbYNn/jQbkF26nlyWrxxnMTgA77Kj244UBVjY8NKXHe1
 Crg9X9QVgzk47fOV+v7pzUtzM0/CTybIi/JOIVde/aFkJTGFwuxm/fXsFk0Lg2VXKqr4
 ooN4XP24LJmoigaNLzM7N/UPskgDpMAwzKM6kKWpDYQlBDVlzi1wPFfTma+eRAnqoInD
 GxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768394708; x=1768999508;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/HAKLwhimybHHViRhRiC47HyFCTYRdg4Qr6FWmEnzzk=;
 b=wZx3ONGCahhJG/KqqnE9+yXXWScXi2smaS3YcdGKCpb88s6Eu2ugRxtOXRia4XdZeL
 bkod7tEBLcojKMgydujK4x8GZtmv2wnaKnAmNYoR4j7EoXR2JqbptsfALR53UNlP4Frq
 3CQ9LkiDai5Ae79/yDGPqBmY+SEXAGoRxNkHZgQDmYSbusynIzdTgaDHmNwaJSh+++jS
 O7iymFzvKxjX3D1tK6zU7QZaDaXLND/LlRSaTozpHvR81JgSg3VOxsQ5NFX/5j8HDf+q
 xeM743Bh2Qc1rQDYPd0tPYjaT8Zm+Hd4klSxYgEZFLYrnjkHLHp4xN4/kArDMoiS9xxu
 xuiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQv5W6oBjxrMp2EeaF9WjUOsCoP8QM7aSj0NwNFqiyO+jvhw/vHQ38KYJTqI4BY2+zp88=@lists.linux.it
X-Gm-Message-State: AOJu0YwyW1SGfPJCAFPlQNaEz2RC1XZYafa5g2EqBfgiO3tJOa3aedOb
 1bo6PTHi4LDSF7kwQhv0x+AS8VjRTtM7/yoCmEwcaN+MYnjptvmALCPg0LpVk0mhGqw=
X-Gm-Gg: AY/fxX7M+SeJ5hNxQn5TLDqWw2AIv3EjCzNNBAq4jGgMQTzyRa2RSNPZtWV3mMQR4Ki
 5D4rmg64AsRa/tSPbBX9JeA7MhaYOQDjxtKfmQWgpQsncvUv1SC7gAIlMc1uSjQwQ53Qjw1c47W
 QeudbR7u1R+HSu80senr7PKZrwqlFiUhz3Wna6C7MeNY/p15r/VGHoTc9bciyG9aKJzEgASPjAN
 rTYKVnn3w7S9GBStHXHxu9WcUOmD02ppumxd2BiM85Bkh2Xd2c4L9OpW6pHpGwcFO8jy0FzQQuC
 Cdf2tHJETr0VtKhW9q76pjiazIYdrnKy/eU83M8HpGrOucn77gREvmGUdCGKM0x3KQBSF6eRfkB
 QE9pDlcoXBakFFlFjUkejWX46ZTK9cwSnCtG++PYulGFAHFpdzDYieNABgShQXGgOlraGsO3IM2
 ztNE/Q9jeo6x4XCP2BQBCr0i2Zhso9cn6w7SJoooNsftce9NQ2NjT7phS2QdDeTe28NHm8AYcxz
 s6R
X-Received: by 2002:a05:600c:8183:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-47ee47bb085mr22877805e9.1.1768394707853; 
 Wed, 14 Jan 2026 04:45:07 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee591933bsm26143945e9.15.2026.01.14.04.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 04:45:07 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 13:45:07 +0100
Message-Id: <DFOBLT952AVY.2VSAX1QI9J74A@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260114122611.372930-1-pvorel@suse.cz>
In-Reply-To: <20260114122611.372930-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: css: Add style for C code,
 files and man pages
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

Hi!

Looks way better indeed.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
