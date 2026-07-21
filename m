Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7607C4451C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784639701; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=yLiF9+9E2+9+qQf+xb8KTMJfxWs+uMORjpgUH1939So=;
 b=aqeNEF8XqyZQvTxWfW0WQeMkxGE5yZkcLlfROxyf3rGs2PLziEMSAZPE4PngSXiF+N+Xw
 heXVUW5l2MkNTjT7PaM8Kb4SnB/6r67vksU3eGiPrHL6za2Yc3YH1WHjEtWN1phkImzSfmU
 hJbZS3sOXisd72QgE6yo8mXpOzm6opc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4B993E148A
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:15:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 458AA3C0F03
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:14:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 97C211400141
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:14:41 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso13210815e9.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784639681; x=1785244481; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=42fTeptJHqXy8noSgguskwBC0g6v2Hrde8U7qpYlIhE=;
 b=d13/1tyj5M9Nz+jtswMNDwXfGyVw6mr7+nSkjLUpSA/4tGeuXtzLzBmh/oxUp0AOuA
 +akHbams5ho8NvkZIxzpPTgJqQm/YLEGAUCMttr38g45XKYxcvrIbkpbcIO74wUQboSe
 moXtzH9Mw13Bi+3Ft/5hNhqx8yDJwcIknp59WIXgrxfn/oYSudeuEPY/CketBXNpNr0s
 /d+x+0k1oFpQ2FiuohjNCCE3M5c5Lcm+owyGPH3o+dvsqUMn/2IPUp7yAuveKkfJyuHN
 rEaCcS1kmufJ5JG1PluQw24EwpCNBVUVt7HDSkmW6F4S3MmiFO+Nz0oeJI4iHDtSldf+
 z7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784639681; x=1785244481;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=42fTeptJHqXy8noSgguskwBC0g6v2Hrde8U7qpYlIhE=;
 b=B+Vqb+0uyctD+h3XNX4cAybpD8IFICF+jrn6Omo4Py14xdbJtN8+mc2Xy7kvjjVStU
 GT0EEx9+a94HUaZjCLXx+yUUZJwAFEZV4d05YPFpSRZJcFgTmMQJpszPOFpn61iJEixr
 iuRTQxjr3co55B6towlGjsZwaQZsGgPWdW48l9GP7CVmTXhRfocnJBXijNtvyYFF69CH
 N4R2nf8MB1fpUHrl4eds1PINIUG/tMF2556L/Bw9Hcj08TmjhH1QxqtuR+145Aq5w/wx
 k0RyNpX2z3LpQQx8LU/altXZeJ3WNFgGQ01/46AD0F66fkKC4S/u7nVliVBv1kF8QTqB
 JFyA==
X-Gm-Message-State: AOJu0YyO+MhkvvoDLJuaePOzfUs0cgM4GIoZXSTwpyta4/szS5MKPQaQ
 4aBgXRwDWoTMJOsvWzEJV8oIPy6WKB8QQYuU+7gApBDv/hpHfU5kFpHykYMGU92EucNL6z262pV
 cQSEfYGw+Ig==
X-Gm-Gg: AfdE7cnTlTA8xiF2aNx+VzVWQwxefiTK2bxsENpJqQDboqcI12toJJGil26lTZPTiHD
 docpA0/6VLVYJHfo8JPba03RXTc3+Tj9sAPGtL1t6+F6BgfSWaaLSqEYnwWIrSpzd+WjJWKDk26
 1qqlRDiR3kF2UUwViJePYw/Abi9uPo7VSHgJzsKQhP1YninMekga8BCQlwdyULg2LG3PrnX+aIA
 4R+ijj+/IHf55u0j7FwL5iRYsp02wV4AzAL35WeBghPVbJhLtBnvfXnfk4zpyqFJoP1u+DxxzSq
 6XiOVHaXYlE+q63Re8K6W7TeZr93Qze4pXnzI+IYQsG/IWR+uY/3pCTrCb9NMmJxZze9Q1NV6YI
 DE4dJbwafjG90+7Ag/+lXJRookttLbVIhqyo+aop2eZp2Dto3WqoM+pY+eMqisU4gkjysy+XQRv
 j+Km+D4Mhowsy0kcbzVltgPUdiqw==
X-Received: by 2002:a05:600c:4753:b0:493:bc4b:b8c with SMTP id
 5b1f17b1804b1-4954a413024mr201397425e9.38.1784639680779; 
 Tue, 21 Jul 2026 06:14:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm63046535e9.14.2026.07.21.06.14.40
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:14:40 -0700 (PDT)
Message-ID: <6a5f70c0.bf927062.8cfc4.ec82@mx.google.com>
To: "Kuba Pawlak via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260717102000.1318116-2-kuba.pawlak@canonical.com>
Date: Tue, 21 Jul 2026 13:14:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] rtc02: skip (TCONF) on read-only RTCs that
 reject RTC_SET_TIME
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

Hi Kuba,

> +	/*
> +	 * Skip on RTCs that do not allow setting the time, e.g. Qualcomm PMIC
> +	 * RTCs without allow-set-time or an nvmem offset, where RTC_SET_TIME
> +	 * returns -ENODEV. Probe with the current time so a writable RTC is
> +	 * left unchanged, and skip here (before tst_rtc_clock_save()) so the
> +	 * cleanup restore does not fail on such devices.
> +	 *
> +	 * Only ENODEV is treated as "not supported" here. Wider errnos such as
> +	 * EINVAL are used broadly by the kernel and could mask a genuine
> +	 * failure, so let anything else fall through to TBROK.
> +	 */

Please don't add more info than what we already need. The git commit
already explains why we have this change and the change talks by itself:
we need to verify if RTC is enabled or not.

> +	if (tst_rtc_gettime(rtc_dev, &probe_tm))
> +		tst_brk(TBROK | TERRNO, "ioctl() RTC_RD_TIME");

Space here.

> +	if (tst_rtc_settime(rtc_dev, &probe_tm)) {
> +		if (errno == ENODEV)
> +			tst_brk(TCONF | TERRNO,
> +				"RTC does not support setting the time");

Move it in one line.

> +		tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
> +	}
> +
>  	tst_rtc_clock_save(rtc_dev);
>  }

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
