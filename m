Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF67ACD8C88
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 08:02:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27D363E2EB0
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 10:02:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CDDE3C973B
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 10:02:08 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8DD156009D5
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 10:02:07 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8ce9ddeddefso36812546d6.0
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 01:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780819326; x=1781424126; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymVujRBEALt5+d87kKTZA04AdWEzasfUUzGyBYStJqY=;
 b=jc1d60Bap/UF9R5S72vtl0T7NvIkeHgE5B3udxyzl7g8vXKs+EYcqWkJTlrSror/pF
 lcOPsUWrKufnewt6FYpAjBiFaLzBz/3hJd/CWkrwZAcOSC4BWs3jqy2wWxdKNaqz4i/4
 74Bm6L47dlX++5Aj4z6FnkYrsx6v6EWWr3vRz/9+6mLXjbCfWDX3sKnI1l7LN9z6oa/Z
 5eqNWkMvrSoB9PMO6uTAIndirM9YKw2z6gMymuePsmKpkQewaHDAgC8DYRSQXM0STaJB
 n3Hb4kxViUsJkGETKxW5PhSmlcWrJhQJkTWafFGcQup8Ak5VgKvlebQXETXwXUKjjOvy
 IxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780819326; x=1781424126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ymVujRBEALt5+d87kKTZA04AdWEzasfUUzGyBYStJqY=;
 b=eN2gUdi3OEWLu0sMhQ9D7Up9GUxfE3noOD/jXAgPaGkq/rE1Xg1cN7f3ki1ooclsGs
 0ZRtr0YSAuvj8Ry+ljv+BaiEOWOG2lXg939yBqZaPmsDEUs7Ol5jgo3aX1ewM7FNhd7x
 tl2ndNlqP3DtOk8yPUsHvH9c7eQJgaL+77jopHyt1GcwCbjXpLdoJ6hnaCwqh4ZQOcb6
 6a4yAdqEnkiW9CIWPY9fYvw5cCIcO3+vFLl/W886TisySmTPVJDO1LZ+OhkzpyfRlLI4
 TofU46/RwYhKtSqI5SrgYH8Oe+IUcXYN871/de7EsE7/gED+nz5p8ZIXw56K+n3Gl7Z+
 gaIA==
X-Gm-Message-State: AOJu0YyMrvJXuvJ58gPNmp51q2/KynEU/lpCJ6Mm/W0+qdCW3mtpJI0t
 TbG5T8rK20AwrzCm+FEqpQKeD+eIGkTTcRRSC6WaAWPV3DQIesmw6ZYd
X-Gm-Gg: Acq92OGbesdqKs2CyBAQO5g9Opyai9ChCjGBEmp68GSbBKbyc8e/PR4Gk0g2FAyXKyb
 XBQCZlfKTCjXJstVzq1iZAb6hO9MEi2yPb25eXAFVF85HUp8DGaXbzNBv1kCsh/53VEjU+yGdG5
 G2h+y4WmHEOVxzPNvWkR187UujAVsOzU0C+rdY2WPits52p7TifHSWniHLWSNVtAjWgHsgSO7Ko
 rzLHDpRrJjAGASYarFs/NaYL0Llr9B/ulAod7tM+WilL/m/4s1P5/Mt031hjSzulRzu34DRSI8z
 u5dFfydU+dt4EPYt+knrAI+/9fnTFHoI3bbjPp3td4izIRtiNdQ3nnB5P9flfloAUQRcglxmUgA
 WJNQ2Al7rRrkvmfAXLBZOGuVui+eZt1ZqgJZ1ijoXQ0lf+u9JxF8DOddo+UnOqM8bhggfFmD0Nx
 dMWXkLXPTNWcujWivpTuuwJ/GkpBA0uD2Bhsx8UrmfKXYCg52eRvHsvLZRh0Lg8DDv4ImjvEuhN
 WZizaACELUMkzR11+jeqek9uLNEUDIikP75sQnGj36hLExA
X-Received: by 2002:a05:620a:390e:b0:915:87e9:2c49 with SMTP id
 af79cd13be357-915a9c29513mr1781119785a.13.1780819326171; 
 Sun, 07 Jun 2026 01:02:06 -0700 (PDT)
Received: from
 runnervm3jyl0.zjkurybzvyseff1vs2zn4x4edf.bx.internal.cloudapp.net
 ([20.120.84.86]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3b3f6bsm1362410785a.33.2026.06.07.01.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 01:02:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Praveen K Pandey <praveen@linux.ibm.com>
Date: Sun,  7 Jun 2026 08:02:05 +0000
Message-ID: <20260607080205.4091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607044201.22859-2-praveen@linux.ibm.com>
References: <20260607044201.22859-2-praveen@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ftrace: Add common library for C implementation
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

Hi Praveen,

On Sun, 07 Jun 2026 10:11:56 +0530, Praveen K Pandey wrote:
> ftrace: Add common library for C implementation

--- [PATCH 1/5] ---

> +tracing_path = malloc(PATH_MAX);
> +if (!tracing_path)
> +tst_brk(TBROK | TERRNO, "malloc failed");
> +
> +snprintf(tracing_path, PATH_MAX, "%s/tracing", debugfs_path);

The blank line between `tst_brk()` and `snprintf()` has a trailing
tab. The same pattern appears on many blank lines throughout
ftrace_lib.c (at least lines 56, 78, 93, 97, 111, 115, 118, 121,
135, 138, 141, 150, 154, 157, 160, 163, 171, 175, 178 and more).
`make check` would catch all of these.

--- [PATCH 2/5] ---

The commit body says:

  This test validates that function tracing works correctly by:
  - Enabling function tracing
  - Verifying trace output contains function calls
  - Checking for kernel crashes or hangs

The test does none of that. It enables the userstacktrace option
together with page fault events and repeats the loop to check the
kernel does not panic (regression for commit 1dbd195). The body
needs to describe what the code actually does.

--- [PATCH 3/5] ---

Same problem with the commit body:

  This test validates that function graph tracing works correctly by:
  - Enabling function_graph tracer
  - Verifying trace output contains function graph format
  - Checking for kernel crashes or hangs

The test verifies that the signal:signal_generate tracepoint exposes
'grp=' and 'res=' fields. This description appears to belong to a
different test.

> +/* This test requires kernel >= 3.2 */
> +if (tst_kvercmp(3, 2, 0) < 0)
> +tst_brk(TCONF, "This test requires kernel >= 3.2.0");

Kernel version gating must use `.min_kver = "3.2"` in
`struct tst_test` rather than an inline `tst_kvercmp()` call.
See c-tests rule 9.

--- [PATCH 4/5] ---

> +/* Check for test duration parameter */
> +if (tst_parse_int(getenv("LTP_TIMEOUT_MUL"), &test_duration,
> +  1, INT_MAX))
> +test_duration = DEFAULT_TEST_DURATION;

`LTP_TIMEOUT_MUL` is a floating-point CI timeout multiplier (e.g.
"1.5"), not an integer duration. `tst_parse_int()` will silently
fail for float values, leaving the duration at 60 s. If it happens
to be set to a small integer like "2", the stress run would last
only 2 s instead of 60 s. Either drop this override or use a
dedicated environment variable for duration control.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
