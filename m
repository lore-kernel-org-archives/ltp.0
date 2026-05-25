Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF66CD5BC8
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 10:13:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E03DD3CB041
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 12:13:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFCE23C5AE0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:12:56 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 560FA1A004B3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:12:56 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8b9f2295a9dso104558426d6.3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779703975; x=1780308775; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIm4/xMvHcLonb/T9F3GmXI781IhygD7XJjZE3nFCzU=;
 b=LH5E7QqELpKS4ymOTk1iY3Zk54n6gUl/9HsTP2ErB4PLGQD3wKcF/VcSsxu5us5NWb
 F5ljwXocpQGqjEQbnViqR0x5UNppeZOZnSJhvVlWdfR+jnK+XowS9MDJUa/EjjMtEg3H
 V2j+ZnKdVIkwz+kKuXVXf3bDadYnmhOEhQe71E+w1QSfNPbTI2/uuJ47zygtdK7DMQs0
 Zd8a89NXrhD0dXeoBwO5aNcTlVPbhWXdW7BVd5Z8pEfmZmrLsRf5yCuu/urQc+x8HDJc
 KRYMtwjtlZEVrUmx0Yfm0C2ZPebflJ9dYFVb+7fTC5eFVNQw5Z3il7p5NVHLF35WKnof
 wHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703975; x=1780308775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rIm4/xMvHcLonb/T9F3GmXI781IhygD7XJjZE3nFCzU=;
 b=N5rY5uWMOm4jiI6VILSg8go5/FAcVAQJzHB4po09YZHz4iuUGVWfdhokIWsxw9Eo4a
 MCQSx17mCcE26DUOtMuHIiztpI+7XDJ1UrJmI3uYOUGP9QCVsJtXQZ4vbCjP3a7n/5HA
 BQY74JfC6hE8jCtJySEaFlhMUDQUCKLtWk+RgYsd9mdpbxtufvoYNZcpH/tvWd+LebCQ
 6Z/fQAKoex/+Sz9pjMxMMIFnZdLXzHfBXllcdvnooL/a3uNSYrcBX6r7WLc5loBNq27D
 glR+/Ku3Voi/NKsKa62TbjlDCSkYFS+NyEu4AmdmSew0KcJ0ZCA3+BuiZmtKgjJolxtX
 V6jQ==
X-Gm-Message-State: AOJu0YxJAuEukrnhy6iYrCFAxbUH8fl5mjJfV2dXVvuaG2vWzxalD5O8
 pEw6ql7lOtVOt7sRXmvKZ0kAqbooBn2H/CBWwiEevankFVnemP//9CL8
X-Gm-Gg: Acq92OFxsiEba6CK8sGcOxU4B4tk82Gg/LFlEx3tyTWuA+5bbDXB7hauHaMj26XR/Ct
 IjO6vMN8gEkFQsSoINOsyFhmNYPXuSA8i1giMyEg5VHWYytt4T+vbhFeRsNXz2mu6FCSsV3ZlRC
 yI0PAoC9p5mCxz5ZSgkOyqizt5nzbnC9iYvA2Biezfe6T/xxyTgQEKrTq2D8ibdNzhwADQYkuOi
 5fH+7ZiHcPfBesfaym7upkDc9kycZfiJ2DNRQsB+8ftY6JwdSZpuO7YnY0dD34OcU81iUk7gGNA
 ueDcmbsNrs5teCfb1GrCUPXFDY3pTu05U9lDYpN4JzEJiv1KptMMznxxAAS9jZgXQdafCP4Zq/P
 fPNTlCFt41o9CvlXIWWTp2bnX2JMH9meFIDT3GOpy66wJk+caRr7TEX+CtlFcVVwNaV7KJO2Xsr
 1hcqXiosMluU9H6MebfvucrQdIwpLUUIZBiaXgny3uV9NLGW+l1wZvuayrYVbqpnW3Q9vYJq741
 YexSpMzahMXjCJzUjgxhNFI+0eH+qldCTI2abE=
X-Received: by 2002:a05:6214:410b:b0:8bd:1f2e:7063 with SMTP id
 6a1803df08f44-8cc7b4f1e08mr104678586d6.5.1779703974962; 
 Mon, 25 May 2026 03:12:54 -0700 (PDT)
Received: from
 runnervmg397c.bq20gyclfbtenj4x1aaeq0pzta.cx.internal.cloudapp.net
 ([20.161.28.180]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80dd02c1sm106494846d6.6.2026.05.25.03.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:12:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 25 May 2026 10:12:54 +0000
Message-ID: <20260525101254.4042-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525090228.11895-2-wegao@suse.com>
References: <20260525090228.11895-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect01: Convert to new API
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

On Mon, 25 May 2026, Wei Gao wrote:
> connect01: Convert to new API

> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2006-2024

The patch is from 2026; the LTP copyright year should be updated to 2006-2026.

> +static int sys_connect(int sockfd, const struct sockaddr *addr,
> +	socklen_t addrlen)

Indentation regressed from two tabs to one. The continuation parameter should
be aligned with the opening parenthesis (or at minimum two tabs to match the
original), per kernel coding style.

> +	pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		int nfd = SAFE_ACCEPT(fd_server, NULL, NULL);
> +
> +		SAFE_CLOSE(nfd);
> +		exit(0);
> +	}
> +	close(fd_server);

Use SAFE_CLOSE() here for consistency.

[...]

--- [PATCH 2/2] connect01: Add negative tests ---

> +	fd_unix_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +	SAFE_BIND(fd_unix_server, (struct sockaddr *)&sock4, sizeof(sock4));
> +	SAFE_LISTEN(fd_unix_server, 5);
> +
> +	fd_unix_dgram = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
> +	fd_unix_stream = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
> +
> +	pw = SAFE_GETPWNAM("nobody");

The EACCES test relies on "nobody" not having write permission to SOCK_FILE.
The socket file's permissions are umask-dependent; with umask 0000 the file
gets mode 0777 and the test would fail spuriously. Add an explicit
`SAFE_CHMOD(SOCK_FILE, 0700)` after the SAFE_BIND() to make this reliable.

> +	if (tc->exp_errno == EACCES) {
> +		if (!SAFE_FORK()) {
> +			SAFE_SETUID(pw->pw_uid);
> +			TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
> +				tc->exp_errno, "%s", tc->desc);
> +			exit(0);
> +		}

Result propagation via shared memory with .forks_child = 1 is correct, but
the exit code is always 0 even on failure. Use `tst_exit()` or exit with the
appropriate code so that unexpected crashes are also caught by the parent.
Alternatively this is a style nit if tst_exit() is not the expected pattern
here.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/26394925194

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
