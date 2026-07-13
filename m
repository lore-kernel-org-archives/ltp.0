Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B4C44501
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783934409; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fbV5kr5yeKz7gnK7MrqbMh0xRWzr6IIFEkZw0tn6tOM=;
 b=KdznprbLHFKgIeCNiNCd+jTRyIcueR9Ju66NhGApbfw1LVOsSbSBWQGXur+5muCuWcMwh
 z+v5XYBlXRzCHhd7VjqLjx/gjh0BGRhASknmC4LYPjJWUEF/FMokodmOpPUgTieZulAeyfG
 FrBpP5/lkT49bjX76/sejEeyfxICHCM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B81F3E2C63
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:20:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1ACB3C0F6F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 11:19:49 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 754122002B2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 11:19:49 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so17233035e9.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783934389; x=1784539189; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ey2v7HnsyT/hXHLvcxqC7fYXqswKsDLxoz0FAMJvDbU=;
 b=hFY9kJA66O5O9OjGPa3ZEFW65RQNFOwaqh2LhNpFfXGb6PvmMqGZtMmsvrmiT4AL3v
 7ZvwgwueVHkIV1YPsMo7Uze8J9xRo0Ck+Y5Cp4zGg0w5vQAiaPmjIZ6kp9wuqFZQKaqL
 f4+3MiJZ5dBK1bQINszstliYr3Wo0ocgkwcyrqIniM0FfQAP+NGKXcR7OGtgSetPb9Ll
 aGnxDtFNPMW3bqRq4+OEEmkMlzTrIKtiuEvUJeAWzy1Cu+u2yl5uMwwdjdxyvdrd5FQV
 01plBQpLLFSoKIiY/DN1p1a71pk5rDJw+onpgcSXOfcoRuEduwcIfhFc1AG7YJDCbIPS
 ORyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783934389; x=1784539189;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ey2v7HnsyT/hXHLvcxqC7fYXqswKsDLxoz0FAMJvDbU=;
 b=tK/fNaLrlEM483wqChwLTjmlfCT57KHNRbi103ZBe3300txPSvmZoEoMO0b409iTQ6
 2eafLSLZwSrOlpjClGq5GDwaaU997ASYFR57aNQK32WgxkRF67mPZ0uxxU5rYP0QYuBf
 3fPpli+FRW3u0NhDiYgFFa+TBggYz+yK/i8l0dC2OMxaOieEbyikqt+e/MmSatWCwHCH
 0yzuWRXU59KJuEcq+Z2pbMl3RP1/A3XjjppcoTHB6oZG5KTOk7pGTve3C11nmPrWq1j9
 +Ag2dA3dMB5X6aOxrtWUMuvMn2hYsfmgCVsvCHCvQxsgIs+zbhE8XwFCaAOYmXKK0ZSC
 BxFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpP8o/TTkc8vL5N0LLmPuFodYXXIuPQOf/OcDIh3m9Dw+XrgW0ZdmRlVNZSKrJyYTexBKI=@lists.linux.it
X-Gm-Message-State: AOJu0YzfSddM3w2fekid7GotjpIraimq+5MOCjrMmwUcIRfMLGndW3T2
 g1vnRP/96lL2P7iNcqIHS4W+mY97hHXVHvzaF7UgYVnnFSrcEXHmfc8ljbDXSsJNDkQ=
X-Gm-Gg: AfdE7clOO5oIMqAExBr5LaZYUStGNhdS1lOOqKIEWkN6YVr7gk3oS8lyJOXo2x8fucU
 y32ZLaACiwqriZH3MvgSSJITUVFFgsckMSMtwZsvx+IkgogQg59CVKUthfE42rkf8DtcIH9M1FC
 Hxk3nFpD6HLZ5qA3aFBK0IY739VI/dmA51ZnsSF3IXaLGOZRcsWMVYICqe3aGwlfIFog3VsnI9I
 hE0YGLdN1ot8Zm/W91taMd5TdaRoMnp035U56cjzSNMBIc5BoMc1/VoEnYEg++EKj/HSuplLrkM
 k4GPO+glr8i7/9qlfoJeWfzoPbJLSdVd3+OCUNCkPRDH0RB7pnplb2/7rQboBo21qAAZnO/lSeD
 0ej0u30N5aG9keN+sjab0ElzF96aPx4m4iKd6Jr+t7hgE+iWKeS2sMwNaOK379Uon6r3qCay71l
 h0CwOIZOuMgQUGcTYAImOOQsja8n3MtiEioVbr
X-Received: by 2002:a05:600c:6098:b0:493:bd71:6084 with SMTP id
 5b1f17b1804b1-493ffb37b0bmr44275125e9.31.1783934388818; 
 Mon, 13 Jul 2026 02:19:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e77c2esm214007685e9.2.2026.07.13.02.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 02:19:47 -0700 (PDT)
Message-ID: <6a54adb3.73de60af.336abc.a109@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <alDb2xQXRdCI0SMl@rei>
Date: Mon, 13 Jul 2026 09:19:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] metadata: test.sh: Add support for
 building out-of-tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > I would say no, it's not worth of that trouble. I would either live without
> > out-of-tree build or reevaluate what is blocking for switching to meson.
> > (I don't remember what Andrea found in his POC some years ago.)
> 
> I'm not 100% convinced that meson is the best way to go. It increases
> the build dependecies quite a lot from a autotools+make to python with
> several libraries.

I understand your point of view, but meson doesn't have dependencies
beside Python 3.10+ (pure python) and Ninja.

So we would switch from make + autotools to python + ninja. Still,
2 tools. The only difference is that make + autotools is messy and
legacy, while Meson is modern and well crafted.

The project I worked on is easily adaptable in the current LTP version:
https://github.com/acerv/ltp-core

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
