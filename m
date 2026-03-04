Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD6EF8FF1
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772637011; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=DTp52s1V77CDVHWNoXgdsfvToRGDL//PYm0r8MuR9wY=;
 b=Tc4Ws2jVdxnfYF50BAW5gEjwTTyVQOAB2+K8FU8y70QZs2/pcT3a3XQa4ZHGCYTZCBbnl
 uIPmlspWKu/z42GRboZl57sLLtc3T14Oe51GPap/WyjJcgzYXQGv2yHCk05uo+X8QF/jX7a
 0U7gt7RfRlREODIj5kGZ59OkD0k1AYQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DF303DC86D
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:10:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18B6F3DC5C0
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:09:49 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8D2C2200A00
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:09:48 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so656392f8f.0
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772636988; x=1773241788; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6p7jpfj0HlN8Sr4sPhuwlmo3DoltJjkU1lN/4UNDgw0=;
 b=LWSoutA/xBYEumqbfJWBEMfQEDZANzaZfTklThFLFw/GGmNSaZXip8DHb8NED+89d3
 0VZf82DcTH4Lz7eovrZTD7PCCGG9+bwLipMDXLnrhyV14n9fQiufS7V70hl6OcTqmOjw
 +C8D12lve9sKPIbGzpeVCS9J6/wAjcVNNzsFkrVYdTPrfWyu55RfYE1m/nh2KjuPtviK
 o2tgnHhDurJcPTTs2MAQHTW7WMWTO+lTmsnU9LQo9fRea+drOqUdj73GwcpYaGtMsMrU
 8lo9SwXLEHMzf9wPXY+uXir84kRq8bohXDRfGJnWwM6pM5TxcfcIIf4S1+7pn7R1bSET
 R+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636988; x=1773241788;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6p7jpfj0HlN8Sr4sPhuwlmo3DoltJjkU1lN/4UNDgw0=;
 b=VegefKIhlDH9qjXMRFar2XErLZj4Ch7dH6Zlo03B1znLl0aOKLpe63093XSegyqVei
 HZIq8KHCQqgRR34TFuuqis/3R7vrwrzVYhvVkvfNJql/z3UEufIVeKFPUaBAi7KzszTh
 qT+v0NV/8Tcx7+ZhlSffSIog0X2v1pn6vpZi5oZk5BoRvAZHaCGBgLKmhhGsSJyPL1LB
 m5eFiJqRbR9/V4K1lyI1rHDwov833VUwfPscuSGBeKtXVLwnGB6YidWh8vYqC7eAJim3
 3GQvqQo8Qt8J8PHy2IvVI7tHnFCMixXyitqGi7As8KQdkMhJS2ncH4IJ6yqFPQb6OirF
 SJ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu2ViNRDQiRonmMTTZxY9Vo0HnJqXi0EiNE8Zz4sdmDzw/H5QlWWMpGvnroRkPuaMti30=@lists.linux.it
X-Gm-Message-State: AOJu0YzXQa0lXZtvOPQieQc5W9HPmXrO1VE8IVec3j7AYyWydDO+ClYg
 1sSc+9Uu4wCuYmV/RV7mIgGmFBJYfJeKAilWgJgjgz7tLtbBkAQdjSQOGgiuwJfrEF4x9b02fb1
 ivgl0
X-Gm-Gg: ATEYQzxJUSA2zOmsxT/zrLq2UOPJ3LqLlXSOctr0mFnL0ziaVJotZ2h0F+1SWLpLx5Q
 tO1W7anlhIxafiOKkuFJnLVVQ6LisS5ePzwbMF4e0fUPcDNNJP1OQMsDndxVrliH4gzuHtjZ1Wa
 l32MZNifNWwQLBPqvQSrXFa4KLczADUegKWXB0i8IW4lnjZQh88ZZ5NHupPCMu5tftxKMQ/9dAd
 yGVZ3shgr2D/zkj2EP39fPowMicPS4YNKPYqaGa6CpYEnAaXdZr7GUK0TtpCb5zIwh9I9OP2g1+
 Do4Zyo7XPs5uffJsxv473dhKFbHC8KLa3YJCx9Nt8PkNtWbBciKZOAGJMEBHlpYrbwdA9lzI+CO
 qJs+x3AepQym7L9NKkGfH+nPgjrbW9p5/bRaBixvpzAuntGEg8CvZQjv9AlBjB6ieAHsNF9myeA
 IpQTKuJkPFmvNw+mMe3mqwdlGeo0vBKnwxMJBTQYTO
X-Received: by 2002:a05:6000:144f:b0:439:bd46:41ec with SMTP id
 ffacd0b85a97d-439c7f64e3amr4367324f8f.2.1772636987830; 
 Wed, 04 Mar 2026 07:09:47 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b272sm42470457f8f.24.2026.03.04.07.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:09:47 -0800 (PST)
Message-ID: <69a84b3b.5d0a0220.28be0c.4ba9@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260304144424.10101-1-chrubis@suse.cz>
Date: Wed, 04 Mar 2026 15:09:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: ulimit01; Convert to the new library
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

Hi,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
