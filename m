Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AB1C5516F
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 07:30:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BB813E9830
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 09:30:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5623E950C
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 09:30:14 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C32A26006ED
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 09:30:13 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-930f7b1eb68so78767285a.0
 for <ltp@lists.linux.it>; Sat, 01 Aug 2026 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785569412; x=1786174212; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gi3IdbbxXUm3n+XNiXgFGdKU4ioKyj5TMhA4QLM470=;
 b=kRt28sTt9maa1HZBQYDsIOnTqze8m5hjrNs5vSuzdMW8UQvQL4RTdeQ7ImIFQM+Z59
 P4qW4uNI5I3p6A1T+oBuzdjre1ZYBn8jb3nPm8PCnMasxnN7y1/Y5Hg4fTBRRX4IKzeW
 3CxrqunvaFN8kLuZEbOFWPoDklRgkGAWjPR4eZX6d/cUr8Dbzb63NXgey1NQst0tDKQR
 oe6Xa5kfwhhL0jDsQqnMbEhdrrHVX/gY8y/S9RixBQDrxLa2xPG2MAHtUlwWPeZ4TusZ
 huQeKSiL5gXJP4Y72nnYcThNcrCM2v7GDKVurM2WmsKpU2Zvpl0Z+LeyzKBRvjtZucuq
 KFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785569412; x=1786174212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9gi3IdbbxXUm3n+XNiXgFGdKU4ioKyj5TMhA4QLM470=;
 b=em4hIIHgQradSM/kiBvJz5ICSsKOMTAzNaxTmBNQCPZPiQjZqWGUxnuehOowEDyTaA
 S7KnGHMKJTUYhfUJ0ssHbAccyQhJoA7ayF58ALMh1vsDM3n8R58KbDx0YGb5EVjCIauh
 RQYoEtzP3zZXgdSkHahBfHCFwyLgScGzNCeMmiU5NF1c0DoL8brYqM0csmKXfVLriD9b
 CStgOSfq8ura9DVicdh9CBDT9CZ3B739dO7Ni2OYf3Ku3lX2BEyXlrdSq/JY9g+mIlzI
 BY8J8nWF5XP/4B5ieOs0Fs3gPmeBd9J3n+9aj+negCCqwowmoeZ/9sdEdwW/+YVD3dn3
 UXPA==
X-Gm-Message-State: AOJu0YxmWqHyIP/6N0BVOQysL+MNNvwVraiaidjSqHxacRPPGzsHJePX
 cH38ZOhmAHi57tJpLqRxKMAafnojyskIeSNAHLhIiQkSUSaQufTR5q/b
X-Gm-Gg: AR+sD11ZQqh2gr6gfsg/wu6qvGkstIg5VBHXJrH3+zG7o+JW0EfN45AoIaD7/20Uo6V
 9DPQ9UvSYzQEFQrSUeBUKsIMD8lBG0uFu3mzgg6rM+nesWnmXAYB6/5TkufpaMAe0S0PF1KR+97
 97Qe22HgyiWWbvlAmfERqqqsAeJD9I8LOql/5It7oqJPEXelClGuf2n/b60d9WZkkoAzEo3QI96
 EMzpfFS+8YbK1SjZnlrlMuIWYFtR5J1dDYtm7QRUiNCJVI++MyidUuA8fm2VWrswKDffPg192DQ
 4GPn36AHVt9jVivDxzmWa7h5xaxeb4loMyv4C5kDQyFhxEITb3hb6tUt0Yi1csfhpUNXWZBXsfM
 3/zt9oNQ1RLCLBGG1u9Ic6v4QGyaqSWpw2Mzr6npPUqqfP8gShA62fpdMe3rE1sSUNgGQnfsm4m
 MIrvVvPk4Csk0ljwbeUlVoz/6JFoAwOmWTGbxtCqQCyS0uiPkOCH1Jnb8I0g/kAPs09o2+OA0TL
 0VKzvDOzShlrF7NlF5Q9jdoQUB1u5Cz1qkmUIY4wH497yI1WLbD9/4bVhF/0bOVvuNNxzAYG5ae
X-Received: by 2002:a05:620a:6f8f:20b0:92b:81fb:87b7 with SMTP id
 af79cd13be357-934a078349bmr429497485a.13.1785569412283; 
 Sat, 01 Aug 2026 00:30:12 -0700 (PDT)
Received: from
 runnervmvrwv9.ehj4x1d5yekefaajqsxkgfvqfa.bx.internal.cloudapp.net
 ([20.231.101.40]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9349bc5379bsm228053085a.16.2026.08.01.00.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 00:30:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Date: Sat,  1 Aug 2026 07:30:11 +0000
Message-ID: <20260801073011.8913-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731044216.33618-1-yeswanth@linux.ibm.com>
References: <20260731044216.33618-1-yeswanth@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup/cgroup_core03: convert to new LTP API with
 parameterised subtests
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

Hi Yeswanth,

On Fri, 31 Jul 2026, Yeswanth Krishna Tellakula wrote:
> cgroup/cgroup_core03: convert to new LTP API with parameterised subtests

> static void run(unsigned int n)
> {
> 	int i;
>
> 	/* Fork wave: only needed before the first subtest. */
> 	if (n == 0) {
> 		*data_ptr = 0;
> 		num_pids = PID_NUM;
>
> 		for (i = 0; i < num_pids; i++)
> 			pids[i] = cg_run_nowait(cg_child);
>
> 		TST_CHECKPOINT_WAIT(0);
> 	}
>
> 	switch (n) {
> 	case 0:
> 		test_cg_kill_procs_count();
> 		break;
> 	case 1:
> 		test_cg_kill_trigger();

Critical: Could these dependent stages remain in one .test_all callback?
After run(0) returns, run_tests() unconditionally calls
tst_reap_children(). That blocks in wait() because every child is paused,
while cgroup.kill is not written until run(1). Consequently run(1) is never
reached and the test times out.

> /*\
>  * [Description]

Minor: Could the deprecated [Description] header be removed? Introductory
prose is already treated as the description, and this header is forbidden in
new C test documentation.

> 	.needs_root = 1,

Minor: Could the high-level description explain why root is required? The
new root-only requirement is not documented as required by the root-usage
rule.

> No functional behaviour change.

Minor: Could this claim be removed? The patch adds root-only gating and
kernel-taint failure checking, changes the timeout, and changes result
reporting, so it changes observable behavior even apart from the hang above.

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
