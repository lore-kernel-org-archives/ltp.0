Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C344F99373
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:18:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74E083E2D7D
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 13:18:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF7913E1D62
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 13:17:57 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 682BE10005A1
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 13:17:57 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8ef2118b478so260566385a.0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776943076; x=1777547876; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJq9RvRYQFQstzUUDiBwFNtPWgUKQmy4JSm4bE9wnwk=;
 b=nKebazML5YBX1rmNv7ylkvIH31TLYu0u1hK0V7zS30dC7qAyF9fdGVPwgkUH/JbMfZ
 Fjmzzavt1mUCxbcJlwN8vn4k+V5Uk2Y4SX0qFXNsSGwirZy9YWHbeHvN4QhUl02FHP45
 asYNgS2enNhvurPBzgygJIe1+ZV1I/6faI0DGmU8Vm3kATaQEnfVUPnxUE6kQMfqlf+f
 1fVV1MFDqc8FTQGSnxsQLlwqPvAQLWX4aNQ3pJ75brPdr285ySA2P8SWrpUo5rSQf7+P
 HkLoFfItYm7hLWyJSpeEUTliCuRxVlY9tWgsH97tC2N4qLzD5d8IDCOku7B/1eFnGCE4
 4YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776943076; x=1777547876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dJq9RvRYQFQstzUUDiBwFNtPWgUKQmy4JSm4bE9wnwk=;
 b=F4MZic4z4oPeNCV5AzxAj6Uu5WUwFhHyVFT9iqHNDTDExluKCiOP7zvCSTPj2CKHKN
 PTWNZq8JYItM4KeGgoAu+U92VZwDoneN4HyGEntFJEbZoYFM4QtpC+Q9SLO3vjf0vrt5
 6vUxh12nL4yyt8NJB9ksPKNVuIRo9UECBhqoZy3/IuXQDGtWOsKbyuQaYALg63BS1VyV
 OWs1SDl77ZQlz+/3Nqq4co9SpZUNqDTZl3GeDErCsQ4qdUH5i1Amg+WMMGV28B8pity3
 YBVlNtixdmkivBrrj9U+1MUhHYUYDn321uKHiJMjnX6U6C1sQCa2vTs2xn+sABvFMEHS
 3WTg==
X-Gm-Message-State: AOJu0Yw6muRaoYJi6bsRr/7Ne1IHYvMSqxMwowpyPDgZ6gHxYcYD5Xo6
 fIC9EUZMyudYLAfN/dy+uuERXxmjIUsoRV2Dj7uh8DWWGgZuhkCLuyGyLdRqARqzWV4VcQ==
X-Gm-Gg: AeBDietO7SqLv/UwaAN8zl+d+NYeomkp/v2LQcanUdtgnDdDf4TL+w0S3MbuIjtXnFG
 XPynoa+ewxAn/pJykTFpd/GogPRLOlZrufozqjs4BAOTpbOhKm86CpD6Y6FmpBAtw0wKJW66unE
 obIcwfynxG/I9gwjYtLn891DB5wPqiUgzkIO1Y1s+rcy1WkOFaE+9ODZ0+6QbinXTT/iuXzJM61
 1a6ubpBwBUiNhBFVhXzBZ4At9PAbW1z+bVdQWTzZPRtglLSDUc7lcBGVwnAYxVD8XDvAGCGFt6O
 QMa0UXj1tprcxtC+ug0n3SfGHQqUFcEM9YCIN0tIV78y9pLdcmTk7bu9dFjG8B6I3BfC0umWLxg
 zI4SOK6kJVJrlg/tU2YIOpmZF8M53CF7nFXyp3OeU1gr4LbzlAB5AKayouQgXgSAhe/6LZUUnUA
 GuxQf8GPcE7CQnGD/izT4bjgY2Kvs46M1TVEmfdxpE8meERkM2uwu0POGDyyRlfHvSqRorgm3qg
 nwBGSZk0A7NolPv26mmeg3FVsDecm2Vf+ztMu2Kr/AO5Za0xg==
X-Received: by 2002:a05:620a:8d04:b0:8eb:f3c7:2246 with SMTP id
 af79cd13be357-8ebf413733emr1501334285a.35.1776943076160; 
 Thu, 23 Apr 2026 04:17:56 -0700 (PDT)
Received: from
 runnervmeorf1.ajpjuzvd0pcu5m1ughqrvmkcxa.bx.internal.cloudapp.net
 ([74.235.126.84]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d9abce59sm1881457385a.46.2026.04.23.04.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 04:17:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Apr 2026 11:17:55 +0000
Message-ID: <20260423111755.4154-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423095834.11932-2-chrubis@suse.cz>
References: <20260423095834.11932-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_create03
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

Hi Cyril,

--- [PATCH 3/8] ---

On 2026-04-23, Cyril Hrubis wrote:
> syscalls: Add epoll_wait09

> -epoll_wait08 epoll_wait08
> +epoll_wait09 epoll_wait09

This replaces the epoll_wait08 entry instead of adding epoll_wait09
alongside it. epoll_wait08 will be built but never run.

> That checks that events from recursive epoll are propagated correctly.

"That checks..." is a dangling clause; the body must stand alone as a
sentence (e.g. "Test that checks...").

--- [PATCH 5/8] ---

On 2026-04-23, Cyril Hrubis wrote:
> syscall: Add epoll_wait10

Prefix typo: "syscall:" should be "syscalls:" (all other patches in
this series use "syscalls:").

--- [PATCH 6/8] ---

On 2026-04-23, Cyril Hrubis wrote:
> syscalls: Add epoll_wait11
>
> A test that chcecks that EPOLLHUP is generated properly [...]

Typo: "chcecks" -> "checks".

> +	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
> +	SAFE_CLOSE(fds[1]);
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_CLOSE(efd);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fds[1] > 0)
> +		SAFE_CLOSE(fds[1]);

fds[] and efd are closed in run() but not reset to -1; cleanup() then
double-closes them on every run (TBROK). Reset each to -1 after
SAFE_CLOSE in run(), and use != -1 guards in cleanup() per LTP
convention.

--- [PATCH 7/8] ---

On 2026-04-23, Cyril Hrubis wrote:
> +	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_CLOSE(fds[1]);
> +	SAFE_CLOSE(efd);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fds[1] > 0)
> +		SAFE_CLOSE(fds[1]);

Same double-close defect as epoll_wait11; apply the same fix.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24831850683

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
