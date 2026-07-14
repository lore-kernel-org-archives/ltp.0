Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14314C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:06:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B24563E212E
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:06:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 380A43C17CE
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:06:29 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC1F5200970
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:06:28 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e58c462aeso201178685a.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784016387; x=1784621187; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yM0Cgz26eySlhl+qV2YxrjAd9lbD3ROEECuZ+DeEFNI=;
 b=a4BQ7l+YZTv6ST5WpqG/e4T5batm0jfqDvcvbfHICc02DYssOoVFb+NamL9CPmGPR0
 dTMcTHSsWf/NKi1mmJsH8hUgLcjd4Nhy11XBmQSj4uIsLCMaCBDvNvVentVn+jj9wPgI
 HmjC4Rlr/2O+4gPc6qf6dR0CtJkl8Aeio3e/vpRZ+vM7vOTEP0WpgQeKkL+dDNsWxrfA
 qN+BBMswbgEKv7u5NJRO7hdvoU8JmujKSNJpsmXlYMTIhHMh3RdPwRMK71oLwy7jBw3O
 iUznfCsXoKfVVu41AYKOFBBYoX6GrJJoG3VFBJpSw+EiaotBd/DtMOqKGYTyzpPtNo1D
 DrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016387; x=1784621187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yM0Cgz26eySlhl+qV2YxrjAd9lbD3ROEECuZ+DeEFNI=;
 b=R7J8Yk9j1oS24cqYBRGbtSMvTbhvsbuwHxpuk/XtOzZvLOWXACtmb5kSPyXRx2pwt0
 qTtLZwDob9O6srtSppawxCDG4k682FpxALqEnXx5eFpbQxFZZeTtz6xxHdHJC/bypdKa
 wM8oMQzLhm12nP2UW0e1BZa6qeCl+ah7UmabspqFWcFZH2NtBf0DLcW3PfzT38xkIc+v
 Pw8jUGgRWQmZNqv0MGxmgnd9XOsd8okUgyOSfk0hyQWC10VS2RDE0UwGBzScYwNeZIXb
 GxUSlNPr7EKhfBQutSyhsceCfCwX0dUXsHdRlDLPMqE360Owi5dBwA/41GEa1rsyWmxc
 ppsA==
X-Gm-Message-State: AOJu0YwFqBmIpXXtluGkTf/o1PtenDpQI70TwPpss7wP+i3hYKyGL6MP
 I9Ij4r1J+pAT+jF1MvxsfvA2xvNnoufBck1hMnCOXce+QHmRs8R8fTdl
X-Gm-Gg: AfdE7cmj9Z7fODrv3TrF9PakqU/mEOAGFrnVbtp+xIOS0+jx2pfLl0eBHuel78mB43N
 60eIj02htPxatscRyVYw4UzAPZRRlQUGRRGemNtN1TCr6PgB/ISS4Tvibo8wlRO1C72EhHm4pHQ
 5AfeYliidgbPOIYmFCPnbkH/DS/VPfq/m6TIh5YXxue95fuei9gHBi6cHTUBuTLu/yHa0C6jUKK
 7n4f8G1yQOig1b7OUDH8BprK5yznxiF8vIamzF2bwb3AQI3aC68zMfSnpNNiCZzSiiPyZNI0LBB
 ffxSAs+jHB10q6rzTcLM3itswiUmoNSWVb/AbB9q65+bUaYkQeYLIM9H7MfBLw2Wb5MTb7ZYx6r
 8zWFBv4QOKT1IDmfrbkVkKlx+uBWPAF416gwXxDn7k3MPYJT73ZUuBefy6UkxYHyh/bocXRvLjq
 JWnECLnesqM7l6kE/9Qd7qS4St6H4vqx49WxvmstDbwaXMqaPUlexj8nSTXIl4IG/Aa20ZP8sFt
 AotCkdzxEi0arbJ2xSmQKFNW9M=
X-Received: by 2002:a05:620a:2686:b0:92e:7b87:ab5 with SMTP id
 af79cd13be357-92ef2be0c30mr1355876685a.25.1784016387604; 
 Tue, 14 Jul 2026 01:06:27 -0700 (PDT)
Received: from
 runnervm5mmn9.dcmqfzuzjfdufk2kvuezc4hldb.bx.internal.cloudapp.net
 ([51.8.121.161]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5d36a22sm1388756185a.39.2026.07.14.01.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:06:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Tue, 14 Jul 2026 08:06:26 +0000
Message-ID: <20260714080626.3998-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714075710.894370-1-wakel@google.com>
References: <20260714075710.894370-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Reset cgroup limits before retrying test
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

Hi Wake,

On Tue, 14 Jul 2026, Wake Liu wrote:
> madvise09: Reset cgroup limits before retrying test

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
