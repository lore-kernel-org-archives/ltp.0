Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C59C44539
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 13:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F5FA3E7631
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 15:54:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64FC23E24EE
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 15:54:13 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D81716013FC
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 15:54:11 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 006d021491bc7-6a3e012b4c2so814439eaf.0
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784728450; x=1785333250; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xRnVpZ48ULhl23Jmlogf34z0xV21gNq/9h1YMcPQC+c=;
 b=H4xCeKOfhPvcF2MZyC4qrYatRHS89JuOrkuRGXHbdoQujTDPuj+xORL6WFeRL+NImv
 bz2Ll7K7u20BBdTNg6hnjowmLHQIS1gQ/mQ1/oKWLutCo6GoLEB0NA/1WQOLDj08jYJY
 iCF2vNmry24bOLAVCgo6o6vaLTwnUp3ItQZMaiH0CbW4yu3uB465iJLoyAFGKwxqfRo+
 O6vfw2QCGQaWvuB+5OE5vFkuxN2/7gaHKLw8D0XKH2Q8ehJoAawAuAbm/F4UmL1s9zdu
 XjE4EmPFVz1baT+0r8FWArsTMi98ydxHWAU8b374cOPlMNQHWA6gcOxcGuqFfwpg1u6g
 WGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784728450; x=1785333250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xRnVpZ48ULhl23Jmlogf34z0xV21gNq/9h1YMcPQC+c=;
 b=PcVlcxdW8PClJ8tz+32UE8WGLTM/fDe8ODUypo0lotvEnwst/iVTe/zOS2XbQA7bLN
 6cklummTb0NCi0Gn/UcVOU0RbhB+PyR2Az4NRlCqskTjBvRO5DC0AsBctAtJoeMvaPzg
 5MME+FFBzhixACerkCKK4v8PeXEZiWQ/fHNXUvJpySdxQu9I3dpB7UUdKjvMDUdTDYAa
 3m6GYZvSoyBXVwMj9WqlOP7762sSq7Qn8ZpWT5TAX3wZUZ0PasrZ+OMKteuqB/c+KCW1
 SIM6TY3ZBSOV+eMQRmKkeMRSYR9+/lV04jP9d8dTJvQhl29d5g0MK5DuOppt5+vF9ypO
 6JrA==
X-Gm-Message-State: AOJu0YxdFBgxTJq7/Iq3oSQkmr9SJh1QvN9y0n5ebmN3LdjWCimZKcDS
 Io7psy4G5MPwsXTBldjXGlZVoxNGkpwiiQGdQJ22pwayMdhgaFozlUbB
X-Gm-Gg: AR+sD11UMFzQ1iOxaTIc3QKNpf9QU/TN8OPsyM26dLfSW7jOt6Ula5p7T88gkj52lVJ
 qdMaefeA9QCMma4VQtIMmQIVTH/SvCXHUKyCP/T9dYJNQRo/iUQ7o9mImeSceoy2R6BQusBASgU
 ilprtIHDIGIlKDsG0/7iDJWGu0YFAUCKPBbxqxQU5zUGVGl771d9pD8lApQH/QY7uHZMseYmMoQ
 q8cs6H85EVF1p1X2/A8KX+4Ypkq529fEl93qaJSL5DD49YyACqsHLIu1rirLb7IifIhOUh6Q3O5
 lljPeF+9Yb28Vi1wMaO8m6308LaS4XBIul7liAzId1zmgsBR+XSqLXv1U1hhDmSl8h0IPCvzd7S
 biDR2JtaccBsDeMTiCFevX9SEWbJOZ1XRQlJFiDgHYmK9FRtVYob11H6ZRvDe/dW1/oOCdGLHso
 nnhmBqRzZPW/f58rvvlM3VPbuRJd5stqTTZhU5GlfeqdX1bz2N3ZA7qfCfx5BvOs2cfK/KvaPEa
 jLYYECwQXM0gEwDNPv7
X-Received: by 2002:a05:6820:c2c6:10b0:6a9:facf:4b85 with SMTP id
 006d021491bc7-6a9facf6225mr1794909eaf.50.1784728450459; 
 Wed, 22 Jul 2026 06:54:10 -0700 (PDT)
Received: from
 runnervm3jd5f.demar01ott0urdwf3jgokd5fhh.gx.internal.cloudapp.net
 ([172.212.171.152]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aa76c19081sm1631445eaf.6.2026.07.22.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:54:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Wed, 22 Jul 2026 13:54:08 +0000
Message-ID: <20260722135408.4322-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722114047.54671-1-samir@linux.ibm.com>
References: <20260722114047.54671-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched/cfs-scheduler: Fix 'make check' errors and warnings
 in hackbench.c.
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

Hi Samir,

On Wed, 22 Jul 2026, Samir Mulani wrote:
> sched/cfs-scheduler: Fix 'make check' errors and warnings in hackbench.c.

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
