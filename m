Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B0A104C00E
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773226413; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=w4/w463o7Iwp9xT8APunYHl1NALJgJZunCgjmWhjopg=;
 b=H6RwZZ0daR1n86P8g58lntnUG+Jy9cQTxTvNN330OnLyqUFsciedE3ppzVf1Pdqs/RfpK
 HYAm/J4aP+GM9geCU9Qpcq6vnKke8HVZS5u1DyYjbzVj6siw0CgyvFNZ+/U14dLL8QjGuri
 5L+oRmKoRbPKl8rguTTIipBqY8xT7Bw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3FA3E27A3
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 11:53:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29BF53D753A
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 11:53:11 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 931261000936
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 11:53:10 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so37523365e9.3
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773226390; x=1773831190; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eqRDua5KXKCrzq6BKqsTZ2QOQLORioqvPy1FVBfuT3E=;
 b=IdmOw9Y9tysm/LrsCO/L1fYdYGKXhm8dJMdbzKcPrCFpG3a4aRQ1C9UAloomeMiy4o
 0MW17QDVATQ09M59GwAEe42HQCrq1yaWGQ1R7IVcybTyKX3wY6bAilxTJV74ZvpIVBmf
 L+OBfeTMx7EJzpujxNhHEhOYQ3Fzbti9xcE3oR3KE2v8ZqWAEcniXkIY0yxd5eSirIY5
 x0iTgxkprMdm4ArSQ3CuDjJSJ2a0g06bvb7Z0erIOQcz9UN67VLYOgCVEUUZ5LG9rJ6+
 WTZq3dpFLj9SqdlL9O0zsDNWkFOrMVynvie+Clnd0BgDDovuiTp03ThffzEVQqhVgm1G
 so2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773226390; x=1773831190;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqRDua5KXKCrzq6BKqsTZ2QOQLORioqvPy1FVBfuT3E=;
 b=m2hbAbrHIB1Xeojp+QwDFy/WmnnBM66DUoYDayHgsDmSnozfYbKfvDp6GnLUvdh268
 zCTdLfLzUOJBKn/UyBtQia8ek6cYSaZBXWRWxGjwd+wpueKQW468caSpIASkpEPO6g/+
 Y3FXn2PwlrmshwNZuVky2KER2rACHNcRVkoiWxUVG+ywyvEySbp8gwMn0tVY2N+NxscM
 MJPV5A3quH2olmO6cGBngfl21Jxhl4mq2qlW1t3aqsVVeKkZ7FxGusAWryokkfzeo79T
 ZGdOfiEQFlf1GUSXe1yMw/tW/srUEqwCjhjQ0oUUvAbI0ql+X0nHYPsYZdE2ETxKRboL
 LVNQ==
X-Gm-Message-State: AOJu0Yy7YlddaNNksN1OhzccSA3zwYZ6rmKTQ2QbUFYxF1Pu1QWjNgI5
 85K7HvOmlQDuXduBD+wRISkMdf0cZ5qkYQJQ7NWge4BVvUhIo8/xVwIzNOVsVnksHkS7XwRBlWv
 sOjWU
X-Gm-Gg: ATEYQzy/0C1LrghUGYGNS7W20JEmFehVqmJwZ6JFX6sezwwfma+WWBwtzw/baZoFZ7N
 xVmnp4rg5ELMDfeJi+/nwxkFAc9tOd1ygHCb2bfDH3IASWbXvPB4DEtJyYz++guGyzhyRiUpN/j
 oDGUk2mZoM8XlXlL6oU6MSTZ0h/miqN/e6x/6oavg1s6S9I7Z+gZpvaNCA8ESUer6WGh/VEuzgC
 sjxzrNMFfuNGZTKYeeBsRUz1Ry/+cAHmH2Q/D5AH06f+yyQOqfVCbUeQMIb5DOf4DJyZVDeSvtV
 tudXtpAWGB1/s7ktsWktNkTCOkSPnjb73gm6t0i7yvyD3TaYky0UfUp46Bn8+s18+AvlWp30qOU
 GIE7i4sNuyGWd3iJtiozzW+P1AZNntnPqLkKgw392VzKLWms3bHYH3yTDjZZSXJsFwX+sv27wmR
 Emp7tQ71ApvohbNZZnnYgmuNc+9enATlI1QPwvonz5rDlf4Ikf21/x6XkbG/3WZdv/41sjHVnuh
 vfcYUtANFv8kLV3J0jaiAzUYBK/96QRqhuk4E6c0BDG55t/3JT8nul4UmgZ7bwsGPS0sIF2Q4Eh
 Nw==
X-Received: by 2002:a05:600c:4455:b0:485:3e6c:aa84 with SMTP id
 5b1f17b1804b1-4854b13b3cbmr31404515e9.33.1773226389570; 
 Wed, 11 Mar 2026 03:53:09 -0700 (PDT)
Received: from p200300ef2f4fc900570dac32b65d0317.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73easm140420275e9.3.2026.03.11.03.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 03:53:08 -0700 (PDT)
Message-ID: <69b14994.050a0220.a455b.bf65@mx.google.com>
To: ltp@lists.linux.it
In-Reply-To: <DGC27F1BK4VU.1MC5BNP80A236@suse.com>
Date: Wed, 11 Mar 2026 10:53:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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

Hi!

> Hello everyone,
> 
> what about scheduling a new LTP meeting after the release?
> When's your first available date?
> 
> Kind regards,
> -- 
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

We still didn't decide a date for the LTP meeting. I was waiting for
more feedbacks.

@Li WDYT?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
