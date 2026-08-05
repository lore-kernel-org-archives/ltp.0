Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2717EC55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 06:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785912948; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IeOeSmzR5bCbGMtgZeGsL28abOOcoCDtHsfMakmLf5k=;
 b=OC5MWavpCXaYCv5OuWKFc+Qvp6Uz6GHphTmyNKUkEATkAPmzJHlkKP26/9HABY+riAdAD
 riiwbo6wQWSV8m/q43T/nV/on45fonU4o7vsMYKJOIE8Ev/J1YBqxKivuHytq2/MtSHKyxL
 U/SIb1Jk+zECOcjUnb4rNSSd++F8mGI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A341D3E24CC
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 08:55:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49D073C57EF
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 08:55:28 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4556F6002C9
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 08:55:26 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso386083f8f.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785912926; x=1786517726; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=niT2bz8H/GYPCmA6qmDBR3g3tA65rA3FAo73DdYkG/4=;
 b=VIGxLq/EDRJrqOCOktdN029UiAk0vvtKrSyo66EZ4dL5rVRqOmzxFGPRSC73o13KDJ
 gfCRA8+7RA3kbfNocDQEvwTuzeCq9eX5S6f6yhVyNiSEMgVJyqpbXCqBmz51LRK+17mz
 0SyG0WUGfFjBu8iKfTx7Dq3Uwbzbg99ofpzzFBQlAvPp8t1u2+plB8aApI0mFK1ctRk1
 hDUUuWiaUIeyj0sVj3FJK1l2vdlpVvs+j0urbTDmfsFWE7RTqjYWEURpur2HZif4vUoX
 32SsyNEK77hit0+bJqdkU4ALe2AEe2Ew2yoEASC3M6J7Jg2wETmHOrErVtjX1cGwv2Xe
 mMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785912926; x=1786517726;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=niT2bz8H/GYPCmA6qmDBR3g3tA65rA3FAo73DdYkG/4=;
 b=b7ZUQazeToPAMEzLwl9nuSiEp9Rt+r2H7v/OUXB5IvUjg+avr0d7wl2QDvi0MtTc3j
 PZ/IHcnol/AwCukETxElToJmkgvoUEjUTb9IJ1MnM0KSkQDzS9zY5bcKWPqLxqj0ABo4
 5sE0VaYq9Nz6tRyE1JFaQKeUDJP5EAs2KH2invZzBtTb07KanCY7sijUqGoBD2zy1iXP
 nGeVC1b+sa9wueOTUuTXhB4MsbLT5uPX2ODcY6S8jSfsQdR7/vtFyx5RiOXFXUE2gFSm
 NYQwo0n9yTUbs3Qxn2KOgHigEPvgVB7zXPJvU8ob4Klafsx0lwAyqbEsnPucGxQfeU48
 N5kg==
X-Gm-Message-State: AOJu0Yx6+lgwWz4xT1h6zEHVvEDS6VxuTH8hkGwJ8A8DF3fYzGEnK+pt
 eMN2++3O4p0Tgus4CbGV7QaG+S2x0/iTTKy8RtoIzQ/8WwehbkbnxOA2iox/nf/Atw7oT6SUSKN
 NtBBoqgA=
X-Gm-Gg: AR+sD10Qqurnk2bNVshXlpQFJu2nrx9Pr3HdAxir0x/3CHWI2X4mvzyljPQoYNmjItd
 hZk+HQyj7kasIKyDkrBeoCFnYPP1Npz565078JFlz7bNniHZ527Kb6Vudrc+z/fiPH54vTLfijP
 WdNosXBO3ce3tVQZ9lwJBxYTFMZLxQLtEXHV3yQuw5E35Ge94wCl2GQ9nfABsqCmHUiJaz/Ke8u
 qBpUTX1Xu9g54lVnz13tc3x8HgQq4lo0/on+/kgBGfoFE0w5QnXRsGiH3tm2ZEk2A10MyYahPmF
 PiyNV8VQ0DXGOSJKHKgGP8YmdkW0Z07enfPBrKeLEflkLv24VCgcLFPIW+3/ZgrI87U6h3hDQXe
 8MEDyGtnnV6VlGUEQukOMhy15gnnKAIhxwolTFyR3Y1YvGWltZFWi3F+pkbxjQPvxXlvuXWJehI
 KBDoVqq8RimzYiSzrAlvVetmfxDY3ZSZ988AZOnI+LYBlqhEOnByajPUH2XOA3bJzQGc2Eb35Lk
 Z8aLL37G105sA90UUszjrwgBpBICAnJtDdCWEstIUh7dCaN9FNGI6IJv2+ruESeH1Gx6zc=
X-Received: by 2002:a05:6000:60f:b0:47f:80d1:be0a with SMTP id
 ffacd0b85a97d-47fec634bbcmr6734554f8f.14.1785912925556; 
 Tue, 04 Aug 2026 23:55:25 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ede6sm6122316f8f.30.2026.08.04.23.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 23:55:25 -0700 (PDT)
Message-ID: <6a72de5d.d5b2c389.26c2a.b4e4@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260805025418.1249003-1-wakel@google.com>
Date: Wed, 05 Aug 2026 06:55:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: wakel@google.com, ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

I sent the Reviewed-by tag to the wrong email. @Li the agent review is
correct and backoff polling is not working with old API. We need to find
an another way for that.

As you can see the CI is failing everywhere in v4:
https://patchwork.kernel.org/project/ltp/patch/20260805025418.1249003-1-wakel@google.com/

Regards
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
