Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B7CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 08:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAB383E2B0B
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 10:26:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4E3B3E202A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 10:26:06 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 193BA200978
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 10:26:06 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso7127268eec.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781511964; x=1782116764; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bioGnXTLndpDXGMjHLm79GygAHUcU/dWpUqd69FCeqQ=;
 b=JO1Nf46K99K4S3N77JYwA3ma6fZEDMSj9eeMB4mKeHHu5Rj5LShvcrTiwMx9zMrOlL
 Ee91oCPiSxJOMVLdNZjm2e4VTTAqnRvPZGmABXbVMugcFei6FpOcqZotYN/hFUNXi7bj
 y5rHVemBbI7hTL2Dcx/gPSdX3BIgJVIIZBNLBo6GBRuwdb+KB2yv0bZmGUWDF7m9E8L6
 b1PQemRjg3BZcCkAXnYzXNNPEo3hxBljjZK2DgG9YX335Sceu5VhbJS01vw/+K9tTLdU
 z3eDh9hf6087gOVF/GwwWdqjyS6f5YdZGSTdduZnGbw2gOSKLAl4Sn+BvkIXN2klIhVN
 cVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781511964; x=1782116764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bioGnXTLndpDXGMjHLm79GygAHUcU/dWpUqd69FCeqQ=;
 b=B52XCQF7jE4gg1KlYBP+MU80t8kZawc5cf6rNTI4HBolTZy3t5LMVpVfxUtaoO7vOE
 +3/IMiwrnnJ9wYvpEgjbDQJaqjnqts6MqMOcKbWHxEv3pNElRAVBEea24SJTyQiRyaOr
 n6U+A4RmKxaENV76oIt+flGGkPChwfAHwpSoHpplU+P/CBjYVHIDrhHOp9owycPKSMJ0
 vg3nsS47SGhjvCu4CbJtwme8PM5d0LNvNF0V7V3NVXNEoz9uirjaHh7oiVlQ1gTEIIQq
 brgOYN2xopK0wmqDHowGGkQlQ0uqCJXK+dc7EKspuOJb418j2IKlvt1dfzC8kihzH6Nq
 HAug==
X-Gm-Message-State: AOJu0YyErh5zf5hv6ctrAPtglMBbvmOhcAiUhzf+MNppkDGJ55uvVW1o
 SqbZJWMwbO5mHGKakHeVKZarThmwJOoxs1wbfaFVfJdGsYL+9rCH8AHMsX6LOge4
X-Gm-Gg: Acq92OHNF+CWtpOMDCd5k4FoxT7bZur6XFVGYp2QL4zPzxXqW4PsHVaDiOexnBB0kfQ
 yjOt/3Y2FKkThpm5FGFymu3/ZakwCiVLJqUaGV2O5XheP5nbHMnwqcX8LRljbV7ZFQPl3hgqaJI
 zoQF0SO+kdsWRB+9SsNQseZiwaBW0jNW90tLM5jG9yiGK9IpWTdMbFwsplBIhOvoZ9uNC/lx72q
 BrMwdk0+K+/PpnqNMjHxgUQKsMXRBFuFQRgrSfPtoProhPrrJWnCD1jg32E+z5urtiuhbTnEOp6
 mLxO0v+SlDOIY5ah83ojeuArffvIRSdXw3t6bhxbhYWF6PEKeiSa/Sg3My6EUTdcmmq6PoRgD27
 RRKnZmyM2C5cIM/rR1yyxKAk8SClwjSLm1FTsYJjcZ+3+BOmeprHGUeReIfqpV0P1+nhOvUcBZD
 J+fF1qQg5f48BsUJB/GI0G3lOmN9KhU043H5r0mnwDle/KRL7nufWU5eyEv3+DXShdNaE8HGgXL
 MKZorPdpCODd2B/yxX68WHH447n3qTNsJ6xdC+fTQ==
X-Received: by 2002:a05:7300:8c09:b0:2ed:e12:3773 with SMTP id
 5a478bee46e88-308201edd23mr7779065eec.35.1781511964307; 
 Mon, 15 Jun 2026 01:26:04 -0700 (PDT)
Received: from
 runnervm1li68.pwecpca2uncedkfoq4buoxjb5b.phxx.internal.cloudapp.net
 ([134.33.68.253]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43bc7sm13718209eec.22.2026.06.15.01.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 01:26:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wenbo Ma <wenbo1.ma@intel.com>
Date: Mon, 15 Jun 2026 08:26:02 +0000
Message-ID: <20260615082602.3762-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615012911.36607-1-wenbo1.ma@intel.com>
References: <20260615012911.36607-1-wenbo1.ma@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open_posix/pthread_sigmask/18-1: Fix race condition in
 signal thread join
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

Hi Wenbo,

On Mon, Jun 15, 2026 at 09:29:11AM +0800, Wenbo Ma wrote:
> open_posix/pthread_sigmask/18-1: Fix race condition in signal thread join

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
