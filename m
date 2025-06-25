Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC26C7115C
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750844906; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=BXnukL25FyVEvlxaRF19tXfW+EV++wHppEEwaK8265I=;
 b=WAYCrQDkiT5JpaCC5MmfuJ1sUsBQWmE7Qnv6DDozN1WpD4SEt5sVecHAqjuOaqBoitsiu
 n0T/XYTEOJwZ81Wv8qIu1R1NliaosggX3QxaRZyW9YFVssv5MY/sfJDcIxOTbYfBpCZvJpo
 h8jT8uIddvrDYm0lSds25PotOxuBMCE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA4373CCB1F
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 11:48:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F15E3C1D48
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 11:48:05 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 80105600860
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 11:48:04 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so3561617f8f.0
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750844884; x=1751449684; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPzPFHs19ZMC2KO4Y3ZlLK3qZHrYycKyawdV4EZtGls=;
 b=Zq7lmK0JkAIPpjppdyHoRODI1z/b4ixd2/eTtg8TgHIxmOT8wzSHN3Q0FuyALnwLqk
 Ham/W8q7s2Jj6GKLk8NWM5hWNhjpzVONzYUG8g4OwSNJSd4ITQq17mhWeezh0JttzCmU
 D7w6S2w2bB+LAuF0FffGLwUMbz4aTNdgx7J4y+Knsz3SQ55I2F46ifObcWTbLOMfT04d
 Zf6iu/lbuDNiSYvLVKrK8SDCrUhJ6gDhDHb6iszuQIaqErPtVXWHUhuDacU4JT4eDr/M
 hWG3UXmMSXiHovSNvNS1FE1vu3qlKvy/l4Md04YA2l++Y3EMe5wVwttpIh+WirBqR7cm
 7M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750844884; x=1751449684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPzPFHs19ZMC2KO4Y3ZlLK3qZHrYycKyawdV4EZtGls=;
 b=BzxMjFwRr7ZqARnPXvi9AVPIui/lUVPVKpMds2d/Ev3f2bcqrA1pbZ9a9+pa30WNvS
 x6XvVyuPmeE+v0xgxF3bN5zsgVoQHXkDDx9clzNrrNM3VRFK0tvai2lfajiZXR7aDJXg
 u6+jiHahfFGkNAUKEpoKp1KtU3fhXeN/E81sOGu03Zbp2fnjvYRfGwGJRppYGOIH5PyG
 KIbIxJOYE1AJEZYa1dVOOzBty69jQDY2VVULiUnrfhfMUakj9IcenHyCEH1UOCLRILZF
 +5FqhEOg7HzwSyggN1EUYh4DbPlz2zklIdp9aRJ3LybeOMa5To9EYl+URhuEiXPmFxG5
 eg/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPRYm5nt928YiIj0as3GLPlCBiUKdvIHLnnEvb7rN7+ElRRHRasXO0Tv6OgIAboDBMLr4=@lists.linux.it
X-Gm-Message-State: AOJu0YxpdH1V2EWyCIWF15yRjAIbRxDS5GmrNcZtViWF8fH3fj+j2SB/
 eBXuAzl+YQgxfzj8Cd+6WAHfNDS3aRmfmDPbgn75vRhjqTnvUCSu83J82GhHt9iZRkI7KsPdvuB
 JdXCoMXc=
X-Gm-Gg: ASbGncsiikAM818uf8M70DX5ZGUs56l5yafXsCiJd8GPwGF5uFYeALCuy/Yt9KZ6EbK
 oG4OofCTCwdVxyVvTxp3pA+MJ3FggMYBsiS7v3b7r2IVPnOzZ1sv5rOgraXXDRRXsQntchE/i5K
 M286yYw5iSRdn1bOTOzNFo8mlI0lo3Vc0OFTCN/ACfKAmOT+2lFO/uJbCAgCZ3KXhUCOdC2SZcl
 7+9q2KoHx6hmiauFrOiWtzEZuredD41psh1giP6mzkItXJutpe5A/aH9mwB9+UqrIkYstMmmlm+
 Xm1M7G8aYiX4yIi9MOWPXirQnHtH1yDnYbs0Ue4WIB4yFPveGHUCZH6uvJYtEErUbw+/TxvZZ5a
 y+xe538s9+dBdHPeaFzG4MD6OFd11hY6xvg8qf61e6/6AAzF5UGQxoJPusuyRgDZVNkvNCwB1ew
 FLEqHjPYfTmdf4zL5Z6zRgGlY/oQ==
X-Google-Smtp-Source: AGHT+IF1poPArI9oHI3WBaLu+VocCV2Ljz2o7QWG5evA8GuyFZqbv5jQ9ws1cgNNU1NQU1HDcRF5Cg==
X-Received: by 2002:a05:6000:240b:b0:3a4:e8bc:594 with SMTP id
 ffacd0b85a97d-3a6ed5e9bebmr1447470f8f.8.1750844883569; 
 Wed, 25 Jun 2025 02:48:03 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c882cc92sm3895549b3a.82.2025.06.25.02.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 02:48:03 -0700 (PDT)
Message-ID: <5dc0e6c3-33c2-41d7-943f-45c71ce6efd2@suse.com>
Date: Wed, 25 Jun 2025 11:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Amir Goldstein <amir73il@gmail.com>, Petr Vorel <pvorel@suse.cz>
References: <20250623073717.338178-1-amir73il@gmail.com>
Content-Language: en-US
In-Reply-To: <20250623073717.338178-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10,
 fanotify23: fix cleanup of vfs_cache_pressure
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
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Merged.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
