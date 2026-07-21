Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E747AC4452B
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 19:28:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17D943E2137
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 21:28:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33DBB3E2137
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 21:28:20 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF2A41400DAC
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 21:28:19 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 d9443c01a7336-2ccb0e85312so65468895ad.0
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784662098; x=1785266898; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=euAAiClQioTIl6+jvwppa+Nh3hSxN0f9584oOkBVkk0=;
 b=OQMmXVRbRMUF/VF5rlyc1fPYjBLLtlo2E0SeSl/iqPXvKDQy9V5Vb5Bbzdxg3Xmajy
 o0KhcGyLxIlw0H9n6qTJmxOp2lryWjO9jb9zhWcTW4JMr7CLnlpsfneSStakj8M19PB6
 pCFUr5Ib2xhmp/+TUxrx4iQIU+fAQRT54Kffju6mFwuBVSHyjirkdvwQhGzmHBiV9LyR
 jsa6/5H5Q5VUmq+PxpadhkHzZ7+6Ri1m10tO9Pjz2D7uX6i2XbQfRoI8eNzeO9F5TlnI
 5nKxqOvdMBeyQt6o/Mu9sZUtDAbBVsX0i8S3m4rIMSqD/bOOaNmEyemb6hGf1bKZHkJ+
 LxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784662098; x=1785266898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=euAAiClQioTIl6+jvwppa+Nh3hSxN0f9584oOkBVkk0=;
 b=pHaerDVsOTZXLxQtSN0qwklOKAPCDNGe4131LmTCrSeGydzHd2jkxcPmJqTgL7/HMO
 8n6UJweZxHql6B9Aef5IsiPciMyxWCmvcuHpLBRo4MZotqehwheO+OIHrQPfLtZbbiUn
 E79CyuidIF/oWNeOXBtNx4O21gTkGrQakm00FQB+qQ5TluNODfOyQsJ0v820wcX2HSbB
 a7tbe4emK2WZvFN+OP8BtMYlavDnR+F4ACsRlMacpKQ/wWJjjXmpcJbIJl0/PBLb1zrP
 DOb9OtKesKCH3AG42+0igH6KONogPhFA/kxOpuyF+NgUzPitpkuKeh+iwwaeXQZ1QcUa
 G/hQ==
X-Gm-Message-State: AOJu0YySaYkgjMldZeO8tpQAYcQg50M9tprzrnxrb2nk5kmli+bSJP5t
 8hWxsN8l755NbKl9v36aoa/jUeiyXJvyblYav2Kz68RVoL0zfqezvgXZ
X-Gm-Gg: AR+sD11PAfshinnPFBfZhhOhE0SQI3h0Z99RL3pV/Rp3JfDiL8rzaXr2rlcIk/e6Ced
 GtkVw4psZywC0pOC9Z4nDTfo6ani0U3QIKyq5eRIe6/VEUdbbG6panDVL9VnVDPpooIG369oDdx
 axRnZyOEMCnzhgEhfvC0P4gS15+TWIiq/cuxXKHBlQWeplt1KJkvMht5kDq6LSaWfwxKe2GbhBq
 6RNu+uMIohgsJn9b3Qvx9f8Uwm/MXp7QTr+Wv/YjcWgXFSRmWf9GEOVlUdCwr4M2Rt5qELaIH/6
 y4DXEU0v215ndjQyrJ8iY8g6ZFnxJSnro7EdgJT/AzPbUFUG0G1KFY4nMn9V2cn9bnaMcPy63Dh
 fXFebjFhvf8Mlo6ZLuocDxH+2ik5fVr4BdnQpPS9q9j2slptWRAUB9+sSQYaGGLYI2jeu3CdQur
 f8Awce9UNF1apxbyDsZ0L0wWPRbx8AWgxdm3qmPs0fvOCFbleOYBPpsnkmpx8N359Nld2bjtzD1
 nOtYxPlb9BD0tdbHg==
X-Received: by 2002:a17:903:19ec:b0:2c2:be43:39bc with SMTP id
 d9443c01a7336-2cf34964e80mr231545245ad.22.1784662097819; 
 Tue, 21 Jul 2026 12:28:17 -0700 (PDT)
Received: from
 runnervm3jd5f.5ghra5x4ztfulfezz0jwlsppfe.ex.internal.cloudapp.net
 ([20.102.235.85]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f2e65f3sm1947525ad.45.2026.07.21.12.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 12:28:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 21 Jul 2026 19:28:15 +0000
Message-ID: <20260721192815.8592-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721153917.64722-1-mdoucha@suse.cz>
References: <20260721153917.64722-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Add test for CVE 2026-53362
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

Hi Martin,

On Tue, 21 Jul 2026, Martin Doucha wrote:
> Add test for CVE 2026-53362

> +/*
> + * CVE 2026-53362
> + *
> + * Test for vulnerability in socket buffer size calculation for fragmented
> + * UDP packets with gaps. Reproducer based on:
> + * https://github.com/sgkdev/ipv6_frag_escape
> + *
> + * Memory corruption fixed in kernel v7.2:
> + * 736b380e28d0 ("ipv6: account for fraggap on the paged allocation path")
> + */

This high-level description block opens with a plain `/*` instead of
`/*\`. setsockopt10.c (and the rest of the test suite) uses `/*\` for
this block, since it gets exported into the RST-based test catalog.

As written, this stays a regular comment and will not show up in the
generated documentation. Could this be changed to `/*\`?

> +	/* Splice input pipe buffer page into socket */
> +	memset(buf, 0, TEST_MSGSIZE);
> +	buf[TEST_MSGSIZE - 6] = 1;
> +	SAFE_WRITE(SAFE_WRITE_ALL, pipefds[1][1], buf, TEST_MSGSIZE);
> +	splice(pipefds[1][0], NULL, sockfd, NULL, TEST_MSGSIZE, SPLICE_F_MORE);
> +	tee(pipefds[0][0], pipefds[1][1], PATTERN_SIZE, 0);
> +	splice(pipefds[1][0], NULL, sockfd, NULL, PATTERN_SIZE, SPLICE_F_MORE);

The file already includes "lapi/splice.h", which provides
`SAFE_SPLICE()`. Both splice() calls here use the bare syscall
instead, so their return value is discarded. If either call fails or
returns short, the reproduction sequence silently doesn't happen and
the iteration would just report TPASS without having exercised
anything. Would SAFE_SPLICE() be preferable here?

> +	for (i = 0; i < PIPE_COUNT; i++) {
> +		SAFE_CLOSE(pipefds[i][0]);
> +		SAFE_CLOSE(pipefds[i][1]);
> +	}

pipefds[][] (and sockfd, closed a few lines above) are not reset to -1
after being closed here; only setup() initializes them to -1, once.
cleanup() decides whether a descriptor needs closing with a `>= 0`
check.

Since leak_pipe() runs in a loop (up to 64 times), if SAFE_PIPE() or
SAFE_SOCKET() at the start of a later iteration fails (pipe(2)/
socket(2) can fail with EMFILE/ENFILE/ENOMEM) before refreshing a
given slot, cleanup() would see the stale, already-closed descriptor
number from the previous iteration as still open and try to close it
again. Would it make sense to reset the relevant slot to -1 right
after each close?

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
