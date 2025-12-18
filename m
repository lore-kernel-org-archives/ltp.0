Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10915D6ACF5
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766061061; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NEjHjWZq1YeD3KRqVosNjC21Ssw+Sxq+HAc65X+wOrU=;
 b=cdbKvGdtw/TkWbCzJLJzCsDrSL4XYWoXqG0KEVgSLJUbKcSkLUzCszW7sXQbO60cAztFw
 l5D/Eu/9lSBAdl6RmkuQy1L493eS6aPTCag5Q/6viCGkIpnJfojhsc7JHqEpFaMeVO4slsm
 1ue7CT2vV567mA8GMgbQnLF7ObrkIV8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844313D0485
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:31:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35D53CF136
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:30:39 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A2B2600A31
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:30:35 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b79e7112398so95615666b.3
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 04:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766061034; x=1766665834; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCbyXTWpTyHmNKML2PmhoXDpKqSI5+fw82fZzwQV0Ks=;
 b=NJpgyNQ4A7hr/V5NkKsTMBE93+QdY1POXwVsOYVHemKnMTRb4Vn1IhyDxhJrC0cnUd
 1/2E9BVL3KgVyk0TpFF94d8JnO49gLwVm5AlfBZNfpa7rnbDYCVp7ZXZ4JP2Eq5VSmvA
 ZolkKH91qhzulSaqtLg7RDyj+Jx9oykDplCycEiIfBZ+zi2++gq9TPHM2+oe/2fbtGGX
 lXaPHM4UVRWmcPJOwlEbBm3T9m4fhrFUoo4L1x5DxtArNKvESgQiL4dZQWjfr4IODJIT
 fxiI8ueV/UHsc24YnzsmmPtijBD9IfU4pPALKTZkCb5hp3aRwaj4P5/JdGNFsD7or1ec
 +hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766061034; x=1766665834;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vCbyXTWpTyHmNKML2PmhoXDpKqSI5+fw82fZzwQV0Ks=;
 b=QUlAIX6sPWj3X+YAdjfPWCxPJ8j1id3IkdC/pBUjTtMOvltNxgA4A/Oo7Iv2xIiy0W
 fFx9bXeCHckdkSslIHUgGpZ30MnxdSMFl4c4MX0Ju5iMOLjIWHnzZ1Voi7wyqDvkpJhx
 xQGffPUCMhHOFlCyRm2RAdPZfHxIIM4uQFKq4UBJeIYFwaeDaCu7unYsvWzU3q45FUjR
 RrE/BlgvoAVT8CD4Y6DUuvECyFTnvmHtl14z2VAV5CIQILBfNaMht+fkNcFUrJjbNYav
 0u/N/laTYtv6VeFsjIdsRtAS4Fr7OgHyAnf9S8/dAqiHFKDV6Y541vY89FsGwFp61Cjf
 YZmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWomKnYXrGLI0z4r7TYbqAIX+M/Wxr/ss3EQl0m8rB1jEG/tfc4zZ5oiFrcnBbXKCZ0A8I=@lists.linux.it
X-Gm-Message-State: AOJu0YxhXf4K+ROJuHMl5jlpDwvUHTbnusEZHbsJTWNweCaM2JJgWP4+
 AAH2RPOIk4wYp33DKkJrKgUFg7viFM0Rl096EOcgtbRql2NiHniGdE9IoCNyrTyx7z8=
X-Gm-Gg: AY/fxX7dZ45hFviZ6TR0lP9eVAeDzCaw+JYLLIi070CqA6aTFn6Lzq2T3T9pdYVX7p0
 ++5RKozj65rZAVCkJnYHSp4ooJR3++y7jpFM5DCde8WqygPzClgQ1I0B9aQAWOMgKAVvg6c29sP
 IuGxBGivBKO2/jTIk//4VDAX+HgMSiZnj3gUIZpFMMAfXhc4hAPbZv3P503981gYdNK8FC0YKKp
 y1szqEc7LSANDYasJC7P8YoYpGKHXWdZfbA60KQ8Y+TRd0K9ETpI6Dgvq8ykcbHyFMXSNhQrA7Q
 9xQZp2PL7KYammdabawHCLplSmiAG+Q39dlmm/0KefLShWwrWSahRf/PuVYEAfOP3gkxt8e8URj
 u9/mL22VbUkxMI2uWbMqo0jU2dF3AS6OmooQi1zF8HImcS83d3L1efLk7w9PZsTY7nQl6i60wdi
 0WXnJmpgofJ+q7C8s=
X-Google-Smtp-Source: AGHT+IElaBh04VWq6dV/eLBJgxL3M3sjKyAIkSygwCHLZcokLumQDgvd3Rz5jF88r2zxgJlZDv69jA==
X-Received: by 2002:a17:907:7213:b0:b73:7c3e:e17c with SMTP id
 a640c23a62f3a-b7d23a1c75dmr2302501866b.44.1766061034294; 
 Thu, 18 Dec 2025 04:30:34 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8022f952e3sm219073766b.7.2025.12.18.04.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 04:30:33 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 13:30:33 +0100
Message-Id: <DF1CDYCKFHZL.3WIZKN5BWUHZ@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250225114418.2940134-1-pvorel@suse.cz>
 <20250225114418.2940134-2-pvorel@suse.cz>
In-Reply-To: <20250225114418.2940134-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_supported_fs_types: Ignore empty
 $LTP_SINGLE_FS_TYPE value
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

This one is good, it can be merged.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
