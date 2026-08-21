Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C06EC5DF89
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 14:36:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05C2D3D0E74
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 16:36:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 937A63CF807
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 16:36:24 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2B5222009D7
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 16:36:24 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc775a0dedso216495ad.1
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787322982; x=1787927782; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rHcJzXvyn3Vf69YX+n/LdyO8Q9ebyaqRvzTWmjWwn0A=;
 b=jQ7OAjq/GUny/J7Cvv8aCWz+3oTio268mamg3q1HuwHZYq2JEXanD9afBbdyehmu5b
 ahlVGm58lBqyZTS/On+Jn+YCbi+6D13EAoy0+0Lw2pGdjakKsXuzZdZt24qLzxGt3e2B
 ABO8Q5f42q2uzVIroa3YPkx1Dsuc71LtD/4Tp3V8RAezt1Vdt/DV8dGFAZMCX0TXRjLo
 FfO0tqrChxNVWxAQdi53uHXQiRtB1w6OBZysuXc86d+C2XjtcgAUpE3gDBsxgxSBAh3G
 vXoCjNVnQLkRTz8INdKV3bhb6s7J2TBiHxrJUhi7D9stOhBFou4SjzQKWSD6y1oQZzjh
 lYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787322982; x=1787927782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rHcJzXvyn3Vf69YX+n/LdyO8Q9ebyaqRvzTWmjWwn0A=;
 b=V5p242pNyOEjGk28wOw4znhwlUKR7izM+O8y7FPoKhWrdO8ytJQtKwKn5fCLLyah35
 oWZeYhEqwT17I9sQbC9X0jLvzj5r4dxJdCAhy9zfA4pNytKpS5mXUl4gl0k4dDYFu1ju
 /Lm4dvbcOD4LEwt3NvrVUDcKMr1LZVj7GLXplcY7CA6fyg4Oy5yK++dxjeKZwfxsubfV
 yzM2tDMnnyezqeOxy/WeDYe4v9FS9xEHOsQ75giPfe4qB9aZc/uDNUZZ1zuv7vkl3chD
 qjbwcaR5IA96dw0iOnB0Wb+BKCDhvE/BDZNELeCPtO4ooI3Y/FPspspTUGdgJ5JMg6F5
 dNbQ==
X-Gm-Message-State: AFuF++lp0+hRLmfwdzPm6+Y1OI6Fv6sCgczxkeFUsZqg7ngTaQGZxC4e
 f9jca+kcHOJKofAAk0zyM2k+ETThhL/UyHMWmRVLoI380oN1tCmuXLaK
X-Gm-Gg: AR+sD10UR/JSFaaF5YHkee5QlTw+3EQ9XbL6k5dfvDGZ1MZX0tAplG2ZHEdGRJOU3lH
 rdc8qzcnJBr53vPpLVwEkIrF/xo/eWNDAwmzjBo/wjlMXstxnQsN36BtkfyLewtEeEUP5EwtJfV
 J0Lgd21NUgc8L4zaXqvTEp2Vwden1GnzZe2hcUCN47BhyCF/mufNs5CbTFiZa6pqeCHzaxCiCXi
 Vd2JK/4WVqHNJiS0A/b8+vb+CGGfJOkrFVq6F1LrpDE/+LhMsxD9KGd9n0jzweArKmLkYhO/K8H
 xnasrILQNf7S6iSF7PRVEvoTgVscGjM7cdl7+k4yqDWub7VWFR3UA7e5vYfepk01ktVgSI2ChqO
 WPWh81aMz0DrZL0GDePgHa1OfIfzOaPEnN4xMGswNPBEL4TMiWiIt4fVEgxKLj/Fys0+j/zvVjx
 lhnZjwP9IQl+H7jtowntnrvItNfsj0vHzGL1VtrySRnsiar9eO3fLt8GNss+TZXAHwb4N2LoWxH
 sGXfDmbqtwlI4rcmFcJef9GqxLu23cDfcgVMx1QzFDsWPEx92yIPbkduM7RjQNNoTSFIHrfethm
 UA==
X-Received: by 2002:a17:902:c943:b0:2c7:f5c6:c4a6 with SMTP id
 d9443c01a7336-2d64d349b40mr53613775ad.7.1787322982380; 
 Fri, 21 Aug 2026 07:36:22 -0700 (PDT)
Received: from
 runnervm76f27.ojgrres2phhexmby5o0ube4pyc.xx.internal.cloudapp.net
 ([20.230.212.100]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d5544b5sm19892505ad.8.2026.08.21.07.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:36:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Fri, 21 Aug 2026 14:36:21 +0000
Message-ID: <20260821143621.8753-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083736.49869-1-samir@linux.ibm.com>
References: <20260821083736.49869-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched/cfs-scheduler: Fix 'make check' errors and warnings
 in hackbench.c
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

Hi Samir,

On Fri, 21 Aug 2026, Samir Mulani wrote:
> sched/cfs-scheduler: Fix 'make check' errors and warnings in hackbench.c

> Fix all 'make check' warnings in hackbench.c to comply with the LTP
> coding style guidelines.

Could the remaining hackbench.c warnings be fixed, or could the subject and
body clarify that this patch only addresses checkpatch style findings?

The configured targeted `make check` still reports a signed/unsigned
comparison in sender(), an implicit fallthrough in create_worker(), and an
uninitialized byte passed to write() in ready().

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
