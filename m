Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4AFC87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753878077; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=AbHopUnNj40TQdlddiTp3xgpG/5igd2kRPsVR+U4N+Y=;
 b=aa7yMzU3WWEl1seG90mDBmDpqgqhKHaELVVLwyB5qNm4+bMvzVHjZQVl93tGYniQkT3pV
 MkmdA7V5NJ8HTlRLzSBuRStTuM9gWzSxNApvNSH/iBy1y3pH7X8u3vNPGUX42lSiYhCU8j+
 u2GbFT+nv05UfDt4GXS3Yki/RrnId+U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EAE13CB00C
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:21:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 678F53C2FE7
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:20:56 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A302D10009EC
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:20:55 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45622a1829eso23486685e9.1
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753878055; x=1754482855; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7uftEeNAiMpPmaYzRkCsZpsFMomhy1LpXmPX2cBzGQ=;
 b=cr6KLRuGwvBKTZL9Xa8NUBRdqWEP494mWOqr3k5dLF3qYTMCRBsbRUpciSgG5/udIp
 TnV/tjSW17JNRxu6VsTL9ZM01PfDVvqHlG+u34KCQaFL3FPNzn/tCeH3RU/DmLeeqaAY
 JgDy7WbzKzxlOcUf8/KL9pMaut66QYPHegXXFdykohB2Czuo5ji2NLbmnvsdLDYAS+B9
 izoFu05+x+kH/kjE8xevhwmgXmN3onVJvXtr243OMxUxw8yxFVpMoV3ArUOlEt1u+nOz
 aN5APVo2t+JB2IYhx/blIAbWHho+J0vi/Gt4BRp54W2MD/oFXVsvzMLuHlWNAJnjMO8p
 Br7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753878055; x=1754482855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7uftEeNAiMpPmaYzRkCsZpsFMomhy1LpXmPX2cBzGQ=;
 b=ISoQc8B607zDqAqfzYUBDscF8BIOb5R+/qn3i276YdT6ocH8Oq8IfzpAckRvCl1sSh
 pYSqIE3Zu6mD1d2ZN20CWUfvFaULYfCTBByqMSG0tJ7PCqRywPTuuNAt3/RREdx94YSX
 FXF9PKy7WYjS6p8zLyXxJr94dtAEYe4YE+m+IVr7PnfCFjdyeBHyt+OWZ0zzYr2Bl6XN
 oWsNod3PSnG++/nbPen1upG3M4Hv67ruuaLH4QDVsTYPCqOe1IAoiVBCe6taa63fv5dE
 MwPxGkTjLWlgvTcQsWOVm9NF6/73/6trpYRSWPILBqCCBtXwwYNv9oqr06aSQCh4P/sK
 RoyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGyM6SL9/DOL6SQtOSkglNcmTF/XTeBh5h6DoQruEPI4GRBYmsGV3eeFJlqqmrRclxa9g=@lists.linux.it
X-Gm-Message-State: AOJu0Yz4bS4DOMYcFxBhy5WqwciCwdwRvjETssjcOHuhTSibgayZNkMf
 OdwnhiNuj+5VniGF/Nrw3TmYA5pY1w5wmz0nMt1+jiUUpv18iSR4DqOORSXHXHzslTo=
X-Gm-Gg: ASbGncvnVs9AGCRCRHfYUxlXESJLDFIOyei/i4l9OZblJqVzdSwQjbdf4LhRQUIFDre
 dNsYMRGZMnaWtZiYu/vKIXNAxsIpLts2CpFH9hN9QdlL7J7p/DwffrW3CjCVa/+ALDanuI3VkBN
 /QwpEpbMU5YoConMpdMAEUlKMziZRPEHBvGGhuQwjL80y0p/cSC78eOdEjM6u3WEw1mpXfUUZnS
 pUxDJ+0SLOs0U+qaocwfWdn/mRR+dD0h0WmClvfjN+6bQBnc5ax+qvsOwk9IOAhqxwmyKiHd5fk
 1M76o7GfjqVn33qLz6L7/JoYePPSinYlgTC+SSMLvVB99z9z3HyZjH+WFjB3BrvAgEoKy0WTZsN
 +mhL7XhouNulbymVemdV5ypEa+4TZfqLMQQ==
X-Google-Smtp-Source: AGHT+IGuL4QdaaUx5enWAXYTir2yBOcyggJUjKR+0Xmt/+bP1BJO8rmBj5uGewFgqL6aEBM2Sj4CsQ==
X-Received: by 2002:a05:6000:4011:b0:3a6:d95c:5e8 with SMTP id
 ffacd0b85a97d-3b794ff355amr2433625f8f.35.1753878054845; 
 Wed, 30 Jul 2025 05:20:54 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-240723c84d4sm39181615ad.88.2025.07.30.05.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 05:20:54 -0700 (PDT)
Message-ID: <ea61ade8-84e9-4611-b655-fed0b19c4fe6@suse.com>
Date: Wed, 30 Jul 2025 14:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250730-ioctl_pidfd_supported-v3-1-f40c047b29de@suse.com>
Content-Language: en-US
In-Reply-To: <20250730-ioctl_pidfd_supported-v3-1-f40c047b29de@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Correctly check if PIDFD_INFO_EXIT is available
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Please ignore this patch, it has a logic issue.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
