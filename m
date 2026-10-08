Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F886CA6007
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791443088; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=U10R6+PdT/dWGJDVtcRWOa2XGqI2Bpahw1QORX9uo/4+XvMLogBEdUlIVC69RIlo+2OTN
 LSgtOKCDoP+fI+JmW4kzBvWi+WSVIRiBHiEy3QdImpwVLeN6A83QE/Bco96GTGOUGflDRd+
 x7sCFCdNeM7OxipcRNMIJvksNY0MsAg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE6FC3E2F5E
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 09:04:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE0AF3CD635
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 09:04:27 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 821372005F6
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 09:04:27 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so1940917f8f.0
 for <ltp@lists.linux.it>; Thu, 08 Oct 2026 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791443067; x=1792047867; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=bdSg9izU6FAj35rRQ4D2DZ8CYL6tRxYv1H71d+07bHeOisM+oE6j6QoohH2w4fqYLh
 V0aqLnHdbEcdJkq5f/OU8huI7j0YMqYTDeuMYChstWPOaKT5QHDdB8q8fY7FcQFpvvfJ
 7lA9ApPx80YWGoNyhNYBlTH+qilDOWr9z66NhKmHeh+cqqNKf9UskMWAp2PHKLqlHbqv
 LGuH/2DrftlUIIwvnx4Z+ABqDQnhRpNzmb71/Gx94K1saEChETtq1DVofnJyWS5KcOl2
 kH1rr29bEXb7tNwvzTVgixI4SJnX9RuLxLnbEt3MqfT8saw8BlujdE7mymTe+kCMXYTZ
 886A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791443067; x=1792047867;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=xDzZggKX3iF9sve1eJXML4Bmvx1+Dt7Kg09m8x0XTcQOU/MCxfhTPu11GUgMOY8NmV
 i7MzvoLybxxJM4/NpUGBTYnkI5ZzNTOL3zyYl4+nxd+2B8MXelIlCbbDRsLSQyO5356C
 f3jSRtkTfS/9IZcCqD+JAYBt4rFw6s5CxMHWckqfxpSmXc4pp6EenlpawQ8ONav2Yt7u
 RAo64SGoijTQweXuMWM9O7uJp45YKCOLHdea7A9VA6eVThXj2x4SYv2d/atdBONRKc2o
 5sOev+eeV8/2O5jQQGR8u5wFKmWBlcpi2qgLEHR8IUCcHAgSi0hF3WZR6muXK5Ga18fr
 FSxw==
X-Gm-Message-State: AFq9FYL+2xuyblSuA0Zu2FBSdUzwHGra79vcn2KU41zSjDcES7K3In1K
 OejaCErZxFmVJsBwDlE8k9Z0sSM+Q0UIYDkcq5B/0GG/crPKNP3gfzTewomL/3C+G5ixx7g0l0D
 YN4uZMdc=
X-Gm-Gg: AYBFou0TqUhZ10hWK8TBqw5D083SQYw9V3q2F5EOIhOusMmGtk/USoq7IU5mmubbA91
 00d8Wamvf6TGThp6GBEtYvZWMvyTFUAfn7qWUiqBNg6uGZv1k7qtd2KmwyJu4iHfyKyeSNt0VUf
 t2rAvb0uegFQnFmQKym9ZsUmQLBSCnRf2A2ROkZjjpm/9KNlomH3MWFKPe2Q8/sYdbN7+/f9FVX
 KHnOY25z1IPXNp06GxVXoLs1H8TFrpDpXcOQaMo5Dyp2Ki2yiI0HnQwYUnI4y6FShLPAL/V3zI0
 CTAUZpBYpPDqjxcTBuBkC3wIMHMI4qvQR2J1B4PuBjOt/8sDLtcoXAUXfhaayFyljNOEIM1EHuU
 tFkOXgoIX/+doNh78rMBwPgo3FBG6MZrUbCx7g95uaIv1i2H8HVcP7Rj1jS+ddnWaIlhQ4/Gbn+
 L30n2o7ZsDZYIBZAvpx5mt3T/MF9wFPTSavFAou1w301NBQwegliEBvx3Eo+MNIoyhxAvyNuckx
 S0pPIjFF/1FuDLtfiUDDIgPPTN4g9Smf5Ys+IFGdeEbgMCHc9TZc7cL3mFHemLOSjzf6A66/voW
 Ng==
X-Received: by 2002:a5d:5f09:0:b0:48b:4a2:8175 with SMTP id
 ffacd0b85a97d-48c7288cc87mr8369916f8f.43.1791443066935; 
 Thu, 08 Oct 2026 00:04:26 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d3d44asm9964639f8f.54.2026.10.08.00.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 00:04:26 -0700 (PDT)
Message-ID: <6ac7407a.b8bed76c.368598.0d44@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20261006020331.3791608-2-cyyang772@andestech.com>
Date: Thu, 08 Oct 2026 07:04:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Update call sites of SAFE_READ() to use the
 enum values
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
