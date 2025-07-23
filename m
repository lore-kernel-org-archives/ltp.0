Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A8CC83F34
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753282569; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=+oDVUUO9rFgR1RCZZitVyfKr6u6lcM5Lut9zQwNmWlk=;
 b=Hrp6Vzgxi4lCzMTUaFKe9M2NtBICVY+/ai3wVTyzjCdoN4s96vDCGndWqw4L53vkQzVM5
 5NyielHim8a17QCfEUgBYne6kGH/HKKadQizikvHdTkrX36iFDOXFoxKZ4miho/19GecU4s
 1XDUs2TOAG/rg73igf48OtvIz19GU58=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3556A3CCD8A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:56:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74D773C2128
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:55:48 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8949260073A
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:55:47 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so6099811f8f.2
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753282547; x=1753887347; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MW99mrKC3fC3K8fKT3BaCQzo0tGrfW25/akKKShlWMc=;
 b=TdJvA2Zzu8br5rXGodiHQ8Dd0/CELj8SvcTnT5f8Rvb/Ac4jGXlUIuf/4OfmEhG1OC
 Gldgcv0O1BAR2c5ilP5eD2xiYD4M7C2s/YLAt2eZEnWIzJ4lxcy6aLl/PoNWavJwZXPm
 RlbybpuCFDclku9ZsotklHccS4nxCMcoqH7GI4OgYDpz0BJhBpWSUh87LA2ExDTXHY8u
 ByYzXMTBoOa/KT7DpQr3SoOvthVV4s7p4Epy1S4v1OOdh/y+7Qd5FsZ1ogmHDEgCqzhl
 9l73wK9QrnF6lYV1f9tOPQoVZgTc57CjNs9vLZG58oV6kPAeN5WhEYxJpcImHb7AZ3GD
 h5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753282547; x=1753887347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MW99mrKC3fC3K8fKT3BaCQzo0tGrfW25/akKKShlWMc=;
 b=qH2bN/si+0rvLvmbMBkJAfjqxFedoM7tfZmlHqcScQ06uDwTyo7BTyUHz2Q7H+K2sK
 +NM1x8MTqn2KnbDd77YyvtcOmXkHRFtLEUb03jHOQMJ9y6R75L+xJrHltjpmoairjT3H
 uHZ6u289OVu5rOzbf1HCJQEq++ia8vqf4GsiRiTuHPDCkIuLvGFXHX7ae6RQp23Y0sO+
 JRaXbSQjQ3GPCycLWzRIwA8YN6/w3yKQpU6aFOKqQ9HwPeIn15WFL4TSm0zxuvlplgEK
 I5sbmrlthN3d3NFJnNMZdarg5F6ikhRYcSLsc+iboa6PXze3k0KK/xETVWS8Sji2Rewq
 /Pig==
X-Gm-Message-State: AOJu0YyeTVtzdxFexZGsVyDcIKKbmsnRbcmPAyU47gGQmLWrSHNaQnBL
 DfmwW2e1/2sEL5W+WVzsS4oxcb3JQM3E1P4X0y+hk7c2bi0QGIfChw5oAjCrzpykdLpuhfoBRBa
 ZjF8z
X-Gm-Gg: ASbGncsCUA/ioQ/P4oGN9BG+4T4k955eJ5SPHuf9an87Su/mSEmRTno4dr4kSp48EjK
 TuzE5MaDdncjprjadDeejCNi/vn21nCIoJKf4qxQEeJM8/TcRtmfq3aVDJtDEp8Ou9VJWF05Ihk
 vY0lHv0vtP9fyod9l4NLYHwhs70sUyXrn2X23cs7AXChlV+QZt+FGVDXQZbbgFpzFMLyb1cdd1E
 /Le7dA72nqAjgzlUzxCmIR+A928RpQbrbwaj1A8OwdWC3oMwb48V6d8mu/UKtW/PZQJB3Xu0trr
 Z2IOXGrPCE82QLQ3TZfDlMMMbuPwmWrVUU+IEzlkTw3LRz/43VFy8VRLLGr94qg66SdDTu1wfNH
 JEN1JzrV7lKI8OoqCtgkeXGxoKxFPYIm5Env+K/AGyhQ/Aw3QvPTUXPtYL/WW3RXsZ5we08RqYB
 izHF/AJs/ID1WLfoE02vKfGRM63oOQ5nqEaf1MBd4RhdXDPsRmvk+2Bc8xnOLbqA==
X-Google-Smtp-Source: AGHT+IEqNkWi6iHi1yyPjDKhyt108OcdC9wyLLcHsdjfspAtZb95KTMjtMXa3NuhAhUN/xhIL7aYeQ==
X-Received: by 2002:a05:6000:26c9:b0:3b1:9259:3ead with SMTP id
 ffacd0b85a97d-3b768ef72b1mr2757460f8f.28.1753282546614; 
 Wed, 23 Jul 2025 07:55:46 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6d19b7sm98353885ad.148.2025.07.23.07.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 07:55:46 -0700 (PDT)
Message-ID: <8d9a0d52-322b-467b-b337-771974cd6987@suse.com>
Date: Wed, 23 Jul 2025 16:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
 <aIDv-M3DF8hQGmMZ@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIDv-M3DF8hQGmMZ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/8] ioctl_pidfd testing suite
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged thanks!

- Andrea

On 7/23/25 4:21 PM, Cyril Hrubis wrote:
> Hi!
> I guess that this can go in as long as the CI turns green.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
