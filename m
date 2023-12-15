Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E9BC4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 10:25:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F236B3CB39C
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 11:25:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F253CB2DC
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 11:25:27 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D699C200B3D
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 11:25:26 +0100 (CET)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ca02def690so5572751fa.3
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 02:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1702635925; x=1703240725; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cC92sstBWZUyWh9Phl0tOwdzPaGMtfIvoMRdfATsrzI=;
 b=LOAIVqWuL+aR9Dhya43YLgxpKMAdcOrfj2SyuS23+/kD8C654fgmi3c27LulaKJ400
 RXNtycMzJjCwBTdAWHP5xqv4L7acfnuNKCg/JtFWt+IuYQrjnJXY6UOvqitD+s0DQsJk
 GBY7qkhmJ2rGat7Pd/1Yg2utC8RNCtxUIJvIsKs+KIb0YM3wzE566IWx/0D90GT0pssj
 sdB4Ew3+uucJfWFYEHiuN9DLJwrqjCuucdkxtLazkPV89/ERDwPuvg/pZRWsbM4TMfrg
 h30dZKEknEORWbc7DVv1R5CRc6N+Y8i+Fb5YeMSM+7JHzTE7pTLceWn+Ugv6KfF7XQrn
 NG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702635925; x=1703240725;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cC92sstBWZUyWh9Phl0tOwdzPaGMtfIvoMRdfATsrzI=;
 b=aFwrC4+DJT9ZnuUTIZQ6xLw93mFGIkOfcLmbKVlFTKQSwnZ7vdjj4gC81CwFA9u6L9
 m04LAjuuNfUteOKbXNIHD7/pNzttclCi9T5I/ScWFt4id/32IvN3JBKvnS53R2hn06Tm
 Ld2ioVR+8HQr0DM367ytrIghR7SmgWu8nyDhJ/oeB6YpZnet7ydMeuVVH4OMWIKQobE4
 Is7qIKabpAquZlVNq0NrBcimgvPXYNIt6YgM/CdZNzJd732M6SE3vdDljsrIYKuuohLj
 1t7pwIFjOv6gCsTU9a34/mWJ8xAHM9AlqIxcI5w2lAA6WjLwZg1MJ09iys23dDMJqYZN
 KDqQ==
X-Gm-Message-State: AOJu0YzLeg0qYQEryfajpc1CD03CEuF/w/zXKW2JdJFasahn0pysW7kY
 iZd065A1cYx5Moqqi92hD54+VKh0Ci+pE9NO3BU18Q==
X-Google-Smtp-Source: AGHT+IFuXpRCzg0xG7xIuaXlo83aBHZzNVFK64QbsyHdgDQ12kF1/Sh8E3tvBefj170fSbElj9QezQ==
X-Received: by 2002:a2e:a814:0:b0:2cc:1c57:becb with SMTP id
 l20-20020a2ea814000000b002cc1c57becbmr6873936ljq.50.1702635925364; 
 Fri, 15 Dec 2023 02:25:25 -0800 (PST)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 z194-20020a6bc9cb000000b007b37a09d407sm4508977iof.14.2023.12.15.02.25.24
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 02:25:24 -0800 (PST)
Message-ID: <5ed0ea12-680a-4995-99e6-d98c29954621@suse.com>
Date: Fri, 15 Dec 2023 11:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Refactoring doio testing suite
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

Hi all,

I'm trying to refactor the doio testing suite inside 
testcases/kernel/fs/doio.
This testing suite is pretty messy and difficult to read/maintain and 
for this
reason I thought to start the refactoring process. It also has the 
biggest amount
of code using old LTP libraries.

 From the point of view of the algorithm, everything is pretty simple 
and I managed
to go through all those tests arguments/headers etc, but the tlibio 
library is so messy
that I'm wondering if this task is worth the price.

For this reason I'm asking you how much we need this testing suite, 
considering that
fs is one of the biggest suites and it has multiple tests doing more or 
less everything,
from syscalls unit testing, to functional testing on async I/O, etc.

In short: according with your kernel maintenance experience, should we 
remove the
doio testing suite? I guess this is related also to how many bugs have 
been discovered
thanks to it.


Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
