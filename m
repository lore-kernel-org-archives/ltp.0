Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAF6CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778083575; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lrV8qK8ptd1rlp7yYRw9VK8cpJwoewNKz8X7Q1quEc0WvN+qBzUQHefiLMwNI/rxK0mLp
 WsrQqR1XI9fXA7AZ1L4Aj7AQpsVcOAJUnRhpNAF3tzgf+UqlxFqXbzWqXI3O18MF9TEfx7x
 QqhofovqGFL94sIzOLTnbOiTPV/XXl4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E9E33E6A96
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 18:06:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 506E73E188A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:05:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28C13200AF8
 for <ltp@lists.linux.it>; Wed,  6 May 2026 18:05:48 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso72995595e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778083547; x=1778688347; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Pr1jfwh33B6ICrd1egur89tWvJC8FDfUAzMOvf8SslBtq7baBLih01kiZYntRdRB3E
 PZAo2dax/BIX+nCFpsJZujkwobBqep53Tfy9P89nmUs9n8Qs66jb0+53Jat+HkJxiY2K
 qqth6M+hRm93o2W+c0wEpiK64BHeyW/DLLG2D++xDNAtL4Z3l0RhV3DKMO9cumQzVUuc
 V7E9jS+G+UC2r7hwEH/jutmOwhkrM1469EADEXK1BLsHYHNV7sk+2Vr3hiINUe4kXdSj
 +YlRb64ciwu73oQigZzQExNcsaQVH6ErGrK47UbA9Gm9nqcJP2UzN5vT8XNsdoBVhd1u
 AbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083547; x=1778688347;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=d+p/XPl+/Nf/BI+MSX1oHBy9WsPCcg2fgD61B5b9CjGbO+iNNMFz5bgFlZFfLcwR//
 NHJs2z4/QW6AqxMsgScVU/wso8MWrNYdspdP3x5RAW7oYSjpVUsaVu+oFI6LfTqzV2HK
 x72AKEvu0+7xwhQi39/qrNy0IpR3FAesfi2ntKHlJ2NjM5CkEElV5eSIpDMfnI8MHW9D
 qBrb7SJwlm6CObmLtKQ5GPnrQL8C8AGNbdTTFWPejAXUlxhwBBtsVFxofygeaAPIoeO2
 BVpbZr01Cna7aILDN1pAkBzFkIH1e+ETSEDE1q+7/WjzqR+esSbJpyEg/kmWevCS83oG
 wlHQ==
X-Gm-Message-State: AOJu0YyldeTFzMuhmKJDlN4ou1AKoRrlV2MJXLH2E3ekZ+oE230yUVSi
 6I2kEANUu0LvHzwUlLCmKjP78IZIjWIwSiS+vYIGO9SuLKbxR8xxKCqhN4UVAcFnXHyTSfm0YFN
 WGZUJcKf64Q==
X-Gm-Gg: AeBDiesfbemlrzXeAHn/Sz/tb2mn1qvchNfSeT/aiSpElxG02EaWakL6O3Ok0VsPTEk
 +X0cRkoDBciGpIyPNENWMSHATRqH7PhvB6SnUNlmOHsfwpUW4EAB/pmlOvIBwP6+HO28biFCjcp
 XbBgNQ6pQkTIKEnNbnVUG8IBaOZgFILaSP6bKAfyHRx28DHRQlHqTHzSCvmAXjQT1H8AQA4VeeL
 3xIDpmPIcRf32oA8oU3Vo0F5Uo1GqPicO7xGmJ+Sq8rTQJf3/Sw+rD/A3+wE7S00PuUEKV6cZSm
 wbpNBkI32le2dwCdfos6U8l1rO6ZvSdSTPwLq3mgs6y7wlDQfAaoXGEABnGvByFdYBoF/AagSuU
 wJZGAvKdxssWjagef4ekASQXgDM+T4B+MJ/2jF9bj1do666ZLs/fP151v00ihs9V/k/JAAK+UoM
 XjrZTa68dcLcd3OzCWDvY2kWbyjVsVIWqYU7Ijj7CjurvyUwJw1aaY0oZqpj54GFdZEjxp2BKhI
 l/9TjkVhkvI7gnwi8oeTmtVz0+fZ7VH/qKQ6x6sVzDKMw==
X-Received: by 2002:a05:600c:3b17:b0:488:acbc:b2e with SMTP id
 5b1f17b1804b1-48e51f32c94mr72349285e9.17.1778083547488; 
 Wed, 06 May 2026 09:05:47 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b212esm26690695e9.1.2026.05.06.09.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:05:47 -0700 (PDT)
Message-ID: <69fb66db.050a0220.1782ec.dcc6@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260428143614.69724-1-sachinp@linux.ibm.com>
Date: Wed, 06 May 2026 16:05:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] doc: generate CVE catalog documentation
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
