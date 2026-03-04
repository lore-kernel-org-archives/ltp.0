Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA29EF8FE5
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772633906; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=oYU9NHs0rH5yaX/R9XsTd9A2t33w1APqynJcMhAPuTw=;
 b=pj0Q6F/7N6rcqLf/2mFE5c+26E0s/ahUvzuyqhOWr+ARUtePOMAtjAJ1Ynqwqk1b+3u3/
 5b7VXL2RjGt8Zib4+CpZzSTfHQYCgq4FsKXx0a0YVNLvmdwcETB1AEkEPKahUNlL6SRbt0q
 IrjzeiplYwwj8zMFeTquRyUW4//x10s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18C843DC6D0
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:18:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 484423CD1F8
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:18:04 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD4591000A1D
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 15:18:03 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so58445885e9.0
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772633883; x=1773238683; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zk5KG/PGnD5FcJhfIHwHCVmxWrbO7TzxeDePtbRuqfo=;
 b=NCBaL2dxxhovR9CRwiyr1XQBVazYu3rKd8lvBuVCGOb316/FlOMFPP8SegnuFR5w7w
 7BOyG1HBR5iGerdg3N8AgMGrVkCBbxBYkfj7YW18JJGhmTlnWAt02p2StKhyEQdQKwes
 yCVNmAKZNCLCepnHYn8yBhbmX+bKJUyhlhdhUJ+9rbH3ejqQr/HrEY2svArftoTGAvnE
 auO9zye0nclNO8+gOYOAgAUx/Sm4GPdzFmhAiqHuqljSd3sNU7+sbVoUvP2vifJJ0Hty
 dTGQWx9xxPvv55U/pYALxJId3O3rF78ooi0Q4nWH6dj20J3W+b+f85byHKNgj3sqh8iL
 Xzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772633883; x=1773238683;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk5KG/PGnD5FcJhfIHwHCVmxWrbO7TzxeDePtbRuqfo=;
 b=j8wz3C8qKqfeHx6+DRYa82a2nZSsTs0iiMVi66WUisd+pcORtBnk7UgXz3Fxet5tty
 ElZSgZ2UIhznNW9XT6SPeb07ZeAzKmbqQDQHm4Dcd/4HjplhIb8g2gA+MAH0xBXFbdNA
 wREAO+IuGx4LfMplriPadsl5S7fcMJZFs8mL4UO0F83Dlax34DF4Zsky0LDmZyq887N3
 CCFHP7zY4nx73XoHtycHchDsS5C8MYzw6BWwy81R6BksiMT3Yuwb2QOICgMfU9UAarXW
 bpPt6YPUCb4Ic1FMSumJn9llm0h/uUoCDY6WcLz5M9Tn4cxRK/oeiR+0+KPaP1Glza0F
 JStQ==
X-Gm-Message-State: AOJu0YwOkyUqYdMxkrG40Qc1QQvjdEzgMU0Lzn4PmAbLmRhM5XbwhOvW
 lKmW2qXU0P8JXpy09Q6kDXI9DEq6G8TIkSPgOBrnA6OgdRy1/7jR8wqM1PZwBlmF3IY=
X-Gm-Gg: ATEYQzxCzeDWauLRaNWrBGVqQLwIRXSd6t92Gh6CUj1RQokx5ik5Vd8FGYsQTmXgt9v
 N1C9GkPC3klRIrMG3jfEnuEN0fIT4Vtl+741/oDyG8TLUA849YKamnp/TRr+TQMJF3E6y9TL/aM
 lN1TPuCMvcNUmqJHT2W3t33V969qQd7RKABl++mYxNvXFp1FPCtBhpoIJRRxzmRUjJ2bIV189tA
 uHBWZB7m7/0NDjl8023X77Ej4DPmJZ+tQeXMGzz3XdnL/T3Z00JCw/Nva+1HChTZVQzSyKbiZdg
 8Qonanl82I/dPPlSnRvitEBkLRBV8ywC7bOgllw6d1j+Rqe+2TMGEX7eVnMCIpj0DCpi3+TTVTi
 oDRkfTonFK3FEy78DJTTp6Mm1ytXcKzAazaEKc3Mmg72YliNfpcLCXY5SR43CF+RdYMvineNCw9
 2A8mRmXK2mWiv7Ts7kt7pBDW8QNQg4TbKw9qfCSi6S
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4851989fb4cmr31531725e9.30.1772633883084; 
 Wed, 04 Mar 2026 06:18:03 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851884a7absm64568515e9.8.2026.03.04.06.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:18:02 -0800 (PST)
Message-ID: <69a83f1a.7b0a0220.9a038.e1c3@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <aZMZt4FTvGNLsv6U@yuki.lan>
Date: Wed, 04 Mar 2026 14:18:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] syscalls: refactor vfork02 using new API
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

> Hi!
> This is actually too fleshed out that it no longer does the test.
> 
> The original test actually set the SIGUSR1 to hold and then send the
> signal to itself and also checked that it's pending in the test setup.
> That is the part that is missing after the rewrite.

Sorry, I think I sent this patch unfinished..I'm gonna send a v2 for the
whole patch-set.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
