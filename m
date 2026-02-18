Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D8EE9A03B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771417698; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lxcO4dNGOqPGPN4oMXKeRYOTIruV3COfE4/jByITsdQ=;
 b=YqEMv5aVQyKART6MwjQPI9geLb8Lce80oDbFMPdPN+KpvW4OgpUy/SGVZaaX3Q7T+6K9u
 oGmvmaRSYRRDpb6AQkNxqubX/9Cj7dM7HoWdcHQfkAMDnyaQPlaKkb2oVSLTcWoYuRlH676
 kH6Xe0cimVAkngMsdqTv8S/sWiJKDRg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C799B3D06ED
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:28:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65DA73CE321
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:27:55 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ECACB6002DE
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:27:54 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so48546425e9.1
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 04:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771417674; x=1772022474; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PjxjkqoGq6Yvr26Uu+ZLJ4xolB+CSCV9r35W6eCTrA=;
 b=TgiUuBJ21UhrXeiN8YMjVCgALlRSGy6ZfPvv6OIjAw3q2KG5F6RpnACPJpJ6OSgV/r
 AF6u9aEVbkdpwd4BKL8tsoXLvm0pTHYwqcVQ3wNT5+Dnhhbdkhf5YNCw7GpYDJ91RZhT
 gcBOGo7Bc1oboJCAevHB3VN8mEVnBlS6S8bwIxSEvbqVoWs5QtvRI5PzGWICdIVqqWEm
 7SuL7QpMDC88bA6clM9eY25+YKGNPaHYdXVo3E2CR0DNuMOna1f14WsrJLxhchpYhVqh
 BOVdFlbVaALOEu5UqeRjGx9irriiHsUww9Qx4HUod1XLp6u2lTvl8cbyUwp/iOSnug+1
 Pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771417674; x=1772022474;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0PjxjkqoGq6Yvr26Uu+ZLJ4xolB+CSCV9r35W6eCTrA=;
 b=ejPSfftk9l61orco04GSfejXAe7x1ltSK4kQynCNnQdKrmYANY71DXcwxJKzmBbyr4
 6i7snQTqasAR26xMjaWR/31GrM+A0kJ6V4eVFDqK2I5aP33wIRSL49PHbY7OfWnEFG69
 X/v5a3JUjKSOLBqiaN9wdtS7ECtQURqJwitnxCOMYgcVne2lflRXXMHIlvlhkGhU0wYk
 Sb6doN67l36f7l1w8kbxEB1ccLi83hUL9im27Gkxdh3slAktsMq3XeeJEDw4HY+KJNxI
 VWvnOaPVdXePPfLIodtTShu6y48ITojG5v0rImcRJWlW7Xxi6BZUvvKfZiCIDzYi9Nik
 vVPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1M/RWP7/workfsJYuwCkuz1ck+ftiVQag/sIzaBfVnWbxY4QMMoZIyiHW5hWWjTJy0zA=@lists.linux.it
X-Gm-Message-State: AOJu0YxD/gMJYFHIELBouvcLKvAYfrUX1F11cxnq5QEJGQeUM0tinLuS
 JWXjgpOXan6l51Za1Zr4ka/myoppdtfGDbv7/3OBxvaMniq2CMxUnqyWMhP+6V3azJE=
X-Gm-Gg: AZuq6aJxIDGYBqyZRBm5l8719zF0+AFY6mIMMLIdyjC4HCq99gDnqhywiDEXZ/EdTsY
 yoZ5HYHUHWVHgJPTorpiq/hpHabOrB547PwfCZQgKU9/zLOrPiyLwp8DpHQ8ZG4dB+1axg44Zfi
 q3Igqs+q5HqUEh5A6ePj8sWLM6mQzAFTi/Qppu6Ma0e7DsYFPh8kRoTJVIGfSRXmZ5VDUjuCLss
 BTksR6OEWRVMV8iY1eFGninrdQ9hINKgTMyj/ZcXLH6RWzzcCygwh2LraSZIE7venB5kSHmVbQG
 Jd6WH4xXN4geRBVBUsq9tfAyqdvW/xFEjLZoIqon9jt6KXcB5ymMyYAfNCWApaLYkxijDH4V87W
 zgFyiNNp03jQLhBfy87yrgBMGiHg89E8cg1FkqD3lzAds7xnUmyLmxaH7STC7QJGN1cKEE/CkoZ
 /m8s48zC34NM4Eb6Z2brvCkJBP1g20zGclE7V+BuxOxpe2YG5oj5g+D4TgZF1wClROgDHe+/Wnf
 KBlJaM5hoczMB6hfa4=
X-Received: by 2002:a05:600c:8b27:b0:480:1dc6:269c with SMTP id
 5b1f17b1804b1-48398b88791mr28027185e9.37.1771417674237; 
 Wed, 18 Feb 2026 04:27:54 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfb28dsm541133125e9.11.2026.02.18.04.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 04:27:53 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 13:27:53 +0100
Message-Id: <DGI35OUGU02V.2GPIXCDJOWR6A@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250716120600.2855395-1-wegao@suse.com>
 <20250721142531.2223584-1-wegao@suse.com>
In-Reply-To: <20250721142531.2223584-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] splice10.c: New splice tests involving memfd
 secret
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

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
