Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EE3C5518F
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 10:41:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAC813E4982
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 12:41:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 201763E4982
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 12:40:51 +0200 (CEST)
Received: from mail-yx2-x01.google.com (mail-yx2-x01.google.com
 [IPv6:2607:f8b0:4864:41::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A9D851A00A28
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 12:40:50 +0200 (CEST)
Received: by mail-yx2-x01.google.com with SMTP id
 00721157ae682-8200c88611eso3059857b3.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785840049; x=1786444849; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWMi7uMMXOXDHNH+5K5eR61M20Wo1OF7LBpII6eSKqA=;
 b=JJ1xzQSENLzIF55ti7Lwgl5HMXsNBmZLaV37pjA1owxsW4xa13z3OcZRuH6cl5KudS
 99XtndkrTnQJadguUUZx4MJmpkVXcrDqt8CdKVJ9h85QAB1qGreSb78OTfiAdncanbXr
 HetDuxto9v/wuCU/Q7DJIIkUuBQkNSHCh+a4wTsyVnpBBLEefP3XnU/TB9+wrNIzWx6T
 Pxwxy2FaboAb7LznCvz4oBt8jWUHDIJlTZJ6Dv3buCSYDhz9pgtl3tnYaswdq2nmSKtA
 I3ely/u+CC9l0l6Md+9MUg5vUUWFMWq/DOAh91NohbLbXlkwTBm/VK1QiWPzNRxPTzoT
 iaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785840049; x=1786444849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWMi7uMMXOXDHNH+5K5eR61M20Wo1OF7LBpII6eSKqA=;
 b=FAxn7gC8CH9ka0lhJW2yT0nSvhwVbnuPT/Gxyw1iDlxKU1h8tdag3kw711V4tvqSig
 8lXUKmwDyDNFOOap3aXDC2TnBkNKeFiDd1l06bCeJ8zkMrMShq2qkPo0X1PeScUrcCi1
 tc/EAX5vpG1Lu9cStdI/z4yrKhK0aJ2loi+Y4XmS+j8OLe5H0/HQAFu1bZZqdc7fsCQY
 lVm9XSJqikwtX/jFT9vB0AD2UiizIjGBEnfkYVGS/G7GylnyUPM4eS6zaBy5B/iWLImT
 s7hF/t6jIXBBxp7dwe4/7+MsUkHa+DmGETpzvySxt2YlSd5JNm0OO5Qz0IsmLCCj6p0t
 CcLQ==
X-Gm-Message-State: AOJu0YygwtLdXyo2tWHUvqTIOrcUqKLjNAvkxzJhshe8dpHJPFgMjGQc
 +JB2+KR8Wo+f1FcYCI6qxsZxrrbQY6eXQW4ANcp2g35CkMpI0TqCU+F3
X-Gm-Gg: AR+sD13WIXxtKxaDY65PIG1BmnU/mz7GPLEgECI3z5qzaa8+i17+Zi487eKVNyRaUvW
 dp1I5aHUWe88MR0AHFOtXFzDtjhTb+rHGWr6u8fbBh3nmADHSNswWK0uiZsL1W2oSl7+U1W1ozz
 ixlx67sghURdtM1cORd8cY7TZ5ODNsIlp+3rckAZyYiCk2ywfKMQI4+BWEfgLDTkLLqX6n4WC7+
 DW1crbWR71JqgB7DfS3zMkEMGLFai02mo5yc08e3w+XU3S895QF7I5EI8YhOIH7+w1k8vcZldx2
 StL0MuwJCeePh904l0oahszWR1R/87n2v+I5dwTPfGvZR3B2exXmUyo/WVzIzLImGc/n2D8Qr9v
 0oUexyR388uoNZGESsbhLgj1B/dgeC9e38vofe7SaC2TUJAq64fppvxl3eqruqRvU58qZfNK+4k
 1J+A9jrYsavrfqH4gAZHX7w1kWnMxkPQIw+vs4T1hOpo+NsmD7EhrLCV7WFEYSlciS4FWrc/dml
 jxO22lgKIWC7usAto+SMTm7jF342xfk6Nu1nOUa9ofmVcWOwm/rLdM1pUKRaweTB3HZ5YRMp9Wc
 +eWKLwrHcQ5R
X-Received: by 2002:a05:690c:2608:b0:81e:5b65:c4be with SMTP id
 00721157ae682-81fd49b941dmr180103977b3.2.1785840049380; 
 Tue, 04 Aug 2026 03:40:49 -0700 (PDT)
Received: from
 runnervmvrwv9.t23bbcoo3atehcqvjow3yojseh.ex.internal.cloudapp.net
 ([135.232.200.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-82012f4ea2esm3079427b3.0.2026.08.04.03.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 03:40:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  4 Aug 2026 10:40:47 +0000
Message-ID: <20260804104047.7850-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com>
References: <20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shell: enable OOM protection by default
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

On Aug 4, 2026, Andrea Cervesato wrote:
> shell: enable OOM protection by default

> +	if [ "$TST_OOM_PROTECTION" = 1 ]; then
> +		_tst_enable_oom_protection
> +	fi

Major: Could the test body run in an unprotected child here, as it does in
the C harness?

This sets -1000 on the same shell that later executes the test functions, so
all workloads forked by existing tests inherit OOM protection. For example,
memcg_limit_in_bytes.sh reaches test_proc_kill() and starts memcg_process in
the background. Linux 7.2 copies oom_score_adj on fork, and its cgroup
documentation says that tasks with -1000 are never killed. That path will
therefore report that memcg_process was not killed instead of observing the
expected cgroup OOM kill.

The commit message says that the test runs in a child, but this patch does not
create that boundary. tst_oom_unprotect() is only called by the new self-test,
so it does not reset the existing workload launch sites.

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
