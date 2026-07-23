Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC093C531CB
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784809475; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=PGmCZMAobIIAZbekWnRqSJF9KAxzF1ApFlMu+l2lzAE=;
 b=bl00QqBeWEAxpOkSlO92p27t0shVXkj9kYxxISp6puaBSbyqXHwscyhCiK8QhRG1m6PLi
 vKoHRuVRi/Kln1HOXxxpIL3mUc/ms6CdI7z1KW1myOM1XPK5B8VrloKWbwG/hJHAPLl0m8N
 wIZFazuxjse86LBDFvj1CUf+M59jvdM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEA533E55A1
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 14:24:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 597343E1C33
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:24:17 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1D8C1000411
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:24:16 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so285452f8f.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784809456; x=1785414256; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nruyq2TYS9uYeQ3XIif63vdHoJDJ/15POak+GgR+nHE=;
 b=Xnlcex+x/J+HDz43oy9Nm3jFm3Qb1tGCzuQH0n/DUm6NZi8Wr8qhzrppUpgs4BXS5B
 4QKRA+Qc1WrJqpgFOacvOU5QzsIWL17tPtLqU8qrc5PdRYIY6It9s/DsOa3sogSOHKPl
 xvttwkvUjrtyi4JMNFVbQrSGKdxeAHX/LsyIRESWHZepOic28NC7LOXBwtdUpSO9CLwd
 8vl+vfeJdGiX0BO1xk8XfAkWkRghUg8K53WgZiWug15q+yDwH2fW2LaP/zQoZdRsgRJ2
 ksLPGCeiYMfIGH7H144rijS1fuEd1bpAOVmqUpZtDL3+JcLP3JbfnMWgJqkCgqRxNuJN
 y9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784809456; x=1785414256;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nruyq2TYS9uYeQ3XIif63vdHoJDJ/15POak+GgR+nHE=;
 b=MPFr16Zb8+daRV0HWKRU2yiufE3muEjWHLOl22RqHiFTwMb6NJfSXqg2MB/pWOpEIl
 kTEdCA+cZdIFzIF6ZM1c1d3oKhwiqGK8TaaskIyDKVNrNIMgSQUo10QdVpRoTqgUlTyL
 7zt2e6Y5Pv4l9g6Agye3AD1XpPlQxqwVYDJ+jiOmrOs7D/fpt8MVupmTSAFkw7Pzm9Rs
 Oqqp5yzvDFlvMQtMWztnZYFC+buGnTW2P0ZlsqScPkiBRRTLpFQu9H7Olc+CJXvIowiZ
 fqFqC4cfw8vffTB4kaqBMHUy+4adpP5BtgD7RGdnVVkZtAhNbArep5i/IAAKmj2JAKGp
 uy9g==
X-Gm-Message-State: AOJu0Yxz3rJgA+l40EhM1xWn7MTrGAb4+MMVQHWLE4YXN3ohQ1lwLext
 sgd3CbskxeUz8Il7o/HN1aPlBk25rH1aXu5dYl94nBnWQuglAOrSMp9DiL6FkhN8i9I=
X-Gm-Gg: AR+sD12sKpbgYcNPDc/Qn9CqoYVF7BbvR3pu5kw7cSZLQmtNYsLjtyw9wIKJvsLEXNi
 8ryDvU6f2q8kCqF2h03ReJBlfb059W9yls4b3WYx+dGn+T+gWkqiK+TWCzjFoGQY+I7wEdB4/nj
 Jr0+FinITa32SgRsM/FuDB0+7fPIYCAjoabpKdMwQWOaLy8kr89OWdUFGG2IXKFn/Kg3VNslmOz
 /RbN12JiAT9qCiOCikSHaENyt/N42tVcaFOR+61KXk2Gmn1msYpGOX05egk6m/Da0AYTFELng8c
 vPOxAwBzKD2Lg+rrhxlpOXQF6yLplyjFeNyV+oxvSQq5wgfOwJ50RykctYwNZXT8xjULFyamdUU
 c0P1YkhAhNSaz0+sX0g4MdbapoqKN/gyvR452WGtqXphCzSHVoj3DJl7+PnCao6pmTJ/4mViN17
 +98/U5pt+9TGWf7369sAiJRjSf7g==
X-Received: by 2002:a5d:5f47:0:b0:47f:6e8b:699c with SMTP id
 ffacd0b85a97d-47f90254094mr3088729f8f.14.1784809455969; 
 Thu, 23 Jul 2026 05:24:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6d277sm15623930f8f.32.2026.07.23.05.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:24:15 -0700 (PDT)
Message-ID: <6a6207ef.8c9cee7f.1e6be1.04d9@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260721153917.64722-1-mdoucha@suse.cz>
Date: Thu, 23 Jul 2026 12:24:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2026-53362
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Add test for memory corruption due to miscalculation of socket buffer
> size for fragmented packets with gaps.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Bug reproducibility verified on affected kernels v6.4 and v6.12.
> 
>  runtest/cve                                   |   1 +
>  runtest/syscalls                              |   1 +
>  .../kernel/syscalls/setsockopt/.gitignore     |   1 +
>  .../kernel/syscalls/setsockopt/setsockopt11.c | 171 ++++++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt11.c
> 
> diff --git a/runtest/cve b/runtest/cve
> index 3bbcfd6a2..99d84270b 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -88,6 +88,7 @@ cve-2023-1829 tcindex01
>  cve-2023-0461 setsockopt10
>  cve-2023-31248 nft02
>  cve-2023-52879 fanotify25
> +cve-2026-53362 setsockopt11
>  # Tests below may cause kernel memory leak
>  cve-2020-25704 perf_event_open03
>  cve-2022-0185 fsconfig03
> diff --git a/runtest/syscalls b/runtest/syscalls
> index c84c32a6f..949ad7622 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1524,6 +1524,7 @@ setsockopt07 setsockopt07
>  setsockopt08 setsockopt08
>  setsockopt09 setsockopt09
>  setsockopt10 setsockopt10
> +setsockopt11 setsockopt11
>  
>  settimeofday01 settimeofday01
>  settimeofday02 settimeofday02
> diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
> index 5c05290a5..58cc82d9c 100644
> --- a/testcases/kernel/syscalls/setsockopt/.gitignore
> +++ b/testcases/kernel/syscalls/setsockopt/.gitignore
> @@ -8,3 +8,4 @@
>  /setsockopt08
>  /setsockopt09
>  /setsockopt10
> +/setsockopt11
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt11.c b/testcases/kernel/syscalls/setsockopt/setsockopt11.c
> new file mode 100644
> index 000000000..5f09291b3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt11.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC
> + * Original reproducer by Massimiliano Oldani
> + * Simplified LTP port: Martin Doucha <mdoucha@suse.com>
> + */
> +
> +/*
> + * CVE 2026-53362
> + *
> + * Test for vulnerability in socket buffer size calculation for fragmented
> + * UDP packets with gaps. Reproducer based on:
> + * https://github.com/sgkdev/ipv6_frag_escape
> + *
> + * Memory corruption fixed in kernel v7.2:
> + * 736b380e28d0 ("ipv6: account for fraggap on the paged allocation path")

We can add an Algorithm section to make the test easier to read.

 * [Algorithm]
 *
 * - Fill pipe[0] with a known pattern (0x42) ("canary" page).
 * - Splice pages into a corked socket so the skb references pipe[0]'s page.
 * - Close the socket -> the corruption causes the page refcount to drop
 *   too low -> the page appears free while pipe[0] still owns it.
 * - Pollute all free memory with 0xBD (inverse of 0x42).
 * - Read pipe[0] back. If any byte changed, the page was reallocated
 *   while the pipe still held it -> the bug is confirmed.

> +	/* Splice input pipe buffer page into socket */
> +	memset(buf, 0, TEST_MSGSIZE);
> +	buf[TEST_MSGSIZE - 6] = 1;
> +	SAFE_WRITE(SAFE_WRITE_ALL, pipefds[1][1], buf, TEST_MSGSIZE);
> +	splice(pipefds[1][0], NULL, sockfd, NULL, TEST_MSGSIZE, SPLICE_F_MORE);

SAFE_SPLICE() here.

> +static void cleanup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < PIPE_COUNT; i++) {
> +		if (pipefds[i][0] >= 0) {

This should be != -1 according to static definition and the SAFE_CLOSE()
bahavior in the test (it sets to -1).

> +			SAFE_CLOSE(pipefds[i][0]);
> +			SAFE_CLOSE(pipefds[i][1]);
> +		}
> +	}
> +
> +	if (sockfd >= 0)

And here as well.

The rest looks good to me.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
