Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C02CD6E7C
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 16:10:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 279673E6031
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 18:10:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8A533E168E
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 18:10:12 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7ADC600049
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 18:10:11 +0200 (CEST)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5aa63daf2a5so2151041e87.3
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1780675811; x=1781280611;
 darn=lists.linux.it; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
 b=XAZBlsquRq4OJP5GN2H87wCRP7vl2A4at2YKjoitCTsqoz3o4+7khnNMBA/4jkSmPY
 DZTzN8PVajDuvSyrXREWHp67yTQCjiTChdz8/dOyj/eZz7hp3kwDy0EEm7+ys44Ks87E
 YDSrYW/kB55RzPPn0eNpsla5rMUVWDtQgLyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780675811; x=1781280611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
 b=rvmQIlUJxMIohJmsHxjFVgrcJ46Sm3Pu3t3yYExfUBEb6gm6Hcws6lT0ahbeD4kLLo
 nA6YtWvXWw5O/QgsMpbPgc4O8e683J9iocUAYO1hTaGqqlYeAH7ImrqtO+NuHS7HTGi+
 mfTsQ3MC8Pz4v5ZNlopB1uCfr9kIcupXEp9F014VJ2v5KCykmShKS7evzwvt4vmwKwyI
 xm21IyKh8jaCqQg7LlqJGMnvBw6l0kOXYlEGFJrAGKfXaj5LGc77JJ2yxfElldMqzF9A
 7LUvs7JsLWEPLFKCzPXG29dJDQublRVOlkVWgRMh1nqK8fQc3+nOZe4ncNeUJ8EMie/o
 cUmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CDcIQlII7Rp04K3C4aOydH+w5GMQiW168PlI1mLLT71ZzajeqP3ZjTLaEl0ZUOhFGliQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yxk4FJYnTo5wXPlD9crwj/zPIWy7BJnVObnIEmMhnOq6eowygut
 TOLfeAxtmZeq27i1CwFYGlWLhcIsDj2FYbGmIJ4L/FvE4eKWYrsR0MVYm/GrNy7zG8tdtcCqNMD
 d9k5mNbJsSw==
X-Gm-Gg: Acq92OGT6IBO252NJytUsmsAkBHuXCODr84JKUJYQ45Or7x7DsJXx+GnssJ7mTMspvz
 4ZTuop+ecsMgWXD2droIky6mLdhrVwVHEy3K7YigLsoeMkylv3YjA3PgA2V4JNxtjiIzJAXnoL1
 MMnnqhc/hGFoQuUsx6Z6mRdP9ksmWgQpZdMNu3XtSRAg0Om9Vm6M821+t2J4nxc0zbgQv/sAzY0
 T7vG4Yua78GM5hiKWqfB2CMg/y3Iw9O4jBrG+SeHJUIFIUkddbNfp3Vqrk1iL5UM4c/LWHcDs5/
 XLw8vXv66H8pNcyuXY2WUybd440sbblQsNKzae4/z+xh4SCrfAJiQbqVnAlR54m3icmNWiST+qF
 9xAtBYypKGdwsDDgemjUtPRbNh93S+o3e37/ERcHUmLf9rvablWtA7k297olVaHVUr6YR+AcfrC
 YPekoBDgYFWFcujlRjUPR9wdz1vHlgCIUmgFhdhCI8hqLKX7IarRxCC2MFr108s5b8710Inmn9z
 LN2jn+uLTZ1ehiAi4AOF/hJOg==
X-Received: by 2002:a05:6512:23a2:b0:5aa:6b0b:1f40 with SMTP id
 2adb3069b0e04-5aa87b671e6mr1550120e87.2.1780675810744; 
 Fri, 05 Jun 2026 09:10:10 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b99cd4asm1927006e87.83.2026.06.05.09.10.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 09:10:10 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3966c0d5ac9so21226591fa.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 09:10:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+p94oiF38q8GFtm1QSKpCfXzZLKR4VS3qR7eoYJNJYsefAmJu/4LxOYP9MUxW2xKg+WIg=@lists.linux.it
X-Received: by 2002:a17:907:9686:b0:bee:323d:1239 with SMTP id
 a640c23a62f3a-bf372e1e4fdmr260752266b.38.1780675389972; Fri, 05 Jun 2026
 09:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com>
 <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
In-Reply-To: <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 09:02:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
X-Gm-Features: AVVi8CdZ5f-_r2ry70kDuq_xsye2rLgypwsymONxqFNfT92KlgrDUIUXs4-jBmo
Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
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
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-api@vger.kernel.org,
 ltp@lists.linux.it, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
 Askar Safin <safinaskar@gmail.com>, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Aiswharya.TCV@arm.com,
 Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 5 Jun 2026 at 04:02, Mark Brown <broonie@kernel.org> wrote:
>
> FWIW this is triggering a failure in the LTP vmsplice01 test case (which
> sends with a vmsplice() and then tries to read that with a splice()) in
> -next:
>
> | tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmsp3vEmQ as tmpdir (tmpfs filesystem)
> | L4471tst_test.c:2047: TINFO: LTP version: 20260130
> | L4472tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260604 #1 SMP @1780589917 armv7l
> | L4473tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
> | L4474tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s

I htink this is the same thing that Christian already noted (he said
"reported by David", but I don't know which David ;), where the
vmsplice() writev() emulation was done as a blocking write, even
though vmsplice only blocked at the beginning (ie waiting only for
_initial_ space to write, not then blocking afterwards).

                 Linus

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
