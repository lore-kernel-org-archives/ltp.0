Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F522C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783943752; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=JVj6OnheWtHdXvZ3JaDMM32Fyv1ue6qwAC/SosIP0hE=;
 b=W4QyCORf+PUcCrix9vdzah1QqXYMD58DUwKin7PzauDeC4LZWR1f/wVAbDLcOMxlEMBwW
 Xsa3aQ4+QnzwFY+WkRvmjT9ZU8CorxCrujFgOCLUlSKdJb0hZg7xLsUGus8yoKOSb9qS+44
 gNzTPcUFru3MpGZWdX3UVA8gLyFHFBA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA52E3E5E53
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:55:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36CA3E295D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:55:31 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 47F621A004A4
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:55:30 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso13413715e9.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783943729; x=1784548529; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lZxan5Lh0NUXoEMMKBuImBccHJ8G6fkldFXQZScnr0U=;
 b=aTvTQhB1xbxFNcc/uqhInj4MjVJQpaxoKRIqcvOHAOEoEG0nFcEXTjioEy10b0nrTs
 wnJ6fSmMmQbE9ePWII8SPMz66u8xUjMcgBxOp+3ik5SHek4yCKDdIOHPE/BdX+XTToRK
 pY//QxuMhsC/2Vlv+uVxHHiO2lg0xo6sCTb8k3/i8p5a0vu8A504l3GUGgFr97xKiOq7
 A3W/TIyIXzYPVvmIlUijcNg4A1qUGoIVGgn/uNMSeVuTsv/FGSrFPf2LuJWeskT+mTwU
 CTMv6xDeX14CkCqtLDQB+HoLEpR4ykthVeP5LTjI0aFWzRQvcRspXRwPcSXFCt6AAaYK
 Yl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783943729; x=1784548529;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lZxan5Lh0NUXoEMMKBuImBccHJ8G6fkldFXQZScnr0U=;
 b=lPW16AQpE/CANWsV03drBJKPtkLNsAL8BlCOgPHefOuPq3cBryWC49PKHo4BTS8K06
 iD2IAiAze1il0ZpOmGNRq9S/KRM/lxLKje5qM0mUSt8l86SMVDs4uSEl+sAr9uShYv1X
 bWU0PEQgYdbadoSL36gehomQ95uqylzahqJzKi80UUK8+bJjy4HS0crn4c39cBWwfo7Y
 6drDvJrJOKqkgTdeGZkkZv4F848Ivli2kF66d+aoghvBgVVPMn9GW89Hk2c5aatN7WKZ
 0VkNS2G/TbcuNbbPwsGf/4/rS3D8ZyqGDzvLtvvmaoJ2+kaFWQKXrHz88o4R87c7yI2H
 TdfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXKhtjJ2HRmzbRco33vk08k6YDbmJ5Df/Luz/e2CZUkq7Oos6+ztPtzYXm93XJ9/h3bsk=@lists.linux.it
X-Gm-Message-State: AOJu0YzYKEWC1rHvcOpUc2+ahYd+EuxkR9M4WetaqrIoexbzm+gB3d+C
 uV18EtHGaS/tCWt4uKSKp6ORjxm/gZgiImq8GOXK7CuQP51bga3vDo8ItOpLCE20CXU=
X-Gm-Gg: AfdE7cmpkg3IJcqa2iv6+Bm8+jbaCtqV/l7mB+Id/YWGhHR4LCnnHfBz4pQQJOWtokQ
 qsyHLGkOGWPs10UO8Z4ypYAL9o9oucjpBKLiPTh9ESv1XKRsoGlFUiQTbnRWlU8eM5v/M/ZAjfc
 ZguLkh0v3g9hlG4+0HqbM2FD37WhVeA4xDciFQQm8z1pMBLq7pQKMvoXqcl/v/JEQB6xwEpOYxP
 WpAMjo0LyBjFfJvCO/IdO7IaFGx7HeXdtF/DukDGpQPhuOqW3H8MPrc1CC8TLltH6KRtZmPCBvU
 /hRKorZnKHqN2JWvd9kl+IWE6bIgbPUNNTWvBVTiQ/LqeXvNj6pLTDaaObWqqpnAXo6KJmMUYlE
 qxsWatdmZ8C5JIXKu82pj46dYN4sB6iei0kU7r7/2UiSnE7po0bZYz4m/r7xJWeXGWnjojKgqwg
 cjLTPTxfCCAzvkX1NQsGA04FxJBO4YzgXf
X-Received: by 2002:a05:600c:3acf:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-493f8829917mr84659855e9.32.1783943729429; 
 Mon, 13 Jul 2026 04:55:29 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b126sm81403878f8f.24.2026.07.13.04.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:55:29 -0700 (PDT)
Message-ID: <6a54d231.332d3c56.6aa8a.09d5@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260713113602.GA224249@pevik>
Date: Mon, 13 Jul 2026 11:55:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock: fix make check warnings/errors
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Andrea,
> 
> Thanks for your effort!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> https://lore.kernel.org/ltp/20260706200306.3982-1-linuxtestproject.agent@gmail.com/
> Also, it'd be nice to teach the agent that splitting string into multiline
> comments is worse than long lines.

If you want to send a PR to the ltp-agent, this is a great exercise :-)

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
