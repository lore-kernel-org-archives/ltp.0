Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02229CD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:11:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 925CC3E6B3D
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:11:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87F943E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:11:01 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 387262003BE
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:11:01 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8cce87d7995so16110446d6.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781291460; x=1781896260; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zPiDfEd46tTc0WGoVeEeYRnsMdh/Yy59/UyZqSe6SY=;
 b=h/Aa0oJ/z1j3kJUe4iKQqTj4jBMx+BLTw1MBczohBxj6LiniC8J8+/eurSN8cC1EBA
 dRGLYl67cgOxgn1mOMeiWcJUwGbOQkC5pEzKk6QFmRpcUwRYmdyBpOnLNncjKuPe0084
 IJtpqosm+uv58+7arO5frtpj0fgjMXVONyVY+9d41rWJEOJKpak8Qk2ItJcpfFnYAGXt
 HDjF5DpxJvZHG3EODetGE9DvioMt5GiD3morEG6+cbaHi3fG/E1oqlCG2/Rb6qvGYzhA
 Ot4dIBrX+i4Sfg3IaR7DUc+Ko3RTk0a/yi5VITpqGtcGs8VEjGbO9fXHdawMJ6RP3jCw
 vbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781291460; x=1781896260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3zPiDfEd46tTc0WGoVeEeYRnsMdh/Yy59/UyZqSe6SY=;
 b=E/DbtBYL/uvo67stC/SuYpt2vhGkpxGzlIvWQmT64A/UIABzCoccYbx1vriEIn3mZa
 RG0aWViKvowzAIRomq5y6MwXTU1yNFYDwgVV2mglB0F14O8ArmHCfkvVkZ2uul9XBG+p
 pRrYMqMURSxumbHuof5SZR/l5EwDkZMlUiTLoUH+rIjmmtrlt6HVWYMYOklKRGuqxZti
 rH4O3v8jBaCRZ87kVdtYMe8j7pLWYvcHU5nOU+/5tArUWzEKJWXK44326M99b3hvmjgB
 3wKTK1L08s2y1clHfiPCIRKQ+pcMw2M1fwqO17DgRtINy1KvfT9im/e0dD/pSy2ZacT7
 Dajw==
X-Gm-Message-State: AOJu0YxfAmdcCvzh19l++Ld9fdgJomA6i6fS4x0wXlvWP6fs4h8mJMgm
 QdilouLPQFsog6ZutvskgnXvLHnyVDycJ+eI570BEqhGc09fsJDB/F9P
X-Gm-Gg: Acq92OGYo310Lbk3iPgsI1xikeCQGiMoVF1tUEfkRg1nPBmmtBb05+z72C7g/gmKAWl
 4bscneqZpRQDOEPa+2ch+KcWX5ueOmrMiGOPy7IGhg/AJJZ2U+66GpdxbcomexNTRHsze7SjqEr
 vRfC4zSEuS01QSUy7hZj8qbVfMR7ngmOU+vIBDe6zrTPSTKOn8zdQUDlRHYJ/09CF+saJSMJisX
 6dfeyTZFu+kWOm7AnYqGumLpS3TbAln++fEv9xk+HpZSkjaBdv2WKrQRrLh8QzQCzsZEYr0QZRD
 MyVhebK6leTs3BKQm3ZbN+8XrVJLOh6HPeK2dZzmsFT141sHnoEYmgLMRoES2UNIMYNcOyNi1pg
 LBgbVSyWouP2cLnzMr5v5ohYtTaeZZ9FRMfEnbq3C2LOODh9IdQfxmrMA1Lev8dS2O/Xljze1wH
 4GOzOEBNmReFYXxnhdNKa7KHKJ76KzzgcdxJUh4lIcZwSXZKE/mH+KtMcY5wm1cBerHnLLf6CQ2
 qy5JeKyUC2+EiMGzjAsjjcVoVZbhzN7/w/B2a05H2JxrfhWeEM=
X-Received: by 2002:a05:6214:2349:b0:8bd:de6d:c331 with SMTP id
 6a1803df08f44-8d32c8ce195mr71356366d6.17.1781291459860; 
 Fri, 12 Jun 2026 12:10:59 -0700 (PDT)
Received: from
 runnervm1li68.a4l5jnhyvw4elhxgcp3m1o2p0h.ex.internal.cloudapp.net
 ([135.232.201.49]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d301b2a79asm32238626d6.13.2026.06.12.12.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:10:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 19:10:58 +0000
Message-ID: <20260612191058.4201-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-metadata_groups-v1-1-d7a24a7ac7a8@suse.com>
References: <20260612-metadata_groups-v1-1-d7a24a7ac7a8@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] metadata: add tests grouping support
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

On 2026-06-12, Andrea Cervesato wrote:
> metadata: add tests grouping support

--- [PATCH 1/2] ---

> 2. @group tags in the doc comment block, e.g.:
>    /*    * Test description.
>     *
>     * @group stress
>     */

The example appears malformed. metaparse only extracts @group tags
from doc comment blocks opened with /*\, not plain /* comments.
The test file (groups.c) correctly uses /*\ as the opening.

Should this be:

   /*\
    * Test description.
    *
    * @group stress
    */

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
