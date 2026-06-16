Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A59FCD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 04:07:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B56C3E6D41
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 06:07:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51F2D3C974B
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:07:37 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D5142009DD
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:07:36 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-915671abde5so477776085a.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 21:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781582855; x=1782187655; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DonDlNTqaNsqk8pvzpPaoi1vmYummMSSSULk6LFlEwo=;
 b=K9LyCpb0G0wO/Xc3P0nPLr4iN+aAbZQtdk0P8n7wxMJWdzkFrCjyrOcl88SpnCNfjQ
 ZJ4OWfYKbhQKlI/U64WeUBIE1ZLjcAc3YZ2TJ1GEwoC81Bp5NWKTP8+KrIVQD79xDpYZ
 1lCaU5WdciKt09tKTDA2182492b/YLjcYHK8K4lY+ATe0i8OmMU5jcmP404rDAaX+/eF
 SIQgsldM4f3J7iGkc1mSXfnQPw/m0X5EsW1Ybw4mIODhg/0AiyyXosOcy+nljXjkYRCQ
 VmuVXUdpRACb7zVTwxqKjt6S45nx4dn99cp1TphgCCxem4CtjCeHVHVA5Hq4zjyFeeEJ
 Beog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781582855; x=1782187655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DonDlNTqaNsqk8pvzpPaoi1vmYummMSSSULk6LFlEwo=;
 b=ANrSG5RaERzX91egsOeKecdW1IPdjGgyVvEaQFEejXz8nx074iTj4q2vs2jDhc6Yo2
 YDYJ31YAV0DR0FOvC3BWpcnE5Psi3bM+CNx+xKunbz8nQj9mTt94dzIPDLl4PLaV+vIF
 cUq1D8XtwOWQngmYpZsLJLd6c3finMc8ph2l+hQs/3vu2M7efSjDV7nTh7pvQeu3Yvxg
 U6F4vd97jCCYUPrWoM9ocEWfboAS3U3dAvr8P/0GOgGLHiu6BPIy3COV2omt9wZj2POs
 QZ8636CGsTWLX6hHDTL0GnQlIfLVQZHY61uWK276BdQhbkuAyM9SRQZIRF5s6HqD1+5p
 PUFQ==
X-Gm-Message-State: AOJu0Yx18aPFhcHLfZxlvp6ZEhwupWO75gGS5c6Y0GPO8N2lvsG89tKd
 +43lQsFeECrMwTnwhsJZ2kSKmSLRayjfdXvV46k2vR+7Ca80eCtR7NV1
X-Gm-Gg: Acq92OEJwJ9oupR2X7Xr188Y8nCKGuiSRa5vxcqrcNUrOzrGKiFurOwKKuFrYs+ImhD
 mO4sGqb23zteQ/86emqkmgK6orYFArZrYufm8NFJ2p3v0maWWwKL/49N2/CUkKI4vh5FFK/JI+v
 pbv3pOxE5yklHDixN5RGFmNbUtSdkotdAAJTRQ1RaboKJn+Lri/JQAmxuJUEI48JZmfjR11KzXW
 IxVI4qupRJfgC00aT4C1IjElmu9jAIfgv5LG1NymFTk8heY+DOGw0V9P4p8DcvQAiME4niIulAs
 qtMrn+T6d+QQdgv0ZmL1U+WbSWH3W+j73xrpZ/16QqHnM2q1WAE4RH68XLqPyHXjPEyIqWBAUXD
 Mylb98GTLwnrIm+NUtVA4uNqpjAEcTPweroXXYdfga5T2M1/Atcrw6nfthIyJUDWoHcIah+GQt/
 K/Qg/KDDMPF2JJSI8P7lf1HlE2iwMo9zD0GM8Afq2sW8XcX9ti2cbn13+PTwa+EIugtTFAxGFDQ
 YPfp+e6mz6bJin4DkIueUC3/a42yiynkff8MxT12Q==
X-Received: by 2002:a05:620a:371f:b0:915:98a1:3a5e with SMTP id
 af79cd13be357-917f1c58315mr2272100485a.40.1781582855122; 
 Mon, 15 Jun 2026 21:07:35 -0700 (PDT)
Received: from
 runnervm1li68.by113jtsjg1uvfl24mkcgioerb.bx.internal.cloudapp.net
 ([172.174.190.112]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00ad75sm1348012885a.25.2026.06.15.21.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 21:07:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 16 Jun 2026 04:07:33 +0000
Message-ID: <20260616040734.4007-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616014747.8220-2-wegao@suse.com>
References: <20260616014747.8220-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect01: Convert to new API
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

Hi Wei,

On Tue, 16 Jun 2026, Wei Gao <wegao@suse.com> wrote:
> connect01: Convert to new API

--- [PATCH 1/2] ---

> +	SAFE_CLOSE(fd_server);
> +	fd_server = -1;

SAFE_CLOSE() already resets its argument to -1. The manual
assignment is redundant and can be dropped.

--- [PATCH 2/2] ---

> connect01: Add negative tests
>
> Add negative cases for connect(), when errno is EPROTOTYPE or EACCES.

The body restates the subject. Could it say why these specific
error paths are worth covering now? e.g. "These error paths were
not exercised by the existing test."

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
