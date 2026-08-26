Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14759C5DF97
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787751434; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YN/oIASTB5JMyZuynM0dfzu7oSt9z1YIF3nMOONnlRk=;
 b=o0u10jojL7eEsfxBnQSHlHuXP+AA/ysRogKVdRgCViim3nMZW0S/H2s27J2wDCtmshMqi
 LHlGlF/FQ1E/7SDl3Wo8QL9lM1SqlKvveQDTH80l73GOV0mZdqTKhUcFQRDR4VlKPw5d0Fs
 dFhHzWSZVGv/cTW+JWys8t1/loS6WII=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2539C3CD046
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 15:37:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11D853C2603
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 15:36:54 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 95CA520099F
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 15:36:53 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso1659934a12.0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787751413; x=1788356213; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iefpxwCBwLOXhsCXxj16m6+/0GxOBP4RjS5y38V74oY=;
 b=OM/6i0wcl8wW3ManI2KxzRwyJZV/cNjlYO1zZmjiNtmO07Za0LCxgxrSlBEZRLX8tM
 qUwq9VKtZ99vzxOnLl9T8QVfp7eVLty1VVhztVtEW9NF2zgVDZUlk24z6DSmb1fD6G9L
 diwjdEKlGdxdzZ+T9+4fglAueFWAbSv33mQTOZUbgiFDCksA8/mfPcXOxKKritU22M6C
 3YhOf7ZFB4o7OYoNFHl+3Gl53zXvXpdy8UVfphA0NAl88kC3f3XMOpTYyUg10wZY7XNC
 s7KAR5ovoEwwx6evVmmc3vztMkwyJtbbRwz+R+E3q8wmXbAp01d2wT/nSx+gyx2GcQrt
 2uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751413; x=1788356213;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iefpxwCBwLOXhsCXxj16m6+/0GxOBP4RjS5y38V74oY=;
 b=K0aRn1W0lXGHp4OEYIAYC1VxRfHXfA4WG5kpU1y9pXnWKFuChf3PbPLD4aX6Kkc3Hd
 cKpcnuMfy5KUAuiuCTKKcmQ065/yrCXk3+7LVbVum0HnDbtbB1HILgyTEqQaCFnvqce1
 3CyC80+Gp/yksF4XCp8MtecBEJ6zO/N8ewDOrK/UsjyAJhwFxzP+Sx9fqZZYkGbfhxi6
 W3w9qSXs4yXXUEk+Hwcmjn5i4MOXRTg7EpaEU+9O/FpD1JpmeT3AVJ5viibJoUMWYOfz
 VVM3eF5x9fxyBlbA3bF2O8jnOIHpvhUUQedjFfjSOaacFYUWLyQ2L7GAFSkr3n7ZQo+m
 rTag==
X-Gm-Message-State: AFuF++lG62Hjn5ndAYvHmSODE9m6TT6EIxjBN73zXY/8JZmRPWhY95N/
 ePHaLXTjPEmX6wcYeW4aa46l5l1Tko+k+bR89i8hZikMgC92OC8DcamtnPwSFINrgKM=
X-Gm-Gg: AR+sD12rDYsClyx5YB+jJp3/mXP9fVLd+3wihmA7+UmzbgCZv/7s71W+SM/ll5nWNDo
 NisMHe0/YcsDRC1s9XljrwfPnPFhiGJPsrAsr0Whhz5BYiy+aCj4QwpITqyO6+ot4vQOi8vMKbo
 ZZ4D+hItMy7u8RcwkGMySHOrt7Mk/qB/Dfot4wnLhkqnWu3ppf9inMbmJd6jJfGj3VdMzJPnEAg
 vXSwov/w9FL+DTFkUHFeWSNEKBbzRxIO38mKFLRwnpy0yLSM8a0dWRo41Wky0U/GN0OjmHes7uu
 lvHzgsWTiQABevQD8vPTGH3ymSogBGRQaOq6JyAONGVBHMfjdTDYgHWLiYLJulv9bbBUt1pNO9R
 tCfKs/42t8Ry5zwYLprWeHw8ZWr68HvihhGGiNv4p/mALAChZj582rFLxMhgHFeULNtasRi4iZx
 NJ19qrWJqChFfENy1WdE4n6RN0Cw0baI9I6GpeKe4+QHq8HgM36nLYgGlJOBCAIQmJPXa/JtTiO
 vDTTZd9BkMWUm8AyM67HG0eUrvD/q9IMODH
X-Received: by 2002:a05:6402:21dc:b0:6a0:a4ce:1b8e with SMTP id
 4fb4d7f45d1cf-6a5df31c716mr8637574a12.0.1787751412881; 
 Wed, 26 Aug 2026 06:36:52 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1188sm4623540a12.7.2026.08.26.06.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:36:52 -0700 (PDT)
Message-ID: <6a8eebf4.f94882d9.261ae6.a14d@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260826-convert_fallocate_suite-v3-1-1286ede0493d@suse.com>
Date: Wed, 26 Aug 2026 13:36:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fallocate01: Convert to new API
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

> + * Copyright (c) Linux Test Project, 2008-2024

A note for the reviewer: I copy paste and forgot to edit, I will
merge the patch with the fix once review is completed.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
