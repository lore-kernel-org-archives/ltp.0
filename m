Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221C8CD98D6
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:22:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 892E53E6AC3
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 18:22:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F4483E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:22:13 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8468B14002C5
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:22:13 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8ccda0ac4fcso12448446d6.2
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781281332; x=1781886132; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RDnR6xWEHZhMWijEh4TrqtcrHotV+H2IhxBK3vLw0w=;
 b=Z8bQyWmTKkBXs8e1LlzyXPPsT4LRgRhevmvdcUDxEf/VZNXjAzekE0/4EvKIKhAQzX
 tU1fiyl7x0u915ur3Hg7OYFH1ebdM30hR2hrmozUFl7hfbS9siHJB7WDM2LqwbLXiBA4
 /aiMvzxnLwpVPnEjM3oRwDGBSfT/2bPMwHdOKlvj2E2UDVw6VOXjPIM4edxBQYMRIHBY
 7KUQtt+/gciU0GLupL1ChFL8c8SU0ui8lTGcrGRgB+LB1am0MGAt4XxI4LEh+n2uMHSi
 hEc671WVZjCynTg4rWop0KGxMjtXhe2we9xubDJwmxfbAOkVYr3VH6bJ9dtkOiuasV0w
 hGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281332; x=1781886132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6RDnR6xWEHZhMWijEh4TrqtcrHotV+H2IhxBK3vLw0w=;
 b=h89ebvTnr/PdW+ld5IgNVQuqLO9Qm2GxgpHiZ6QJ/25x6uCCUIrGMODIxRmxH9GBxt
 LlkvT4JXiBko5djXIxaoA1aeUfEyXQwiDPi6EmfiZxhSbg9lZUtNnCtlFuorb7o3LNtL
 7yag95LiP7Szpue5gQn0dHFlmHdriFsF7pYcC7tBRGXBRZ/JFA+dOLgrjthh4ncXVnDT
 EPxsV2QHd5f8h5aH3YltJELncs8+NTLEg6fQ0NG8nvJRWfdBJwnJxlsfovUAEHCeRCX9
 r7rGpjnVgIzAs7USsWQ3ZwvGUykNT8kdy2w7YHu+ClPwOxqEHGPPlV8rCm2kyAOaxs4D
 sMXA==
X-Gm-Message-State: AOJu0YwB0AU5ygzInZvTdEwdl1MPLrz/wJyzYAkMsJNVZj2I0PeaDgn1
 /ydVdghPlYwipnFiV63HUCGejr2fTLFw0gJ0Xrmw2n9eQaYeC2+RYbxo
X-Gm-Gg: Acq92OEwQd3bb5o6csvYHaM00Ux9O48qXq0he6et1/mBUFs9uv4LKCbte1U1FBxnx1D
 kio7N4ahJqgr0iziWMqM4VygekKgCb4arh1t1TQ0J+DDAvL7yAt945V2w+7CNmy23npCi7vdc6x
 +PCh1x9zHSqcLnNJQ4aaITF883VBgW7xlItXeVwZYmxWH1n1aKJfs2RLqAD/OQawhgVn6cUtvzu
 e9G+5tfx2SZ0lbEfU+ptusaMSxHfWBd45MyysAenJ+cF+SL9Pp3I39BJl0rOmsQGqSnb7dFNjbp
 9aFCMVPoBwnyoKZuwe0fj15agIDcpyaHTfBJ6OXxK5eAIKdFQNnn4tDKkOQh2RVgF7jIFYh1Ajk
 2pdL7VEGBzmt4ItLzbJ9xgHCKNfgtmSSY+DjOggW5e+P0sFjU79uf/oPiuQP9o++oBI+JfLEceY
 P3Uf/7uR1yTEeQVH8qsEgIK7idkvvRt72pyGNnmwmXVsUxO2DN7tbxfLtgR2iF+p5N442nFcY+8
 kVApwNLqKE71ypzEwnkA8czMMjUgEAuCG5AWw==
X-Received: by 2002:a05:6214:5248:b0:8cc:3546:261d with SMTP id
 6a1803df08f44-8d32f97c0c0mr56816476d6.40.1781281332247; 
 Fri, 12 Jun 2026 09:22:12 -0700 (PDT)
Received: from
 runnervm1li68.bbvfuim50bhurirfaguag3kcgf.bx.internal.cloudapp.net
 ([20.83.174.52]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d301a32d5csm27266806d6.12.2026.06.12.09.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:22:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Fri, 12 Jun 2026 16:22:10 +0000
Message-ID: <20260612162211.4004-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612122045.14962-1-always.starving0@gmail.com>
References: <20260612122045.14962-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

On Fri, 12 Jun 2026 21:20:44 +0900, Jinseok Kim wrote:
> power_management: rewrite runpwtests04.sh in C

> diff --git a/testcases/kernel/power_management/pwtests01.c
> b/testcases/kernel/power_management/pwtests01.c
> new file mode 100644

The old shell script runpwtests04.sh is not deleted by this patch.
Since the Makefile installs all shell scripts via
`INSTALL_TARGETS := *.py *.sh`, the orphaned script will still be
installed even though its runtest entry was removed.

Should runpwtests04.sh (and potentially pm_include.sh if no other
script sources it) be deleted in this patch?

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
