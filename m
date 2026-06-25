Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FE5CDB479
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782399915; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=C8hG6jp5ZwCA/MG6XNEYDXqK6obcIHr4oabz3ft2nSA=;
 b=EO9enDVSbNrfOZ+EAFhOG8pHBR7NWHH6SdcrnEPMfvL0jQHWEwM2Bm11HkV6gDHNbcKk4
 3mJPMn2RI17U+Dk0GG5FMmXJ5x9ayFUPEPkB1XdArcJAv3SVtuEhiyd87sNeggsBalsSeoq
 9I7e2PLkWWbyRDmt7JCSpkD2sKJcEz0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAB2D3E61DE
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 17:05:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A74E73E4D8D
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 17:04:56 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C88B21400513
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 17:04:55 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c1217010b15so68561566b.1
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782399895; x=1783004695; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2DoqNBTyN6HGdNxKbX5/CHYbvtrAPnwxe5qaaStVJs=;
 b=Pvlg+UTbYN6RLV3iAFDJFnGLKmheRwxuy16svKHAEvQt4HZk7gLV+w4aG0RVuGZkGQ
 py03eX3NRFCd8KbghTdsye4k0HZFRgpsD6gbanD81z5twJIqH3a45Keb1AHI0PfdrqMD
 HLR61ZVKqbadm7FDkwzuAey2C9Fdm0uKCIkCqQ5dOQXhPIPoJBwDa4gJrNbjsIp+g7oe
 y/SzoPp/7VaLIIb6hVDUOS2bWqUJZi20CI6xv76WhoZzsZU9494XhengKl0olGbIV/Do
 HrK2tc1CujuJ1WeY+ZU505fN2UtbYuJUkF0668zfuDiwriSkDJkRimgp8IE3vu6j9fUq
 FcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399895; x=1783004695;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2DoqNBTyN6HGdNxKbX5/CHYbvtrAPnwxe5qaaStVJs=;
 b=QcrQBNHZMLRpkbS9v9LApuRdoKT9VnnIiYgWUKFom+VUBt9jd3W4LNBN13+wMCvsfE
 Ct6v85n5MVL0R7fW2HHZp5I66KvNCc9y3iHeo9TEIAzMWLhgRuIyP9Glae8X39mj5pq+
 WO4O7fbvADLQTP12o75ojBQF5/wea4RAMRg9+1gLMzVpvreRjJ4Hcbnkv4u+9ptl+j4b
 y5+OpEVlMYyporf5ACCKc15G09DH8os097Ks6kXsPFzLJzBWA439WBln31hmWo9TuU0u
 Rue1z+SJ6SLwqKkw+8GdR8HmaU7FzJ9aQuWmWjLzivpMISGoStV55g5/6xvBmG0ETvNa
 VtjA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1Ol8pK2ss6yxDErpEG/5pN2mDeMlh5l+Nk3tvtiyLwCzur6T8EN5tq/IMvdY0lVJDpx8=@lists.linux.it
X-Gm-Message-State: AOJu0YwhcPOqBzeAQHxr9jbCNPywe9ClBoV+OePs6zUfwlMKZXr0Ss47
 +5/AxYnfq4bKO7B/hijwpjDMpNgiuGsJAo83mPN+bJF1UtqyFjQmkWVpyAyMOzprqv4=
X-Gm-Gg: AfdE7cmtsVCfYK80XZAJuDdynKQPj9f7l8vdT50yx79Oc2yRIcAkEtiNFag8Iz664eG
 NBJNAP2tFHtw5N1fY+2xS6wnaSDWfZtC6eqMyfCHQV2aolEv/diG87ehQEBY21zMEjyVsMOwT8p
 mWhjwM/1Cdh3cj0w9BU1sM3TeYQrl2NVslVSASGqcbX06yBPY5Z9I5BMaCLtEqPJ0wxe/RNMRP5
 hi/4HIuNh6R1rItYBw3d/uy4goNLw/izlccRyDkheS8i0iD9+pBAvCBSBN/470oSqs745TjAKQx
 EjJ/c6kH7Gd3gPJubM8s0YrDZBACoLiVLG8ypx0JTxb3wdGLcxSPz45b+U+6hRIncWWRdaQJA1b
 ZV/anQ94pBgrXa5fGGOBMXCKNElKMWVwmmacnmfZaSLJ48nbpmqSgdFF5zdFrRnvcGAoZO0WYLP
 a252TWKBeIo0pNJuz8Yxc7DrfFhlEYEw==
X-Received: by 2002:a17:906:7955:b0:c10:bfaf:6f73 with SMTP id
 a640c23a62f3a-c1204495c0amr235334266b.22.1782399894973; 
 Thu, 25 Jun 2026 08:04:54 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbedf971sm223937566b.62.2026.06.25.08.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 08:04:53 -0700 (PDT)
Message-ID: <b1abedfe-14d0-4a34-b4b4-c7209a4748d6@suse.com>
Date: Thu, 25 Jun 2026 17:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Avinesh Kumar via ltp <ltp@lists.linux.it>
References: <6a3b9837.ff344046.2fa080.bca7@mx.google.com>
Content-Language: en-US
In-Reply-To: <6a3b9837.ff344046.2fa080.bca7@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sendfile09: skip on native 32-bit kernels
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 6/24/26 10:41 AM, Andrea Cervesato via ltp wrote:
 > Hi Avinesh,
 >
 >> +    if (tst_kernel_bits() == 32)
 >> +            tst_brk(TCONF, "Test is only supported on 64-bit kernels");
 >
 > Why not .needs_abi_bits == 64?

Thanks for the review.
I switched to .needs_abi_bits check in v2

<https://lore.kernel.org/ltp/20260623195000.110648-1-avinesh.kumar@suse.com/>


Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
