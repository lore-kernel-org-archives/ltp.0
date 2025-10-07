Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2891ACCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759845623; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dUII8zQf+fmepJf9Wcu3FHbELIB+eL+ybZVYxclomy4=;
 b=E1g/rJGf10eMmwx57Vte2bYnuIpydrlLwam7SjeY0j5gA5u7LZco/2FXSbqtMzpXFLu9X
 pMDJJKFYd3+wurITRhTa+YHPHhO+fIgM1s2u6Kja/1NYkwRy7YbI+iUNppFU2VUHZK1OXRw
 cYnpOaugjm0cQb2kDl/3WSHoJwnskdc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5519A3CE405
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 16:00:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10AC03CE3E1
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:00:01 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 489CB600420
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:00:01 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-637a2543127so11577831a12.1
 for <ltp@lists.linux.it>; Tue, 07 Oct 2025 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759845601; x=1760450401; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yg8r+1cVYcrrRI6W6VVdzgu34ho5OLLMTKSBFmSlA2Y=;
 b=XBfitNqBJTiVBdYFhJ1zTa4mvhzp59P9HvUl0XTTfBNoEalq5YIPrP5g5/IWJkPHHN
 KoR29V9x52Sv8uDh/usr034BXKfPMsJQ+AUMtcouBI5/h6N/xndyKUs4235sl7ktfmzz
 GMJIrM1agGFM5119tV5fKpApJxv5mplKgxjei3SjisjLM6rgue+U+jCsk3x2XtcFY50E
 o/ZovTxRhcvZUpLzew1hS/3l2KwkkrWVM2GXkupKaUt5ZPikHSyI9HuDEtdxP9JFWguB
 3Ah3QBG2gD2xh9rvnWILS+h5KgMU3grZ0wXZA5McluDnsGYivYw5LbdER6UpFfsTRILf
 gfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759845601; x=1760450401;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yg8r+1cVYcrrRI6W6VVdzgu34ho5OLLMTKSBFmSlA2Y=;
 b=HwEn8vR4Dn6tfHIT4JgpLoZVZGIXGQvWlKvMRek6aBlH28SHBL10kpmjdSmVsK4FyL
 xTfFZHwsd/0hWBTOoUcWV9OLDqdTMsJOhjHAkyN3M9xCZdbjWSJvHS1mCULU1Ca8Qd4c
 ZTJdBFW5hbV0xflO2+ZewzCQUMCjOUvW7OzlbpZgT2rmbDz8yjlTKomJZFaxqPL7qcUK
 DTvyFwe6InGopYj2vVXkI+pOvDTBKUUDVk/56RS6VngINJTqho+jQRpShbW0y1S1j39a
 tMEJEs+itkC1FU31GXaWooCQeuCoj60BBdSHyj/yBpWvfc69dQC/3neJ+QpdEoz6RIjS
 pn5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC91BDnLGnC+ZYcB3MsgYwhUegESSZVRQwuZfpK70sGAs2T2FydiHmv97Ym3lAoHP0w6s=@lists.linux.it
X-Gm-Message-State: AOJu0YxJ0GA7nFEI+wdr4Rw0GdCZGrBj92FcUW1JIY3/O6JGh62ehJxT
 lvujTRsIssepB9VimxY+E57rIpddRlBEU9BXefOLG3zIXzkSvfLcU5IHwnHawDM9+zs=
X-Gm-Gg: ASbGnct3BOybjd27KSuMoaK8k7uAcCn4RQpQdYKCzFCPN61gYImZbp0ghbpT6SBhEiC
 p99p290nrzWJRs63L5G56roi5jbz1Xnt6G2eGNnGWiUcjPhBG+Izkl/eQEmARcDoUpUxAi9JxaM
 xeH2SYsOLTB06qRrWTYWFX9EAEmynONtjwd7M3oFURCRRWmQ1DZCTWmN9aMy8sBYAy+VChIs3lM
 APhVw8j5JgrFxFmkp/aUcW8FLfk3x2WWOU+kC0cmbIabgShjewLEOi6CF2Z0HuoONBQacTYVGYZ
 mMoXrRHjyNUAI1wdGtOgN5oyUc+ARkgj/2BR+JMcTTctHBbj1Nsva2C8zU/bJJv28jvaXM8iUfu
 31pqycQhcD0Hw9qoJ3XVktZIH56WfjUHf5QUlRZlpIhb/hPtK3ElCQg5ptHkNpU6/HzOlUMlZUb
 O1G0ZVoG7axTwHHVujUNZw06JpIgcW2ntNBrfTbJWL
X-Google-Smtp-Source: AGHT+IEF4p49VBVmpSgvezSLmzCjYhhufJKurFpgJSC+Y4o48Nac08BHc2vuYFJF8H/VHLA5uD1bNg==
X-Received: by 2002:a17:906:c144:b0:b40:b6a9:f704 with SMTP id
 a640c23a62f3a-b49c146e5b6mr1889430266b.7.1759845600537; 
 Tue, 07 Oct 2025 07:00:00 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4869b4dfbfsm1396610466b.68.2025.10.07.07.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 07:00:00 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 07 Oct 2025 15:59:59 +0200
Message-Id: <DDC577NIBN3N.2ZDGVIH2KFDRC@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0
References: <20251007112719.13289-1-chrubis@suse.cz>
In-Reply-To: <20251007112719.13289-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_detach_device_by_fd() set dev_fd to -1
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
Cc: ltp <ltp-bounces+andrea.cervesato=suse.com@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
