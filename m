Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D6606A326
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQNWcISE
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00B623EA99F
	for <ltp@archiver.kernel.org>; Thu, 26 Nov 2026 04:11:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 928733C774A
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:11:23 +0100 (CET)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 11A2B600961
 for <ltp@lists.linux.it>; Thu, 26 Nov 2026 04:11:23 +0100 (CET)
Received: by mail-oo2-x05.google.com with SMTP id
 006d021491bc7-7033e26cb19so1961722eaf.0
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795662681; x=1796267481; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8jBw9lE3KbU37V7GIcSPrHmj7nF5l3iwondiTqBKzxA=;
 b=jQNWcISEwmZrYpI36odGKRXWuH5IOSMdC6eyq1eJkNc4ZtddH+QlyQLEjK+O0dOlMO
 cKlgDD7uJE8mJU6mPwI3ipub5YvQj4LYVikKANfPnT7VvaozJJk6RFov12+jLjzUViB2
 2/erBPoP+HjsKi+W9fUgTAFzoqnWJo8oaWaBpDOA5kpHqVj4XsuA90AqR+3z9Pmsv4ZI
 bDw/WQUrMbOEXeSkaA8iIGePxevycy5f28pq7iZNlzTVf5aelE3jmpMFgZwQIyuKd/cD
 mR9jLb3Uz59JWfmcgSwfnpRT+ZNabEUjjer4fNKrIZTR0dn8oEqbAfoRf2uGVaqT+0QN
 QdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662681; x=1796267481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8jBw9lE3KbU37V7GIcSPrHmj7nF5l3iwondiTqBKzxA=;
 b=1RTu1ZWn7cgxvKinZZqRO8jkpNEJf92xYwoR5NUuqNa+IcE4hXQYDmcU39+yarOyFN
 Q1edDfaqqonLFg+kc1+BH5YCIASkw7ASfJgfccs8H/OUjBP5VYIBmQdNIyjC1tsKyHEv
 xlYIOcaY/JHHwps5pFx/w87Pe5xtpbCFJvYfYRJ2B7lcbmT+iMrlkOX6slV/lyvdZ5vu
 MaQUoiSdGo5nLCJcYZ78T0RHyo11ktemVH0SWFt5ShpVQqan45lxA6ANRFyynlSEC22b
 YV2kkpoxPA0OgJss1mj0bPuuiddljEaIAKflDxejv7l5sNqwe3aJMUzdYC+XQyt4ppCm
 Hd3g==
X-Gm-Message-State: APuU4Z93j5aw7Eu5VHpsaEMnquvGIUtGuT7E8eMFJXUkv0ZtifqtDawZ
 gXF7k1jX4i5ou8dkBtyIRgwoW+VS5C3SI0uDv2POwOKhBNNq8h5VfHOS
X-Gm-Gg: AZFdTZfXn9O3TCMaNMBrargmWQRI6YU1VTUx9VRjKN2o4v+TAVJ6lSyKiuLSQTRj9qU
 ASOMMj5e4I0m/A90cG/RF2F/1heh0Uubk9Tf5de/SiUJOm2OyfsbQjl+SJVoXp8TAH8LswYDHpE
 tGPyT+6EtuB+nB+93LEp/NoQY7FM4BoyLzftw6TnL03US8+kFNJDF0c/AkZ58fPgfFeGk/1cMgt
 mRHWAKXIM/wG7+zVjyTBm/UX0J5bTeXD/ioaH7UoTDNtgrEa9WcQ1xI+aAOY1hx9n7akhocu0I7
 QcXTdgJdxOXVhmJA4Ag3UaZnS7PoJ+ywMAcciroGovOy1mRM/iN3uWOKvDZiXVcHS7zXi8Ae35S
 Amng3WHqo4RBVgLYrrtwms+ww+mZ2BCHZ+6KQwWjxOsCxhG7vHUjS7m3GWtYAAaWKSCuO4n2ibp
 NctxhN4rOLQDoUy+g+XqqsHLlrESbtrWz0QPFP2+3MLmJV8FU2UYs9DX2Pbz1LvkFZ4XVENDr2U
 i/JKKUVzlHv1VBIi8GPQSTDsLo0t1PQxDhx3rtt9tvDAOxsY+DTpCnjDZxwarReNULoL0vAYABO
 CDdL35pK9tjiu2ltddYovH+LpTq6utC6tLvIW/DttszTjoKvHRF11GcfOTkYknLmuL479LSIndI
 z6nRtlKsIhOo5B84nuv19t1ORSpMRYIM/3PoygsdFM1ht5DN2QULYXkUWP8X6
X-Received: by 2002:a05:6820:a74b:10b0:71a:fe9a:6e91 with SMTP id
 006d021491bc7-71b395fe3d3mr11540386eaf.84.1795662681543; 
 Wed, 25 Nov 2026 19:11:21 -0800 (PST)
Received: from
 runnervm0hi8g.qh5nfne4lk5ubgjehfayj2ylnh.gx.internal.cloudapp.net
 ([9.234.7.244]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f784fsm14447619a34.16.2026.11.25.19.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:11:21 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Thu, 26 Nov 2026 03:11:19 +0000
Message-ID: <20261126031119.3813-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125211719.759525-1-rbranco@suse.de>
References: <20261125211719.759525-1-rbranco@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add tests for UFFDIO_RWPROTECT and
 UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

On Wed, Nov 25, 2026 at 10:17:16PM +0100, Ricardo Branco wrote:
> userfaultfd: Add tests for UFFDIO_RWPROTECT and UFFDIO_SET_MODE

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
