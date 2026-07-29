Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3ACC53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785340071; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=oeFQFn9gz6J1HbMS8wciTU/ihrMNZ0Lawp6qnJ8S8Ow=;
 b=agIomoyruSy6BPA/NwrNKYZCXcGYOxDJ0uHAWQydTjZLlGk33IqZerLR5y/A01NB3rqKl
 vA7kmSHY/GxCMkm5qWhLFMRMa23QYrVrSIFxnuq07xJUlDBG8OB9OBKjbL2jAMsLSQqnlWK
 tZqkRnmvHlPX1NJO/GmW+AHUDBXaJAI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F1873E62BB
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 17:47:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0DEC3E18C4
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 17:47:30 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C3596008CD
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 17:47:30 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495590dde14so11689865e9.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785340049; x=1785944849; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ixC9+UqxrHKoC1fhv3/rCDjcPPevbbT6xyV3Yc/gStQ=;
 b=NRsH3xbmmCR2lar3Y1s6FRur4X2+2x53w+Xv/TcqqEAJalML3KaW//xz2EklZXT2bF
 /jdPTQmz/JB8PSzylfqgMN0err0rNh7kPtvyWP1sdfh2s07CRfQ1xH4RUbiHFfM2Fa0+
 t9seoZgPtfZOkTgekKYaW+eImnm3AgyVTlt2KjFQH4TxkdV2KOOtdg6bHr/i433x3FOg
 x1oTo1tsbeLIhYMZdCA6CKGdI2wn9LqVorNdmgY+ByiJ+eHrSQUohpa6pUKfXEgjvHCf
 eMPam6C/epLYNrwPJbVtsAT9piTCrENzTjk1CZEmCXjQkdLQKrsbyNUcxlLQIi8gzYKl
 2nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340049; x=1785944849;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ixC9+UqxrHKoC1fhv3/rCDjcPPevbbT6xyV3Yc/gStQ=;
 b=Xo9GQ0JCbihqA5FYFkykb4roMtq0LSaO/6XuZ+rLbItUIbKkXdfY9fjrtvfBbfHlfv
 l9da756DAM7sWVmt5HfCt2br8HijVd0ET1Qfvi4gfIWbZS/sIk4SxEjH/Oeb/diw7MRB
 +x7sJHk54tD5HZ+G8vJZnXNIrHcHGSIZUrneWN3KvoY8P8sYzi3YoyQN1YDKQ9hkwdLg
 f5ZqoPoghZPmOh1niQ8wIy/aCec4A5pPtphcdoeTm3yKdUXds74zrR6pAwRIY34tJhzq
 cYVfoHgxetwOGiDubxr7mB3fBkFiuATlQppr051TPyUpU1FNCNBNi5eAAqFbCtm5V9iu
 ajqg==
X-Gm-Message-State: AOJu0Yy9STtZzqpzHMk30/vjC/bYGsbLpWpz9kRp4SFJsMvPPSJcRVkd
 1OzPoWpTnhbuL/XZQTsQ1VFp+p1C/43G3teR1ltGQrjTi3xw1jGUyN7ow4lU2TPztVU=
X-Gm-Gg: AR+sD10fAfNkvA2gyyTu7lf0GoZ17teZ3yOeki1vPkfv50YzXrX/ycKVEI0oqI8yTIU
 RZrJDZnBsgtrNEtHAW3ijKvYrWqoLuQsNVawbObK98/8TiUrwaAk/s5guW2rbSyQgDioXjPK3c/
 j0sO4LF881uEj2YeurZmO0iNfzaVDiP0r/J4PYTHeAYoFg6IBPlTgJwjVJdEBxlWAlJwQBv7vdM
 fi8ZORrJ5v80fxsfwnRWbMPt/XrND7uLb70PxJZSTXvXmtCxvTRkhA8958Wu7D1g399ymwPqm3W
 5mJqHB9MELxj98KMOSeqKoypRQRitJ/UukKvZHXIRpSFmEsWPXAy4dG7+4NtZky8cdkwmgyk9K4
 Em0vpWpHOKoYyblp4etEus3FLPoznIzsRxP7IfYGLahcX3BNgxPWpP2cmiCB+p2oUYyKcqcRGyq
 vIpw0yo3kmSjn/GohIwZoHFZCvMOg5Pe5zhHEgWE0/BNawv5IpORE06uCgfOz8BuX3EjtSz840R
 qPz9RA86iCe1S0x+rl+J5Cl1QBm9JZoJWBRUv1C56JkB3nvnqgj7Z9xg5ItyhGro4N8+bY=
X-Received: by 2002:a05:600c:548c:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-496c64103f4mr80313945e9.7.1785340049521; 
 Wed, 29 Jul 2026 08:47:29 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfc2ff2sm335962485e9.4.2026.07.29.08.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:47:29 -0700 (PDT)
Message-ID: <6a6a2091.9b80fa5d.4e4ae.7aac@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260729095730.29185-1-pvorel@suse.cz>
Date: Wed, 29 Jul 2026 15:47:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/5] Add support for .max_kver
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

Hi Petr,

feel free to add to all patch-set:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
