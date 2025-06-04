Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F49AC5B543
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749020512; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sjIEXI0dvcW2HtYzo/KVnQiWxNo3hXUpsDWSmiYSUXs=;
 b=OymIJ2H8vgKXdXDSmXEwGITBfIKOWCtY2TcEZ7PoyfiqQ7zhitrmRE0EkMwz+Bzactrbc
 SLnufHYjEuEqF9bSFU3Sgy1s7CVILtlAJ8iR+7uaIqVGDRkzqqT0TImW1D8u/P9pMrS4Z3/
 co+oXucXuffdigbgunOfj9+t5/CPO+w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9007D3CA0EF
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 09:01:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98F8B3C3334
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:01:30 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2820960141F
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:01:28 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so5137368f8f.2
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749020488; x=1749625288; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=OwhBtYTBYzdAgtOgwtta/B9APGh9MtrJIuoiQygM+IWey7zPLvxFLTiBwsJj97z3Ik
 HVDcyYbbvBDi3AR5ZGK8zi3mvscdDGAqb8hOkHs+xolbiiGZjoxDmI2fwbDK4sTmrwrZ
 11JBGDxyGkVlMrQKoVwXmd5NER7dYciBnBvZlx4OYjWCCjspCV4Gku05CFxCNVwiJPNM
 u2TqJ4e7P87C5264VEyArlJFnJa++BWUgZtFC9hh/uSk+ZCvxcwRkWzoyw1sXBcRYfDF
 G0SkRmPzmz/z/d24u0jAfUzA1I7KLHP+0GIWyXGM0JadON4H4s3ML9BpVpj6D4l0MPPU
 GvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749020488; x=1749625288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=adLjBbHTP1rzPhFS9EZowxuVyYyhyna/16FJwtFjOv0uv2mvvJpaJubqnD8MiJZBKO
 MA6aya2MXzyqwoq2VZKlwUlVH/U6y2TwtUpXrpGFjXj32MG/5OHGOMZEDtUeC+LNg5Dz
 WF292+uWhmFro3/bCEJmJjx9FMZw3MP6iJfDIPStz34UgNNTFgDqiQ7p8Ffg1AMy3l+S
 r2mtNIuXR3eoXbcgRxv+lbE5WC3pEMJHSMv0vYtlHm394kg0fAIwltbFfIfAyUOKSdiw
 hnXOLlh5jAMSWl0C0J20PvD9WDskDdyrg+t+vo+/B40e9VqEjCh2VEXdJWGRfpJeJsba
 wJ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARoK0zQ663cnOwtnQUme+UD9S9uJ1GiPShYkyVH5Cbuuj+Vg5TCgahzYUYA/oo4fPUa4=@lists.linux.it
X-Gm-Message-State: AOJu0Ywl6VModVgK4JIeMegtBnI32yVFb5p3+sxIOwW5lfd6xGixs6cj
 fnJfOWO8NNrERoLSPo9lEI3nKSfptILfLDSsYHLi89AJYkNC9Rvj4IaRtprNaFYnOHsf8rXZSEi
 Qo+bQ
X-Gm-Gg: ASbGnctftgohRfaCxxbwHeMtCy5txWq1ZFMzVxJ/tzjwYtGeEFwkHYjj/x2yBEhv07H
 C74MuabH0x3eznfwV17mPvdBRc7eSGpGtBuu3VnCWtJte4fMpG4qxmynNnoTpTN0o3Pyv8wkf3n
 w9HU/mEh3JjRbM+jK8OV4dgZJZ/Z14x9KJJdpOTeKQGzklOCUk/cFF6f/6Bpe/5topj10jicvQa
 QhEV7VXNR1HKOSsOxbwlOx8omvpnd6wy2T1r9Cx0UFJqswnkSghrnm20R6DGmLJWNWzrWL4KxYa
 IUq2d4IB6PtIl9Fvw8fCnTQWA6T7azhNHKyffrykCaBej0OYw6N7Q6ydlPAkLUrdbMj518+qKBf
 nZR4XbKnQD4cf2Qq7fwBSGqVzRD1btfCpyyxeEHo/9TINHT1KjJGP7CzLWKaFngzBakBffrt2/2
 Xnq4Uu/zN/RpdYzgA8J2ggwLDMckKshcpjaoc=
X-Google-Smtp-Source: AGHT+IFaf6JIR8AmY/BFIpiXNoyq12hrt/Xz9HkfesNhXwzHFXvCgYehbd4wRFYDxiQj9XEGfcQtYw==
X-Received: by 2002:a05:6000:2903:b0:3a4:fbd9:58e6 with SMTP id
 ffacd0b85a97d-3a51d98de21mr1128275f8f.50.1749020488287; 
 Wed, 04 Jun 2025 00:01:28 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d14bdasm97557145ad.227.2025.06.04.00.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:01:27 -0700 (PDT)
Message-ID: <20e4af84-e614-4e43-8192-3ad528d6584e@suse.com>
Date: Wed, 4 Jun 2025 09:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250603152253.214656-1-mdoucha@suse.cz>
 <20250603152253.214656-3-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250603152253.214656-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add regression test for epoll_pwait2()
 timeout
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
