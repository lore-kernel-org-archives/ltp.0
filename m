Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4BBC5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 10:42:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0FA63E5A46
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:42:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7B23E25FB
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:41:50 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 851A2600AA0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:41:50 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-381072761d4so536114a91.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785494509; x=1786099309; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HA/qMPZLYftyJWs5mgKwPJLVSwrJ2RPf/w0T0nioJt8=;
 b=P3oNw8/WlbMR6IQRlUk84tWJY3QB1B3RsDsWYLGewM712yp2kkADKai8j5/z02XA/6
 hv73HYKgHUix+Hq6NL+vBdRoX8EfJobpVLUgdAssOxVzLYMbTfMu0IfbUv5iTF0Af5qo
 dE8XKjxbFmW8o6da3nhcxqwCyU24Q9l/TyQeV7Coa+TzMHH5gwnwH2wgBsjbnKUyvou7
 fEIULGA+K66H5ir0+t7wRGYthI95d+7vIhqhuFlRi0gx2VJaAO1Fb1iLyvs2Ais8cFGc
 C0U3uLBPLt0I5MypWnHwuJL+8Q2yowonJnafzEKuleJ7v71NK7ocWpWKuRPytndwUNrg
 cvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785494509; x=1786099309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HA/qMPZLYftyJWs5mgKwPJLVSwrJ2RPf/w0T0nioJt8=;
 b=YrjIJYR38cJYHgWYUBKewJJLrkiqMHM3SlFg0BviE/c6hJKsgFnciCKO7YyIx7TZuE
 wXYappnOY7i7OfwpbDxHxFwZ4Z6r8dwmkwI0kv47E7YO4LewoGqcaJxq20yamw7jhRl4
 /+O0XnRvpd+xYfeY3rAsZv9+5AIYzjvwRzwfICCisxP5++JIexNhXwH/+sIgjLLnad+E
 Vr8stKwnyV8HGe3xViLUEZjKebACi0ApuMJ+gdlIU9afvkSg3KZBMhY4eUuCUvUyHuxk
 JBZVDqO+KVYQcn1j07cZsOVa6oJVpfBy9KJCHpCPOdmmyf4T2BM3kGMtJOUTnva9NKaj
 wGrQ==
X-Gm-Message-State: AOJu0YwvM60ifkdaGJ7p86oNLjKPvVPj7IbKlBkUnp/0b1LL6H282EPX
 FQtM7+6Gg985hBrc0ZzHoy/ORDpSAEvA9vcx3WQ9BVdonaxRjj4lfLv5LeGaJfuA
X-Gm-Gg: AR+sD12wFamDiZtElOJiT7O322M9lyvQ2+phNt93L/SDgUEU7Wt+I6Jy11zPvYlWtc8
 iWRDBp0cIx+NpHcCZkbHO8sofLAb4MtV9n/e9wRYr02JStecPiDY/et3feJEBjr6ABwMOMkuqsz
 F8JofiBlrESbTwg3Fe2bImDDZo02oJoDgXrOKO01qwv4avZpPr780YiSVHgHOIGN8p6yJOlV3BH
 B6WviQ6BEIqJhUPCCl8uscq9WmYR1R6FQGzf3oikw0dthQjrXHYkiNG+sgeqX3mwbSHSaW/LxbI
 e3kBNfPd0WHkjmTzTiqp5Le5QMM2JW03jaRUnf8v5b7RMbpjU56LELxMngr5AT/dDX05R1GLHbO
 36/Pr11zafe5R1gOZMqa42jXB3r6l6P4otePeLwG+vk0zvFezKFnh8j979uaBazseiCX2xrSTa1
 rv0X0ganHY6np3C3EPz5zHaUfpu6VnF4wh4oZVWSsnfx8TwVk3neND5bFJvTBUv7R3LMbYPF2gu
 ujBNmggrvbkcp4CQ/118jf69Y6U9+nwkLhgFStf+7H7ZJIoasS+bOLkJoL2n9lhbnSs0N6qEfh+
 cw==
X-Received: by 2002:a05:6a21:1f8e:b0:3c3:bdce:27c1 with SMTP id
 adf61e73a8af0-3c91b381c94mr1421085637.51.1785494508916; 
 Fri, 31 Jul 2026 03:41:48 -0700 (PDT)
Received: from
 runnervmvrwv9.s0dhqrvhcoxedfv3gzip5zasqg.dx.internal.cloudapp.net
 ([172.185.54.254]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e044912sm5379539eec.15.2026.07.31.03.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 03:41:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 31 Jul 2026 10:41:47 +0000
Message-ID: <20260731104147.9091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731-cve-2026-64600-v3-1-192da4ddf707@suse.com>
References: <20260731-cve-2026-64600-v3-1-192da4ddf707@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

On Fri, 31 Jul 2026, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

> 	while (!stop_pressure) {
> 		SAFE_PWRITE(1, fd, wbuf, blksize, 0);
> 		SAFE_FTRUNCATE(fd, 0);
> 		SAFE_FSYNC(fd);
> 	}

Could the write be synced before the truncate? The truncate can discard the
dirty page and delayed allocation before writeback, so fsync() only persists
the empty file. This also differs from the documented
write/fdatasync/truncate sequence and may leave the XFS log without the
allocation pressure needed to widen the vulnerable window, causing false
passes on affected kernels.

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
