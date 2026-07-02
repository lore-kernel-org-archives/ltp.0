Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83167C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:42:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0308C3E4A20
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:42:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4490C3E2E31
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:41:49 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC10E200358
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:41:48 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8efc219ce73so7711296d6.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782996107; x=1783600907; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/Ea99wcJg7bDAmgn5uq7R6kLKRihGO6kTp6f81xPGo=;
 b=Yg8lnu3he6N6zqIrbwOvCm9qBNgk6ADJqn2dLWIZ/Udfd9m7cMMzN/flbGkodJs9Lq
 Z/7oGf6Wk+isYKi+8goqrnOed0T59DUNX1yNA1PXFC5JctG6EFlvbPuTUdt4bqD7LUrJ
 de9oRF5J4qj1E+l8m1rJhIKhyKAAnl+f0b65TXMIxgy4oBndkKYlxZmrhs7usO++XoPg
 egqJn1F7CtfqH/0tmZVJP09LddJ3Jt+z1NLWfBuTQtTZ60y/TLwIOnchJhMHfvaACy28
 tB4q6hslFgOfl2iLRsP6lvhIGUDauCy2JcSD0WIWbTmSmVOQGZUeR5VvDH/HH+HnsFfo
 2N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996107; x=1783600907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n/Ea99wcJg7bDAmgn5uq7R6kLKRihGO6kTp6f81xPGo=;
 b=cJ/vjMCFisBYsPbm5WbOTvc9+sUIowD9apEcrm2fBMtrJvlVW0rPMlROfOeYNxR6zd
 IxehKw90mfPOO4Czuk3niWnGseoJf4IQFcobqe3iWkIAZ+ZlmwS073IJx7q5rqhCRd+N
 A1u7jwQXsS0vfnaUPzbhJR2ETi+bU2QBT0YL91SZRay+9AFq8ofXDSCsiGx9cYQTJDQ9
 IdMbUdN1p6NRAZR8v1aqKNfKVdtdcA4WjMH64Kx9HS96PKI/DfzTMYeWo0B4Ol6xpWzZ
 pJRD7mv6v2XurVhUNI+MQb8XkprXzzpOKMbJyvOBFj9Pl9nJozu7VFEDZWl07jtS20AN
 N+5Q==
X-Gm-Message-State: AOJu0YzzzDYIa7ppDQx+0fG550PkDkueImzm19xFXhypmdR6EJ5I4K6y
 XC5IgkCJ4c5fcjTG3EhD0M0Cgqtn9PMOIPax/SEDgzK01e80pkpomH36
X-Gm-Gg: AfdE7ckkFVF8X+uX5cE0/238arQONUykXL2Hov7JAjhWHQOD+uXcL3ywS1N0r3ZkfLn
 ajOIQ83AWZlR0elie2rryZ3v8QPYFG5op/B6M4mi1TJbiYym+K+8v+bk9iZ5eyMVwLzMUvUo8rI
 IkupDXFGQpqM1lB/M+etbbWHfpikQzWyzuPTdS9svsBOQwv2wLihZ64Jux9sVYJcIPWDXFKKCwp
 lkPYuIycDr90A8kRdzybsKjSePGYEfaDCcOdnmmY0tQPCdevCZtuuHN8TdLiARtcoQNOBEpLMb7
 Glaejn0WoL8JrlnfMcMnIKw/SkE1GCw+NFHGPz3Q/YVTKqB73NJFhkCUDWVjkHDbBMJZSsgOnkJ
 2+NDuNga0X7/RO1ThvlVXeU2dk2r4ABc/m2v52kPyY6IQINjoReYv5gA8iyHMEk+7udigdv+4r+
 /bwbSDZZwyIJfNU1RTqDckiZPw7jxm/Iao8WMfC0rpDZcd5OWzHTTe5dVUN0Ty9xxFnFzJV8X55
 2rKNFqhNKvXgR6G7fZDNBPydKnUCTgJkpoONxw=
X-Received: by 2002:a05:6214:3212:b0:8e9:f5de:d619 with SMTP id
 6a1803df08f44-8f3c9da7f64mr80827996d6.56.1782996107406; 
 Thu, 02 Jul 2026 05:41:47 -0700 (PDT)
Received: from
 runnervmkkn4f.w1fkxcgs0uuutkcgc1hgptdknd.cx.internal.cloudapp.net
 ([9.234.151.116]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4726b3201sm25420436d6.46.2026.07.02.05.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:41:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu,  2 Jul 2026 12:41:46 +0000
Message-ID: <20260702124146.4086-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260404165346.1689061-1-pavrampu@linux.ibm.com>
References: <20260404165346.1689061-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap36: Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test v6
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

On Sat, 04 Apr 2026, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugemmap36: Migrating the libhugetlbfs/testcases/truncate_above_4GB.c test v6

The "v6" revision tag belongs in the email subject only, not in the
committed subject line. The subject should also use imperative mood:

  hugemmap36: Migrate the libhugetlbfs/testcases/truncate_above_4GB.c test

> +static void sigbus_handler_fail(int signum LTP_ATTRIBUTE_UNUSED,
> +				siginfo_t *si LTP_ATTRIBUTE_UNUSED,
> +				void *uc LTP_ATTRIBUTE_UNUSED)
> +{
> +	siglongjmp(sig_escape, 17);
> +}

This handler does not record the unexpected SIGBUS in any way. The
caller uses it here:

> +	SAFE_SIGACTION(SIGBUS, &sa_fail, NULL);
> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		if (*pi != 1) {
> +			tst_res(TFAIL, "Data 1 has changed!");
> +			goto cleanup;
> +		}

If SIGBUS fires on `*pi` - which is exactly the kernel bug being tested
(the low-offset page was incorrectly truncated) - siglongjmp returns 17,
so `sigsetjmp(...) == 0` is false, the TFAIL block is skipped entirely,
and execution falls through.

The code then reaches the sa_pass / `*qi` block, `*qi` triggers SIGBUS,
test_pass is set to 1, and the test reports TPASS. The test passes when
the kernel bug is present.

sigbus_handler_fail needs to set a flag (e.g. test_pass = -1) so that
after the first sigsetjmp block the caller can detect the unexpected
SIGBUS and report TFAIL before proceeding.

> + * Test for a bug where truncating hugepage files at offsets >= 4GB on
> + * 32-bit systems could incorrectly truncate lower pages due to a
> + * misconversion of hugetlb_vmtruncate_list to a prio_tree.
...
> +	.needs_root = 1,

The doc-comment block does not explain why root is required. Ground
Rule 4 requires that the reason be stated there.

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
