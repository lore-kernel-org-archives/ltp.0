Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F02FCEE81
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772019334; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Wfk4xEpsZVROzV0N0e3SuChL9KlOeX3vk3tHsiIT3B4=;
 b=qQ0qjhmzLGB3sqDVG94ZLND8QO2OiYCD6wICF1+krlXVRFl7Am0wI0jKpPEFg+NEjJpjg
 FT95i4DmNomqO7vc377TKaAM3NAicPru6oZvMJtYoEeWQFDD4tEoMEzipw9UhFq1k5LTSdP
 AH4MYavn5Il7rVPZzTeiMiaulIeDoXY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 128663C7BB7
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 12:35:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEBD43C8259
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:34:54 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E7581400048
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:34:53 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43991064db8so426021f8f.2
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 03:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772019293; x=1772624093; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=InEFLV1wWEfNNiDpvCcQE/pjU2h4dkN0wLCenIqA93FOKQrRcic+2qZYISAi5gyNJk
 h/YvBlmSmglIH7TEVVM90R9TYFo/q4ky16j8idv1gWNDYN+62y7OCzAO2aOzMkSsSWI9
 5fqYVTMpiWKzrudOTCOYtdzmjEc9vFcb03uMYb+5njkoDdCqLC6TXfmYbXQaavH5807l
 KjMwg9t1nCBm/ky+vhPjp7R5WPqhLfxbg3Ysqv5nwOr7ajL7aear9kOrsMmUsSYGLzAp
 GxWHhSaj5ahcEx5pD7cHEKomYRwut9L95IDKuQahFljw1AYrrS5FwhPHwb9FTe+w/ZhC
 Mj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772019293; x=1772624093;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=R5fpxZuuK4XOAjvC58ioXkKrOwkuDmzyf/IJ9szfNpf5JcldSmhzeVXrBysK+83ZwC
 dM6Ffx0OzMcuK50J5l09tmSiVQ5I5yS+DfVE4b7Vv0C/ri24WsaPT49dGRfN5cdpywPD
 f8ikzxyIlpUMSj6jkzLtGjXcBMJWH8XNzGkCQrqWaSz5EKpes4xF8O62TEZZZKWGsERA
 reZiXuRGgr8PKPkIcQtY8lwdHYYDgVtPfKvWYGyhabB23VVgHU9qSURtH5qlMhbDIOzO
 fxdR7hFggJE4izNitZKrue6O6PgbLMopobDEgnPPHJFoFt5edJ4Xz7I5lcn2YKawv0Bu
 mR3w==
X-Gm-Message-State: AOJu0YygTy68tR3Uii0OrNF2INfPZZAC9Q52oB1+B153d8K0ZMTFqk6B
 R5zycEbnfwos4y2H0Pk47AdEmCsfsM6ymmjVGEEXkyxGrCA+fKBbK2+/0tc0JIpwpog=
X-Gm-Gg: ATEYQzzQPLKp+tQUGKAueysIv0uxrKGGPZIcyA+m5gvc9jORNt9J6zPIgCDmpE2VWy/
 3x2m79Bnta1a0dXhHS2WT61yrfLKfK1bybAgVJTXZ7y3H09PW50Gin2F65M5ejif4s98pc4p5Jj
 120okazCtP7MILjEjPRXS6G6TsFGU7JLigk4wk2iCb/R/8wYZ5f2Phb/Ezdd2JwWGnLEgwCYnpV
 sN2m/7AYFKHpNrZYWqJ0ehkDaSLrwqJg3Nyi+0TCFvvF6kVLIDrCw8N3DmjKWL2OQ7FezRjpwvy
 WOnnXoUijw5pHVNhFJOOf0vvvDwE5oXy3NK1HOfL3kH8Q35kEd4WErKsiqeb/mLz5f0SK20+kzi
 dzgKjMZA/I5ut6AbvtpgenXh/+ED0M+8ujB1VjEplbjRvm2EmEfG36ulPGRKLlHsXqPcEYHMSCs
 aBxpWmO3kMn9HYBEqlPZ19v0c4
X-Received: by 2002:a5d:5f83:0:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-4396f17c94bmr28507719f8f.34.1772019293308; 
 Wed, 25 Feb 2026 03:34:53 -0800 (PST)
Received: from localhost ([88.128.90.40]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c60bsm32720768f8f.27.2026.02.25.03.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 03:34:52 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 25 Feb 2026 12:34:52 +0100
Message-Id: <DGO0EWR1HZE3.3HFUFABEO3QND@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <chrubis@suse.cz>
References: <aZ7Q-PB-_LV2K1xK@yuki.lan>
 <20260225112903.1978-1-always.starving0@gmail.com>
 <20260225112903.1978-2-always.starving0@gmail.com>
In-Reply-To: <20260225112903.1978-2-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] poll: add test for POLLNVAL on invalid fd
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
