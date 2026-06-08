Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5ECCD8C8E
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:02:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81B593E5F85
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:02:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89A63E18CC
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:01:51 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 864F7140042B
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:01:51 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so2016007a91.2
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780909310; x=1781514110; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoV8Ms1JTH0FW8yjAjdNZCnEr4qtJkfhT+zApXXkyBc=;
 b=BBmYgtoFJrzsSLZVa++p3mBrRyb7uR7q3wuRgrhsBILJoXAcmoDUnw+VmM4E7Ajkem
 J6X+Sgb1YsJfuflE73XYsws/3pbM5wvPXwMcArh5WhoqnRSrZtIeNQUzKklgFHPPu6Mw
 5GWjrMSgQcYJ4bnm3t5ZxPbkX2hIl+J+9Td7g49Pv+fIydDjjaEBVP5V+Jr+btinNM+w
 24wmGhbNjL27xAa0W9rf7etV04PugELXbMkbe6FeiUK6e2/msHgiAO66RQUN/gEn4tfc
 iQUgf011KT92LgK1FdOqVGA5/wd3qwPe+DPD2/wFj9xvKtyNg72eV7stYsA2zkmfA7NG
 X30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909310; x=1781514110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FoV8Ms1JTH0FW8yjAjdNZCnEr4qtJkfhT+zApXXkyBc=;
 b=NKycR+AstxXm9bhiNAVQOymZDXrEs1dqxidREy9+KmuT0jSB+wX9/qXcJlbHs29dOa
 nvpUvhZWRAauZMB3QMUHBpkLggigMxiCTiE9iuFQQHroUL2mW39uPAT4aCrhVx1wuH7S
 Fv8VETDfgsp7qMBOmou06eHj3NY+EW6nEAGCtu6o/pY8DWhscKD2oo9Kg26mZm57+eIb
 TpdjodSAsy9D80XUeJzi9GGBJoIAaKsgLQEyzpI8nn5k1pvQdZxqh8sytI7hkxXXipM0
 ADutpdp2bprP5u2IoKtvvczQO9rvZHrp7+E0zdT0DPftiTZkH5bQDaBex2pPyDo+T/J4
 wfeA==
X-Gm-Message-State: AOJu0YzwOm6eaqI3gCbrsdmbjjlZqxoVbpZ97oxqFypfVSTm2/NAu3D0
 X7c4oYSSQwwmiwSo+4+aNV7ZyPv0uV+nSbeVBlTmb+81+I33j2bvrykk
X-Gm-Gg: Acq92OFhkhi3DYbE6CB+x2+rSc/kIwu0kzgNawYil73dcgQMf4GV0eOqzeGJPJds0Yh
 XpEjsa9pKo1gz5Gf8XrbmweJUUubs22I5TUns3f7XhGGNZeI+XFy79Iq6ZE/yN3FgZTYRFwO0+a
 oK3gPyVqReZjC1YPvPtneosFuh/P1FwAJAx4RbLGwp00OxSj697UqO5v+4jj2z6apTh2HmjXNHh
 XMmtzc2P1Lc+Z2WfzVuAJymgGHMvXwWC3w1JDPg5zm0W1izKEwGVY0fKjBi2+OSVwswKOj75mHf
 l2FhnhFcEgOwC2uqh+TB+bQKlcOBHcsfKmAj5XegbfTCxfoKQAemXz5iYpR5a+b0XudgUwxA23L
 M1Qjpokthz+3kDmPJSpfanJ/gIDcm4JX16ArrgXZv+RbfW+vWKYxfMcEvkA/ItYlbgN1BYBl76+
 oYRdmFVha3UX4HJ9RRfTFZoeA7tHaMSgjKS+hzpWe+49CKK40qjNi9sKgF8/wdvRsp0YPjgqaYH
 CDA3mi9RbIubOSxJ7Byh+A1lGMo9aPdl/aNk2RTWFUd1UEllR8=
X-Received: by 2002:a17:90b:1f91:b0:36a:6ac2:8bc8 with SMTP id
 98e67ed59e1d1-370f0480bd9mr14791992a91.14.1780909309879; 
 Mon, 08 Jun 2026 02:01:49 -0700 (PDT)
Received: from
 runnervm3jyl0.vgx3we2vmjdefpcn0vneq0jovc.xx.internal.cloudapp.net
 ([20.115.146.229]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c668f9bsm15163624a91.7.2026.06.08.02.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:01:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Praveen K Pandey <praveen@linux.ibm.com>
Date: Mon,  8 Jun 2026 09:01:48 +0000
Message-ID: <20260608090148.3944-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608055000.97154-2-praveen@linux.ibm.com>
References: <20260608055000.97154-2-praveen@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Mon, Jun 8 2026, Praveen K Pandey wrote:
> ftrace: Add common library for C implementation

--- [PATCH 2/5] ---

> +/*\
> + * [Description]
> + *
> + * Test for kernel panic while using userstacktrace with page fault events.

The [Description] header is deprecated and must not be used. Remove
the `[Description]` line and start directly with the test description
text. The same applies to ftrace_regression02.c.

--- [PATCH 4/5] ---

> +static void cleanup(void)
> +{
> +	stop_testing = 1;
> +	ftrace_cleanup();
> +}

If the test is interrupted (e.g. SIGTERM on timeout), cleanup() is
called while stress threads may still be running. Setting stop_testing
does not guarantee threads have exited before ftrace_cleanup() frees
tracing_path and debugfs_path. Threads accessing those globals after
free is a use-after-free.

The fix is to join all threads in cleanup() before calling
ftrace_cleanup(), for example by calling stop_stress_tests() here
(guarded by thread_count > 0).

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
