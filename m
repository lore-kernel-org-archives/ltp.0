Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95341F8A163
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776341089; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nfT9ftwLTTYZA8pWV1XrTzkveP0hWcAe8bwYQxeXBBk=;
 b=aLuBynO4FPqjBsaGBLDpA8N17ryJJwsKcLazQ+1/SKkw7moqkIeWUAlDFv/QBDwBlSETY
 V6WI+vcNnaLGP7jn9GCGbEqPaQk5PzUl+phQfUxmZ4zO58ujdQ8flAhRWK/UCPuTKl1GFEP
 bRAPvFoBaefnGArYNHtZRN6mInjOHq8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B2BF3E2DED
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:04:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA4C3CB983
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:04:24 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F00C4600921
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:04:23 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d7605ec91so4039196f8f.3
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776341063; x=1776945863; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ylYf+fdztwbGN3C0U12sTB0Pd+6hMRs4n5FxyhYLGos=;
 b=JlBDr9FuNtgsWIuv6LdfX5rX7JaDD8NDElTpDyRx7uc4V7TB6ueLdNKee+NqpD68xu
 7ME8VNRMTNo/UrUwPfb4TifTma6Gs0hBgIIiNLi6lMMzkp65gwXxyhDNZYg3pmpDN3z0
 Czl8MNOpUYf/9hwmr8L4cLfdINsm4ncv4xm68iDVnEiFvgQUtlfeYyIfErpmk0BUJ0yk
 EC6COsJi5olBfSQQ5i95CxEqnnPUo7/Ly4wCGPE8/h0gkHZs0KbSfCgdsnUPJ47sZa4e
 aSWqGgoXcD1HVfp1u833ZYxgoHAzPI4kMK3DG/sbO01Mw3gYnJSQHP/vLhnllmAFxSy+
 n4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776341063; x=1776945863;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylYf+fdztwbGN3C0U12sTB0Pd+6hMRs4n5FxyhYLGos=;
 b=eFkL5CjNiXGwD7/gRWVdIJ1iP1mcYVXFJz9HF8woTL/73CysmAn1kFGtaIfKdMb/3W
 FlZxZThyu3ACkhU5gjrOL4TlSZK4eI/a2skGcD1WFt+rywGrR+yPdGZEb4u9lhEePOJX
 eM+Qsbb77t72UsKMXO9/TbuhItoClJmj7WIRpXqLGJyXfZqTmCYk+0/j82NdPRkBo8Sg
 xYhPUNrdLG/454cg8b49ctLGSylscgdkCEDNLtkvqVF3LDFTp6JoOw8xz3ug3peXkqMF
 hCJcDpcKb5x5cgnvF+PWH7h8qqbfHoGS1q/h7RdB+JgArTXfyKYvApaOs6Rrzp5bwXWa
 c+LQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+znkXa8gVw3XsqLESNT+J9HQIfdqrg4nIy4Al2br8djXG1vV6yJQW1Lerl/Xplyjachag=@lists.linux.it
X-Gm-Message-State: AOJu0Yzoqbu4kFt+8wUXGIo4tKXcScZPMhgyAPnUeSCLTOmN931/9G5l
 0cggfaQ0uoFtauiIBpxTgm5yF1hacnVqiWcC7bVr0bM3FRn77qQ/DTXEbYbXX0TFobzVZPku2sQ
 oiczQlYGSZA==
X-Gm-Gg: AeBDieuTAuR6FglbFXG5w8SuzaGsql5j58tQ5rqZIc2IGk8QO7W7hKf94rS3SZxuNhc
 Esq4mHZGdsW5pE/sPteJaMwQsY4LgOCTntcvF1zFoszuLpZbKqS4sa+A3n3W9hogJRUlDBcSD9p
 CHJzF8MXRjqpesiBGILPpSyiP9dYz229NJnWGwO98mFlutfNKT08na7kMb+/qybwGtc4KgcBtG0
 HXdC7A4AHineIac11YOn8hJeBJHkrYtQkMBztb6rQ4OrWJuWF33AURl3Xd6NIyfoYJfLTXtMZln
 l4S066fBwAGJVvO6H4QFBxKwWgeAMuBhnzNo5q1gnLDteN/Fxvn1ULCxRa/tkiW3TnscJkvNy0q
 gG6IbqiDFM6sPm6QTHtbEz8CBilPqupFjXEtygbmvXcwKJhtGshO9Argspn2P8eGUgzgsmn5O88
 BIb4eLJT6oqwiR8pEFK+Q4DwMkB4lfNTXqdVALBMeT
X-Received: by 2002:a5d:584a:0:b0:43e:a70d:7632 with SMTP id
 ffacd0b85a97d-43ea70d792emr18095230f8f.25.1776341063238; 
 Thu, 16 Apr 2026 05:04:23 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e89ddsm12698896f8f.30.2026.04.16.05.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 05:04:22 -0700 (PDT)
Message-ID: <69e0d046.5d0a0220.852a3.35df@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260416115801.GA299728@pevik>
Date: Thu, 16 Apr 2026 12:04:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nanosleep: use POSIX runtime detection for CLOCK_MONOTONIC
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> I'd hope agent would find other '#ifdef _POSIX_MONOTONIC_CLOCK' use without
> <unistd.h> which is in
> testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h

It's one rule behind to make agent discovering this. There's no rule
in the actually c-tests.md agent configuration about this particular
case. I personally never add any include to the file if it's imported
already from other headers.

But we know that everyone has their own opiinon when it comes to C :-)

Should we add a rule to the agent spotting/ignoring these corner cases?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
