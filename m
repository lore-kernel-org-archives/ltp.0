Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F53CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 08:35:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10143C6F29
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:35:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A86483E4E65
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:34:43 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 488DA600048
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:34:43 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-304d8362a58so3159295eec.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780994082; x=1781598882; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9ycUaC5swXnnx53P6G1iBDnRdCAsE2W8Shu6PkS5gI=;
 b=Xa8cn6dY+XnsBux8bMUK2bfu9XwLVjbZH3msc+bkZJaYnCdljFtILvpVs+ZhM6SWW9
 0zZacoPs+RzvLf7pW92zXl3jQxIqO9IDKTyhlm6VWf7sGlW/cBr5Xy+c+KwM29udU1Uo
 3+tAqjvA74G+sP5CztJSlVSIMQubb7etDv6Dtqp8kwnpMdM+gYq27iNF7BtFRadhvpOY
 /IsRypkP1pu2TtyXR9ZYYv79n6212Wmpoubuzy9xeeWaJ2Wj/qn3s3SBZI0wsDidkD8+
 WYrL0y4w5iltrTMMB//BHNreNSw5GA0xTrRnS3eqfhAW2QZbFeKGFAX1z0MN6L0dSSa5
 sEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780994082; x=1781598882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9ycUaC5swXnnx53P6G1iBDnRdCAsE2W8Shu6PkS5gI=;
 b=qXxIsTQEjP8INp9o/9R6doBZZgj3M+9eadxR+tIQVa2uMLiPbfzz3EvFnsbi7h/4nk
 IiIN8abAfLWxrUtiiaFXzX3XV3TNFM9LAdTiUIFuiqLdWwF9ZoDH6ml7pfnE+HmZBjLB
 jaIuQ+ETi48TcGluAnwoq7ro/yzR+wqoCcSsKg5rd0ly5YuuTrDz1OgaOKM+UaaJp3Ee
 vTt+1Bq/H5hSgxBf6ngLeb7pA/HcN2kBFsCa3qYV/SV5Mv5RXlvdhl4gScdF/L+FABiJ
 xTuX4Q1lwiFPMpacC0N9Fa6xm/JlLcYXpyrQq2Q6gv0r6MPtpwyR1tI0UKn+HQFaTuUa
 LYGw==
X-Gm-Message-State: AOJu0YziiYp5vY7nVKzCSYMvAFoFwMx9fGR5RTJR9oDjP1ob93kkg11n
 96aD3mGbbLS1nQU46xvGeFlC+UAwNVcSr0ftXV/lnez6ltk6TpuvVRHRvHOTUsxh
X-Gm-Gg: Acq92OEtD/nmuRa5U8+Bkas74fWzv7Mwz1b+rwr1USpA1YTMpq+CTaDnxZumLO8Bf++
 4hPW55mmYi++Q0RycpM3i1AH6/unBVirG9JehZb6zHVJ/rH7pKd8vAlGbjHKWwOS8pqSfPWIw66
 Q6XWOO45s3GQeoe9Ecl/03J4IW16BQfg3PI9kO9ONKldOZlB69LnFwvWRJQekt6tfxsBbJH258u
 MWUIscTGY69GJCgfDOkt7IzwT8F4NTB/9hGExm6+G4BABrqmDjkpQHP7cMH/W2N9sucVK82Wtk3
 udqOCFJB4eYR2i/lpdU9OJeFcgrunFkH3px/iFuL7rGd/zTrTPXL7k0cdE7Y7+/yHeMCurqZYVG
 LSdczpce5SfmGhIizL16Xh0bGDDWtSlkYA+X8obgAep3s3N1fT+sdE5wSZ0HqRWl1ZnrMeFQrR1
 p42+m2tV7dqYZMvqdCnJspdAm4kC5aBpa1bFu6jQaYZ/JOuAr5GBC6XQ5cYsVvY6QoRNGUXz57W
 rI4hbnzoeh3GkWwkIqdTBNoqaHG2V1Asjan1NhkMALYhaWAF3qMkmPrjNRj9g==
X-Received: by 2002:a05:7300:a887:b0:304:ddc3:2c35 with SMTP id
 5a478bee46e88-3077ffb4d52mr8619306eec.10.1780994081525; 
 Tue, 09 Jun 2026 01:34:41 -0700 (PDT)
Received: from
 runnervm3jyl0.n4ynvi3nwxeuxerw3ulirhhgtg.dx.internal.cloudapp.net
 ([52.159.245.177]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm29153503eec.11.2026.06.09.01.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:34:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Tue,  9 Jun 2026 08:34:39 +0000
Message-ID: <20260609083440.4005-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525153352.188816-1-pavrampu@linux.ibm.com>
References: <20260525153352.188816-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol04: Fix race in pagecache allocation
 measurement
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

On Mon, 25 May 2026 21:03:52 +0530, Pavithra wrote:
> memcg/memcontrol04: Fix race in pagecache allocation measurement

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
