Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A1CA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 11:16:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B4ED3E5830
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 13:16:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 750C53C2169
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:16:40 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19B76200AE5
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:16:40 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 46e09a7af769-81d53a6ca68so1269855a34.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790680598; x=1791285398; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wFAR4M91yE8YXo/DEoINDT+VTLfT5h7sRRP+6W0D6hA=;
 b=bW8FVtNYZbm+XRDiwA1sdc0haQWwpH2x1Bn0Utll4OfJUBQmNGt+bLfRJRKNVVY8EB
 xrvJur0YJKBueCngAjQyftZMCci891wUZzhZzqgS88mTEa/vNS9sK8XaXisuv8fSjliW
 mXEaFLqoApLDOXJjPlK3dJtE5dGXGfosPKah0MYSM56wzUG8e9xm86MUSrrhkJpsdsOq
 qt7NyElp567Q/TDNbLz40hbyB6WN9unj3zYvGgMPswkNlPb5QdEWl9D1NsixKAR8xBg9
 eVdpTEk+zVV/Qo8x+9vX2hsftAp0jluLY1+3PeHYjFrPJqkn7u2M5u3dvaW0jSyrspuY
 p5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790680598; x=1791285398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wFAR4M91yE8YXo/DEoINDT+VTLfT5h7sRRP+6W0D6hA=;
 b=Q1HugKy7VwqYoYVQvJY9OXyuArrknKQIJCIsOWILJz7Sl3BPpXa1/z29g4YXq01Hrm
 XPPDfwiOdtT32Kne918yU8PSIYleLR/Tp09nP014kctzpSvhIHdL5sMbZFv7yp5mrbpp
 hq7wWVFrryxdFKGAAps5ItMrb60ptz2dNkG8Kr7q1GPZIqoBpa3z7GrwHJrLJzqn59ur
 t3Wf/TLjo5nA8ZowS0hA46fUpN5xnzyaOrXSt9N3WD6IGRmolaCO4zcTQEtxL0qrhte9
 3qQLqD2ZmYMWXKZ61BwVVyMZ3be9MrT+ymjWWNTY30elVD2I2KqOA9l31s2HwLM8b+x4
 ig3g==
X-Gm-Message-State: AFuF++kGM4etPl+98yuQqiegXCDPrv6AP9raUNAbXWYxg3mk99utlUcZ
 fcxykGw2MJRMpeqBrR4fhWCxjtchpURMPgKKbosbp0nRVt/sFsbYZQYA
X-Gm-Gg: AYBFou0XGsRQ4uoWPn0JJTyM3cMsvqEFkFZwLVeqBNpOQhhfeaJvK0I50FbQYMoOLkg
 Y0D6V/9/JvKlAWdRvDMSEEzEPUNwpAHRH5u850DtxJbe8LnTHhsdQUiZLxOmd7XJ+PRTTL28x24
 TcrvfRGC4LX/gNUAgLa8355o8Jopo1Z6PFJNrpj5TFlgV/XvdTh+gjSan9DBq+aUBrkgeQYP5qZ
 P4SR3apJuv3mlx1mfMi7ZUaqkz0pNBFjjhp6A0l974jh9nCOjgoAAw+2Jllgh5jBuFwQO8oFh7J
 lU2ZwxrzC2kDgf+K7bo8ki2NEi71D6MqnYArDKIii6cKl+lJ30NvNIPd21oDEpmDfTtaq+/w90m
 13SV4y6nuWmjlzRWpR1Mtk+3WI646BV+8PvCccm/ZriGw9HhXmyCNf111NdKbgaIwMTBlmM116a
 T92kNaR5xDi+Gbeu+dGw7/TjIZMaMkTNj7pplIY0J9mtMweDS5pa+Ko4qYn0GxWiW6yCnHnAY0f
 43uK+t/BoZMU+Zo2aECheUqyiB6QZk4LTlTgcVP6AySa1BCEftys9Kghm++lgFkVt7fBqXHwGF0
 rqw3GtjiQl/6
X-Received: by 2002:a05:6820:83da:20b0:6d7:7979:bbb0 with SMTP id
 006d021491bc7-6d77979c189mr4883394eaf.35.1790680598313; 
 Tue, 29 Sep 2026 04:16:38 -0700 (PDT)
Received: from
 runnervmtr4k5.abxiezd4qetevpp3zp2jhejobg.ex.internal.cloudapp.net
 ([172.183.149.68]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d58a044a4sm3934715a34.17.2026.09.29.04.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 04:16:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 29 Sep 2026 11:16:36 +0000
Message-ID: <20260929111636.7777-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929084253.3093742-1-anders.roxell@linaro.org>
References: <20260929084253.3093742-1-anders.roxell@linaro.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_clone: Fix child detection on sparc
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

Hi Anders,

On Tue Sep 29 10:42:53 2026 +0200, Anders Roxell wrote:
> tst_clone: Fix child detection on sparc

> @@ -20,6 +20,9 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>  	};
>  	int flags;
>  	pid_t pid = -1;
> +#ifdef __sparc__
> +	pid_t parent_pid = tst_getpid();
> +#endif

On SPARC, clone3 already returns 0 in the child, making this call redundant
when clone3 succeeds; move it into the clone fallback path right before
syscall(__NR_clone, ...). Additionally, the SPARC kernel returns the
caller's TID (current->pid) in %o0 to the child, so use tst_gettid()
instead of tst_getpid() to support multithreaded callers.

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
