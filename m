Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457ECC43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:26:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B023D3E5D47
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 17:26:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D9763E1A22
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:26:38 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E9591A002EA
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:26:38 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2caf18d4903so6510915ad.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524397; x=1784129197; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XdS2KJsyHDvqp2tbHIR3VIolrUh6rSR7QWDjEVTEoK4=;
 b=AwFstfqJWx6bOIY3yyZygwyluOEkn7zRyoogoBRyIHwm9LmaW7evF3fVaG7jvSbCH2
 jeaUq1B9CjYyrfUknNz3JF/NipMWqkQSdJ+KsogGhCtxSRDCQFlb1Rdl8n541mljGPo/
 hGbV/MfJ/FqScc0+JQwgSCUlSMTF0IC2FoQqigVXWW5SzqIdUd6EhgS3LwUjzSMaXXjE
 1lI5msOl6qbgxw3p60wal3Mg3EskpckcqeVdoqwmwvTkAlya4yIEc4H9vRGkrzcF9N4m
 VN5iVXECYuTH+TZAuZKOoFES0pwNbwrhHbJ0NOH2nlVjQ8KqTpVqJBiFfZOG+ci9Tkj6
 S3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524397; x=1784129197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XdS2KJsyHDvqp2tbHIR3VIolrUh6rSR7QWDjEVTEoK4=;
 b=D9qr9vjWzutEuhVMAa3uNF2j8rPw/ZCWFzHVjBvmE+Bg94LeTvtOYfXJe44sGGnh2R
 uLKKgLHIZaAAZCb6Srqzkjo/1GEP/AHYvX7UU+erfDfZ/Gmvr7998RYTnY4NqLgGXWqF
 bIwbo6AyPu5ULSmjEzpFbDk9APqAtzY+eNWUpuxMCWUcGeAOrbBF3pPpxj81MdViC9m7
 StqpJXr5Ryg2qQsXo+oIkpKjLBhLSHV6PZLAwJn67lvKtoVpriX9r5Npno/hWkNo6EDI
 1Ucxjig2JDfg1eSyC2Cp4u73FnPs+ZazaEwwU7n/3ecr7+XHvHVsHgyGPgJZOkLBeSQ9
 ATHA==
X-Gm-Message-State: AOJu0YwavSdYEtposWMfvCoqval1rcFC7FSDu12SGcQ9SAK1HZZm93e6
 flouqXZeAjTYhPHGX74RbKVhBdDTDmT7sseCQ1HEtt8Hl5/N6ZbVIUJB
X-Gm-Gg: AfdE7cny0/tShL/2qVkcrARMAUGo7SnIZ9BbreVvPQZilSyg3+dFOYxJyAAiZpjmJ3U
 SxqNs53gp+TrVLrhkU+tw3FtDAlmfX2s3C9Fin3ppmq3IIhNwVdDG+zzioL+zq/5cNX6wu38Cqg
 +QjvnXWCQN7BqdJoVf9jtImVmcPBO45ikGt8qZy1dTYx50fW2LaBF+spA9m2Ud0ue3SSEmD57HG
 pI7LMVNDUQEGP25sTM9P1cGFK+v/LARQTaGldO848Jg2ceC2LwOwiq1IVPmLPAkXsL6Vc6sS8lO
 0Pc6ZcWhYImOs60pY3sG2OZvDVRlH21Vg9XjTUzrzXLYU9ZcN0X8BaWgKROCNNMHcAyWI/uN4SH
 igYomDbiXTrjANxhDbfq8z149AFqZOFywswwB50lsYBoCrOT4O3HPeGR3zNqeUwcOct38uECFdO
 U+cKdbjDkpUtbiO/PvLH/BgpaQhSZqn/C7q2GHBwXNBYwX8DeULFXWKurvuRZ1CydpRuAXCdDh+
 OUWqhWxuXaXboceKSCo5+A/8qLskAb9sSKt
X-Received: by 2002:a05:6a20:1587:b0:3bd:203b:b587 with SMTP id
 adf61e73a8af0-3c0bd1a82c3mr3788408637.40.1783524396516; 
 Wed, 08 Jul 2026 08:26:36 -0700 (PDT)
Received: from
 runnervmkkn4f.13kyt4zaxshutkgn0nb4cnsixf.dx.internal.cloudapp.net
 ([52.234.1.99]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d7c8bsm22457624c88.12.2026.07.08.08.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:26:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Wed,  8 Jul 2026 15:26:34 +0000
Message-ID: <20260708152634.3782-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708133726.223095-1-japo@linux.ibm.com>
References: <20260708133726.223095-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] kill11: Skip with pipe-based core dump handlers
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

Hi Jan,

On Wed, 08 Jul 2026 15:37:26 +0200, Jan Polensky wrote:
> kill11: Skip with pipe-based core dump handlers

> +	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%255s", core_pattern);
> +	if (core_pattern[0] == '|') {
> +		tst_brk(TCONF,
> +			"Pipe-based core dumps detected (e.g., systemd-coredump). "
> +			"Test requires direct filesystem core dumps. "
> +			"Set kernel.core_pattern to a file path (e.g., /tmp/core.%%p) "
> +			"or disable systemd-coredump for proper testing.");
> +	}

The check is in setup(), which aborts all iterations when it triggers.
The hang described in the commit message can only occur when the child
receives a signal that actually generates a core dump -- i.e. the cases
with dumps_core == 1 (SIGQUIT, SIGILL, SIGABRT, SIGBUS, etc.).

For the 12+ cases with dumps_core == 0 (SIGHUP, SIGKILL, SIGTERM,
SIGPIPE, etc.) the child exits immediately without touching the core
dump path, so SAFE_WAIT() returns right away and the pipe handler is
never involved.

Placing the skip in setup() discards over half the test coverage on any
system running systemd-coredump, with no benefit for those cases.

Would it work to keep the core_pattern detection in setup() (store the
result in a static bool), then check it per-iteration in verify_kill()
only when tc->dumps_core is set?

  static bool pipe_based_coredump;

  static void setup(void)
  {
      char core_pattern[256];
      ...
      SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern",
                      "%255s", core_pattern);
      pipe_based_coredump = (core_pattern[0] == '|');
  }

  static void verify_kill(unsigned int n)
  {
      struct tcase *tc = &tcases[n];

      if (tc->dumps_core && pipe_based_coredump) {
          tst_res(TCONF, "%s: pipe-based core dump handler active",
                  tst_strsig(tc->sig));
          return;
      }
      ...
  }

That way the non-core-dumping signal cases still run.

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
