Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF7CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:30:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046173E7D4A
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:30:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14CB13E62B3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:29:57 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1762600070
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:29:56 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2ee990e8597so25631434eec.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779809395; x=1780414195; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNUCRQEwCOzK+BYAq7IWCwTpwNi3TXaowgx1GATJda8=;
 b=DdWxcs9X4d7mXBg83iIwmHrNQNNOh5ilgpysFW413lOnZhQC6/ceQJ/J23zReeVISK
 V6g/BHYtV6UIlMfI2s8QzbxMkGTcJkvQQBdAZMJSPILoCnligyg9IVLsxhbNGvUMQF+Z
 2N0si5r0zaaraaj/A5UFcrb4FlYEdeBtc+AdTKr3oXpHSr8ZCKAmLV1UvODYsXQvlPPX
 felam7lpKZZE3dWDPOaGnkFyl2HrqE1aoMsjmsGJ+mochcimzHcN+I+AriqNlfzSdzYg
 dYjXah9U6HrPP0stYYGeogh2mX3yOmG2/I86i6kEVQ11pYKtSQUPvByO+cQ2M+Hus/H/
 ZCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809395; x=1780414195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oNUCRQEwCOzK+BYAq7IWCwTpwNi3TXaowgx1GATJda8=;
 b=cLodQmtrx96xjPUg6PltgmZOGnloRoxWLTnYlCIMcl5F/g+PIY6nSTGz7O8HaBjCx8
 AQlieCjM2WRksCh03/i8xr+8hHP18hlC5FWBzRKpObZgv/rlVwNYpN80eAJKdxrII1VU
 Jk8aTXBIFr1PN/2eJUR0+DnCtVitlIkJFmUYy7Ey3ZxriFL48RjVXVwLskbxAVOFUzdx
 O7tSKW9rhlfL7gnJtWmeUnnf+YZI5mFQjzSVFP+64pCLIqELfT+MiIxSKnxNPpS1+GpL
 b3QLhDcT6YUtfwHzFEEF5yCxIeFDLRsW7pNaVgRQpRqeugLFXWikErG/6N+lVCsxuoDz
 C6MA==
X-Gm-Message-State: AOJu0YwbdjyHT9SfIaUgHGh8nq0egj9YW3bCZY+5LDlR6ZRFiryVNt1n
 5vHd9wMhz9Tz7O36Pin0kX21VurTKgh2+kvXlvOvgqUPwdAFGmEs4X7U
X-Gm-Gg: Acq92OGgIIiSCfS67wWUCfVIg+ts+LWGnrpG22pewKkea0NCLgYgediQei4vxfzZhBi
 miFBf7/x7jet74TXAirS1Lp1nXfbb1vH7af1ow1bVzSyXnRbFVoa4OG7XdajF/m3/q0bo21awiC
 JP3cQgybq9jtA53kvHjD8t0lRwmxufyYFKF8jpRmOGmuM5GpeUN5eTBAxd2296iZxGDSUYHMhBt
 mh/8c0+Bomkir631Sm3hkIT3XN/1SEJjU0xwhBKZWrE+5B+74OFS9lFpMepo3Lx8VIuLWNhxA2q
 EgHHlASwjqhgnbe9J23vaSYGeE7bTkVAtg8Gi/OS3cOBHQUhgTyESa7CxZU2H/zXuITZfb3OVfP
 ESBIE3te66mqN5GOBSVifXyQvM8AxRW9vMRAwIeYafT/n1aPko21eXgJNKT0s23M8hITAtUH3pb
 0h9l8qF46PST17aougXfInZ+o7fLcE2ihrxD9dtrKYt55soOVkZ3fXIO1JDQ6lJnqLTYyMjXs0J
 iX8qYQXvETjBv5vZAhAwAsshkV7Q0fTC/l/8PZpFg==
X-Received: by 2002:a05:7301:169a:b0:2f5:6d9c:7156 with SMTP id
 5a478bee46e88-30449101dc3mr9034673eec.17.1779809394982; 
 Tue, 26 May 2026 08:29:54 -0700 (PDT)
Received: from
 runnervmg397c.r5jbl4mdtirulmehxqxm4a3ntd.phxx.internal.cloudapp.net
 ([20.168.109.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304535ae870sm10484193eec.19.2026.05.26.08.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:29:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue, 26 May 2026 15:29:53 +0000
Message-ID: <20260526152953.3854-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526090730.22455-2-mmenashe@redhat.com>
References: <20260526090730.22455-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

Hi Michael,

On Tue May 26 2026, Michael Menasherov wrote:
> futex_wait06: Add EFAULT error coverage test

All good. Approved.

--- [PATCH 2/4] ---

> futex_wait07: Add EINTR error coverage test

All good. Approved.

--- [PATCH 3/4] ---

> futex_wake05: Add EFAULT error coverage test

All good. Approved.

--- [PATCH 4/4] ---

> futex_cmp_requeue03: Add EFAULT error coverage test

All good. Approved.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
