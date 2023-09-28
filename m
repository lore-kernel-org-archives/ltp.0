Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0B8CE7B10
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 09:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C2D33CDC00
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 11:19:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 268AB3C9944
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 11:18:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 735DC1000A10
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 11:18:58 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99de884ad25so1632968266b.3
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695892738; x=1696497538; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=f0I8AEvxud0N3U/mCzEd6vO0RsTxP2xVStL4mYXmgZI=;
 b=WPPvg+NqbQFZE8w7Hm164d7p/Jr/4IgDzRIT2RWV4QuOF8v3iDeX8CNetsyxX6dK6E
 Uz2+tPNEFqTScOlOk4apambb3SUcm5EvorT92rB7goA87rQeOygL0WyJaaCnhCt2FWN4
 lIwmddBNyh8Oqi2VO9LrxoXO4MGv21pHybERjON9wtGZtWq/FUVzJrKoIp6d387VXtZ2
 ixnrillIe/2swRgWbkSIUBv/CfoffK+m/wINHCIIeV1Z+7auL+zCe5lvMSpCGZU+ECY9
 GxpbaIH89usitboKuRJZVHDHz6+AG5+ibbtDHlFpuGVh/Gq46NmPx8dAhX+Nh7TMv1zI
 5V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695892738; x=1696497538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0I8AEvxud0N3U/mCzEd6vO0RsTxP2xVStL4mYXmgZI=;
 b=O0lWjXXCixBY1vbBlCnYzPcXYFmjsYGSdZyJaS2ox6qCOjIE61R1J080+z7T2/BZ95
 uzc9Z8a+i3Xx7RD2Z3Ko0Dxdc5/NZHBjsmrLt62BTLdtMiG/kPPzX5jNaQzbTL1dw9AQ
 nBZ74tcQhHi6AxKgE3w6wxKTvAQGFRtAwKvN/1952f6+poxRu7EBSkp17eUpJVLbv7At
 OcF+tv7Z3mAddqQDTT3RTqgegzy7NP4rhYpK9FNFnFfhlJoKFYUFGfLYlOJCw0c3rEk9
 /uUI/+0v47CnwI5u26wZVvo/alUWM7z35aq9ZBDw0a9qUXz65rm9ykvFuhAS1T9WYbLn
 0UnQ==
X-Gm-Message-State: AOJu0YyqEVkvs8KDyjnwx2ER+UkMI9khewwaJfPiWPu8HqEBwnBvRLHv
 mYm+YeY9x2sIfrMyXlBgEVM=
X-Google-Smtp-Source: AGHT+IFPh/r1TyxtRbkXEAXTdqs7ZV2buYWXt7RQCyLLk6tgfYiPozTfQSuBwY7Gjj099Namzn85Ng==
X-Received: by 2002:a17:906:73ca:b0:9af:159a:5113 with SMTP id
 n10-20020a17090673ca00b009af159a5113mr768221ejl.52.1695892737505; 
 Thu, 28 Sep 2023 02:18:57 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a1709067fc100b0099d804da2e9sm10600973ejs.225.2023.09.28.02.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 02:18:56 -0700 (PDT)
Date: Thu, 28 Sep 2023 11:18:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZRVE/nQlVi1woRPf@gmail.com>
References: <20230927103012.9587-1-chrubis@suse.cz>
 <20230927103012.9587-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230927103012.9587-3-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] docs: scheduler-rt: Clarify & fix
 sched_rt_* sysctl docs
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

> - Describe explicitly that sched_rt_runtime_us is allocated from
>   sched_rt_period_us and hence always less or equal to that value.

Just some spelling nits:

> - The limit for sched_rt_runtime_us is not INT_MAX - 1 but rather it's
>   limited by the value of sched_rt_period_us. If sched_rt_period_us is
>   INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

s/is not INT_MAX - 1 but rather it's
 /is not INT_MAX-1, but rather it's

>  /proc/sys/kernel/sched_rt_runtime_us:
> -  A global limit on how much time realtime scheduling may use.  Even without
> -  CONFIG_RT_GROUP_SCHED enabled, this will limit time reserved to realtime
> -  processes. With CONFIG_RT_GROUP_SCHED it signifies the total bandwidth
> -  available to all realtime groups.
> +  A global limit on how much time realtime scheduling may use. This is always

s/realtime
 /real-time

> +  less or equal than the period_us as it denotes the time allocated from the

s/than the period_us as it denotes
 /than the period_us, as it denotes

> +  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
> +  this will limit time reserved to realtime processes. With

s/realtime
 /real-time

> +  CONFIG_RT_GROUP_SCHED it signifies the total bandwidth available to all

s/CONFIG_RT_GROUP_SCHED
 /CONFIG_RT_GROUP_SCHED=y

> +  realtime groups.

s/realtime
 /real-time

Thanks,

	Ingo

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
