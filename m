Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E84DC5AD5A
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 19:37:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47DA03C93DF
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 21:37:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 974D33C5EC1
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 21:37:12 +0200 (CEST)
Received: from mail-yx2-x04.google.com (mail-yx2-x04.google.com
 [IPv6:2607:f8b0:4864:41::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2E544200148
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 21:37:12 +0200 (CEST)
Received: by mail-yx2-x04.google.com with SMTP id
 956f58d0204a3-66addc3f4eeso1237774d50.0
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786304231; x=1786909031; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knA+rkwtM74pw5B1hRTz2iEeDbHCvlzTz9BuxkIFi8k=;
 b=oi5G8x4kbCxBKh9O4w5QnL6MTLdHmHrEGfEu7ZhKeYrBvVHnf64O6I5RsOBo9gReBq
 HHyFAG5e/JEmJLzbrC3ZzN7ndQ3AMDdSwIwNv2pvpPhDaf0Rx0qUqXm+sxNGqpZXYXrH
 H71+ycgQX7uGpPTD0YVoy0FnavEj3zAh8oqDlZEmB0nR/MUCgFzHRqakUqh/STuQKzJZ
 UBSIm4SR6YX/ASVbFd+BsQ4c/H7y9ALnwFk5kCaqFnzBfhlG7XWPPNAxIhNlGRh+tUHB
 hE/gF3QiImND0zYM6OVw+I6bMlPqBi8Ua6NaQnuu5C9EoFcgorJmXU6OSXjPuuBm6O9Y
 VU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786304231; x=1786909031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=knA+rkwtM74pw5B1hRTz2iEeDbHCvlzTz9BuxkIFi8k=;
 b=Yx14Sde7Qkz55QQfJMOcRKuyasZ8UiVKTI1LfjfH74QyrCYt2RdWnQ62YXmmzn4XhK
 AWdVLyuPNu1REvgeTJjBu0Epb2BkBsH8vq+9rvEM3SF+Cda5X8ryQtTkwqREQzY1UwCl
 KfpEKQOhQM9gXLhIhqdeioQAI+bcbRA0d/E/8a9/MykwuPu05S6f54DMUAqL1i+Ilyzy
 pcI41wHuMA2Y9Po0UlBT/AWyJRE7foR+kbNRn6Zg3puz992z31DB2YNF9eTCFHbkRS0k
 fhgT/uCPFK/8o8qHU7+WLf7mCMXdvScLF06+o11CIDbGBWotIdXeYBfBYcUqtmY8lpy6
 fbsw==
X-Gm-Message-State: AOJu0Yy0kRZ6hua6aIMsvHhuphH2CpiKykGxaOMATRJ1njmhqYh/9ZSw
 W8Ut9wRUzQ8XbQX7ZVpuHZV55X9FiyLJ/xVKlxEcyDujkz7wtVo7Sx9T
X-Gm-Gg: AR+sD11zUoBFDAJiWlUZ5hZyTZvK/1Pcqi/IJrjfau34XmzagLSf19MIdr1/qJ4DPQR
 XqqetrA1wvvnhkFSplpCQNSfy1Q7SOidBHuhd4ieSf7gP2gkn5dPAU071o40CPXtK5dEWdIcMLH
 kQ3IZkAVKYD1ldOCimGjKtHLgAOenXkC3EV2D14fPibUIZk8H/hJUvt5D03GpooDf5lrfZGxNC9
 LswSYyk7OKLaS7l6V+hm7T9UzgymZZUQAg291USxWB0yyg8HIoF772V7d0IjDbyO5wx2JA95QG5
 7iUYPmhoeFfEdzjcasFmCnCNAgXjeADjb4xXl+US52/hfPVCwgFCj4cankx4NHeJSx4s+L/qdAm
 NvoKZCXpr3Tqt96vwH58wTNYDLUxtDmQhBTSoTWu9vP5kEsbNutfBOfbjoXc2GMzDCu7ZRt9ije
 DzWof/Sk3Y0TFTE9wrXHxCfue0B8G4WdLRyZJ6uajzZHl2vk42haQw7Xald1hIYDGWz4WusRFFn
 L3APISYRnS/sWvBWFKgXSQNW8ClJuiW6LKdl+XB0VHxno1JOhGm71HbhJZZ8AfiFywcQMn+3aKt
 bSM=
X-Received: by 2002:a05:690e:4396:b0:660:4936:95d5 with SMTP id
 956f58d0204a3-66ad7355326mr6959044d50.40.1786304230904; 
 Sun, 09 Aug 2026 12:37:10 -0700 (PDT)
Received: from
 runnervmvrwv9.sbo4f4120sjejcpudlippbucbf.ex.internal.cloudapp.net
 ([135.232.208.138]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acad24d53sm5024399d50.6.2026.08.09.12.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 12:37:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  9 Aug 2026 19:37:08 +0000
Message-ID: <20260809193709.9093-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809185027.1867585-1-pavrampu@linux.ibm.com>
References: <20260809185027.1867585-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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

Hi Pavithra,

On Mon, 10 Aug 2026, Pavithra wrote:
> hugemmap/hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

> +	SAFE_PTRACE(PTRACE_ATTACH, cpid, NULL, NULL);

Could PTRACE_ATTACH be handled without SAFE_PTRACE() so that EPERM caused
by Yama policy can be reported as TCONF? With ptrace_scope=3 Linux denies
every attach, including requests from root, and the wrapper converts this
expected policy denial to TBROK before the test reaches PTRACE_POKEDATA.

> +/hugetlb/hugemmap/hugemmap41

Could this entry instead be placed in a .gitignore in the hugemmap leaf
directory? LTP requires new test binaries to be ignored in their own test
directory rather than from a parent directory.

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
