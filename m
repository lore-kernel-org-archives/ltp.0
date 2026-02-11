Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23863EA3F27
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770801492; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8+08UWrrNkT4YcKJ4ynmpWpK0xtc45hoC9drmbIbgV4=;
 b=kV4Cfs3vFhokz2PFgpfQW9dmMzzjtvbESEME3xQnBIlORu5rknKAT3ftPiWqVXcATPlnX
 6cbvMpmyC5tPJX+5BCKZT5TCM5b0fENkkrA76Z/yB31jbFrvirSPLLVO/E/MdiLOu1T+G06
 oMWKvCoDeN9Aeg5wo28wL/M2NrP3qfU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6631A3CCD55
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 10:18:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AF403CC237
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 10:17:47 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AE521A00A26
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 10:17:47 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4834826e555so27266475e9.2
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770801466; x=1771406266; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRTi9FyXH3bMBKkNlpmLY5er2r+ce5WKA2RhAKRQtU4=;
 b=AABt3v15LN6SgUAyFlMdB+0pTyClwl7GPYstiyZXxC4hrTfgw5yHnrdp3v7BYR7DbQ
 8havhl2oJwuEnZVScs2vRyCT5Wqzu2X2Q1VnnWsEvPUnGbyp6RQIazmN0RGtlsjhh6zj
 A64kS99opofSn9AtqQqq17qiu+BzhXZ2NtMImQwyMEws/X5E6PrNsYfO0umFoqMVPiv1
 sXmEHo5n3CkbLEfsLvZzPvUdL8LK8xTqJL1pYzAVfcOghdZ8R64UvFV2RNXSEVC4iAYI
 T92TtBYaM653oKuiGmSdgAslWGgmeYYdMbLSdQ5zawR5CCddPJeUAbrLwMHAyvAl2dAZ
 oJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770801466; x=1771406266;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MRTi9FyXH3bMBKkNlpmLY5er2r+ce5WKA2RhAKRQtU4=;
 b=gjMJEgmvHWt3DoPdLgiMnFF+cu9tjkpVdxpi+4ME/zlsK52e++vj+cCZi38LpcrvOL
 7iewFivpqyksqgMOxDVrdL7p18GCDv8hq4CNYX1Ai/4uASHuZ3D1vxvVxP4TbvWCaoVr
 iKbluFDI1bMHLZUsOrbT25LB1sGDpp4GDApwZ5mWt99+yHCBeFf1OAQIpj80+xD4ha7O
 v28pa7LhBcST+zs2PJgX65SL4HeD2QLsDbIL7FJPYOM+3rZVo3RD+ysGHx6pRnfY4UO0
 VkHFGtStN7uhYzwCP8sTFEpaVuwUnhqdG5KUZgktxcfuwqs/PGO5DmIXt19Y4fmeEgBe
 wADQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ZbifgDyxFAZJJLkxxYGqePA2FAYXSJ2BrtjRW2MaO4NXfvR8i5NjrbptypkBPdSjAjE=@lists.linux.it
X-Gm-Message-State: AOJu0YxaJ5v30Ko7BXe2JWHJ4RuvRyfoBI2OBzy/o1qW/TmkNbFfEG8D
 qeKlf4P3WszH/4jhar8R680PV3NIcie/swYuZidca8nBpJHlyLoPMb2GvX7KD5XVDuA=
X-Gm-Gg: AZuq6aJ86VNvkxE2xtPdCjZke/aN5kGVgO6ukZ4/sS3KadjQRqRulQuNwY8EYfrzycp
 8V5acrG302J7MjNVR2oslovBBhkq2pEHYwcic8z6xtERPTupTn6TDF7scapxRfiw9do/AgLl6MH
 l52fP/StZalZ2tEfy5J0gwdpMnNp0OPmrRxFrxa47HfeehSmvg69YuKiVMnpCAzkKQiVT8lfuUW
 aoxblUUYB6Y5MHObUicCBwpUl5p5HV3UEZWUOCXFSdts27rRafhdnAncQ458pJZGOqvPxGy8gXY
 4yyZcDw0G9XHgAtUtJRsQN16+IQLm59wVN/jlFpdXECQIeB9Z6srcPcdLb/h33lVlokm9fZQV5y
 sCiXU9rkEAHh/KAspPlibWbf9nQmwEk0t0u+49QIBRAnmO4fjH99C2x1wmfwZDXqQYqfF+7xisg
 VqF5Tq/XGmvZDC4RiEMsnTZJtU14gHTmgpc+BRuYQiHqOF3pPtFt7tF5wQMBxKdAiErY35aAQnO
 jDuBAKr0GWZeAETTJrvOu8ZP7oC1w==
X-Received: by 2002:a05:600c:3f12:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-4835b952486mr21248025e9.22.1770801466375; 
 Wed, 11 Feb 2026 01:17:46 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm107892645e9.8.2026.02.11.01.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 01:17:45 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 10:17:44 +0100
Message-Id: <DGC0QAGRNIIM.GU4EHKMGOGK1@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260205121540.329921-1-pvorel@suse.cz>
In-Reply-To: <20260205121540.329921-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/6] Remove runltp
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I don't know if it makes sense for you, but I would implement this
before merging this patch. What do you think?

https://github.com/linux-test-project/kirk/issues/72

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
