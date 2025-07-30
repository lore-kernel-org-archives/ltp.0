Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5211EC87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753887499; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=PCpqwLCIm0H79LDlcV+5xCjQF/CJyMGqB+reJpYnFYo=;
 b=blbaUnNw0iXrUvnladpxgViuHIaiSz6XEAC6yzmKcTBnb2KGvQ8z5rWKh+UkIMT2ghNeb
 XiLfLh+3peGhVol3M2VsN3yQfKk3bzNjo0OK83Bv7oM0EXaj6YLOh3ta+reKF6cH6RwoWY1
 Hza+4XuDOg+0Bz23tqhdnHMzTtlaO2o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BAA23CB4D4
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 16:58:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F42353C79EE
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 16:57:57 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D58C01A00247
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 16:57:56 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso5956239f8f.3
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753887476; x=1754492276; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ECdufCviDX4YwShLaRWKExSVry7xWm71XMXKefGJc4=;
 b=YkvRqu5wf7ObIhDWM34aNQGl4xBvI/dr1NSzEJQOOBC2Zsj14NL0I150MeB7pBFsAh
 J1+pPkHN4QVMyCEu/Op3bQRey55iy53YUSF6+iNn5uNUmhWCgKnQIxLvzQqm8jJ2pxIQ
 cdZc5dciOEFrtl+anrqv7+JoLJ/tE/HHEW+8qq+J8Lz1yXoIbFEL86WplXbn3pvbubJ9
 NqbDhbZxEWWuPC52R6FkatgTmM+3YUDciTsO+uaNUpLYnJAsyF0rITv/61SKHURCs4h9
 Uz5L89VwE7gXur+hdmf6RM+4dQ3CTAxDTpahuFB8mRe8gMABCy3cjpnb/1GIZSEp/tPt
 kPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753887476; x=1754492276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ECdufCviDX4YwShLaRWKExSVry7xWm71XMXKefGJc4=;
 b=KrQOpDNlw8NmhMD+G5FVeKfHLjSQ9FGJDNfq174k4tlLN/61gFZ1IpocfSkTSUsDsp
 v7sWub0MU+EZYmjEBc7W6gWjWdlYEm9t1A8fYBqUWa007STIkvI18QYahtAOOwHXsNXH
 ah5b/Qn5sPHM6G2j4Y1Glxwkx0WQQ8voMW/JtGmx0tTHWPY54ivbGizDGEH6QQBF6GeQ
 xkXEuir5vHqoOnHOwk442aAKO71MP6jUBbXr9z4t2l72+NRkhZDkG1mitIPH98gVNdvC
 CihrDqf/MuGckgd/IS8d0HhPLfMzMC8qqEKbHMsuah31UTRD8t4PrUd6bFAG+tMyORNM
 FjPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNZVgptwOZ5G1YTCYyJTjPatOhFowrS+hOEOQb0ZkoPY5j8N7Mecg5EfjKAG9nNa5lbXg=@lists.linux.it
X-Gm-Message-State: AOJu0YxMnaI5Q0q+YYIrG5qfvSZ0IGH3IDcx1MWVlnRBFST+N5pMIe0P
 6KoavtWVyb7rcwLdkHHVIibHovCSigBuWDbYNNXMei/BP1xVJrAeSs0eRfroJ6KYBZE=
X-Gm-Gg: ASbGncv3e/cRgr6S8ugRfJN0nmG0k1nDwY8gSvChq2EjydAm+3jx11xJ0XkFbdhnRLn
 K3ebMyNeiJ2CKwaPWCvjTEXvRexwSUKkX9Uomjzou9Z20ZYfsfhWx+JkKApj7wDh+bSrpq+yMLc
 mOvHMgNF5DZ50RUwnBA/eS4lRkgJUvrNnjy2G2pRqPr6dyOVXEUq70v0zppXa9CobdENY80GK9u
 9uED5lJxPpLS7kesTf+tPYhWXhOgReukFkNENSG8NM+Df/zV1EFdeBG9KT39bg2b6yMH4TP52EQ
 vBTuOFpqoPGBHkZRAG4YDN6tghvXv8IeBvMBwNEV8PXFEvuFuHxEfC3qQLSKR+4nRpv+U6iKGmi
 usYowFmEw+HhHxUSFM9I5+nhwwzRFKGYGJw==
X-Google-Smtp-Source: AGHT+IGDk/zaZPeok83n6o1qfcdTuttv5y+AHEkiM2PHupUPpGlXm32GaCJm4Auj07yVmtICLKXrvg==
X-Received: by 2002:adf:f008:0:b0:3b6:d7c:f4ce with SMTP id
 ffacd0b85a97d-3b79503b386mr2331362f8f.54.1753887476245; 
 Wed, 30 Jul 2025 07:57:56 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2402b768e70sm72710725ad.9.2025.07.30.07.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 07:57:55 -0700 (PDT)
Message-ID: <2dbb013f-4b7b-480e-88e9-51833bfe0816@suse.com>
Date: Wed, 30 Jul 2025 16:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250730-ioctl_pidfd_supported-v4-1-db7bd905a1d6@suse.com>
Content-Language: en-US
In-Reply-To: <20250730-ioctl_pidfd_supported-v4-1-db7bd905a1d6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Correctly check if PIDFD_INFO_EXIT is available
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

Merged! Thanks.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
