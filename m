Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC0DCA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 11:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 109E63E9E6E
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 13:46:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C96F3C0646
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:46:07 +0200 (CEST)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9538820090F
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:46:06 +0200 (CEST)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-35104f34166so1230924eec.1
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791805565; x=1792410365; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8eUnIdKuDHuPwWSv4D1SvfXLLkaA+V1mAtVCPs7AWA=;
 b=Tc7b6Vtzbifq3kDRNKd0EP/4xGhaiy24LFlkOsxFlViVkwpI4c9AtP8rigMpcTUcC6
 gM3L17VNSrzYMuKvV3ARoxi8GpVca8sPzQT8aOmrGcDbTo59z23muRkYqcqETVehECyR
 2bdwnXPDQEs2GCo7nviYhPGeFX4KVxdg5QWdhk4pI/Zxy/TI86cZC0lLXBwPYUKsVP0i
 8EAVEWWmKrx0HXVK66mowY/Z7gam8TPnEpxOIO8wJreUbDe1PykK4X8V76BuE5V49Zr/
 FNQczpa1BO0DAuNXn5Se1jZe2+iW/X5W0f30XOIHRpwBwgKkvxME6e5caLzUBj8rmHuh
 7Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791805565; x=1792410365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j8eUnIdKuDHuPwWSv4D1SvfXLLkaA+V1mAtVCPs7AWA=;
 b=fZgVCLuogovCOpWHRZSF5gJI/VS+L4y6OYfPrma2tRMKJXFIU53V/vauOMU1TcgJlI
 ETIfs84uydas3qwNUnwDg08tBym7z2mRhuAVUEMoAS1YxZMmrqja33gXndDHBulS7QBQ
 QQCwU5H8b8Ezl0DxOcI6QKgO6bx7WzYfkZ4npxNr1teN+PNAPYh6U5Dv0F+jHeXGOpbP
 Dv1CcwXJsgFXmpiOPDsdJ0ec9Ss0A2GlaKSVjqPka80lwqUoQBICm6xGdBDkNVFEVX03
 hVp8W8kpII8aYuHipiAcg/zPUGpZLrLQW78fXhzz58sLpXcbEYcw8Wm4vwcenJxwFX9o
 sI0Q==
X-Gm-Message-State: AFq9FYLs1ZdvR46Aw+TcAM7e4UY0K6nS+6qF4xbIqLhb/HDqAA6f+sZP
 eIJRmbCQ2+rkfREh9YDmQk8mIP/WC/ubMwPCXQxS//wK0A6ij3oTS3ia
X-Gm-Gg: AYBFou3NBgQvDkApCZ6oVWLqzCmNpIOx6a8y/Sl1rGMHDSENvNrgkxCbR7VAWcESwbL
 gFhvTO0JHnW+8XjTnC6xQ+/djYfa64a/eo3fW/sPxyy9wABVXv1k+6Oief1FqyPDz8H9iyMpTwJ
 WQH9E0Q/pbMTRKU65Y75SzNFRXtClvfW+kD+xQkIf0eTwkZNkqliAGRQKrIlBevWdyndXla6PkE
 qhvo80dtDnKU5QOJTZQdGdAmD/AAA15c47B0pJge1NzEM99fRsTbqiDoVnFmooRiElYsUXJbxTj
 1DeX9GxJMLk0a2ZKbxOHwquELQSHsA49uM4ac5aTAwIrfF/ZhfdhTCeBOvK0ByIcVb3LFp6ivxM
 oE4933ujOqwI6b/+22RUNYo1NCOLiApre5dB8eVk6DrS5LtUqA+SayYttLI+mV1hI3iJ1qMqF8d
 TAuFKaRn+JAZzGlIoXs2XU/ZTsZ3FvS4vx27NFunNuTOAE+awgubUuHmGRD25glPAJbHbXE9HHx
 1WJqHKweFn0B3feYv5JykWqBEX3Egh3mnS/PxqCnFsPZFPn6YV4Tgqs24s2COrcBIYR5la9uHoE
 JFOqblfoHyBXBzBLn2NEg+k4
X-Received: by 2002:a05:701b:465f:10b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-16a5adfc4dcmr12916721c88.11.1791805564624; 
 Mon, 12 Oct 2026 04:46:04 -0700 (PDT)
Received: from
 runnervmmprz5.bwl3dcx3gy0ubaefsilkknbind.dx.internal.cloudapp.net
 ([52.190.141.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1699718c547sm28508514c88.3.2026.10.12.04.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:46:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 12 Oct 2026 11:46:02 +0000
Message-ID: <20261012114602.8346-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930201430.1924463-1-anders.roxell@linaro.org>
References: <20260930201430.1924463-1-anders.roxell@linaro.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_clone: Fix child detection on sparc
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

Hi Anders,

On Wed, 30 Sep 2026, Anders Roxell wrote:
> tst_clone: Fix child detection on sparc

> +#ifdef __sparc__
> +	if (pid == tid)
> +		pid = 0;
> +#endif

High severity: SPARC copy_thread() returns the caller's global TID, but
tst_gettid() returns its namespace-local TID. In pidns05's nested
CLONE_NEWPID path, tid is 1 while pid is the caller's global TID, so the
child still takes the parent branch and the test waits until timeout.
Use a SPARC syscall wrapper that reads the %o1 child indicator instead
of comparing identifiers from different PID namespaces.

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
