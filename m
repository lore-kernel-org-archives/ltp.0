Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88793C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:36:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC31C3E718A
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 19:36:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F2943C332C
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:35:45 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F8DA1000448
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 19:35:43 +0200 (CEST)
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-456f7012050so106275fac.0
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785951342; x=1786556142; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJLQjOIayu9r41U8LhTB9qHczHfTRVKv4ASissbB+38=;
 b=OcGjSJ98fduZajesNNNMRG26TF1zDv2emi1AEqCVtUSDSPvEPNWuPy7Vp0A9wZ1KF8
 f4n5/ZHIbKCumUulnIskxaMNK1dqijRKFqr7S+bNYgKWnkpbfyumRniHkpp0LFVHr7YK
 6O6fqi9F5HpbFKhjMLpT9G+WZovtHzY4f0y6/WT5gp4YdnxXCbSJThlWFepgDdzWqS6B
 SmmlcsZ2T5el5zYzxpAUUmi33IEtJ4/JTiofTziwzFHWQyOqKxMZGiTQhjx/IfxoAPHA
 gmeMrIzmK6TxSj+tRXWFHXTab9z8/ElpRQ9BgyRbg0U5eBzx8co2brdeyxCbCLP8Z3FX
 k1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785951342; x=1786556142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BJLQjOIayu9r41U8LhTB9qHczHfTRVKv4ASissbB+38=;
 b=SWZJ7HGntK425RjNcROLmM6tT3/IIUcyUHIpiFXlyU8cMn32Kk8ZoXdeckAxhBuG7P
 2K+OAaKF7LAjUa+TOcQDR41x6oHofXOWKVvZ/3RG1pUDbb59EvXZiYDY2rR9KTeGS+z/
 w/V0hKgJ9WyCO6puTqa6zuicovDoqdgzPUnww/QY6853EluTmeDEPcd9DFCgIxenAMOd
 6NWSV6RWU/Gt9JEQp3uxNb/U6ThjCh7/2XZFCrjJuee6TZY6CnMDKbfxvP0Z2U2NGjr4
 bWf7kCO7+q+dVzIGzPiP8tQjNDXpVqUP//psfxJyQkWOuxBDSXnJmfvXSB1jim+xDLXG
 FcKQ==
X-Gm-Message-State: AOJu0Yw96tQtql823qPYoDv8C5zMyPwWkhNGkMhBSkNpho+cp/GONujO
 OtHl7QGwV4tPV/aLU2N7mqrUxGQ3qd7pv4sQ4+bsRWlesIJuqn1WkI1t
X-Gm-Gg: AR+sD12/UGpsAPvstd0WNaeInuCiqgKNyWWDyWvTnKBFqTH+kM0cUc745dXGWMiYi6f
 Thm4uh6LeoH/VUcyM99H/YOHUQGR2DhBHO6NEDbWQp3AhUKj0nsGq3LcRHG6zNDsfUCKdHDXJov
 tATlM0GC+xBL4QubkjstwskmVgr2SjtvUy38CtYtS0jXqBKRKgj/5tY14hAXBXvstx7NL5ifSvE
 YeNXGdAUIwSXmZrhgQKU7fgo9KlsWSbRxOUmR5fqxlEqnAix6m6S04RWrpJIPxWTSIzpAt+G7u9
 vf2PgB/7omBUU7PxebaBb+gTE0rO7Nf8kBEjjN8fZT3GJdzLNsG+mA/FS8DmhN8Ws/gnpjLxIEj
 ZfzEbIHGLVm4lvupjStcSdsBALujBjyLCD6Xn1f1IBNKw3jd6cBHs+nS+nsRJMrSn7nd+1TAeRu
 aTdh9x+pYH6xq2wA9Y8JeY9E6yeoXiygKxK+6VgbTnv89hBU97hBE03S1BzO8yo2TaGAghFGWNi
 nvgungYXroAVMixbTKOCKFNn1JvSKSEOpQGtKQKBlhJXGolXWThtBPKC6PXg9HOkL0R9a4vNZtX
 GA==
X-Received: by 2002:a05:6870:3105:b0:456:e46a:1df8 with SMTP id
 586e51a60fabf-459c27bbeb8mr552781fac.6.1785951341660; 
 Wed, 05 Aug 2026 10:35:41 -0700 (PDT)
Received: from
 runnervmvrwv9.2hu41doa5igu3nug0dckgrlpfb.gx.internal.cloudapp.net
 ([135.119.38.208]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599e1c0c46sm3215131fac.2.2026.08.05.10.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:35:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Aug 2026 17:35:40 +0000
Message-ID: <20260805173540.9276-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805151451.648990-2-pvorel@suse.cz>
References: <20260805151451.648990-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi Petr,

On Aug 5, 2026, Petr Vorel wrote:
> tst_kvercmp: Factor out error handling

--- [PATCH 1/9] ---

> static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)

Could this be renamed to parse_kver? File-scope identifiers beginning with an
underscore are reserved by C, and LTP's coding rules prohibit such names.

--- [PATCH 2/9] ---

> This is a preparation for struct tst_test max_kver member in the next
> commit.

Could the motivation be stated without referring to the next patch? Each
commit message should stand on its own rather than depend on series position.

--- [PATCH 4/9] ---

> 	if (TST_RET != -1) {
> 		tst_res(TFAIL, "creat() succeeded unexpectedly");
> 		return;
> 	}

Could this path kill and reap pid before returning? Removing the version gate
makes it reachable on affected 6.11 and 6.12 kernels, but the child remains
paused indefinitely. The framework then blocks in tst_reap_children() until
the watchdog terminates the test instead of returning the intended TFAIL.

> 	TEST(execve(TEST_APP, argv, environ));

How is the writer child released when execve() succeeds on an affected
kernel? The test process is replaced by execve_child, which reports TFAIL and
exits, while the writer remains blocked in TST_CHECKPOINT_WAKE_AND_WAIT(0) and
becomes an orphan.

--- [PATCH 5/9] ---

> 	.max_kver = "7.1",

Could the test keep running and only adjust the expected result of
FAN_REPORT_PIDFD | FAN_REPORT_TID on kernels supporting thread pidfds? This
test-wide limit also removes the
FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME case on 7.2 and all
newer kernels, and that exact combination is not tested elsewhere in LTP.

--- [PATCH 6/9] ---

> 	.min_kver = "4.4",
> 	.max_kver = "5.0",

How can this exercise do_test() on current CI kernels? The current kernel must
lie between the bounds; min_kver being less than max_kver is not sufficient.
With this maximum, including on stable 7.2, the self-test only reports TCONF
and never tests the new success path.

--- [PATCH 7/9] ---

> int tst_kver_cmp(int a1, int a2, int a3, int b1, int b2, int b3);

Could the new public function's kernel-doc include a Return: section
describing the comparison result?

> This will be heavily used in metaparse.c (speedup of metadata
> generation) in the next commit.

Could this motivation be stated without referring to the next patch? Each
commit message should stand on its own.

--- [PATCH 8/9] ---

> Will be used for metadata.c in the next commit.

Could the commit message instead explain why host targets need access to
MAKE_DEPS without depending on a later patch?

--- [PATCH 9/9] ---

> metaparse: HOST_LDLIBS		+= -lltp

How can this work for a cross-compilation? metaparse is built with HOSTCC, but
-lltp resolves to lib/libltp.a built with the target CC, so the host linker
cannot consume the archive. Could the version helper be compiled with HOSTCC,
or moved into an architecture-independent host library?

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
