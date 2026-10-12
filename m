Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8112CA9EC5
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 15:48:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E64673EB5E6
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 17:48:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E88BA3EB148
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 17:47:45 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 743DC6001FB
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 17:47:45 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 d75a77b69052e-5350beb1d49so18877381cf.1
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791820064; x=1792424864; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=crsegXQW3y5aVWi01cs3Ut1w1ch/7uslr854JocYl/M=;
 b=XwxTtxQQSuYqmaMb5X4VOeh1Izca3J+2k98g16s2nUWu1iCfirNwaNKNCk61X4/Wbq
 FuzGYt+9CzVpY3MBfYkRz72nNcqEcgkvvIAQSW9EEIaeFroJI03aTypwFdSKMKP7C1vX
 kBpOMAi5qtOw7PK3QB3ZhUwXBqG7/q6C3Nq9Sd0Tcs016jpj1h1uKjngbovC0QoMHriP
 IwRGB1+neP85qOYNb1K0JQ2ztmqn0Zlp1/4crhCNIxQU2LHhLpCCg8eJgKjSKLWJIUFt
 EuFVqMrGpHSGL3T6mlz50c5DsB4M0gQuYQd+8lqe5ew8Rwale5kKkAE95GpADVc/DYSX
 FP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791820064; x=1792424864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=crsegXQW3y5aVWi01cs3Ut1w1ch/7uslr854JocYl/M=;
 b=M2NhcWueFlFM5O75y1kKZDGkIxaYywGd496JI2V2J5c1lzNAT6hK/o9BCedeDHxUsX
 B+VUd845XtYAG1UrSy6jkqtwuSiN1qEPf159YbiyHta23awlauejmjgfjI90o9iXb4T6
 SgJEytY2JHLqMG+nAtvcvv+E7rlpYUKiI/T+R8O1JZYZw5CKL/+D8EcWdkKF//NZr+w3
 lo9tpw62LOdfsoLvSnLIlf0091FeGReCVrVYWwXn+C7QAvqQVkmoVJ9rpDl17gCHpdxJ
 l3QB/eqrq3Uvy6n/dSJ/ZxIFjwGWTBincz1vN9l8490dEScgjnvQ2Yrc6L3eM9QuCLe9
 s5PA==
X-Gm-Message-State: AFq9FYK0xMhOHk/hSeH9TFSqSghOjAgnDUAJNE1ZFWWkNj0iTRWHpu8J
 2Etk5SUOdSIlLh+dPS0Qe5xx2b9GDDRyaz2Jrp+j9gKYfh0faFM80BWf
X-Gm-Gg: AYBFou2d0hyd8Gttf5qlFtBiv9k9fn0Ta04wpH9YSW52j29qE+1XlPnEz4Ck6+ohKzB
 /eeEkC9c/3QTuXen9SZFSdzx6yuL71wIp7Fuc/E6EP70S+f+ta/0E/XZ2u8yRu47kk3qVYWguza
 YLn/RfbRnWGIfXYYb2+RXAVRdlia7wsKZtW9QmheB7/IXiPWecO11SBhNxtg8m31H5i6M2ndXKN
 G41zu+PRPuo+yjHU1qpFz5r8DgeTf8y6mfkkZjH4rkFocw6lvvDy4xElQhln7kjt7Pj/G2TQuVD
 RFEHmriQGxazKCLtjxKm8mfIHRAsQvr8sR3aqpeNj+gi6UnUh/VCmgswUqdynCENC2dbgaVevyp
 ZZezPjsk/0OMQQElVuWl8K5rcnnDV8f1O6PKEYwBpQtTLqEOIRn9Rri207xqPNLm4DoHejCVxba
 Se66H6GSUUV929ioctNNvZHNEay7NwDv2YUbOZeeU+k6zC0nRU0OZYUvMr1dZ4WzcjvNs3Tgbyy
 fSIlAHB2XPleRb0qj6JHHfLTG1mCydsBPNM7D54AKS0hqlCTDg3cZF1YK1j6Yxnxm1UF4AIfDLG
 XS+2WSuq0DE=
X-Received: by 2002:a05:622a:5c0c:b0:535:84e7:59c9 with SMTP id
 d75a77b69052e-5359f06b1e4mr178429071cf.0.1791820064182; 
 Mon, 12 Oct 2026 08:47:44 -0700 (PDT)
Received: from
 runnervmmprz5.c2rp1btxlhcejh44lz4aykhskb.bx.internal.cloudapp.net
 ([20.115.95.132]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b79a2easm80192431cf.21.2026.10.12.08.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:47:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 12 Oct 2026 15:47:41 +0000
Message-ID: <20261012154741.35026-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
References: <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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

Hi Jan,

On 12 October 2026, Jan Stancek wrote:
> openposix: timers/twoevtimers: Wait for both timer signals

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
