Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F73C433F5
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 11:12:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B413F3CA8BE
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 13:12:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D3173CA852
 for <ltp@lists.linux.it>; Thu,  5 May 2022 13:12:34 +0200 (CEST)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BEE8200074
 for <ltp@lists.linux.it>; Thu,  5 May 2022 13:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651749152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkeuNckzxF4U2XnDt586Oquxr92EDztr77hc08KlmFg=;
 b=W8PQJKOgeKFwTF6wr4uYi+Np9NuCUrEXLfSWE/K6ge6f/aXhIdydX7dU9giXByGzzmaNqe
 l8RObzab5hSlFiEdeQRydlw9C5G89SX9k59K8QvsDHauqrRE6RA562fzBij5tY/bW0OwdC
 avurrzmFMy9iMiXmUEYuzWiYThEPp7M=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-Ppy8OMI_NNW23dp6NHI7sA-1; Thu, 05 May 2022 07:12:30 -0400
X-MC-Unique: Ppy8OMI_NNW23dp6NHI7sA-1
Received: by mail-lj1-f198.google.com with SMTP id
 l26-20020a2e99da000000b0024f02d881cdso1310487ljj.6
 for <ltp@lists.linux.it>; Thu, 05 May 2022 04:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zkeuNckzxF4U2XnDt586Oquxr92EDztr77hc08KlmFg=;
 b=U2Jai2lRZt2baHwsEUUOsotPBXVl71mPXRAMhSGrxelCohFFGPn+XuJEdHKTvRj/0g
 60ZJedGULjG8kMsTBy/QLlqcOxdZdOVLwPJSbEVXWHROOA072HccGkyEGKAyDYg00R7i
 7ZfYnBnynZpIYIpzWro7ptvuufWwO1vd7unVl87Zq5KGxUT8AmPKt/FVxkeBHK1VDup0
 DH05/lBVU44AsCyRPwOjL2Q1zFionErbSMNzcvZAAD2WBjcraTFtOSihLvXIqLrlkekZ
 x8CeasoP58FqwF+NtKiAF1kfHAq6w7MdRSafRD5MQNKzG6TsI9pgEXkaslDnnZCoalEo
 RBGA==
X-Gm-Message-State: AOAM530R8WCwAREYz7BNtXu3el1r/V5wkBiZ6HhTpXV+BE7AgRTMsOA5
 bq5/LYDwMBaBIIGqWoJciuDPAP+IL3NM0Uky93afpRi9w4wIYF7he2Hr6NGwNIRvruOq3xS34up
 xm0EaeFugOtqjjyi6c9gNWUhFm3Y=
X-Received: by 2002:a2e:9583:0:b0:24f:482:e1cd with SMTP id
 w3-20020a2e9583000000b0024f0482e1cdmr15304570ljh.22.1651749149296; 
 Thu, 05 May 2022 04:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOYaJoRh0RIDOLIKwe83+bnAnKATrxrjONZ0Ijqa4GLnUmXxgu64lBEVOz+9YRNVd0qwgzdcSELhWd0uZR+Xc=
X-Received: by 2002:a2e:9583:0:b0:24f:482:e1cd with SMTP id
 w3-20020a2e9583000000b0024f0482e1cdmr15304552ljh.22.1651749149029; Thu, 05
 May 2022 04:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
In-Reply-To: <20220503174718.21205-2-chrubis@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 5 May 2022 13:12:13 +0200
Message-ID: <CAASaF6w3Eh1f6qBDpDR7QBLPjzVD24X4=yPyV4Xw4EB_5nQ6rg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/30] Introduce a concept of max runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, May 3, 2022 at 8:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This commit introduce a concept of per iteration max test runtime. In
> other words test runtime is capped at a certain value in order to make
> testruns more deterministic. Test is free to to finish before the
> runtime is used up, for example when maximal number of iterations
> was reached, but test must stop once the runtime has been used up.
>
> Testcases that run for more than a second or two must check for
> remaining runtime by regular calls to tst_remaining_runtime() and should
> exit when zero is returned.
>
> The test max runtime must be set either by the .max_iteration_runtime in
> the tst_test structure or in the test setup by a call to
> tst_set_runtime().
>
> The test timeout is then computed as a sum of DEFAULT_TIMEOUT (currently
> set to 30 seconds) and the test runtime. The DEFAULT_TIMEOUT is nothing
> more than a safety margin for teardown of the test.
>
> This commit also maps the -I parameter to the test max runtime if
> available and introduces LTP_RUNTIME_MUL enviroment variable so that we
> have an easy controll over the runtime cap.
>
> Lastly but not least the function related to the timeout are turned into
> no-op by this commit and removed after all test are converted to the
> runtime API.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/user-guide.txt                            |   4 +
>  include/tst_test.h                            |  27 ++++
>  lib/newlib_tests/.gitignore                   |   5 +-
>  lib/newlib_tests/test10.c                     |  22 ---
>  lib/newlib_tests/test12.c                     |  21 ---
>  lib/newlib_tests/test13.c                     |   1 -
>  lib/newlib_tests/test_children_cleanup.c      |   1 -
>  .../{test18.c => test_runtime01.c}            |  10 +-
>  lib/newlib_tests/test_runtime02.c             |  31 ++++
>  lib/tst_test.c                                | 151 ++++++++++++++----
>  10 files changed, 187 insertions(+), 86 deletions(-)
>  delete mode 100644 lib/newlib_tests/test10.c
>  delete mode 100644 lib/newlib_tests/test12.c
>  rename lib/newlib_tests/{test18.c => test_runtime01.c} (58%)
>  create mode 100644 lib/newlib_tests/test_runtime02.c
>
> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> index f41cbc733..d50d2e0cb 100644
> --- a/doc/user-guide.txt
> +++ b/doc/user-guide.txt
> @@ -25,6 +25,10 @@ For running LTP network tests see `testcases/network/README.md`.
>  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
>                            slow machines to avoid unexpected timeout).
>                            Variable is also used in shell tests, but ceiled to int.

Previously, setting LTP_TIMEOUT_MUL meant that test could run twice as long.
After patch, the description above could probably use more detail, to explain
what this variable will affect and what's the difference compared to
LTP_RUNTIME_MUL.

> +| 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
> +                          that run for more than a second or two are capped on
> +                         runtime. You can scale the default runtime both up
> +                         and down with this multiplier.
>  | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
>                            library. Setting it to empty string tell the library
>                            that system is not a virtual machine. Other possible


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
