Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3726CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DA343EAA88
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:50:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6C623EA9D2
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:50:06 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37D14200AC8
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:50:06 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 d75a77b69052e-533257d7704so7790371cf.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704205; x=1791309005; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xz/SRoAiN0CSxHorsafxQEg227V7Mr9427a7MFL0FnA=;
 b=XCzpC0mV86p/Hvvq2JkSizwtMrR11jp9LTI0KpRtMcE6zK2xw7hBDLD+4toIOSJgqd
 ollP9PUAwp8sdFICWFJUUyxRaSVi4PsAjsOb8qogB5L/Ut+O2C7AlFNUS8qpX3zL/pFE
 zHl7qCghVGTaIdVTU9J48sC4PM5wReIuUQrKZNhf9AZm6b5uHhXN/U3tPRxMIMm4P23s
 XWFWCcqpkJGOWQF9efV2jhXH/DNzc7J8Clbd0agd2UZq/ZuTXLsJkI2a+42+KrP8RZjM
 hLvIESSIxL4LzTM5cJbA9rM4ljsq71qYN7xq+tVwHXzv+U/uck5xktOSrhDotFI7UZF6
 /ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704205; x=1791309005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xz/SRoAiN0CSxHorsafxQEg227V7Mr9427a7MFL0FnA=;
 b=MsYZiVXK8pYTw3OFprcNlTroNhtDbRhtolvLernj+R7PDmRabewA+E0mvoOZf2Fe0z
 McWBQd+IPXLob0VpdajiCQxnwy25G+FOkq+mNXtkJjc7arSSBEKUremcai4sN5NPlLH/
 3mXu06utKNlr60C/inChlWtENASwoemwlXSDd9DZ/upxGufJr/RWC2oqvoAerdalotAq
 isJmhHyYFLFq0kmhQJEtA7gLOeL2g8rC6vKwlykTSV8Mo6CaYYlwqpTR2Dl8hTcdLiuI
 dcsA+sJKutQLhC6WmGCbq62HJjU4DdIyQU+t26zdYGahShFpjv7nli+PRgJ9a2j5q8pN
 xL3w==
X-Gm-Message-State: AFuF++kdqV2IDQ8noWhaFIIzJCdEA8Z194zPOQSemZxIBCpU1SlUIIB+
 4GNwR/SrfXmKtOge1/8QJ1ozSdHzLHhsQ8iFnriexLuOHd58hPAKdvmB
X-Gm-Gg: AYBFou0cF/nX2kUbX+dqln/IwoSYjmMaRj7obC2G1OUlWEdvBXhNSwgteq0ZrUOz2ox
 sB9Hq9vNqoIXeLzmjw5CDe+2ho5XKN4u5ZeHyfS/irffCzXX5IcEzz3dYalb/Zzo8fuiMwBxxEK
 n7iAcR3HNx//LTBzNSm5h0uKgvUWpl+lD5JupXIgC0FzZLM0S4bGEfhWwto6iByCDG6Vi8tkQm9
 GBF2Ta+t3uuWbsBRtITkaiijvjjTPnpAH745kFJKI+YLjZcEBHyysWOg3iEZBXodqhOFhDzMfBe
 lQbVrw4LfNqSPch3/etnloJcP7ggmNRjRAc0Q7jNsKBJ2HRlang8yS96S3YW7fmpGcW+foh80Lf
 i/LQOkPXsignCSyddStfe2kH2FKNX5iZCkq6F6CUge7TEt1dMDB0hS+SEbeKmnd8JVFXFEMdJ68
 ah3zTHxHxc3ThJwN4Nmu6w1BZK10KwdnqYotUkBAfLVbpJjdCZoFK8V517KM/Ik5qbUX4MT0/Yb
 c94vTtYyeMUI5C4iRSyOiCJ3SkYJ563TpaJWMfFFzkV7NOlq8eK0Trg8JpLAdzyHXtEihP1dzDo
 Ojr9mZWFT9rx
X-Received: by 2002:a05:622a:c8:b0:532:abc9:8f4f with SMTP id
 d75a77b69052e-5330b67d3e7mr302499241cf.37.1790704204787; 
 Tue, 29 Sep 2026 10:50:04 -0700 (PDT)
Received: from
 runnervmtr4k5.gvdpdkbpqlwevgifsipgujp5cd.bx.internal.cloudapp.net
 ([172.174.190.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53369c10a76sm697721cf.27.2026.09.29.10.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:50:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 29 Sep 2026 17:50:03 +0000
Message-ID: <20260929175003.34880-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929124756.836342-1-avinesh.kumar@suse.com>
References: <20260929124756.836342-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Handle SIGSEGV on old
 glibc
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

Hi Avinesh,

On Tue Sep 29 14:47:54 2026 +0200, Avinesh Kumar wrote:
> openposix: timer_*/speculative: Handle SIGSEGV on old glibc

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> index dce9277b5..c7a94e144 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
> @@ -13,13 +13,31 @@
>  #include <time.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include "posixtest.h"
>  
>  #define BOGUSTIMERID 99999
>  
> +/*
> + * timerid is not a valid timer ID; POSIX defines no required behavior
> + * here (EINVAL is only a recommendation), so SIGSEGV is an equally
> + * valid outcome.
> + */
> +static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
> +{
> +	PTS_WRITE_MSG("Got SIGSEGV when calling timer_delete() with an invalid timer ID\n");
> +	PTS_WRITE_MSG("Test PASSED\n");
> +	_exit(PTS_PASS);
> +}
> +
>  int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>  {
>  	timer_t tid = (timer_t)BOGUSTIMERID;
> +	struct sigaction sa = { .sa_handler = sigsegv_handler };
> +
> +	sigfillset(&sa.sa_mask);
> +	sigaction(SIGSEGV, &sa, NULL);

Catching SIGSEGV and exiting with PTS_PASS circumvents the check for
errno=EINVAL and masks faults instead of verifying the interface. Use
"static int tval = BOGUSTIMERID; timer_t tid = (timer_t)&tval;" without a
signal handler instead; this provides a readable pointer for older glibc
(<= 2.31) while keeping the MSB clear so glibc >= 2.34 and musl do not
treat it as a SIGEV_THREAD timer.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
> index 3a8f1448d..7861e99d4 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
> @@ -13,13 +13,31 @@
>  #include <time.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include "posixtest.h"
>  
>  #define BOGUSTID 9999
>  
> +/*
> + * timerid is not a valid timer ID; POSIX defines no required behavior
> + * here (EINVAL is only a recommendation), so SIGSEGV is an equally
> + * valid outcome.
> + */
> +static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
> +{
> +	PTS_WRITE_MSG("Got SIGSEGV when calling timer_getoverrun() with an invalid timer ID\n");
> +	PTS_WRITE_MSG("Test PASSED\n");
> +	_exit(PTS_PASS);
> +}
> +
>  int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>  {
>  	timer_t tid = (timer_t)BOGUSTID;
> +	struct sigaction sa = { .sa_handler = sigsegv_handler };
> +
> +	sigfillset(&sa.sa_mask);
> +	sigaction(SIGSEGV, &sa, NULL);

Same issue here; pass a pointer to a static int variable instead of
handling SIGSEGV.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
> index 586b0ed3a..a3a9e080e 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
> @@ -13,14 +13,32 @@
>  #include <time.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include "posixtest.h"
>  
>  #define BOGUSTID 9999
>  
> +/*
> + * timerid is not a valid timer ID; POSIX defines no required behavior
> + * here (EINVAL is only a recommendation), so SIGSEGV is an equally
> + * valid outcome.
> + */
> +static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
> +{
> +	PTS_WRITE_MSG("Got SIGSEGV when calling timer_gettime() with an invalid timer ID\n");
> +	PTS_WRITE_MSG("Test PASSED\n");
> +	_exit(PTS_PASS);
> +}
> +
>  int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>  {
>  	struct itimerspec its;
>  	timer_t tid = (timer_t)BOGUSTID;
> +	struct sigaction sa = { .sa_handler = sigsegv_handler };
> +
> +	sigfillset(&sa.sa_mask);
> +	sigaction(SIGSEGV, &sa, NULL);

Same issue here; pass a pointer to a static int variable instead of
handling SIGSEGV.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
> index ac7f7bf24..953d585b8 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
> @@ -12,14 +12,33 @@
>  #include <time.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <signal.h>
> +#include <unistd.h>
>  #include "posixtest.h"
>  
>  #define BOGUSTID 9999
>  
> +/*
> + * timerid is not a valid timer ID; POSIX defines no required behavior
> + * here (EINVAL is only a recommendation), so SIGSEGV is an equally
> + * valid outcome.
> + */
> +static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
> +{
> +	PTS_WRITE_MSG("Got SIGSEGV when calling timer_settime() with an invalid timer ID\n");
> +	PTS_WRITE_MSG("Test PASSED\n");
> +	_exit(PTS_PASS);
> +}
> +
>  int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>  {
>  	struct itimerspec its;
>  	timer_t tid = (timer_t)BOGUSTID;
> +	struct sigaction sa = { .sa_handler = sigsegv_handler };
> +
> +	sigfillset(&sa.sa_mask);
> +	sigaction(SIGSEGV, &sa, NULL);

Same issue here; pass a pointer to a static int variable instead of
handling SIGSEGV.

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
