Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DA5C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752567496; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=MHmQkJ6TviDnEBUiZJmYikOXixKClL6A5ObTsiiE/Fo=;
 b=cE2KHFhMWNhZctguv7kK77Fe1GwsDa2+SnegYmEKtYuwvIW+mSE8M5YhvJi4gCFPo6E4o
 VJvx7faX2YFCCgkIjSUMmLK6AKW58fKoajYm+ICZnSgHVLBGqKEmHT3dTbc7bd67F3w3gja
 Oa+quHeHz/74EDFPMn8mCHqUnGmFhPI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 277793CCB38
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:18:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76AB3CCA93
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:17:55 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D5C551000939
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:17:54 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso59522705e9.2
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752567474; x=1753172274; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S1kVDsdM0DB58ImRViouQZAXAswGD0vznz5HYNUgRV8=;
 b=ReeFMPRCE4vYBhoXrwBG20NZGDPklfbkv8S3KP4hF6pfdu26zHL5kIoQF1aK6SDzWr
 zhtB3rl/0neNUL84IFwoRYBN4InZgH7XuV+iQ5S0/OZrpDDKK7umhWI3luzsGAa2T900
 ESBH1lqgj8rt5wp6Y+OZ+8PaHb51ILUAQbPjMjCa1RbFhqJA7TwHXs3UTM9MwhNERFEC
 IrKn+N9FAHJbu8aoSDtVvFoR3IuZpMfz+1/j3wVQP/RjFUSqd4L3IvA8M8QhGS4jFzBt
 keCrl/pkVgirBO1qII8xXTn0nhHKRb75197i8sxyHx9fBe98bVJp1yG3I/wAnHeB/m//
 U8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752567474; x=1753172274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S1kVDsdM0DB58ImRViouQZAXAswGD0vznz5HYNUgRV8=;
 b=nxZTzSEAivkw/syZr5mjGJ62XJUOEQJ3RC1JXthN1b21TYPYCct0fhvxFA+P3HgqgQ
 HGoQq3ki7OvRAV5FJtg2Mwy9VXxIt8d1b7ztIH5x6DK9hFws6r4J51GId1oXXy2lw08n
 6sgy10Ls+NGgQc2reQMnMRlCW5WloAwwtuEL2wDvYE4g6xUrOrZ27MiUYLMnXhp3XhAK
 Lomj8zr3xIEZZi5fwjBaHmuR14Xd4cprHx72381NPk5Z7Mw90UXUmF3GJHwYF8aRPMsi
 XCpgpOlFMsANB5ECsszPi3JnuGtb5KPtTBLWazhq8G1Abm03ktJBOKMSNDgzVdaTLj7D
 sclA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsdPeJ2MZIbRuW/7NhQ+6y13ERLbXFkqwRSqQhhQl/xHnio/V/6EYFLDU2T6y4i4TlasA=@lists.linux.it
X-Gm-Message-State: AOJu0Yw9UO1x0zAdU//hPgwPNi9KKGpnumuqBSt8AaBHKFP1ZJ1ycGDU
 lIDwPCH7WqKDkz8PzQpsyhZOjMmmsVntUFZz6vhOPEjquABsCZtsXVq8BzLHlpoLBxK61t8YcKK
 FiH1RsI0=
X-Gm-Gg: ASbGncuHGP/xCUZW0vCDdoTJJTquYITDdOEFAD3ZsJ3ypmxvnBWdj+cX5WdCZdMlrpy
 kiPWxF7+IxxqWRQcqxPAJFsv8d3OzPcVXExRvP33SUdp3Wl2ODVHD/9YyPTxR3cTJxGUauJhT5g
 AKrlvOJTjqz9q3gzSJXPwwkQ0Rhgm3t1F5mY+Rc1xpHbCyQfZNppYWrcsD8VqPUBIPOkViQdZ1s
 jNVJae0m1y+in8QdvtHXqrlJhkjqKRNnaKmYZje+gq0rZ+yPma+VuVLB82nqXz6eV03kEUjkvFf
 ig1hm8yNo7jVZ0/tcy3L2f7n5BYGtNRTeMkzthAFRr4BFRAlpgslHT5qm8TtsJ5VJiqgdN4uHTq
 /ds6kDoTSDjH78fBhsUM39/2nJkDhiA8iM/bhJ9qkhBWTPGky+FC9U6hKv7BUeqxoLF2dVkBEWl
 ZiUs6IZqHEIrID3W9r+T8M5PiDbZ2CqeM8krzUCTtzMHOOpo4m792SCrtokNpECA==
X-Google-Smtp-Source: AGHT+IFP8pijJV6LR3bZxcz/+rhc+0gkY7vzW9rwQ8/KTtQtNAnrqxxC0p5VVxw4KOcCuUOLQTI41A==
X-Received: by 2002:a05:600c:4f12:b0:456:1560:7c63 with SMTP id
 5b1f17b1804b1-45615608019mr77952915e9.3.1752567474199; 
 Tue, 15 Jul 2025 01:17:54 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561efa9301sm39186825e9.24.2025.07.15.01.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:17:53 -0700 (PDT)
Message-ID: <b7694ccf-6efd-40fd-8918-89a26f51f6f3@suse.com>
Date: Tue, 15 Jul 2025 10:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Florian Schmaus <florian.schmaus@codasip.com>, ltp@lists.linux.it
References: <775c5a55-6079-44f3-9af4-11587bcec468@codasip.com>
Content-Language: en-US
In-Reply-To: <775c5a55-6079-44f3-9af4-11587bcec468@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Fix out-of-bounds read when invoking
 write()
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

Hi!

can you please check why this patch is not applying first?

https://github.com/linux-test-project/ltp/actions/runs/16225377946

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
