Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96843C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 03:07:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 431D03CB830
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 05:07:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3797A3C244F
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 05:07:20 +0200 (CEST)
Received: from mail-pj2-x05.google.com (mail-pj2-x05.google.com
 [IPv6:2607:f8b0:4864:39::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1597C6006FD
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 05:07:19 +0200 (CEST)
Received: by mail-pj2-x05.google.com with SMTP id
 98e67ed59e1d1-39661faa189so224724a91.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787713637; x=1788318437; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1gaoYr1vUcbZLegFA/PW+LLGqCURNU2RLjdmsbMmJXc=;
 b=CVBlUbc9C5dg9gC4cWKtAQBlyV4GpssRB0N8YHM3oqYTm6w2ibz4R+DgkznCdwo2m0
 9fMo2ZCzUjEZmP3F33YckhYaSo0s6P9a/ECHAIYmCnWZSwVuhcmyaSPXI+/+ECUwPukR
 kA9qwj4vhaPcmJLmu7X47n3ugqriM3JHssxJRQT+f1UNif/lEXCiRJ+6NR85WrbAWm4V
 /eg4Zw5tVhHCVX2sXber6xGK8RW7qbqbtfgB9zgloV2o8iyWLodIfUMv0dFYM7bJBJL7
 AK6n36sVM//WG6hBvue5eTb4BL04EI9XYpCLCcwSSrXmqwdDXXOa5F/THb1siDbdxOJT
 kgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787713637; x=1788318437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1gaoYr1vUcbZLegFA/PW+LLGqCURNU2RLjdmsbMmJXc=;
 b=gonCSgsigpZW/TCFmsfFxTIghUiiWFMmiSm+EOmwvmZmzroQt01plWgl7UyHsSYttw
 vongEz3AORb+aFfL95N8StbEgwU7w9Nn2DL1e/g1SrGHBZTRWLD0xy1aaqQ/9SpfwtJ+
 rXx9CWiIMkzoD2A6lH0VqBvYHr/wxqPY48Lt4O2lpILKDz51/oUDCJ8L080y80iGuGjT
 8ILSR3HqsQyXmVNRGs2M49R5+7ol41AD/kS9+cusvknmURCy0bGo0raEqURgROk3pYWO
 8uqFmVqQM9+hNIOkcdIv75tc2AwqRlUkxRClUxhkAONl3hGnDWV/kwh8Epuzt1OrinzV
 0+SQ==
X-Gm-Message-State: AFuF++neu9wyTFozTqB3gm//Qb/fw2yPG8SpM1nxuoEh2bXN4bdEcJ4V
 bRNkaexwzjbubYxr5N/y9qimxyS1CvaOg0eXFWD8bf5+JR9UdWiLzVXPBdpP0kdM
X-Gm-Gg: AR+sD13eUhtd2LZiG3/NWP/Egz4weG21Yv6R0BG+BpngLT1tkjv43VipT6MP5g7jMV5
 YarZHMvkpwRo+LtbQEVJR1QhmhEBID2bKDNaVDpHTUkyV3GOv2lRU54Nmc6UaVW9hFQG5XP2hVL
 NSdBEWyIRwwiRnPKqaS6TdGfAM1iLJZrf+JScMJqY5LEUvUhTRIUTW3DZY3wqGkL6KrdtAg15Fj
 kijAFnp4WEOhE5pK1Y56OOC311H9X9IdlSwuweNS5byPhuQIuCZQ4QiJKhkvKIAdKpbWdzEpRY5
 ipSv30CN3+eypdXepHTemog4TJ5Xi5DgR4IP6ErR7LB18VCOOTKXdlhNx4GHwyj3drSRWWO0am1
 XfraN3z789Dm4Wsjiz9SX5QHoA4JZ2ZM1kdD8eGEZdfl612NWYoRoIeJScPRQWbG0jcwPaEF63k
 wXKTxleOYn6cVKRMggn1KvI2t/pYtGrhE4FG8TXbAit+Bol4cH3HCfwZP8J0PZuCxs+a2cZbfNl
 0vdEeqebL7xrGXAlWCLpKaAqKy/qHpeKoHUhIYvLRQ/SZ2oT4EXO1F2rAHYQSgVKQDUaPTJSmxl
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3966d412ab2mr7078025a91.9.1787713637396; 
 Tue, 25 Aug 2026 20:07:17 -0700 (PDT)
Received: from
 runnervm76f27.nskwonoeu3eefbocoimehfapfe.phxx.internal.cloudapp.net
 ([57.154.5.133]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283da25c09sm4965178eec.31.2026.08.25.20.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 20:07:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Wed, 26 Aug 2026 03:07:16 +0000
Message-ID: <20260826030716.8729-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826020337.3685452-1-cyyang772@andestech.com>
References: <20260826020337.3685452-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] readahead02: Fall back to the parent disk's BDI for
 partitions
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

Hi Victor,

On August 26, 2026, Victor Cheng-Yen Yang wrote:
> readahead02: Fall back to the parent disk's BDI for partitions

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
