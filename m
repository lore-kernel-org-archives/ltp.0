Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DF2C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751902111; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=j8KCmdCi7iW4bQGzW26s9MzBAW4O9AqcHUccyiAcJIs=;
 b=WmuCOMB8zFGYE8WhtUL2TqBwSATQbmvXswsoYvQ/tmklQoaD+g5aKTkwsjtagBUq416yo
 InGFoPsBjEvV0i2unALiA1gCOje222SfP8TDqJoiXRtsT2rMGtbyVUd7EHXw+ktLhTkQSzh
 N86Wp9yb6k7LINrOraQuV1g6+0om5GU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336B03CA0E6
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:28:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEB8B3C99CF
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:28:09 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 088CD6008B9
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:28:09 +0200 (CEST)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso6435318a12.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751902088; x=1752506888; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bk6AqKf8n30s3qRo8JYd3RkmUgjt2fDngwdg2aPnLPs=;
 b=HFd+y50LIvk5KkZtEaszC6d6MI2wD8WESPiJlDioLPQeoU7QWS9frKoe7Y032tGeiN
 7lPSLlDBVqubdlgwdHYb+WT+p9eUvIsLN+uVoSXBUu3KYXIJ8uiopZcCXLvuQzApk3WI
 5lY/y8bo14wEiH7Hjz4lCwffAp+NMAV1acl1p/BOOqxtYCd/P0YMyDX1VXMznINYqlm2
 R+YT/OKv1XyrEsr8KG35gJwWTH2Qsdf4FVS4ArfFqOkKr7kySxg3x8PzXrOpBw32LIp8
 sJgTAaQ4Ei8eAIY7JhpkJmQB13fxKDOHGTh4cChf56u8g3vD+7iTkEorZFNzOGUM/MpK
 l5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751902088; x=1752506888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bk6AqKf8n30s3qRo8JYd3RkmUgjt2fDngwdg2aPnLPs=;
 b=hA95p7P0iM2kUhJun2IVP6SqtOCZK80RTFOvoIW3E8RSy/rBfM7eII08cDtjF+eyiv
 oYexhoy+L6KVjHTd5rRJ7dM46MkkylJEQZ/GTlUUtt3W5961cROKXZEBuiU3SisceBsQ
 bs9D3/irNK2a/DOhms+9XBVu1Hbv13jroaywxyt1ER27aygYKqCAotNBhwtz21+QeAaK
 AUd9m6tE2rU79rjFHlk4gtX2hc6IecB6gD91PA9baTrxgb5/ICWhF9B0yDXSmI4OouFI
 DtGUW6POR/UYH2nWADc9kbCt418MkFd8ORytqYUkZ1hiOHPAcA3FxVVIN6q4CKVWNVrT
 NY9Q==
X-Gm-Message-State: AOJu0YwJHXuxJHKTEXO3qHgAOViKtojMay9N7Rpb39t6cmFGCmOWc0X+
 L8lyC4mCuN/2aHREbLdLScMxbSieaYKJiIUKC0Tznl/RdEK45Z+i61J/4ZqtSvnc0WOAUDI6sLI
 nhFOQhzD2XTL1
X-Gm-Gg: ASbGncsqRhVOPkOQhpTXsYS/p41P9ziHUE8bX6m+pxISIa50nmiAA4PF0mevIqhqFAA
 MJo/uwOHCQkoOsQGtcoBbknlepe9r9TtxhWPdOuT8PzW8jENNX0J6mnoTJTUGDAqEIPgWbItBAF
 SAk5dcmrPIqhD7xRkJHklRWf3dIKpS71fpFaxx8YdjkCZkHeNPPDuPIw3vLREzJbkyfBzatSz6C
 rOh8nR9oTpgJkLAMAXloboVnMQcH1GVx64NkFS7+KcaJOlVSSCvxtKttgW4REam7quDneIFV5K7
 jbP9DyIIgO6uoaBSAggS8VZtYtw5pT20GaJaUCXg6WOwZRMCflN9iZU7PQxmertr3XBUp02Mjca
 7GuZmZ3vgYbbWQDG9bJFpkbA1sF8AfRA=
X-Google-Smtp-Source: AGHT+IEJGAsLysJHN24Xf8ys1+dQyuOPpq+LoQf3zhTmX/IH6jc4pu/l/EQkyTUxhYDAJ7b+/yXYgg==
X-Received: by 2002:a17:907:9686:b0:ad5:5b2e:655b with SMTP id
 a640c23a62f3a-ae4107f1f06mr846404966b.25.1751902088337; 
 Mon, 07 Jul 2025 08:28:08 -0700 (PDT)
Received: from [172.20.10.10] (ip-109-40-178-88.web.vodafone.de.
 [109.40.178.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b02794sm724662866b.110.2025.07.07.08.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 08:28:08 -0700 (PDT)
Message-ID: <7080e0b9-2d4a-41b4-8566-c7afcc694bfe@suse.com>
Date: Mon, 7 Jul 2025 17:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
 <aGu-qne-SMpTCEy4@yuki.lan>
Content-Language: en-US
In-Reply-To: <aGu-qne-SMpTCEy4@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Add ioctl_pidfd02 test
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


On 7/7/25 2:33 PM, Cyril Hrubis wrote:
> Looking at the kernel code it looks that if the PIDFD_INFO_EXIT is not
> supported we will get ESRCH in the second case. So I suppose that better
> fix would be to allow ESRCH in the second case if kernel is older than
> 6.15 instead of skipping the whole test.

Maybe it makes more sense to check PIDFD_INFO_EXIT is available via 
configure.ac and eventually check for this support in the setup(). So we 
avoid weird runtime checks. WDYT?

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
