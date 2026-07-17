Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACBC4450F
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784272191; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Rg3SbALRBjLOB1j5qL/l1W1NTgwCs+f0QZ8lW5B6FHtw+FcX42tyzB170s4gmnvyDriFt
 VhLhCdgMHe+o4X5HREzqnkLtIEwWmWHVRMIy/A8S1bCuRqZZ/z0HQaJ81JkBWd5kW+EQWw4
 NGoaQ4adXrSZfA5qoxoECaLQxdXDOJA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 380193E24E7
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:09:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8F113E24D4
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:09:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 267EB60096D
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:09:31 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so41235205e9.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784272170; x=1784876970; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=WD2L/5qo07XZtY+fzYEomTXKPAUMhuTGMA49wLOh3r7ET42e3i2stUAk7bE+ebIlMe
 CVsmQTjgTXbSMyNLgRr08XTBKSr852pv4B0/dP8LprVfd66Mk2NUfEDOpYeCyi5TSNXZ
 xjWS2wESyWOt6MWMfUn0Gzfp8hHqc8vDwA2hkWk9ZuJ7GkPO1W9MAxoa6WJy0lCoRrb/
 l0adOUs5lbjZ2Utqks1v5nTNwn2/nt4xRfRX7rnRYtjhxTINPulUZC+MbjhhQxDwH6k/
 zb5o8a+yHJXuX3Ld+aOCUruwzEtJjotPWESIOeNv4yv1VH2sIVefGzfGPI47pMTss25d
 QnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784272170; x=1784876970;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=RkXES1j+m/y3tSymCfnEixMG037HJm9IbdTZNUPNaEQJWOYVAY8sbA5daD7R0rAMyC
 ZZMG5+Qv+UgKxY90zNhqwqejxFGEywjHK5jYlsskjjBP0k9qPXlxb8ddFJY4g9aKQyp1
 jkfHzR8X2RcSZdWfXUsPRsMlX5uqjPOZTBvGXYDED6A9hK8H+V6aVCBOd5muBOCLbYER
 NyQAB3caMq8r8q2TcWrjhDdFKzQ9d1BC7oGOzhUvlEHxHEkoRg+Cl8jW7tLDHCgqoduR
 ojGVyt1i5rDzug4aoVZeqEJELIi6we396dzyLaR2Fg5dLJyOOxN41NthLI+j93v4Uwrv
 jM+A==
X-Gm-Message-State: AOJu0YxutJ+1eVxooijOZv9CdWDUjnItXJ0rancKIiASjFYA2JZ3yggs
 +wAtIXmHbysaUUebN5zeogqGMMZJkA6YchrQJo6tWTvA66L/SCQQrNdIyMQhAR1RhHnWh7CeWgW
 PBBQx0dC7NQ==
X-Gm-Gg: AfdE7ck7hXfLVjRuta+dg79zxrdCKXj5Ns94rL8dCGwMT0qD5EBzEjEHfFz8sE6j+rY
 kslMrtqIq/8216f7dB+0p2wwqp/IlW6lpcjI9f85FTlVR7fS8PjFpg0Y5UyYXroxNi+lQzivogj
 OkI29OQart56UAJhWn5fDfHGl3Q2QSZM2Bm6q0N/BP3WoDDc+1OysXc9xR9kQGpkY0mmKmeaSJG
 6O9F69OWqTzKIJd4iPpzE7k706ep7sxE5zbyclBtisn3D528LLONOirTy0Pz10uaNfT22KzqYOk
 h0BRql3wXLNqBSrWpdl+QQKt3CMaacDUVqmxdwJdGmqOW0IyJQWNURh3mylgCQQ+ol8sqqtw8Pb
 zQh7SzNui0+RhLjTmDYc5UGECYb/GqPftUaEggtZCubHnYT/KPd6SadLReJ252VJGDLduR+rm/L
 lXnija9YaMWm/6hdTc7dwsEQYkLtDG44y/9le3
X-Received: by 2002:a05:600c:3586:b0:495:3f68:699b with SMTP id
 5b1f17b1804b1-4954a3f3173mr14974525e9.9.1784272170466; 
 Fri, 17 Jul 2026 00:09:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm31554015e9.11.2026.07.17.00.09.29
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 00:09:30 -0700 (PDT)
Message-ID: <6a59d52a.87c5160c.c54f3.bce2@mx.google.com>
To: "Benjamin Wheeler via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260714162834.47191-1-benjamin.wheeler@canonical.com>
Date: Fri, 17 Jul 2026 07:09:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] cpuhotplug03.sh: Poll for CPU migration
 instead of sleeping
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
