Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB2CD8C8C
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 11:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C27553C74F7
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 13:32:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FD943C7049
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 13:32:05 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E251C600080
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 13:32:04 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-5177b9a02bdso43131711cf.1
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780745524; x=1781350324; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/4cINTZimE15YztQ8CYE1lmui8m4p3FnggTmv3DS1o=;
 b=Nob/YWkm2gpXPbeW7PIch51GGQ9t+VLaEf4K0VoO0H1B2PrBBn7W5lFWjgmHnhAcfV
 6v/YUNPbRDXCPXlL/xpRYPoEGxdsifrOM/4EAiuUPMaGe/rZuZ5RfutwvxKkl8IsUgxk
 LBgeULu1ZoNyrCZkVgCtbhallEIyemxaQakrUOnNaMgwagjkoWj70T1h4Eh0z3eJcMhJ
 ZEqrDX1gy2ctdaNFF2FUZvh51Qyts+OeuuCcZLtj++QgmjNi7uBIfGU+b4GL6cwjqkZ9
 qwD2ko/R0wsgWRJrcUz+SogbOxalbgTt3QoYIwK6uHmBkDxFYcjOnT20yUoYdOJJ7GhE
 LpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780745524; x=1781350324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/4cINTZimE15YztQ8CYE1lmui8m4p3FnggTmv3DS1o=;
 b=hvni3fXNtfPbrpuuZvnGsuGJjy3K+pMAt8SDBsRNxTn4xBbdXFsUUxLAlY9RJvgp6c
 mXE8EoZvrQS8Lqmmuvt1Bv1gRzxCm7MiBLK5eaB0XVdDW0woPw0wP6atkO9185tcyZSm
 77jyaPKCQyql3V03XDR4NEItr1/guUGKW1SMcTsoHFzx1zIbXsXMnVXkzwwtmllv3G6A
 veLlsNTHKLXUbMmhsSADA/pE8XRWkQxfpmqmPcAIu7cNHo7cYJpV7KJLAasrYY759Gu8
 B+m3p0U9/qxkV1i1CrUhsMp5v+0vUPejnuFpVi33Vv76aLqc0DD8aczlJtdJti8/0y11
 r35w==
X-Gm-Message-State: AOJu0YwSp34OQ1bpZVrqK9pSgos8o/BiRjEi+n9/nqDtAZCUKoaSGbc5
 kUBSfq6IHK1WV0AeFqXmJE2tY3XUmjInbYIYGWjryDxRGx6T1BeDVnv4
X-Gm-Gg: Acq92OEXOXD1o+iToYd2pzEu0L81o5q5x93/Iq68EiRgQ7xTBzRfDF0tdWLuM3FdN8z
 ljf0DQxpXUot835C+DXHOjJK44O0YBhQo1S6zD0R+OkQ8WGUNo4/9xSCkhjEUrenfVo4AzVslOf
 B1q+0K17ElN/AUCmk0DFuWOnJ0QHweBqByokVXrf9IRDFrDdvLLrE5FMvVUs8JbRC7uWXWjCy6R
 KnWE31XW6LgLFjr6mDgkr2kO01BhbJNmrmbaxsLWsQzHDzQjZ6iXxWEhiOLpjA81nlxL18RLr0u
 bGdFZqAJKrwwmiOnD39TBEkdLshyPc6Cz2xUPGaQ46IttO8D0OFhEUu64Yga4N51FlxvgLZudWR
 w+Bnodor/BG0QcMLTkIw7LAu7AWrQbHJ7jtlZmKU5te9dpG2wM8FudxICqDHzLUv2m8ZOsL9mMV
 DQXbXtt+/bFw+I0uzuggrE3MoIm5sEVY16sSP1t21cTRtLLw0MpAybasBGrutpj/bl6lytsIwk4
 JlLQqTt1GknLtUl38iFwrnV6yBWlD3Pi82/8TdEuHAgMTkJ/g==
X-Received: by 2002:ac8:610b:0:b0:517:9095:c32b with SMTP id
 d75a77b69052e-51795c91654mr109919841cf.45.1780745523558; 
 Sat, 06 Jun 2026 04:32:03 -0700 (PDT)
Received: from
 runnervm3jyl0.2d4yuw4mzllehnbsihy5bpj2mb.cx.internal.cloudapp.net
 ([20.81.159.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm108203191cf.2.2026.06.06.04.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 04:32:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Sat,  6 Jun 2026 11:32:02 +0000
Message-ID: <20260606113202.4034-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606100823.32067-1-wegao@suse.com>
References: <20260606100823.32067-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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

Hi Wei,

On Sat, 06 Jun 2026 10:08:05 +0000, Wei Gao wrote:
> mmapstress06: Convert to new API

> +	SAFE_WAITPID(child_pid, &status, 0);
> +	child_pid = -1;
> +
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_res(TFAIL, "Child process failed (status: %d)", status);

The child already calls tst_res(TPASS/TFAIL, ...) directly, and
.forks_child = 1 tells the framework to propagate those results to the
parent. Checking WEXITSTATUS on top of that risks double-reporting: if a
SAFE_* macro in the child triggers tst_brk(), the framework records the
TBROK from the child and the parent then logs an additional TFAIL.

The correct pattern (per the LTP rules on child result reporting) is to
rely on tst_res() in the child and drop the exit-code check in the
parent. SAFE_WAITPID() is still needed to reap the child, but the result
is already reported:

	SAFE_WAITPID(child_pid, &status, 0);
	child_pid = -1;

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
