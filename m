Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0AD29DE6
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768290601; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6qDcTOF0h2MUtPfxKea1bYB5GTHzZvRG5X+cKt6JM1g=;
 b=CDvGx13eJMa5+hLVa+q3Uju/6+5DrXZ2aubv3j4jUXp+BbBxhIVVTw4JTx3HY4r0cWKN3
 c/wGWP5CTj0l5maPFTOYaLzWNdtEyQE9ZSVaPqXs3dVkozGYFZXhA9pd9r1HdsIotCIJUQQ
 bj+zcF/eSRNp9EmwORQzk8AzjlrvKnA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C7443C5A01
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 08:50:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F0FD3C4F45
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 08:49:37 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10308201DA0
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 08:49:37 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so45925205e9.3
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 23:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768290576; x=1768895376; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNVS0as/WhODcHO3yaM48NZPjJYSv17nRvWZB6j7X0A=;
 b=b7FqVZf+n214aEGSIgeVA/nzF12zKnWcs5T8gkZtBUVY7ZUIc5uoNaPfX+5Hrsg3S5
 IGFmmjRduqAfAvM6Haw3X8Sy5kYXs0aI3NGb2DEqgokU21e1XiNzjRDqyPw7qXwXZJ1e
 mColXCHrmnfzlDJIxGvznp1aIeiNqBM8KJedBM9F+dtISdFJ1LOLWXR60O4sV2odga+a
 Pwe6qER1/oaY1LlAko8r3ULJHxcHlfwO+6t93DNrRH7qSY/gYGnxGXV1ruAK68P0vsoY
 gSii1LGU/1IQBq3/86U+vub7SgpnDQTji6KdQ/GTLucxdVWgjteiKtYKGece6vsALGD/
 Sn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768290576; x=1768895376;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UNVS0as/WhODcHO3yaM48NZPjJYSv17nRvWZB6j7X0A=;
 b=dzrb9bP9sizJkL6bcr+z6fovOThJb8WD8GiPk7acB6Z3330ZxEdKyVOXPTKifXqW5G
 bjX8o4bBHaOgqctHJa5tdvDvIUBlKIFJhpaox8Y7Dftw4Sc1JshJkq6jCEe3j3OAOtfR
 mYstMbreo4kG4apJ6P1cIuNv2TWaSmO50JkRX6KBTwwtoMBit6J39dnkTfs3zpolijex
 3FlMp+3aR3Zu0U6V+v5xsPUQNVXUZFdYTmfehRWtgZi/5jMDRJuz5ae0ZeeOm5BwfKVK
 0LZJ80u2dWAx13ZSvxhwh2iKeH8UWP+YbTpnKbbXsRBpFwzwKG4DgRhs1iuCXaKq5AU0
 H5Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeUjNpbDGHMcLLEY24RDBgvGRakOazVgumpBvkzKhgiSpmjG2nSH2YotXKEExNRwv5R/Y=@lists.linux.it
X-Gm-Message-State: AOJu0Yyp8PHtnG36YZu8XQ2xnHIlcu0OQKvTbPk1h3i/AWw6u/P1LQmV
 fNuMscmNN+8oAP/eRgV1F7eb+TlOoKHS0udSDL2J2OG5pmK+Y+pjhR19P9vvnuVfKrxOptuuF2j
 QmdDCWwMPJA==
X-Gm-Gg: AY/fxX7+8GPiS4IVnQ0uHcjClGAy+51AX4g/5k20tDQRrh/T7IqPEB3CVtO50wPnRu8
 m1ZgtjKUCqaaEloGb/qE9KCTKEckowCb+UGH93oad7UZ9bO/ng6TTZt81E8C81usoXycq/Qeok6
 IOazkOSYRDZXDhz266bS74xXsYgp9XN0djwnpAofMk2Z8+wXl7BWEhY/Pz6I2eRlMeNmpG6SNqt
 Wdd7UPReYAytfr5P8zt2ozitswMsYzuoEIGlR/ePzw7dmlrlAOy5SFBm60HAOIdC/gbsBRh8omI
 pOYTMPpEzmyeYzwbNM/NcngLsaP0hvAIvc5fvp2kgpXybtEz6Bmmy/7uvrIGfxoAHO/660PRV9K
 ALo3tny2hjOGvOXppoDfzRf3CKBwN4HLDBwty0A8dfWpf17WLOzhDbsUqYNQuRfCWuCF1MPZRjl
 nTfWM1eOnTy/TMq11gS19Y4NA0p08lBfzl+66ohgDhsPdll2PWEPF50/8lZ9uQbB53GVLVUsXl5
 1aaDio=
X-Google-Smtp-Source: AGHT+IFqkfFdX5OvT2iyKtKlZZYS7xHY78NJVFUF95fuEQzmcsTb4Le+I8cGGR+keIIAEWRUHymg6A==
X-Received: by 2002:a05:600c:1988:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47d84b52c14mr257922005e9.35.1768290576390; 
 Mon, 12 Jan 2026 23:49:36 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm387812245e9.0.2026.01.12.23.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:49:36 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 13 Jan 2026 08:49:34 +0100
Message-Id: <DFNAOZFXE7ZA.1IJYBUF0AVMYN@suse.com>
To: "Liu Jian" <liujian56@huawei.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260112015047.2184003-1-liujian56@huawei.com>
In-Reply-To: <20260112015047.2184003-1-liujian56@huawei.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc
 validation
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

Sigh, for some reasons the CI didn't work this time..patchwork seems to
be too slow again.

On Mon Jan 12, 2026 at 2:50 AM CET, Liu Jian wrote:
> From: Liu Jian via ltp <ltp@lists.linux.it>
>
> The testcase(rpc_svc_destroy, rpc_svcfd_create, rpc_xprt_register,
> rpc_xprt_unregister) was failing due to an invalid fd, which
> caused libtirpc's internal validation to reject the operation.
> This change ensures a valid socket fd is created and can pass the
> validation checks in libtirpc.
>

Do you have a practical example why it was failing and where it was
failing? And eventually arch, kernel version, etc. It would be nice
to have it inside the description.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
