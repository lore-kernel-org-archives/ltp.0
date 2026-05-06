Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0006BCD3439
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 20:28:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F9A33E6AB3
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 22:28:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6526C3E6157
 for <ltp@lists.linux.it>; Wed,  6 May 2026 22:28:13 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6355200769
 for <ltp@lists.linux.it>; Wed,  6 May 2026 22:28:12 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c1a170a50so267664c88.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778099291; x=1778704091; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HplWS8hK/qwjkRv13WCyYX+1QW1gUWjGmozCq+FAV60=;
 b=kpNZ+BFimnQzjfWXY7XvZTGoWwpDA+AikP4gbFS6RSsCyLAiwRuzmHwxlK5owv4aKg
 DXbGZbLCjGeRHE+77UMzTvgaJ+9VBJVPqBsqFux0pCOdvPIlPKlI1pxR9Tl0ExBYBS3G
 FXnA25mO9RRBDiTm5CptAhFuSnD7vIaPbfK9SIOZGB+W2KR/ZggCkEKqpJ1LAIjJ6c6s
 SAXmw0QV96B19sJhR94Ngjg9UftUzO9RGWNPFRRiMvNlr3fO9avqwqXm/PRmZTMUO9gL
 GrWBnIyRV/yMQxk7tbnI3he54L+ia+GBjUVoTYFrn1LJEIFKlON/DrQVes8qZRBVLRfo
 +BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778099291; x=1778704091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HplWS8hK/qwjkRv13WCyYX+1QW1gUWjGmozCq+FAV60=;
 b=GX52HtQs7vgTKow++K686+20PAo7cgmJu5QtEczwLaZhLPchXq5ne49L20dIcZ5NHX
 68k3W+dh2hgSeXFepDiERVMhtPLKJ7h+Jwi2xwax8rkAyBBYx17tXpGJVn8yOntuN2kz
 k84ybV39EYVNzJX/dKr3lr68DtmMvEd/f2VBX2zi4eQUYevSsgzYNDTUQzrmoNhh0vn5
 uvYHw9tBgsVLJ25KOYGQvFDS2gz96QTnmUL7+3/cBSn9+AflhlwjjW1dz7XRmzIzLFb0
 OT/4zw9u8MlmOs6uGI3jQJ9Dz7QRW5Cwgfd74taDPXo4QagY4rL3IWrLfcpvnpRz1hgg
 srIA==
X-Gm-Message-State: AOJu0YyaGWxySsM9Fje3OObbivJhWI219A+hFwzFtIHgrGbnrzowmRul
 w/XkvIhaUaavPtxyOueGHK1DsHP+O7vY46cin2aCO2YUUgk1/oJX/hJO
X-Gm-Gg: AeBDieuoxsBb7YdEHNdmapqbGc5J5+WwQhVhx/bFJG+1uXGLSa7wD9mc2jvoomVybvm
 M319qaBr5D0q6q1X0jMit8snbMIi5QGPPv0cZJRfXjOStwKvOmOHAB1YL6+J0qsxCMe8awx10aU
 SE296nJ0yJqXOfPwqKSv3CuKwqYLM0j6YP5z159TU99+TBZNmosNjdepxCjXjULuHzDyN/p2wMG
 KLfkYwi886dBQlIIji7uD7UVVZqHExEXzgSLUO01x7v4Xa92jqPF5nRvXx460NUsZEiJhOj+FDf
 lZfepCqBnm25vAaWBV0cRrY+iSXD/7ZbB2V1RugzLSjsg2YAC6cBaypiVrOGVymqMx5xD1fr1Xx
 387A7ODS+t0Cadg08iUNm/2+LDSvFQRJyZ3/HYyOFgjHGjbuGLLpbzoSq745nUlyyyN5lsz7PVT
 mDYKwS0muG+RgLFCL3Ymiim1FXnoxF9yHzTDTd/0JQ18xGjqrGoLj6qNlQzpDrXN48LfHXsAY1R
 w6oBmbMoJwe3aI/a+/mSb6++xGYLraH7pl4m8TMYDS6itvaNsY=
X-Received: by 2002:a05:7022:23aa:b0:12a:6c4b:9cf0 with SMTP id
 a92af1059eb24-131967d5026mr2494677c88.3.1778099290805; 
 Wed, 06 May 2026 13:28:10 -0700 (PDT)
Received: from
 runnervmeorf1.obvp2ksrncaevj5sei0wasotfh.phxx.internal.cloudapp.net
 ([20.14.76.132]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9679390sm6200581c88.2.2026.05.06.13.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 13:28:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Wed,  6 May 2026 20:28:09 +0000
Message-ID: <20260506202809.3930-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506183750.97191-1-sachinp@linux.ibm.com>
References: <20260506183750.97191-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Add io_uring04 test for vectored I/O operations
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

Hi Sachin,

--- [PATCH 2/4] ---

On Thu, 07 May 2026, Sachin Sant wrote:
> syscalls/io_uring: Add test for partial vector operations

Nit: the subject prefix "syscalls/io_uring:" should be "io_uring:" to
match the rest of the series.

--- [PATCH 4/4] ---

On Thu, 07 May 2026, Sachin Sant wrote:
> io_uring: remove unused io_uring_init_buffer_pattern()

> The io_uring04 test merged the functionality of
> io_uring_init_buffer_pattern() into the unified function
> io_uring_init_iovec_buffers().

The function name is wrong here. The replacement function introduced in
this series is io_uring_init_iovec_pattern(), not
io_uring_init_iovec_buffers() (which does not exist).

--- [PATCH 1/4, 2/4, 3/4] ---

On Thu, 07 May 2026, Sachin Sant wrote:
> +static void run(void)
> +{
> +	int fd = -1;
> +	...
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);

fd is a local variable; if tst_brk() fires between SAFE_OPEN and
SAFE_CLOSE (e.g. inside io_uring_do_vec_io_op or SAFE_FSYNC),
cleanup() has no reference to it and cannot close it. Declare fd as
static int fd = -1 at file scope, reset it at the top of run(), and
close it in cleanup() if >= 0. Applies to all three new test files.

> +/*\
> + *
> + * Test partial vector operations with IORING_OP_READV and IORING_OP_WRITEV.

(io_uring05.c, io_uring06.c) Extra blank line after /*\; the description
must start on the very next line. See io_uring04.c for the correct style.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25458989491

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
