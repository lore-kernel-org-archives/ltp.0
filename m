Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93B3E784B6
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 13:18:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43DE53CC01F
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 15:18:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28C893CBA34
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 15:17:51 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 772C46013D4
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 15:17:50 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-538575a38ffso1777037a12.1
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696252670; x=1696857470; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=KPqnJsqsKHIApUXBARSxKv3rNfiUrOevvN0MUpOGTZU=;
 b=nPN2UddK+2Bs93/1NxYViVXli/783Q2wDbAS5h+1B7tyzse6EA8NdO3QLKz6Z4OE8D
 QUdtfLwkewez/fwBnqU/vGJNXi5rqrxpZCYKTN00IZxmGTt2BoHMuGvCccpryMFC7eC+
 mn0M0HJQ1n+isa5GhHXOJ9g4IhrmmWLjNt5SVNUqvAP2Fzzooz0gCjejoXZzrHbURUR5
 WqtpIkF5MJENgK+IVtrKw3YHIrL+H/6mNk/pC9trv4glTJUA64Svdu+3FoO7mXg+J5lW
 hsEXMgQ/ZS4+6r17yO0avKJTufcwIgCDoNuQRmZzMrkv36szaqf3LQMR3aQNEitmFMJx
 o1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696252670; x=1696857470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPqnJsqsKHIApUXBARSxKv3rNfiUrOevvN0MUpOGTZU=;
 b=AdZJFYZyeMrcjKnJhSzaf5H15hFycaOqME8nMpSnSDNcfuj9ZRyiPUi0Kk9/u8uYzX
 Ty5bFZl5Ea21/7dam/LUMUwtHk7aRZpmTdT80XjTrWavIq+RV0TAWofv4InL6nhAgLg7
 BOPm6qzxdhTW6hrw/l7U0rF97Hj7VuUR1bRoWhIGNul8XfOF0lTAyaM/CyUSgykDltjx
 bZ9aJLWurVhdc15qz9Tbz1TvPVNpV2sF2g6A/k/458adG8cI7V/RiNGd3RXq5wzoc7i2
 rxjFhnraS6fkBIyAsUIvko2smZHH7c/ue/ddFXypmnYnckHPoOODirzAN0IuM+Eo5vZa
 9pvg==
X-Gm-Message-State: AOJu0YwrBRcFJllUPelhYAcDZUGykuAO53dyCgF1uArPel1CTG7Zc3Ul
 6e97GaHwziexDiYtsObVKcM=
X-Google-Smtp-Source: AGHT+IFhl411eyi7vPLUepzMCi+w9fjzkBCacaDfBy64uzt59M6kokx4CDuSnFWWTJcKYypgmf7iuw==
X-Received: by 2002:a17:907:77d9:b0:9ad:e669:ff30 with SMTP id
 kz25-20020a17090777d900b009ade669ff30mr10547957ejc.68.1696252669523; 
 Mon, 02 Oct 2023 06:17:49 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
 by smtp.gmail.com with ESMTPSA id
 lw3-20020a170906bcc300b009ade1a4f795sm16919304ejb.168.2023.10.02.06.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 06:17:48 -0700 (PDT)
Date: Mon, 2 Oct 2023 15:17:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZRrC+huyOi5Ow9s5@gmail.com>
References: <20231002115553.3007-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231002115553.3007-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/3] Fix sched-rt sysctl files & update docs
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
 Vincent Guittot <vincent.guittot@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


* Cyril Hrubis <chrubis@suse.cz> wrote:

> New in v3:
>  - Spelling fixes as requested by Ingo
>  - added third patch that replaces all cases of realtime with real-time
>    in the docs
> 
> Cyril Hrubis (3):
>   sched/rt: Disallow writing invalid values to sched_rt_period_us
>   docs: scheduler-rt: Clarify & fix sched_rt_* sysctl docs
>   docs: scheduler-rt: Use real-time instead of realtime
> 
>  Documentation/scheduler/sched-rt-group.rst | 40 ++++++++++++----------
>  kernel/sched/rt.c                          |  9 ++---
>  2 files changed, 26 insertions(+), 23 deletions(-)

Applied to tip:sched/core for a v6.7 merge, thanks!

	Ingo

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
