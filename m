Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD58E9E304
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770816052; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=i6h2biOgPg1sKGUR6/FqQYGk4gtXH2VjSiQMcBuwTpQ=;
 b=djiRXu5W0o2/q/xxfgfBsBAiVV1glA86H2QyFbJsEluODBCRwRTTJvm/5QBGeFNFIZC6x
 VulSISEpxHYnm2rqefNfTMJZkmsXSbufbjbSWO54n0+Cwr3QGGxdzTTvcEEWNSAFW+Ue4kU
 ccipgOgTMo33nx1qZnbBaodDT/OAhgM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB56B3CE4E6
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 14:20:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A03703C2C39
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 14:20:28 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07BD960077A
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 14:20:28 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43591b55727so4752406f8f.3
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770816027; x=1771420827; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIXJ6p7IXn4rNWFH6mUxYc+5HNQ1Upt5+GyPNO44o+A=;
 b=EzsK3g37TxJYtEKGb29pJ5zuM62OrBoUeTojNgO79ZvunET1lolo6gDNHx/Z3F5dNA
 mNeyfrZkdimNezGw3Bs7F1q+HDwMsHqMzQo86M0Cmhj9uOFAYnNh3lK49qhH1zcqXNNC
 kB6fCrCgncUwzKkIfPv70wwX9jo2Q4TtPgOxhYHTOfGHT9XOxrn9OZzlcXnUy+D9rp/2
 5L0/Fi3Le2sJVkQzryNrixaVrWgIIv2/OXIfLRh8QefTYIdEjEUpHuRGDfsFOGJXMtdS
 0BZktFB/t1IfW5MSA9Be7HpDgRMEJuNslsUIH4kWWPwk9Sp/0dsmW2jvZFHzTVGv/lVb
 KahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770816027; x=1771420827;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oIXJ6p7IXn4rNWFH6mUxYc+5HNQ1Upt5+GyPNO44o+A=;
 b=wwjHM28vMsj5U2jqSMSHg67iJct4YWMUI9XWArVLOyfz1ZidLa1ZOeAGdgs4Q4POpa
 hxplehbNnUjsSZHIsddseRKg/qU+5YavtgBP7rwZpc2eFNFgzaR/uIodaDoXutSniwsX
 ve6DR1aPq54Ek5uTc2tvjI9OevDtp7Y+yaT5vvV18dsTgAFkplPcliSK1bLSwJfP3/xV
 a/nFRuCHnoLnl/zEXdpS+KH2mIEudwLB709nl5UVFaFAvc/m7sicBlW/h2bGFVi4scsG
 2ZLkc3zTD3wLUL+/UBFSGkoKRsH+c0nb06ulMqACjMlvgVcOJOS3plGrO2GAxJIocrFz
 QIlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbDMyzjpTMJRx0r5WNpq9IFeuI4MdE9EotDEmSeN5aobVf7UZ+pGFRqA2aYDNT/4xjAh0=@lists.linux.it
X-Gm-Message-State: AOJu0YxW0tRt/URejL4gWZgyRSeEAw0GuiiDIYEVu+7ZBFOw1KKHmepP
 GUuTnAHF4yHjzSHV29XdtB6N9NOeZxYjTJ43MkrTzpf2Vc4q3vtH5mQooH3tBZouR6o=
X-Gm-Gg: AZuq6aJpjaFoNmlK6uJmKfQTgLLAu6e5aP6MrkOWTWjsRcthwk9qSl5sSsLMIRM/otG
 3PaFmUeF1Dxnf+SeguOSOgo54X2JXXLSBMVEAcBKGwxp+TigKE2clD4Wc98zVFBo3b5vlIViRAi
 5WZ+///Ytn8YQ11BecUvKRHcA5GeldMK+f2mCRg2tDrvRve0M1ubdTvfj7SpwCrUxiGw/g41jJh
 /FqOwq6cW2ECYZRV75YMSJUbxK1ss8rH0mwkbmD6N5PGMLsXEz4H7TkXaYpVlhlqF6syyvgPE5+
 ZbVtTotbz06L62o6Ke386Szw2YRi78l3SDVdts9KgCj3zf6715JC0PFZ4koZAqRpNN5HfhYj70U
 cU4A0HbaLdIQkL+osBVwYXjCXQ59YJTpq3eBAQc6qqmL+LA3qxTo/cs/yuZe9UbP6G2yHecr0Rl
 kUedV1pPhogNoF/iwBte4HOIZpeaM=
X-Received: by 2002:a05:6000:613:b0:435:add0:3d68 with SMTP id
 ffacd0b85a97d-43782cbd3e3mr3833540f8f.58.1770816027277; 
 Wed, 11 Feb 2026 05:20:27 -0800 (PST)
Received: from localhost ([37.162.249.193]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d50f3asm4892667f8f.13.2026.02.11.05.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 05:20:26 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 14:20:24 +0100
Message-Id: <DGC5W30WY4TS.1B98RFMSD86XI@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260128071040.802-1-wegao@suse.com>
In-Reply-To: <20260128071040.802-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] shmctl03: Fix 32-bit compat mode failure by
 forcing limits
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

We already have a discussion on this test, so we should take a look at
there " [LTP] shmctl03.c is broken for 32bit compat mode ".
Apparently, from 08 August 2025...

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
