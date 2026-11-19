Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C83606A325
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/uYJi4z
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA4113EB2B0
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 22:03:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC0153E2217
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 22:03:15 +0100 (CET)
Received: from mail-qk2-x0a.google.com (mail-qk2-x0a.google.com
 [IPv6:2607:f8b0:4864:34::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A3451400E53
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 22:03:15 +0100 (CET)
Received: by mail-qk2-x0a.google.com with SMTP id
 af79cd13be357-930f59d1dc6so11129085a.1
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 13:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795122194; x=1795726994; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPnHxz2Rm4bLaTuNjJR25vQso7b7vm/hsrqznqX4A6o=;
 b=g/uYJi4zRO6gmWHB7OCpi4Iq0TxUGcv4rJGi2vsW5lzZxxCszJFirKgxAmxaJCWjQo
 ys8oo6jxWD9jWuRbuy3eBfbx3dUAn1/i0/Fe0Yv8c+jQDNwORc5UFq7sGtSmuZ29TxDZ
 1Bqxlc9E7TBv1V5kfMa/CVaHtJrEZoM0sfhUxf7B5LGToKJRSqX072iCKfKyN6RDyLQ2
 Ia45rgbSGToS8SUreXilD8Jgi/5nOYJX+Hp7iRJmkyKq+leK5R4avt9uhcGwqk1U0FNB
 JFJ25ZyrxK+phyo55UFaLXJCK/94I7usVDmpBOg5uR8Ky4AnrGvtK8strGfalvoPPMq2
 ZrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795122194; x=1795726994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QPnHxz2Rm4bLaTuNjJR25vQso7b7vm/hsrqznqX4A6o=;
 b=ZX0vLvXOVRJmYHQfQwDfTs7MGpqpvuRB/cUk2zA++gO0MvPt+60SZcVlkRnYwJbXgs
 jdJNTFUluLE9ytm1FcY9RcmbEHuMcv+oQ77UA9lPENx5mjRQ20OLURNiaDmFTYsoDrZ5
 SJ2Ci2pCPbf4iZkr4rNj3+vELEyPDnGKsAPzBLP/H8aOTY45eWcu79zuU0ctXc+bD3wf
 vTTW4CwKSbaQvZiWYBqL6H0OsLXn4ylUuvCeDib3gFjekIOT1BQpJ3ewYkS8JYFxIE+j
 1mSz/JJPCz3BqHPEFKw2ifARQa3WOK7nfL6ow3Lud2z+cXw7YGnkVn7k3nA5+ZGxAAx3
 kjxA==
X-Gm-Message-State: APuU4Z8KjvCqdJp1V0ABgV6dUQZmYmSFMFsgY1E2+bBNLEikGRxJokJF
 9uYLorXBRBC8Z8+sxTCuJtHp0zetYiQbQ5x+O7pWn08Pg5idBTcSM7kb
X-Gm-Gg: AYBFou3TWqLp7oe4F1leFcT7Q8BpF1NQOuv3Ken2SqAHRde064pxg0TgGgoJjMtFmZS
 ywSdVQseW5Z1BGPR63vND0bIP2hYU5SWk+ty2tbVSX43BDsf0v1HlKztVex+Lnx1ai05AtbW/Bo
 d9BVWPrVVcIb1Gzo4xf5gizPso8w4S+9iqOueYgp/3L/kbUb63T9JztF/ocF4KjZhCWJHfXwsGG
 0bUxgkkgucQcuNsVbpSfzPFXCO3QEGWc8aAHpZO9AXDTYprq78C+lU0tvRer2XxcT265BiQLprM
 6wwHIIMhmoPjDobXOrZoAQX8urLTLwPWfo54P4Y+8fSDojD2mwgcXSn2Z2nIYp9hl1tycD+9KAy
 Od0nNGoknytublz/rbqWi1APblkGd/uTl3/pIirEw8yHBRgsW/etcz3yT89ZJTe6WNwjZiryrBB
 lHut9L/psWw92glBumBX3YW4IicqLCw+O7WeBeC5kK2ltKAKHsccscK82cJhCDVS3EXk81iYiq0
 OgxD5mMrgI/WmhYZOOKi3k3L3vVLF6fwEGFsON0Te7nswYQXJz1wbaRZKgjB1h802YDBVHXoSaG
 QXJAUiMdOR+6s8J+kBEgYvyHjetEB8NLEcrfO1j/HsTd40frvi7MtBXLuCvnlCKTF2Q4rsddzBf
 Na+x8jfQCxi0S4Ut4fktXCOhk2k32tnCNVE5wB/Euck0=
X-Received: by 2002:a05:620a:2803:b0:943:f4a1:7bb9 with SMTP id
 af79cd13be357-949ba9555b7mr126397385a.18.1795122193751; 
 Thu, 19 Nov 2026 13:03:13 -0800 (PST)
Received: from
 runnervmccnms.gvdpdkbpqlwevgifsipgujp5cd.bx.internal.cloudapp.net
 ([172.174.190.73]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb031601sm51635785a.6.2026.11.19.13.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:03:13 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Thu, 19 Nov 2026 21:03:12 +0000
Message-ID: <20261119210312.3725-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119162504.2947034-1-chihsheng@google.com>
References: <20261119162504.2947034-1-chihsheng@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_block_queue01: Accept plain "none" in queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Darren,

On Thu, Nov 19, 2026 at 04:25:04PM +0000, Darren Chang wrote:
> sys_block_queue01: Accept plain "none" in queue/scheduler

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
