Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2EAC43458
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 14:53:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A7C3E4EF6
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 16:53:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8E33E1DBE
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 16:53:16 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7ED1F6007A3
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 16:53:16 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-519e7faecf1so52942671cf.0
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782744795; x=1783349595; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmwgd3xucYekzlbPiIEuQUMBaWeY12BJmKxDbR8b+O0=;
 b=Nm0msoBCzxdDS88Hkr9GEG6DS4ZtIUtqnyRxfOjzK7ZfW9grboRGLyvuHbHDuOSuy2
 tvdINy6aWzgOGiuQD33ug3OHn8QVwuC5GOlv36wKIqA1ABgniyfYGFCPo318qXldNQOy
 VCp8C6otyAi2aKotcBgrSNOMi2rhYn/VOdwvzKSBY5XTQsU07Tj/lxJTjuP7cPJyMnn0
 /kJAWsgJqnVz4QBaKl3uJU9DjUS6Fvp6fvHl1gaDe/Qmssy/9C4B7ADwwRZdaa5+qRrs
 A6fpPbM+IK9PntP434VVCnoHbEgWW4paXG0+sLr3lCSWEy+GpdS1kQWbiQkHL15BpDSg
 MLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744795; x=1783349595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wmwgd3xucYekzlbPiIEuQUMBaWeY12BJmKxDbR8b+O0=;
 b=NL24F9KAoFBNVMuMzJ7FhmkAF0LQFLTkiR1Bb/wODsdiGSR5R/N0hNvdq/X8WobXei
 hYsVQL+DgrJWIbKdx8WxAtxYA+aSFv3AHM+zYasiK7BTbdem5oBKQGXPdySPmbQwBVBB
 sD5G9/5I+vWrQr37IT2QJIMkV5z2uZsCuzNIm5WV7asiHaalFz3w3bW8JmKPhrT9FWEx
 ChAjA8fJ3cZ2JXVEBtAxjTyL8DceFck4OeGY7AputRbL08ejOKxRgo6ECs1D4CCZW6md
 R+mZnESHlz92eqBqw8EXgU5AlhQ8Njve/+Q4cTQYKd3BIo6tZG9U6xfPhNZs3bk6q55e
 lpWQ==
X-Gm-Message-State: AOJu0YygQEoKep1OmOTp8WNKFLYweLF5dSA692IZ6cXt2zCK2yBkIXsc
 ogKGnOjkn66uNKwWgVWdUWdQ+tXrw4w0VBV1QdniyAgB27Gxrh5inIhv
X-Gm-Gg: AfdE7cmxEv6IM3kwB8i55SwdvFjZqbK/f6FqGDgDiCEC7VrIFo4uD4w/9bnNB+C6rpM
 2kl2DItjKTRRKPOfSAVum9kP7pRWNVHw7dQpOiHKgP4M9BHO33FgBPbMrN4V13JW1FqMVN+pQ6+
 T+at01Wk3CxWQv7MHDbOVPvtKdnZwYE0dO/EqJfto9Brk0/0U1aiHIy5lSagoney3BJsqa1H3Mw
 1zZECkVB1oLBvDmmcOqSPMBOHXiRxsglfGJHLPYXmU7GNzswBTWfNlz+byGBLWrOeHj5rDPwYoZ
 uAMWopX2EV/1VkGCM+S/Xf98Jk1789yhZxND9wcPCuGYspZbgGU0dAUKlN6eG7C5UeuFJmo7t2w
 f1oR9v480de6R1c9HlnJbBvrTKdAL6jA7dvDaxvhKEuALAexgqKuQq3J7yHhlRrmtUb5Iev7ncj
 3e08SnQsHhFtChEMPIsOOdfKctfYw1GpnQp6Dem/o7/1CegAdljcPepMo7LCd55/OH6obvE00he
 MJNLDs7Ol7xXoZZoHft1S+roB4uiXrS1JD4
X-Received: by 2002:a05:622a:610d:b0:516:e10f:7140 with SMTP id
 d75a77b69052e-51a7279ff95mr236883691cf.35.1782744795310; 
 Mon, 29 Jun 2026 07:53:15 -0700 (PDT)
Received: from
 runnervmmklqx.m3ruuhvfbpvurigifwzuo5wjad.bx.internal.cloudapp.net
 ([20.25.10.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a514b50b9sm165403581cf.3.2026.06.29.07.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:53:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 29 Jun 2026 14:53:14 +0000
Message-ID: <20260629145314.3959-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629-invalid_syscalls-v1-1-6276034a35c5@suse.com>
References: <20260629-invalid_syscalls-v1-1-6276034a35c5@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscall02: add invalid syscall number test
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

On Mon, 29 Jun 2026, Andrea Cervesato wrote:
> syscall02: add invalid syscall number test

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
