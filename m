Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B186C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 10:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B19123E2A1A
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 12:21:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16A403C0401
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:21:25 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A41781A00616
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 12:21:24 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca7d1dc4554so25029a12.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783506083; x=1784110883; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbpBI4oAn9DlyeR9Mx5DfqKh1f8pjTN6/roJdAOvtpE=;
 b=JF+jCExRBMSCjiB5/has4WL3LsmeQHlki5s/36BksHD0OjIxMrQEh4W2IdEOkoC2Sa
 xBDGKnZ58snc3g9IqvZPha/kZfG4Vd8lrcz/kfmDz+QabKwbu65I+rwTdWSa1rPnLzJU
 c2J2+xFsdP++J1xuopcu543mQfRGWV4+BmT7/bxHaVHmLv6AY5O9aioRPIWi2fgqlr6c
 3zfOg15tgTKOdMKGL0VM9jlqwp3f6XWrqbPqRfYKkoaG/ZLsVaZ21uBkWcOsWvpBVLwC
 vIAQPxEUE4iV/GHPgWw2iBBtyE7yRIwaMFP0w7Z680g6dtH4Y1fCTFyfh3SifDDdo3hY
 PPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506083; x=1784110883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LbpBI4oAn9DlyeR9Mx5DfqKh1f8pjTN6/roJdAOvtpE=;
 b=mlmDTWVIud6ZiL7zF7P929qn/E4k6bYvw1LRHAB+7eOPSvs44Aa7JixjJ5VTd0pWCa
 CpVY1er0p8rxp0b+XcM7/rWnVlrUMrQOKm3fjC+7bfOzzuvDFakG4nzj4ehHgmCWG3z+
 PhQp6K2yQpA90st5PkM1cfcyVo6XcUFMwGg8Z5T0nvKIRuBfoIlky/DRauuogASseHRg
 L0aU6d9slkpUuPgG9mAtox4qTw6ub64Up1sdyWGabHz5/aAu1G+aTNMdlrCrVm21nH+m
 I1hllmGlRwFcEir1EDlmVZvqvEfSXeREM3YpL1mY7jTJyoUJOKcmpDWCvDbT9a2XjzXt
 j6dg==
X-Gm-Message-State: AOJu0Yzu7BL9GHjsUqFNfdldapIo+m0tRwAo7uXyDQtBlPfjnnf32qpq
 t45ehSa78Q9xmz2ZtORhRhJX23ofqnvJjCPrUgixAcM8BWFIMifwCKyo
X-Gm-Gg: AfdE7cnrVeJBO83xPu2aUsFBJz0cWzr9RCQbbeZU8rhc55GxPwsHp/asneBl23Kpvqp
 nbgksTrfiUWmXk41IS2Q4ks+NFv71DkziGJhWpmgPpaoyht54jcxON24LpPNpxEXTwvLiq3yHqm
 S6AcpcktbB8z5wnnT7sgqoJr25Ur6IEztnDg9cxZTc0cHkfQc6qy2yDyjRUikSrELlN7twTnJNH
 LeAde9D0gXCPgIb/odPsCL1OiEeg6hHr7Bh4s37l9xliUbkEtdusX2eU6fHrEMKfBJ8Srom0AmO
 olCZwNyQro6vwsOYJKR0uehotV5dDItYRg2Ijpgh3oASRtIu0JUTLjLk6C1lgH5OixLnfaHzhtM
 HrS+TaZXzAuiHS20loHAJ1CC1Yjo4Dq4TmvutJV/azeRKkJ+O/17syT5PKz7wjk+TGxUacvvKjc
 Xo2rEqLLG2DSf39v7Q5AqkmCtE3P7ibFYKikiUd0YSd/Wo/kiLVQocFSCYKuSBfhh6TkVvnzk/6
 9a9trmt9Jf0KgR0ghd5Po64iDFjVQ==
X-Received: by 2002:a05:6a20:da1b:b0:3bf:9795:ac0a with SMTP id
 adf61e73a8af0-3c0bce18a74mr2273685637.4.1783506082937; 
 Wed, 08 Jul 2026 03:21:22 -0700 (PDT)
Received: from
 runnervmkkn4f.nshkfahygf5una3mqolsq35y2f.dx.internal.cloudapp.net
 ([104.209.11.213]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac178dsm19354679eec.28.2026.07.08.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:21:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Wed,  8 Jul 2026 10:21:21 +0000
Message-ID: <20260708102121.3950-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708091154.999385-2-avinesh.kumar@suse.com>
References: <20260708091154.999385-2-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/cachestat01: Remove redundant memset() on
 cachestat buffer
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

Hi Avinesh,

On Wed, 8 Jul 2026 11:11:51 +0200, Avinesh Kumar wrote:
> syscalls/cachestat01: Remove redundant memset() on cachestat buffer

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
