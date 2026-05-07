Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B28ACD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778148111; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Jq8PqKGljTMbaUpeJ+gLndDE+a7rvcP1MQLrKWwkDPw=;
 b=krmV778Zfyo/MYgLXXX48tUZjX4cpqfO2fAd7MMDeEF5AlcCD9edenWKPgJilsePBQc2f
 aBsOSXfL0G9vn1Lbxzie3m7yLBlCHqLsLiJLRNKXO5jhXMlI5JLLTVdXzAFSkt8KGTEz/qs
 M7r2lThB+2be322MnOTRe4ZGF/F2W6g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE2113E5F5C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:01:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ACA03C20B6
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:01:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04BC41A009BB
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:01:26 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso577198f8f.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778148085; x=1778752885; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sdwZpxiSByjVlKjJCOfAsBERpSG4DuGieLRJz2TaCk0=;
 b=R54VpXzIzszBVWStIFGumjwwggAdRaGZEGJniju7ajqhA5/rjghv94tItkV5fnDG0y
 FEuGPtNpmBMZovKp0c3ClyRurjnxvDh80l9MSkaTQjryiDFjlTmBvXZFi5kG4Xie0QYA
 karahcqEA8OE23EY+u2yAx5cgMMRK4OaicnqrfI/vkeJLUl/R++xsNT9YQLOu6MBsvTl
 ZL70ldwr01pVYWnz4Etmj40D3gK0cmmiLPmYkpX8pC6OyL/fmLNyFVd9o3oZ3XDML5C3
 8KjVeFDymmlamrK4yyGTCCwkzEWZ7y1g/anWsAqkcysmWyIxHY7XTbcpT5e7nRtVXbAU
 qqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778148085; x=1778752885;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdwZpxiSByjVlKjJCOfAsBERpSG4DuGieLRJz2TaCk0=;
 b=Y3+00vbIUfKwMO4u4d/0OiDU6zu4bD4EEJuVe6uALDEDOP3ArKfyF6Oxta309ndqld
 MDSrS16m4JDCZxzZ9a7Rv0zuv54ymvzHshh9tIjQCB+KtkCJI9XmvecztG3b7uspP8kZ
 D4+kSD6d/IEiiN8kkqmyd5f7Oj5hMo8X4PVLy1pyoKdyJ3fHcfHn9Vah27M1rOrMeUGU
 9Q6S5c0Ofb6LWm9QTTAmEMeX/+Wl7yPzrSPCt5+8y8Spb79msH29dstEcqKVXVsmoHW6
 oI9BgwwBXEaOASR29/KjTFnKVy4DD3u7yQs3ceahPp91FlmaUdkcc616/xhSwJIsHOdV
 9vFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bw/HzbsIZPyAmqAIyJYGZay6TQbC4LPl5Wc2COyQaMF2IxSbyQNR3z+zi9sDS/RVsuMA=@lists.linux.it
X-Gm-Message-State: AOJu0YzNXQakio8iJMJAlOi/YBbxmD0bvlNGikjebYBohtB3D1j0Hi8p
 JVRllPNVxFnunkFFIS5nTcfEwdpN1sl/VbEd1vJAYsb7JD2zBoc7PUaSOHpzonLUo+p/rs3VLJL
 +WzG8Xuo3kw==
X-Gm-Gg: AeBDiesXc2UE37b+5ZVO/VcySnrJE8Z8pX/PhKYP0i/lvKcFCfkT8QP0rzxXuJyY/xJ
 AHQvQvS78c6nDIXDmlFRWR5r69am4BOY3S2sxXZup5qUp3t3QqwvJ4JX8sMFg8Fn0xT2jRctbmm
 MqgrZ9cCuMCAOR4/B9jMS4NvgFtO0eNK4WhDtImQOeVtMd4GbL3GHE357TKQqU5GUGLXLZg53Yu
 bTWw0tuQGnMTYd2dOQHG17QQDlzHsUMYVMcdf/A+1ely6LTHVfGtasRz33Kbe4WlJo40TXvOuwJ
 fVYLI0NjnEizYlsMKIpKLhgjB/0AtBkVXSlfPRdHsHYBJvjmV903Ro9VlpdEeLo4yeCH8CDzNdj
 SSXAYISZCA58BCu5STM6RhpeHjjlJMFeQ5w50nkbayDh4T6/dwLW/gL/RlLiYZ5CughEMSMYlQe
 JY2mSX0y6vSK8hcCzWhXQeMYVFyvZ/5D1QDWOSJoGKJOIrWU5C7zIgEl0D+5l6JEzYhcwwVbiwf
 xd8jz/TWpqewCCRYQZjyUgY/x4x9c1UXOVvPp9b9QqjNg==
X-Received: by 2002:a05:6000:4211:b0:43f:e99a:ff91 with SMTP id
 ffacd0b85a97d-4515b057368mr11891097f8f.4.1778148085043; 
 Thu, 07 May 2026 03:01:25 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960973sm19239803f8f.30.2026.05.07.03.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 03:01:24 -0700 (PDT)
Message-ID: <69fc62f4.5d0a0220.ce944.088d@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <afxgt-lV0hlsr1L-@autotest-wegao.qe.prg2.suse.org>
Date: Thu, 07 May 2026 10:01:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> 
> Kernel indeed saturates shmmax to INT_MAX for compat syscalls
> Relevant kernel code in ipc/shm.c:
> 
> static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
>                                         int version)
> {
>         if (in->shmmax > INT_MAX)
>                 in->shmmax = INT_MAX; <<<<<<<
>         if (version == IPC_64) {
>                 struct compat_shminfo64 info;
>                 memset(&info, 0, sizeof(info));
>                 info.shmmax = in->shmmax;
> 

You are right, LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
