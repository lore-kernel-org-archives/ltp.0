Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF10C87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754375412; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=WHQpuyFHrw9tCyW1p/ljLbZqR/j/GXZuUuIv90P+vUA=;
 b=fFoOUGB+qwRERJbbcyrYQqnAKPC3utLp/EiyQHz+4bDuBGecNFy+fNJ9RlL+4M9Pnhm4t
 mSE9hrplAwLpfk9sxXp1xvNF1t02umCWDiHIVd/HilsW5khFS6G5CXbyr63QV++FB4Rq7ma
 joaKA5Mx/dWp7LTpDHyhanYTk+e7/o0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DB603C736A
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 08:30:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C59BA3C4AE2
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 08:29:50 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9A7EE1400C43
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 08:29:49 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-615622ed70fso7923789a12.3
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754375389; x=1754980189; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
 b=OKmuW+L94+dJSPl8JAsE54mZqnV0UwEpo3d5Q3/qK4aFsW9yg+LGU81OcnrQ0mICdc
 hlx2bbPh6mF3RFJ/Au6TarNLQTFO/+q/xQ65k2dO/tGdtKQB3rg7h/GxNxpCzO73VO0e
 0nyP88CUQWipINMwMwpN9WhyhWf2wybRmljqMI2mPNv6EZTE3ctcvMTVPPU5398JofZe
 xzhFBdXc5mh0EewgwwAQp7/AGsKyBo2FXOaM2j8TzkKn/qLrIZPRCBW+0Rt0MP7J7TAI
 kjY9cZKR9HhhhityTTnKdBvO/nY4AH7yrVCx5IH/qvnmPPKG0TVDLBPvvzx6pbglEcum
 nqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754375389; x=1754980189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
 b=uPRW53/nlsQwqY2mqFQNJYbWuUBk8FM2RER8wvqWw13bS42STWrtBekdEMCbk22ySX
 q0s7M+cKYLFQspiDXoQ2Vu4UKZGNgDG9XosTN8BD6d5yQg4M2tWR4CGkFLiqINWlNpMU
 UJERrykvBRuNoO9vOtKK+LHP9CWzSHOVqNdycqOJ2JVVgXeQjzC3xu+3ezdv6Q7674xQ
 FkR7Ka38JmiLDMCCE5X1KUHLAFnxrNbVlugvT0yGcm9CbuNqrdYPy4OR9ROitK/X2DtO
 56A6edEoaoD+vIE+5v0gQYcyYKh3LgEcK4AXS4V1ECE5NtCb/1aobSk4Y+nEqPEIxK6f
 aJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV761B00znMqsaHcRyngR+PpDf14Gz9qbzyg3q/F3EGbgEH1k3Gn/XO4j3IHaXtpwisEe4=@lists.linux.it
X-Gm-Message-State: AOJu0YxN3W1y391SuG1RvNQK42W1nrWx26MZN64GasYUzlwMUKNlU5yV
 azQNvT0gZQaxPr2oZQGSLCF3dli40BpPwY49z0aNx18TTdZ3Q3Iy+wBx28hvqJOgvxM=
X-Gm-Gg: ASbGncvGkQ+oGazAhqdjbYkdmP+sAh6wwq3LztvxrjxjtnFhi0uDZ8twFThSYUfb376
 nfZIEGcTBk+D1e5UA2SEZZ9jUUbq90L4QAHO4v0YwsoZI1FjxEiqSg7h8n4Y5ssm/S7jNu6E+Zr
 ewn7LckXpa89YghK4p/RSICjtHhj7qckQeHxLwxTuqJbTjGgKBwTTak9KCCqOZHfTS9k9EH1nFs
 2s9xQU4ARwBgRNul2mn1FbuPqlsA2YJwT6Q4ONUDAWM0essPCDggKs9zt1SqPnly2E32RGVEIfx
 NlhqN9nwenMGYxKqH6WU9f49V1nseN8a1JUBV+B5aMBmEh7Hb2dmCqp4a+gGrvwp0L3JPTDGKXe
 oKYC7/Ps1sgjBWJtV7qUrIT4lpUL9C3lWBM9fEOpL/iY/
X-Google-Smtp-Source: AGHT+IFR0KTJGtpkf4Jdk5JXkjeoINtPyGSiP/xYiQcPztWja991UcFO6NiZongrM8LcjzoYEeGZnA==
X-Received: by 2002:a17:907:7f0f:b0:ae0:db23:e3e3 with SMTP id
 a640c23a62f3a-af940017c8dmr1313720566b.16.1754375388971; 
 Mon, 04 Aug 2025 23:29:48 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.162.118])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a1e82b0sm855409466b.87.2025.08.04.23.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 23:29:48 -0700 (PDT)
Message-ID: <62eb9500-1fc4-4292-8abd-e0075f9ea8fc@suse.com>
Date: Tue, 5 Aug 2025 08:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
References: <20250804201141.y5pncvmjhqv7mpjz@lida.tpb.lab.eng.brq.redhat.com>
Content-Language: en-US
In-Reply-To: <20250804201141.y5pncvmjhqv7mpjz@lida.tpb.lab.eng.brq.redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Make sure 32-bit powerpc syscall defs don't leak to
 64-bit powerpc systems
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
Cc: mjw@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
