Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92ECD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778139481; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=bws2bNJRJ/HzonybNOwoa0Mad8hOjIobF1GhUvSnmzU=;
 b=ULs4Ek/teBKqaqoJCXZmkIm43+u5U8u9DWlhpZ3F1TUywwveVdxUac1e6T9KLIQck3IeU
 EPcOK6vnjAeli1Lx5PK46WIARLW/hLnXdKzGh6JrVQRJaKZ9Hk089RQqizDEwIEiRtqExUp
 RjycLIggBMqgRGJhWufgB7RLeLehgEA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B39DE3E141F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:38:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E98B93E2C3C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:37:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1592520033E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:37:28 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so4616385e9.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 00:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778139447; x=1778744247; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nUe2GNSZ38x7qnrBurg2adYgJhffImhXoBqZ+Hr5Cg0=;
 b=QqfLkIvRMH7e1TZOShINTk7vYE8TEpT9nyRsV4wH2eMftRKy4tZxdW5ucKFK+e+7jx
 4iUvKBG6fRRQFFrV1Yu6dRT2ham+D113HvDLo5gYDOMdaRrst/llpJNkWfAmQDT7Wd3w
 3ynPJdLKMad7e2nT403C79WWdk58ES6cJPoJP9QQDnXgmRpywekRsf94R9ExTY9LZCDI
 snpDzdmnrG1sHf0OyI4eyGkjGWhypDu1WEmxterO5iGs2mrU5w/jleKL9kg2VFwWMv+U
 285Ng6R6jhUNGhNQqV1aeA5OuINycu4UDoucGI2x56mgkO+Nk5O/UU+iWVyiZ3tocQza
 Cdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778139447; x=1778744247;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUe2GNSZ38x7qnrBurg2adYgJhffImhXoBqZ+Hr5Cg0=;
 b=Y8wRVXAQIGIlo0hY16hfeM5UHWs6WQh4wyDS3hAf6ylppE1f7xbtRPSRUAPh23qwJz
 E1tL3gyn0k6628G2ONhdAf+iv+QIj0eVs2bYYw0t0P5nRIKKp9O9bXwxxMH85cu0qk0O
 jFE/hXxMwAZLPwSpXoGz+//Ici5f+ivKxvOPMbYDus9lJlPACy4euINm7jUs/Ia4NiU1
 L7uf03K2ZQnEEUjSSKYdkYCraRuiiOYDQk1gEhyKi660pqiQ2DQRUwZIKFmMdMEPMKMQ
 gzPfkz1R2yUrVw5vTlPirl2EcTNOto51ADI6/P4myCs66Qjc1Ayh2SkGu4sSJ1dPR86X
 raPg==
X-Gm-Message-State: AOJu0Yw4yJvBJuE48CO5Jaf0Yxb0h+Fr6eE3RCHUPIgof9FSKJ2PfNe5
 yoGgh+t+Ei5eqzY+xoN/iWrZEhfdKdxzaaJGlxFTjiO7sq7ssuVqGEOuNZ2rFK8wAPk=
X-Gm-Gg: AeBDieveAHV4UDSRpPVUxZhXyIZOBBJ+bI7iVgPXSwKsEpP5J/NX992/ZVpE7o3nrdK
 govdltTSGWLp++KUpUeH7gvWfAzqOz1YnYk8X6YnWmkErK8YrPeXZvbo0Vzmjy7VrOjj5Sei5BZ
 btHbXKTGfH4s63rJICaUtsM5cFsw+65rHyUWExac5gmTAWGtqBx7icLhOgzah5LARoak27YTPGE
 xoyxo2sUnvKdJyT4A6Ci359inq2BRrvUJ9kVXdubxIMfIAkvelz1EPMdRuW9ucFD16XsbaE6MbQ
 Q609vPoVRF8Owgxa1IDAxMPudyiuNl7M63qSXgnHZaVZ+JtH1k97Y5/whPazNpQwQ9V9MtTi8HX
 EYYk8298kd4gB/f1GFkefh8E8/hN5ApuLwdy9fwCPyyLSOdOy3xdcmrdyMe1Tm6gzsfup5ab03c
 2LQ9Yjk/bCueNVEAalNT/qolFNHwgvzwzA+9tGrLDcMWBTw7LwB0SXE4qIbj+y581oXy3rQA78s
 HxqFmWIrsqY4DJapAUNUWOAInCtqmoCTRf4uu0D1wXqZguNpfjCe2kH
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48e51f183demr103778545e9.5.1778139447417; 
 Thu, 07 May 2026 00:37:27 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b26a3sm192081365e9.9.2026.05.07.00.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 00:37:27 -0700 (PDT)
Message-ID: <69fc4137.050a0220.143608.5b4c@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260507025345.6722-1-wegao@suse.com>
Date: Thu, 07 May 2026 07:37:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: kernel
 test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

LGTM. I will leave @Jan the last word for merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
