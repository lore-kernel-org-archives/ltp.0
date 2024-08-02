Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2670BC3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722595168; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=0qPt+r60f0XZiRstfcaJ/HCe/yQiqs9uK9bLP8kkN5Q=;
 b=EyWhdt3EpI0VtFAKR5fdQBGwUgUNuF54gR43orY82JUyM8G7GskPVp+pvR6ScytrYoQ/4
 afJmfLDn1Hni7tsKtKah7QdorgHamzy2GolLlBMg9VbV8DIsP0LCtaJcxuv3ffZytdPWqxB
 5sOiSzpgMVAOqHW1WXgwbR9/r6MWA/M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD1653D1F4D
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 12:39:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 093C73D1D11
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:39:05 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E89B1402E2A
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:39:05 +0200 (CEST)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f149845d81so45664881fa.0
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722595144; x=1723199944; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tH3OFn/29nQdFIlTGOOnN+K8AZkCLNcuy1a4SoEws04=;
 b=L7jNENEm2tcWESuq4/kLkFvuxLhRwrQLbPC3mD0NxE3lDFyapMZIE3PLuYyLV1hegd
 uuOWT5OGqBFBLYxi/ksCzS2bcnrwvUIyigIAn7eJ/QgLv98SOTBB/33nSYtE/7umIr+Q
 X4h5AClW2HoymvwUTpdh/hRWdUpjAvv/a3A9ll2nUjpOK4j0nMemHvDWPrFlTLkEOZvx
 NsO8vk4FhsivJXsSvbs1432FP/5r4+/Xvi/cK8QWMbPA+QKokIIxqAKzsybL1+J3R7YS
 fwUCYi6/vDz4l9Dylql0UsL2GQ+I3xds2FqLVGdhVPcwYJ8A74e9hFGX/0lnP8miNrQd
 jdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722595144; x=1723199944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tH3OFn/29nQdFIlTGOOnN+K8AZkCLNcuy1a4SoEws04=;
 b=wqmq8Wl7RqJTNVdEr8HS27GoVu6fwUT7qq3nEeVji1zIhngu/IVDUJ6OqM0BzWAz/x
 k7uMieNb2M3Xgl3Gq+6JqKK7bqAHwZWUdLdZeufHFjZvUm5W7ea2DSJUR2zYdj7ZHYCc
 jqPYeEL2Z8LqjA0oMJb/PPTwjs51UqxdS4C8k1XmnCGPJn/gZoKDDXcN949ryh4y9dzx
 S/S2tqe/w9HZHZbbcin97PjZM3KQ+mmVt22geFj2Fm3ks0Os0AThaTuXUlROdkBBn0lL
 GfHT5iT+jlSjFK2j32sycM+LAiNxbXjkS/A6TQMj1ZCJj3BP3EENLQlvDsTaSjiXRJac
 yy4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiv0bUf3WVLV6rSgpLCJ3EENcDWp5UNXmXVG7dYmam/ZTOFB56VAzBjV7dC7Q7Mmr18jf1PWNbGchbmlVof5a3lLw=
X-Gm-Message-State: AOJu0Yy3/b3s4x6/L5fosZYdudObBm/wbKQEFPb66pG3nXS65XfQaetZ
 Dnhb1XViulejPcNSSLlM7/80vf+LL1UibXMF/XOofkwA2QXCpWsl1Za5I424EZY=
X-Google-Smtp-Source: AGHT+IHHn40vzCkhABSfFgW+m6QO/XYmenwRk1VA+CtYXr8Co5xhyf4Nq1TBdpPxhgC5DTSrCu9PZA==
X-Received: by 2002:a2e:91d5:0:b0:2ef:26ec:44ea with SMTP id
 38308e7fff4ca-2f15ab3507emr20501181fa.39.1722595143539; 
 Fri, 02 Aug 2024 03:39:03 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01ee30sm1641711f8f.50.2024.08.02.03.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 03:39:03 -0700 (PDT)
Message-ID: <318a31ac-074d-486b-ab0c-cbc60780ea9e@suse.com>
Date: Fri, 2 Aug 2024 12:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
 <20240802-fchmodat2-v5-1-bff2ec1a4f06@suse.com>
 <20240802094732.GA1613449@pevik> <ZqyrdRfQ_eAGdk7Q@yuki>
Content-Language: en-US
In-Reply-To: <ZqyrdRfQ_eAGdk7Q@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/5] Add SAFE_SYMLINKAT macro
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

Thanks for catching it. It's clearly an error and I already knew these 
headers should not be touched.

On 8/2/24 11:48, Cyril Hrubis wrote:
> Hi!
>> @Cyril correct me please if I'm wrong.
> Yes, the rule is no new API functions for old API.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
