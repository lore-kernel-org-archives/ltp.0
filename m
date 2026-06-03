Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CD5CD6E4A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 04:09:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A90A13E30AE
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 06:09:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C77603C567A
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:09:13 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 05B3E60013A
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:09:10 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so14949149c88.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780459748; x=1781064548; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uFdM+7FOO5AtghCakmmu56BYrejLlvr0EBN15O9jbY=;
 b=s2g2IbPqQ2xZe57/czit3E9ZaMF7R+85ZSAjGTbhU1ATXXxg8FRjrY2iwRTeOFGlMB
 l1TOVNK1ZHR9UM+kiLErVAh+dx03noRt4AA6zetWdhKwfiQnnzR16gQjmL/5FFrM3wnu
 e05IAP959fhkSsdDSzY9LiX7eyMAyZ+8JDDG5Ns91bUDrN1eTK92EZcoEM2t2OP4rZ6e
 NvFdBD2+pjfyrX3MELJjV4I28zqBGqQJkwPV3tysm4Lu4szZqBFNvpoJZ87mpLOkRGws
 dp8KOHwMC56oArLC3VxjjJ+KtolkwckjENrDTT3+WVlzUlEZMNZzs+XEr/7VY0PoZWsA
 bpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780459748; x=1781064548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1uFdM+7FOO5AtghCakmmu56BYrejLlvr0EBN15O9jbY=;
 b=WAtiklEqQbMj0D/d45pvAmMpeCMhSbL8/J611PhURQ0t0dX72PjZc+qZKfOmIa7QGK
 RazYJIYdsnbR8n9I4Csx5fPG8ufV5OknELixMnVs6+Po2gUeQY9noJEirdgjxs+0xOT6
 lNYaYouh4oYZVBVmHlRoVTZzo7jIDMVBIAPGxUt0Wm9gx+a8/Be6PgG4Fc7omjkF3VRd
 sdhFS8ld6oVBCAyU0V6CHT/ExR8OfJfwQ/Z2pu2/z4NrFxtstuYC/4MLyM5iBnaDUwBm
 yMt4GYRVODNaulC2089sW6Mu798imBCP/1xucCdR+Lmtsb0cvVpLEk0M9FGpd1npYEpp
 53GA==
X-Gm-Message-State: AOJu0YxS0pgPoDilPteUS34mH7kXV7vnneBNLzteencvS2ltMpfIpe/5
 utk4M2BRqMZtLNWOurwu2BR3/MVVjDjXIj5xU+It6WIfli6chyk6RlDB7yr/ffpM
X-Gm-Gg: Acq92OFFXTAXt136aQGBszQXnPAe7nHBxsKFOtM61IvQmiRx2ynZGtfaWBF9JgNQBOX
 2QSV1nG47FVYbHZG8B8K8NGo2upYZ2tVabnPIkc+vK00ELMwI7LPRpWeiIvHVOP7Nek2CqvxP9R
 zVwoVul9XPBUb9jvIDLzuRTD9p81lx+hGaLwIvrhwxcM2AUmFR0MgJfa+zoxrhNhtHUm0QQ441m
 3kPmE+6zfkmTyN3q6j52C7RjFfiEw3tmI4Wy3KPhtqrZGj5ptPQ5At09FIpqFVJTY+Nm8ZBOuC1
 8wf/z1/MvhYZRDXrmkQQzfpVHvQAHVRxv7M+w25l3/a7gCvXdbO0XlGGnwZEkhaPLCp/9KPC+se
 EM4rE64MFfuu+LQGU0ScuNDnpP3sUAeqhZvbXs5znD9hOktDfjUWBasB1rIXlLh9r13JFNZsvQp
 hTajz7cq8RI4nsw4eVcVuNRqhK2P9sVbBGmvOgRnQEyVWRm6UC+dWZUkE2cyp/tetVKVdMELrTo
 6pMXz+aDCAhcn4Ah3Y7G0zof9P/m1baiOlIRvQOs8fbp+8=
X-Received: by 2002:a05:7300:371e:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-3074fa3d73cmr924297eec.2.1780459748159; 
 Tue, 02 Jun 2026 21:09:08 -0700 (PDT)
Received: from
 runnervm3jyl0.3efhi5j0urxudl1u5xhnkcmdbc.dx.internal.cloudapp.net
 ([52.225.29.1]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db55f60sm1923247eec.6.2026.06.02.21.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 21:09:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: panzhe <panzhe@kylinos.cn>
Date: Wed,  3 Jun 2026 04:09:05 +0000
Message-ID: <20260603040905.4067-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603014933.30653-1-panzhe@kylinos.cn>
References: <20260603014933.30653-1-panzhe@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] gethostname02: Accept EOVERFLOW on alpha
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

Hi panzhe,

On Wed, 03 Jun 2026 09:49:33 +0800, panzhe wrote:
> gethostname02: Accept EOVERFLOW on alpha

All good. Reviewed.

Pre-existing issues noticed in the surrounding code (not introduced
by this patch):

- testcases/kernel/syscalls/gethostname/gethostname02.c in
  verify_gethostname() -- if the hostname is empty, `real_length`
  is 0 and `gethostname(hostname, real_length - 1)` passes -1 as
  len, which returns EINVAL rather than ENAMETOOLONG or EOVERFLOW.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
