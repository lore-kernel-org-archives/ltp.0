Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2657ECD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780653742; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3UqsQ51upoJNv/niGw2uS7xNZcWZGTMrD7jgZ0gG3HU=;
 b=EzV1YsHWe3XuUKih/wcYuRdks48F3yHLKbC4wdpAq/ZTy7MnZRubm9OS0p3uazcBYHN+X
 CIIkGv1P5qsP6mqFZwMV/b8bKJqug6+xN6fOmKgnx0thZMiXL2ETU7R5l7VrH+o26WNWa47
 76/+tfslinOoJxq1V/fKC3tPuoFmpsw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 805193E547A
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 12:02:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3540E3E300B
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 12:02:03 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 899AB6009E8
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 12:02:03 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so14133125e9.1
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780653723; x=1781258523; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TMAXslTgyyP3uePgG6LokXbmVIbkO1UNLyO5giW9wc0=;
 b=MC23JsTuUBW4h88ac4nlBDXlwvMqerR7G/uk9x0ZkzJgx2eShcgjLZRSYlBu56RE5u
 Ycz7tpNovJ/ksoZ3Xh9ES6FnGO38wC64j84d1o4xVcc1zmJeGAS61nSyQ6M6TCeOJqC9
 ND7ThS7PNuOYkeq5NQtW48uLYUCGAXYB6p5rHIBmdZkSkw5T86aw28niU+9s98Pe1G6c
 fhhbVhLdeX1Sd8lEMfmulowSIO7+KpXvsDk3p66uFe/8QiInx0tdmD5lmZVZOHNwGNBE
 K/7ntzDY8NohcpJ9CyYee/74qRLGEWveClX6yC7g8MxeVmwoio+EuBR+4XQS4j+AQOM9
 O2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780653723; x=1781258523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMAXslTgyyP3uePgG6LokXbmVIbkO1UNLyO5giW9wc0=;
 b=g3FH13mnkZJQOWBS1OHzpxM+ONiusPUSh3RERpQgdHqeMTaMM/KvzErpsioyQhGZaK
 XGb1SlMzXKNdmJxbxrC3Y5arWxklF6tQnUF5kmusGymmXZr5zp7p2TX1P4tniN8N3OAp
 Fa16QOz90rY69LlOa3FO5mVNV78akxvLpuPjf9Ghwn9WSXJgLbCt+JbnFf5SbucJTLQf
 h3F9+QLLWfx5k/T1kBTDOWNSImCGpqocEVD826cOIW8La5RoWSkCHkOqIDIsDRgo+rAH
 3YeeA9I3bX8awWn3vzj1TgWOt0tGTZoqsh0BiBby26hr2mdpWLNBuK1DKt+xsxgAdbps
 b/LQ==
X-Gm-Message-State: AOJu0YxJ/ZvnnPxVJgwGZIuBKAZztDYSOqF7WWob5Y6HNNEsgUH8kBKU
 dvPzJrwFmi7Oxwoh9DoAKX86ePcRAfnWgpsc9I8vO3h9B+IQVoeCwjhvxeKDU8k/7w==
X-Gm-Gg: Acq92OHhhgqI6MKvbhN++WAhiUZA6F0f3/aTXOXAjigpopge6MPQfNgFidBdpHehZlN
 2/DnE4QV7U0cD0VJqY8d9rYx0sGFZxtESoajtANg4B562OYLliKM5KgFGm3frLr0wJGtN6XjeGn
 wq/vdyurPo25Vg/qMF9PiwTYWzBE5UZ+PGfMor2c51byryJ3HiUd+7Z9vTMmovho+JAlEGQEuV2
 v0UNT8TobSqsORKaTvozpkofWS9aoTJRHxBO8INdSkUvz7TqyGUXjcvyDaLEZwQ03jD58H1CufE
 QVunYmtlu43onHp7KyY9eLvgk4Bw0m3uKY9TstK237/nFpqExZA3RVKlC/mLzLHWCb0HOVnrhZ5
 93gx7Q87qG2Ndx1erHT0uFg1S2oZBUTeC3ANcX8FT0wl5cmgpB12npAvoO6KCTZNanSvLUyQnKQ
 ShLbkNQ2zakt8QapvgiygsWK9Y/M9h3qggF8vdpdvRgP06ZcBnGz0=
X-Received: by 2002:a05:600c:34d2:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490c2d1fb35mr30347645e9.15.1780653722682; 
 Fri, 05 Jun 2026 03:02:02 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344148sm24340346f8f.19.2026.06.05.03.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:02:02 -0700 (PDT)
Date: Fri, 5 Jun 2026 10:02:00 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aiKemKUVj4suWkOM@autotest-wegao.qe.prg2.suse.org>
References: <aiKYR7gagyA0y9zP@autotest-wegao.qe.prg2.suse.org>
 <6a2299f7.34ecd23a.11d42a.38e2@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a2299f7.34ecd23a.11d42a.38e2@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmapstress06: Convert to new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jun 05, 2026 at 09:42:14AM +0000, Andrea Cervesato wrote:
> > Some error happen i have not noticed such as "manpage:`mmap(2)" format
> > is also created by ltp-convert skill, you can check AI feedback on v2. I
> > have no idea why this kind of simple issue still happen.
> 
> You can probably run /ltp-review after converting the test to spot the
> errors on the commit. You should have quite a similar CI review.
I have run ltp-review locally before send patch but not help. Maybe
different AI agent can get different result.
> 
> I updated the agent, make sure to run ./setup <agent> again before
> doing it.
> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
