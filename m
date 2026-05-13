Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E45BCD4F21
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 16:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36D2F3C24C2
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 18:29:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE7693C0D0D
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:29:32 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 527231000985
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:29:32 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-902deb2412fso766505585a.3
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689771; x=1779294571; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmdgDDTo8FRMZ+x8J1P6zCWcQksdUGn+UM47C+z8AtM=;
 b=RUPdKLOnB+NIxFbiD7+Q553vrmomswE7FJ1K/3e1zGMUycEvs+8cewe8VsaHpL0Z+M
 TYGU49RtkQoZsJPlJcvbZf61V/cxmYMGSk5IuGBBDDsZV7f1GPxLzDB60DTeWtP0VcKo
 24nEi8EiMDky8dIML0+pMTtWYR/RzdqDOTfDUgmRaUnkJO0GCfrBTg5+bpbLRFyWOybM
 VJjYxukpsUKGpHCy74DivhDu87AEcwlGdgqIJWQy6bBGCwBfO5hOym3auBKFCUb63A9h
 MJMcKHZ9c5jAGrpBGWZVsj3SIRV88hbZjoTADc8dMCOpPCa7upYHF9Ax0nXy7JNSzdtQ
 dU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689771; x=1779294571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rmdgDDTo8FRMZ+x8J1P6zCWcQksdUGn+UM47C+z8AtM=;
 b=gRwfjhre9qSVk1nVrX52mLQTqGzPmjkJqUKooIneVhmvFdjpTDr1fg4HT7KnDoCLdh
 SeoXwGFFOkR6hRw9qXfbctNuq2K82fM5PFDf+pRUsh+vxnI6q56yONulj1D7SylRK57I
 /Las7RslZjc3yEyuPiGKZOjqKFtZe5dNSkmXCOT09AuD190ZEZMvFaPNsOqki26oxlax
 8ONBEfdpULvssuRhs1s1JmVwitj1b1pB+NbsEStWx2PDnKESY5LWBpOJ8zGXj00iu/aH
 LEV1DJ7UPVZ4DPuo8mHAO69GaR8EOQvIaTBKVvaDI5laKVCDvrBP7WyroyMu92H56Pji
 4yeA==
X-Gm-Message-State: AOJu0YxLgQ6061Y9qtgUs3Q2MOSo26yAn5MdJHcON8KzXNTje/TTrz6P
 AQXTFqI+sAuj64D8+xHwpfQulIwsis0niFiFnlPvkELLU8eNdJDtYe7D
X-Gm-Gg: Acq92OG7qDACwPhEGEY5HXZID/EpdW5UOr+xIwtRtzFjcbUMdDYzwiBQ1MWx/SRHHrP
 clui6lqvwf0hiHvQh4CN6CHgl3LvLPafDQmf22WhrgMjNIShiVxueXK46JNcj2PGIiQrb5KktTq
 9Qtb/OvTnTHpYJ2uBmEfEMFAHK5aV4QOn3WLZu4enMNRUfRScwSSgc/Qo7sBQmNNlKZQ1yzaani
 L2w6JFfeBCrki11P7aU2hjuLC+esU7UQSqttLDmYdBn5dS3e9QHeux2q++pE+6dHkocqKhkG0iJ
 GxpD9JWBp9zl9+hJxhnGhDjzL+C/dWw3Hm99KnWaFVg8iGbzr087QxHjDaYUIE4za+4Byc2GWNu
 i2TpZOb27nCcvp+SymSoUW3A23Oh9ORCLjwcrT31nth116ASIixJrnLImadGHFOxCF8h5SP2ruz
 DyNj1S48yHEEUzHGcj+xP39SbbguxVaEYg0/isF4IaaTGDEQpIHAjo+VAzLRm7+B+olX0mmoYo4
 BNCsVxYad/vWTvXE+K/3P31s902P9P1ucr7Ze0riIom394Sfls=
X-Received: by 2002:a05:620a:469e:b0:90f:5da3:950e with SMTP id
 af79cd13be357-90f888c31a9mr675881685a.9.1778689766341; 
 Wed, 13 May 2026 09:29:26 -0700 (PDT)
Received: from
 runnervmeorf1.lca4z4pwcdgebph4hp2vtpj1rd.bx.internal.cloudapp.net
 ([20.163.133.232]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53ca982a1sm411305066d6.38.2026.05.13.09.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:29:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 May 2026 16:29:25 +0000
Message-ID: <20260513162925.4072-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-fragnesia-v2-1-07a822c66cbd@suse.com>
References: <20260513-fragnesia-v2-1-07a822c66cbd@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sockets/xfrm02: Add ESP-in-TCP page cache corruption test
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

On Wed, 13 May 2026 17:35:03 +0200, Andrea Cervesato wrote:
> sockets/xfrm02: Add ESP-in-TCP page cache corruption test

> +		SAFE_POSIX_FADVISE(cli_fd, 0, 0, POSIX_FADV_DONTNEED);

posix_fadvise(2) is only valid for regular files; on a socket fd it
returns ESPIPE, causing SAFE_POSIX_FADVISE to call tst_brk(TBROK) in
the child and the test never actually exercises the corruption path.
Replace with SAFE_POSIX_FADVISE(file_fd, 0, DATA_SIZE, POSIX_FADV_DONTNEED).

> +	/* Let the espintcp strparser process buffered ESP data */
> +	usleep(30000);

Sleep-based synchronization is not allowed (G2). Use poll() on acc_fd
waiting for POLLIN to detect when the strparser has consumed the data.

> +	acc_fd = SAFE_ACCEPT(srv_fd, NULL, NULL);
> +	SAFE_CLOSE(srv_fd);

srv_fd is not reset to -1 after close here; cleanup() will find
srv_fd != -1 and attempt a double-close, hitting TBROK on every run.
Add `srv_fd = -1;` after SAFE_CLOSE(srv_fd).

> +cve-2026-fragnesia xfrm02

Please confirm whether the fix for this CVE is in kernel 7.1 (current
stable). If not, this belongs in runtest/staging with a [STAGING]
prefix in the commit subject.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25811801064

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
