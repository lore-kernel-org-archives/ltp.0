Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6317C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DC033D865A
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 15:58:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 776EA3D0F40
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 15:58:27 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 632FA20004B
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 15:58:27 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-52f837d0456so4388561cf.0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787839106; x=1788443906; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2THyhUybyd4lMwvKc41KlMBoza8YXm5hphvPH0NobCk=;
 b=qejDWzJsYvKk0P+VXjEEz1RCYzqpPdNYFFbKPjdYGzsGpqXQ2mGOZ37+8xThqIWyeE
 HAqJBD6cRQYibBrrU3M/XzBHGRHdYOm2HVWjOXkg5XkvpkNAq85olsNIebJLeO2hDWpy
 IT47tq8eSnz2huNTA1QtorDJNkSIS3b9U4AFYblIrhsTqmzveGRiuKwXT2i8SWw4ySn7
 RVwFReVsIkg0wrLd0VBKBUoLtOOcntIBMkxMMvopd823UORAdaLrVjpnug1kf3LtuJPf
 8KUPr344YmWwCB0T2Xuh6qcK6AQ7ChJwwc6Z/fKA+Gc9D348RMu69qkKrC4gbtAbF7zJ
 Q9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839106; x=1788443906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2THyhUybyd4lMwvKc41KlMBoza8YXm5hphvPH0NobCk=;
 b=gxRl+k5dP3SKrPvKJKtBwEFnLijYPQ+Fm5qSanwMClWQyPbjEw0ITj+6YrDlhat9oq
 Oq9NNpulcl2aOrGqSImwWVKZQoSW6zDnq6PPArB8erQUoPdC7+hEHnzgMo9qVHKfGqYA
 Y5hVmwQ9m/HSZQtZ6/eAqDEVq0yO6qaZ6m9IWkmS464cNk1eJZ1LXnfSxEOFvIdXlHwz
 RkyEYx6oQR3wcn4Eag9g/MBf4Dx+2MC4uXeeeUXNtpO1SlSTKtTxgkUYnn1xYYZ7TnKw
 zlHnKCohUqfTu2kNA7xyoiCCmCtT1mKzhbl2uXW4Fl9UgnmChtOs+lLLOsiV8igVYfIu
 tDPw==
X-Gm-Message-State: AFuF++lIxmw2OCQTi5ChV8wYDmhZBnp6ExAIpAOKCyU6is201HftRP91
 7Y5ICYWpBW9dPL27+HDcSe+W6TdG74kKg6zd0zikopmTMoe07S6nk70x
X-Gm-Gg: AR+sD13QA36HzP9EZ8YGTiVW5LrIbz9HYV0VbI4OZOcPujOV+/C13aWF/SEyYwZt4OY
 O7KIeH44KcfmCAAJB0o490BveG2fbw3McAPykkt4smTaRFVnjD5HRk3vKxYGOjALeAaUBwmNnfW
 7/kn/+6WItINzt5pr5ZneOjWiAvebg7amRE86uK5Uk3ZzutIBE1XXc9f7ozK+5itrNT6RntXOXF
 uRn49RdrrjaXYuRnGCsL9kT6gnNHVxd+YnjdiINAZ3ysD426/nboN7rmZYL/w12+qy1IaD95cn9
 kZF0ytxiLr4abcSFe0QLzKf37n015iyR6fdKaM4NVeZkozRkPYnI3FY0HtxvA4ijxAG3QiJQlne
 YYURuIsME/S3nDVmxQF+XmawK4fH4JJScn9D2DAJCz23mZV6K4bUgTwKf9qI6aFc/uk1AUyFoCh
 6U425qKklOnW6Ptivk+EmRoSCL2jTcu//6IrAkS44f9vXeJPYMt0FYvJ1gF99T9MeqerSGvA47o
 6JUlWq4nlV1Wb80ZpTUFogviPXwQNfD7d99IyrTziRpUsNZ7c41vYDtFzvAmzp/XZsIp4JLDdNA
X-Received: by 2002:a05:622a:1248:b0:52e:39c7:b75a with SMTP id
 d75a77b69052e-52e4237acb4mr186164091cf.24.1787839105917; 
 Thu, 27 Aug 2026 06:58:25 -0700 (PDT)
Received: from
 runnervmgx7h7.dqphzwasu1dulfyg11icnuwebg.bx.internal.cloudapp.net
 ([20.115.103.86]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4270a6ecsm37571681cf.17.2026.08.27.06.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 06:58:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 13:58:24 +0000
Message-ID: <20260827135825.9152-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827-swapon_discard_coverage-v1-1-633bcb11c181@suse.com>
References: <20260827-swapon_discard_coverage-v1-1-633bcb11c181@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback definitions for swapon syscall
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

Hi Andrea,

On Aug 27, 2026, Andrea Cervesato wrote:
> lapi: fallback definitions for swapon syscall

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
