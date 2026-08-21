Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A5AC5DF81
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 03:05:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBD783CF4C7
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 05:05:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8EA93CCDD4
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 05:05:04 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3709D60071E
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 05:05:04 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso4253545ad.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787281502; x=1787886302; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rZ2VvGAY8Qvn5ItA2OzK3YxeqMIBH2ZC3kbty9YwTm4=;
 b=o5fvMhERRwgNmfA6jH/gc/MHcbktuQ6ReZE8UMF1H2ki7CBdmOEDbSRg36I55QGj2D
 xdUc4PYmuJBdYwtDr+gXrjRuPeihsfHy+kzFlsRe/7wxn3gR8d5u6GDtRYqbZ13QO4P0
 aUpG4JNoiXaaZa5A+x0Y6HvvEC0UF9te+/45iCIr1HsE3Y8MgQswZRNZ1TgwdJ/YhwGQ
 vJELs5eGFdJFDDfuGlDzb4oVgGTNJEiPF1FYqAq5V/h9CKJwGvJczQj0gRQCUXGfxeCp
 TAgMXc6IoeYB/fEqt1uxCj6dXxJjes8gpGYAcBmUVDD7kKUtllFvHhie3x45XS0/7LiV
 9bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787281502; x=1787886302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rZ2VvGAY8Qvn5ItA2OzK3YxeqMIBH2ZC3kbty9YwTm4=;
 b=TNmSW+At2axyRBLalaVjZ4FQUFJ60cQOgVN4hopRiPtMDl5aYIbAe6DPgeLRJSQWsY
 OzlXLF6I+vDouhly80mfRLatoFS19bU+vMcq1j+N4cVLTbvSevZvCrH3kiCCHDGQULzo
 RC5zk+JDHSFVhXt7XhaujFm4yXXfO6Ch+v108IEKQsaOQY/TqTimMLBWCy7pnBuFK3Y3
 rgEWiht3bWdSHnsbjnoeMkuqECn/zQq7PiIsiawmfBx8ikLpzZvCM558Ntf6idk4u2kx
 YIFxTGNKLgRWRmMIwl1Df0CKcti6oR80NhwzodReA6mfo++aU7l5jDexy4nBvq+beU/6
 WeVw==
X-Gm-Message-State: AFuF++mdLTonfJntN3IUZd1BClfiL5b5Ns7PvDS6nZlX9DnphXsi4foD
 DKTdHf+wvRFkC4U62rBv0ZyZrffCdfN8NPyOpsSA3y9RR9G4ezoWQn5w
X-Gm-Gg: AR+sD111owaY+Bb9lzbk36ZegkaldNzd4WggLcNerMImPKGEjKe1gWhk1MxUzbQarsj
 l91uAQ9F/FxTy/hzVJ+Xq7yx4lCIe1QcEQ3kSTWjDDswh3VlXEnV09hcDSnJlyoFwRaxuCYIdca
 aMA/gDfV66MvTGAGDlaSSjuFo3sKTKpbnozhlli8mr9O6gozBiSe0iZwHIE39Blj2RF9mgP9wIK
 VNLaphznziJlG43knPAJE4svaLdus0waGfq2kHsV1KzyztOzNw+cV+ft29BL4R06gGhThsOOpzU
 CeIqvUc0bpN6RoaPKvWxv5z/PjUwHFZ+Ax7gYqmRmHKEAMJQvw2xCyFG/jo45lqTATrvfBvKoXu
 ZPUl4eQtkwoWB68ubP9RxszLC81L38D54qtOKaCzSLvKFwXkUhEovEujfFLf8+siPNs51NDwWrg
 z75/KhKuSw8y4BQeajBMzOFFmZLHijSlfHMHIWST54XwNCbUND6vVS4WOW6x/4FbBGhnVgZV5CE
 U9VdCcwm3eVKwNYROqi2YgwAvsbqAfP3itToWPkK8DIaZ5G+a0AzdcOXa6td8mxsa6L9pKq3+M6
 tA==
X-Received: by 2002:a17:902:cf12:b0:2cf:4544:104b with SMTP id
 d9443c01a7336-2d64af6bf67mr66559215ad.5.1787281502301; 
 Thu, 20 Aug 2026 20:05:02 -0700 (PDT)
Received: from
 runnervm76f27.euvoypmqv01u5lz5obefzjxsjg.phxx.internal.cloudapp.net
 ([20.163.83.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf10ca5csm21411742eec.17.2026.08.20.20.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 20:05:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 21 Aug 2026 03:05:00 +0000
Message-ID: <20260821030501.8558-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821013917.28499-1-wegao@suse.com>
References: <20260821013917.28499-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

On 2026-08-21, Wei Gao wrote:
> shmctl03: Fix 32-bit compat mode failure by adjusting comparisons for compat mode truncation

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
