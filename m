Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8B9CD4F44
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:46:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 444FE3CDE66
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 11:46:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B9833CA0FF
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 11:46:22 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10AE6204737
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 11:46:21 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40535597f01so16707565e9.3
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695375980; x=1695980780; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=mUA/mCVKETHVeKPilnMQwh1npNRNUxijAiM43LdtxFw=;
 b=IVIZjfWRWm3RZjKuvCT9Dh09104M4/9UX+gJqo031VpYW/YMeosmQ1YYsrshcVNe7M
 dcGVgMbTMESHPEB0QGmXklucjq9E/ZtK88W4OSYNsNMgNXY/NQakDkq+WVsqlRqZ/eAt
 kMdKLOHdHHhw7Nc8l6X017c+0VYH68AWscVkXDKiCBvk5Z6cmza7YZ68Hl10rm1dOaz5
 cKMHG+3FJDQ7aOrROB442M4onoS8F74iY20dbiNaGIf9eOT4v2TXRjMxbqwpseJm/JHg
 5fCWGVIqjlbaGu9KFzPlxkSsRZo+jQpyV6PDJ5KsqQ9Hebhw8jxq+douIRPxHSEPiEkg
 bjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375980; x=1695980780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUA/mCVKETHVeKPilnMQwh1npNRNUxijAiM43LdtxFw=;
 b=UOjJI86SYR6I+kYsxQOBomxFmoO/uD2pSCEOn6ATqqX0o3//9vCGEmmoZYzkrPz4yy
 faHWkyFkvrMTINQ1vtn/k/WhIOdgw/VHX09wplWtt2xivpt4H0E72Cfi6QfM9XklISHL
 kSO2MBBTXQHL4H+0zqpMSj7/9OEoS7I5+yn4KUrbSxg1WRC3vWFuXKeE0MtwBV54a7xH
 65HxEoRECS25/ltcRwAW64xLMeIFmpvl9eweOtTLj3hTkg71yHNtiGGvgaG6GhyM7mz/
 tUwam3XdKgn4BJP0lWe/aLowwnbF9zRSZUr4cajM+DhvKnIJlGyYL2ZbdfJ3cPBaDQz6
 i4XQ==
X-Gm-Message-State: AOJu0Yw7sc28x8glGbtKTF8C8tMX6fWqUY97WZjl50pSWzye7aIYRgZZ
 EGWhOeSyT+jQkN9kgzf4V0U=
X-Google-Smtp-Source: AGHT+IHC/lkFQ5wP8FgrtEHxdTFGpcGfLQxRq3yofp9mRyN/G33P5JRbEFkIhPDYYUj1v503ZbgOfA==
X-Received: by 2002:a1c:6a04:0:b0:405:1baf:cedd with SMTP id
 f4-20020a1c6a04000000b004051bafceddmr6772220wmc.1.1695375980270; 
 Fri, 22 Sep 2023 02:46:20 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a1c7507000000b004051f8d6207sm4207822wmc.6.2023.09.22.02.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:46:19 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:46:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZQ1iabFEs93OZMSE@gmail.com>
References: <20230901154355.5351-1-chrubis@suse.cz>
 <20230901174529.GB364687@pevik> <ZPIqsmTbJh7z-LcO@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZPIqsmTbJh7z-LcO@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/rt: Disallow writing invalid values to
 sched_rt_period_us
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
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


* Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
> > (INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
> > even INT_MAX would pass the check. I suppose we can do nothing about that,
> > because there is no value in sysctl_vals[] which would represent INT_MAX - 1.
> > 
> > And you specify in LTP test range: from -1 to INT_MAX.
> > 
> > But even much shorter value than INT_MAX fails:
> > 
> > $ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
> > sh: echo: write error: Invalid argument
> 
> That is because runtime_us must be < period_us by definition, since
> runtime_us defines how much time is allocated from the period_us. I
> guess that this is not described good enough in the kernel docs.

Mind adding a second patch to your series, clarifying 
Documentation/scheduler/sched-rt-group.rst?

Thanks,

	Ingo

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
