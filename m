Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E2DD4415D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765533441; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zM7QDX6BffFNSkVafgO5kH1fNAEkVHnLbt6F2H92bYk=;
 b=UE1MYg+bFFE8ZbSeydga+ce91pN6+qwpqxkSnhsFOXuAUTwRkU3nccDj3VpuK8Ixme5bB
 czcAaNbB/RnUnmB2aEVDBNYF5zk+IoP8hUyT9BTX3uxzgtKn8ly1jkbiJqvz1X7S6XDynfk
 QgwL1YF4XIreac0pUpEQ7ixRkO5pKAY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9482C3C7B1D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 10:57:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36373C4B76
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:56:55 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 67AF7100029A
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:56:55 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so7937255e9.1
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 01:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765533415; x=1766138215; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9VXY3G7eQqrIUHNPWLYkngYBNLIu8YBZRJTeZj+puw=;
 b=IakwczwIWKii7YBzc+8DsXocuHdR0OdWevPKg+7wjCOcA8aGsb5C+O8I+Q+Wd3RFRY
 aoaQFgKcNtobphT8pz6iF99aJkC96FmFJQt0n6b+YSuZkoYTxIzlE5BuA9aKGHIzOTtg
 eZLqlw4FmNEIjI/Zed3JSOp7CKTylmc4rKgeSApb4hTfrguwgB6nEpwDjlcBNCpLSoNU
 cBWZhVP+dGkGycIpEGsn3PPL3TSn0vu4M4tukivy2igbDtYpbjiUCva6JpNfzKStXEcA
 UhiQ10BCRtJWcAa1L7pv/UNk1x5Ujm5DRWWbinwccJahaQdi3Ao+COkBx77sKIMVL1G+
 3rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765533415; x=1766138215;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V9VXY3G7eQqrIUHNPWLYkngYBNLIu8YBZRJTeZj+puw=;
 b=oZixUnHU2nsya+MIMG84zAZ1y4wjl95ljKN5hSVkkezfKZ4aFU0EH61zEK73smljpB
 Z3blWplv6giAGZEO21kUmOcz9/COqDs16hafXGWn4yPv3PDVbXdMIy4WFLWRdTTHb4kn
 yOC2CP0WF/AN4Si8Lam+p22lEpj1IqTg7/sQZhgHkt5dLwL4JXLxpUXm5hgp6ooqYpbn
 zAkTFcAV2TvFBskCCZTY9g7rMQH72yg+L2fRsQ+DshKbDu9NhcbfpQ19FHJ0nOZ5hjI4
 enN79hGbPlgqLgoy9lcOpnVQKqfyp36pRTqDNZ2XzwlMOVUPexT5qYtpNIfhO6HnnKc/
 2y8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjAjcTfKkfWujfqUhcRgU7r8BHjcluwoHCp0SriufnebDR5SwgTFxzzzp9t1eTvYdp7x4=@lists.linux.it
X-Gm-Message-State: AOJu0YwppNNg/9xrpDGVIF1FfMF3I0cj2iz5D1mvPxhE3jjp0Vpw4tYF
 g8JQl/zSeaWolY8UoQ5ArNaMMm8nnUA5JsWGIRov2Wgt6gZj4eDHH5KJDl8NijHsN/Jx0SOQZia
 DAgD79Es=
X-Gm-Gg: AY/fxX6NUh/0XHHG0Ghv1ojzYlfnWHtRMlmDTcCtBrFCILMBM1JU9phRyILsv7L5c2J
 2d3AVyh8wr357u4TknMYUOMRHyw2wYSip5ATxde9nZ6YZLbe9nP+gixbIBw7NHdVRdcqzegeWM7
 qjUsV2NtvJOL8gVEJ1kJY84Fri5S9qMOLCYYiqU12Ieh6y5s5miCNH67Ole+1wuWW9QpttfycQ8
 iSuAhAL2uAri3dqgGkiOJpHgbd7V8HjWkVhoQr4UDSHSwqfqJ1JxwFva0oB/qjjh1FIVaMuGLA/
 HgU2iAKxAZyJkq576udLEsS3prKQ5a92WaYkcmIXYrAgTM3JSLBzPUynaYpWn4RYD3BJDG/O6oh
 sbjeaMHjZP8dW8DUDSE0Nu8WFCpVA3hL2Ny9BxPEU22REdXlS0kU3cOhuz9WZchkq3JZQy+6rfm
 MerKv/ltX1rpIuV9mk2F0=
X-Google-Smtp-Source: AGHT+IGfRNZ+ABZa4DEkSA1c5AjjNkwVPPk8uGplN5+ppAHTje3gen41u1iIdYjGjkB8CUl3t7g1fQ==
X-Received: by 2002:a05:600c:6290:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47a8f1c1e65mr17792295e9.10.1765533414730; 
 Fri, 12 Dec 2025 01:56:54 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4f424bsm22988905e9.10.2025.12.12.01.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 01:56:54 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 12 Dec 2025 10:56:53 +0100
Message-Id: <DEW5D154QZ1N.2MDHFCFGA78OL@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250909084512.10962-1-wegao@suse.com>
In-Reply-To: <20250909084512.10962-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] connect01: Add positive check with different
 type of server
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

Hi,

I found someone already working on the same patch. Please take a look at
it first, since Cyril already started a review on it.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
