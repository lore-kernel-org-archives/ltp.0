Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E04BD37E33
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768397921; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qeWF9x75hzu+OXR8FO3cSsE2Hl5mupuykMFKDSwsRno=;
 b=P99GDTJy7vTn2oXU9gCeY1QP90IOfSkKpBiOwQUTZ9M5vRXEhT8bJO3SyIPuHYm6oqZLT
 VonX/8KCBjxlpfJ64uj5aVTldhUsvaW6EsgNREQyG65iO3ph+3Xdh7v9bLhnxao56QT6mbQ
 SudsS6slqs07S2Mizk8MPU7ZbGaR4kI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D15FD3C9D40
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:38:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E81533C9A9D
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:38:18 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6EC751A008A6
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:38:17 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-431048c4068so575103f8f.1
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 05:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768397897; x=1769002697; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dh6BN7za4Q/69w/hRGnsKm+I7qQUeDib6re67NcBA1E=;
 b=PygylxY5nelfJjKuMLRB39OBGxN5jX2H8Blj9QJzVz+b/Rd+8Eic6wBOszRKUHqI3Y
 GoQbzUqx5VjmS6gbRds6WZf0vwWN81gQ0n/+kgzd73p3Q1l9vrcfsU2CwJVFh7QuJUUL
 pZjw11VsGdYvjg0IQQ2xbDyUU7bVywq2WrYDNGmwwZWzQZDgtB4UZBTjJJFestU8Qc7c
 twX6E82Z6BFhMLNYOhgRDU+Y9+a/xCZhorchlTQn3p2bY7hZlRURYhybn6KaaYo+VSVc
 sy7hL8gkJKs+ENwcqYcvpVmsKpll9Xqr6jOy3vCP5opPt78TB4y7vLeJRtdBOxfYqY8L
 Dr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768397897; x=1769002697;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dh6BN7za4Q/69w/hRGnsKm+I7qQUeDib6re67NcBA1E=;
 b=ngUxEODkQadqfN4gAHK9OiDZlHNxPV1OMsQBtYomu+vcUiYZpumjlEKBI5XYvsGS0l
 T4DKpInONb48HALsdafKmbIXrZlee5NopcljU0yza7/CJN8jqv+PkZlTTRvQXneNtXZy
 ZM2x1PBoFImTJWeX1SjqIlZ1eLQe98cR7JtoDGNy1jgrp4Ac1IeFgC4ffXk/0i1xD7SE
 8uc44hzTHY4kxj9bS5wtZzU2ciQUlTUwWJy9nLBcE/tWs9IBwkSolZNjvoqDJzGg5YxZ
 h1LfvF5wsYr0bcRBiMflYPqJsfxWtH+WFoQBt3ip9aBKVT8jptG7P4D2EdmgufKTAGB7
 g3JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURPsdNasZtG06rCAMRJyYKgfnRR38NK+MfHHXAwlhb+2uwRg19dsoii8Fs97L0jPE7csU=@lists.linux.it
X-Gm-Message-State: AOJu0YxjQbgr2WoNZOCfgx3Akw3+OKJe5RCHnxw7g3jtrmRGfiBEOAwH
 hW4Ho5uZWYJ2iT/stdwkcOen3Ntg+qvQ//+zR8mqOUl2cysTDFgNW9Z9BqS37ymLYXMH1Bh04kq
 ggl75hM4=
X-Gm-Gg: AY/fxX71tC3WYJp3Sv9GmzGSgCUz9xs6b2zVb8V74UoelA47NwT0IcjwTphf65QUR+U
 Ud/HMcn72FLO6atTKIdTuy2p0vFGbh+8I506x2RNy4IltlS0odYw0mrS7wzExVuLkEKhYYluPr7
 6CjgAHq4B60YWx+8FxDayK4hRs+FIUJveNjmakeg391xHiwet+2QqLNt8sWlcVNlQp2xorYLD/z
 gStaLUz2MVcTNnsSB8hZM6ykEuTJi0Rm3LNNZRLqhaERnpk7ZnbsD8xGvWViLCkbB8/o6xericX
 lEPZEKISKA4OAIQPAqLmg9A9dmq2XAbuX9xPV7qQGZEYp3XmlKqO2Rgxc5M1B8AFVrj9F8Qfuxl
 rctCK2RG9iKB49H8uoGqGCik6CClVjUbB2IhzEGWk+wUIgiyJV/FPxEthvO2stlZuracxqjA/38
 fBjGhQAN3YSGv3MdxfHY0H4fDrrxmqOwXmdd9kldArkAG+53BJ+ROunBsQv7iDdUhdIB2xhxuMF
 47B
X-Received: by 2002:a5d:5885:0:b0:432:86de:f396 with SMTP id
 ffacd0b85a97d-4342c0f2d6bmr3193483f8f.26.1768397896805; 
 Wed, 14 Jan 2026 05:38:16 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff319sm50999602f8f.43.2026.01.14.05.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 05:38:16 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 14:38:16 +0100
Message-Id: <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260114133548.411077-1-pvorel@suse.cz>
In-Reply-To: <20260114133548.411077-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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

Ah thanks, I guess I need to to update the kirk TODO list for the
release because I always forget to send a follow up patch in LTP.

Will do it now.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
