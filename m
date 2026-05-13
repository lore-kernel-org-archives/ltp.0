Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E10CD37AC
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 19:02:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DB8F3C6603
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 21:02:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AA4D3C6118
 for <ltp@lists.linux.it>; Wed, 13 May 2026 21:01:58 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 820F51000A0E
 for <ltp@lists.linux.it>; Wed, 13 May 2026 21:01:53 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8b81586dff3so82705606d6.1
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778698912; x=1779303712; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2edI8OmCHjwwlWDHTDoILY7AdQVkOgFc1bVYTqnXAY4=;
 b=ISojle9M1UZQxD+ddx+p3H/sCF5lCjBuojNiEIrMPiAMmJJwTqT/PC4UL9DHnf/h7y
 GHusuwY51qT4J9SmlE++7ZudeJvGhwdfPY7XEl4wihCynUdCuH63BqBDDnFK28pQEYz9
 0ksb0SMKTzrWuG9Zcgt5cszKygqk02EIc4WJQJ1JmU0wRCZaTEKA0qlqRWwOSxImbp1L
 Swp9gQtn08iUYgyTNmhcOgR3rjyNl2ah732hO+vH+oSHYkchyYVl6TIY8PUoUbraEW7O
 KQrk9Bl5ciEPypBf4NUlD0uE1/vEsPtZfnf+hirTZuh+7J+/J3RAJeHi7ZAdJy2L1cfV
 F95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778698912; x=1779303712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2edI8OmCHjwwlWDHTDoILY7AdQVkOgFc1bVYTqnXAY4=;
 b=piQaabqmTUTIn6oGg5kY2MVatrzhjwaZ5mA95VYntLI7l+Cy1vnpZjXgEA0UYqfXEf
 YcJ5Zoi+w36gbYtEu9YsibscxADU6jG3VsGH3QoencQ4tM2B6mOyBpKBSbR5fCWfMPvH
 sM4QDaa+eFcbLhxL2MpUOaPPwfQ6c6z/aFKSIem5XcxQdtO7DtfrxKiA9X9I8CX82kEC
 MkAYUo1tkZb8aUPZEfiDn3EkJNxMcJHXbj4msN5fjHOFTwUpPLHDFC9jbH5i0g18Jntc
 o5NOiR8TXtjnPKdgTyzEDMeDRXPI7QWppYHl5tmzbOt0YmZJuX3MCDdJ4UDQq/nC+wvu
 I72A==
X-Gm-Message-State: AOJu0YwrsksTFSdbZRSPFEWC+Dsgi/nWyActveeCyDdn/nMJEGUtyxRT
 kBoZSRJaIeLO5kbBRRAa+x5+i8zrHNNqFItwBl2jHMfQSmV+kWVxZYGW
X-Gm-Gg: Acq92OHtf24t5KfM7IaWyfYPefe7gzMr4dTf80QzXd+v5cWcKOV4hh2Rk4dQcdqqYmc
 3fHkcfdVDS84SzdRoZv+nQGxb5PECMvv4n6BYr/xran6N1JKd50UrabobEIE/MfbPzgiIfnmO68
 hNww04vYibezjb0XRS3kKfglMCVrlal8DYQ7hHrf0mzIkhaB2tkBNbAY75kouOgv2JjrqN3klKk
 hqILizYamTAwZ8hlONMRUCtqDPLbO94c/qPYw8wMLYSNfTA5sS/4WjmJ9MEaAKNU6oTIIjS/8O4
 G3sdOzQp08bFrYLoLPOcgeKyFPwle2rOKvmoXfXDDs2pSDc5eBnhxJKnFyhclhGnQCYmfuLUa12
 qAWL0wxnE293Zy1ItxduIKgBEVCAoFZNHNGpnoWPRGlB0NkKF4CQVV3XY59M14/792NURcHMJCC
 5VljIrBuO6krH00XS9IL+OqIdHRnNgxAAu7BUPfOMQvAx75TguqCrRLP2F/DLYsdhTcVNHK4tjE
 bUZNCNd6b4dBvNA9i/tniVPXaCQX+h7BkRKeTE=
X-Received: by 2002:a05:6214:428e:b0:899:fd80:f79f with SMTP id
 6a1803df08f44-8c7bc91b235mr95457476d6.23.1778698912080; 
 Wed, 13 May 2026 12:01:52 -0700 (PDT)
Received: from
 runnervmeorf1.blvezttv0b3ejdl4gomqurzhhe.cx.internal.cloudapp.net
 ([20.161.67.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908f0601asm4586956d6.17.2026.05.13.12.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 12:01:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 May 2026 19:01:50 +0000
Message-ID: <20260513190150.3890-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-fragnesia-v3-1-50417c8a1b47@suse.com>
References: <20260513-fragnesia-v3-1-50417c8a1b47@suse.com>
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

On Wed, 13 May 2026, Andrea Cervesato wrote:
> sockets/xfrm02: Add ESP-in-TCP page cache corruption test

> +	/* Let the espintcp strparser process buffered ESP data */
> +	usleep(30000);

Sleep-based synchronization is not allowed. Use an event-based mechanism
(e.g. poll the accepted socket for readability) instead of a fixed sleep.

[...]

> +		splice(pipefd[0], NULL, cli_fd, NULL, DATA_SIZE, 0);

SAFE_SPLICE() exists; use it, or wrap in TEST() if failure on patched kernels
is expected. The return value must not be silently discarded.

[...]

> +static int srv_fd = -1;
[...]
> +	SAFE_CLOSE(srv_fd);
[...]
> +	if (srv_fd != -1)
> +		SAFE_CLOSE(srv_fd);

srv_fd and file_fd are closed inside try_corrupt()/run() but never reset to
-1, so cleanup() calls SAFE_CLOSE() on already-closed fds (EBADF). Assign -1
after each SAFE_CLOSE() on these globals.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25819929958

The agent can sometimes produce false positives although often its findings
are genuine. If you find issues with the review, please comment this email
or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
