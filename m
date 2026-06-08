Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76936CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:30:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89753E6FDF
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 18:30:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C83693C9F18
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 18:29:49 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63B636013E8
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 18:29:48 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8ce3876a50cso46551736d6.0
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780936187; x=1781540987; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oZznP47QvrPmWqrvv1vjgaamJlvdhzZDafOtuJHI8o=;
 b=PqEtZYS7hurn2dgYrWszarlJcpvmRfRfqVMkrPv6EghuiAys6ScNb+htggh8a2fCL+
 JvyEIwlLLLBNTOIbdYscSd+v929wNkbEuxBEBz6FM6gm6SlrRP9wCsJDASPz5bUsAqhM
 /eAc5Nff1mSGHnjhXojmk70WQ9HuuMTdyLmSuhcRrdy7MIpr5vdowmDAAKexVqh+dIvC
 r/K/cUl06+ZP7oq3NqpNsgszXZ6VGozPA7Doc8WG3G8T3VIVGVXc9kMTdhmtl3EHFIjg
 G4dmwzd/+Vb7AsgODqRQpiQnjdyOspEsFIa0toHUwKMN0wRhMpwY7pWD/G4JvyBLjaAp
 ReDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936187; x=1781540987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9oZznP47QvrPmWqrvv1vjgaamJlvdhzZDafOtuJHI8o=;
 b=mMGa8Uq7uGaaN/7a/rHEPUTnXEeI90uhv7ecwM6K/tb5hTXkY++5UdlOEX8/PqKwMx
 SyNoZdG7nrZF7DG0sSyTCT4vDu08jTCxU8U+vy8iZeHqTU+ZqW6RIDykU0ECF2FjBRpk
 kNoXx06WYT0GWKL+HFBt2OR1UyQTx+/bs0f4Krr7QRRcuoHlqSAvZoEhqycomy0M7kg1
 2wXxJrvFCtxA53V9W24pMk0LpwzfvlJ8tEww5ySltQJ53m6iWd043aZGLaY69jW/lv9j
 m6UrEKFcZarJ8HiFaeFJeH0765eJ3tLi9yCYCO7Zx9tNPVJEkKXEaBiGugPhhsruhhgt
 bWlw==
X-Gm-Message-State: AOJu0YzZ4Kidzbs30ONL2dbWGSeaVVnW/m0d4HE5fzmdvQakPme0rn1U
 DyK+qqPaHveHcxx4Wkvny6MJ0D5ztHHGe/AT85EmC3cUrPyxH2Zl0tKi
X-Gm-Gg: Acq92OGiIKUTxSqp+SrORthYTVhRWH+dA+OKSEaJASCa19TEv56p0qRLU897Z/H91lv
 UdsKFpxqTY5JVaPaj9AOvL/RtOcF44yyj5Wdwx4ZhxetYQ9nBpk8bzz8SU8YaEkUkKaiz6Z+8Qr
 v5TQnTzxbxLOSkU+MgMOu63GT0Y72+JEUE0hOwt0lWGZQdL5m6z+swlxOJuRQ9aUc+K90u682TZ
 gOu01KGrCUfBfjRF5+FR1zHCVKdijivXTdZXiCx07+rskjX93pc2AM+Y9k+FNOI3l0w1b6E5vUe
 leop5lZrREme4dLbPZ5FVvWkshYcJMs3mUx51vRKydlthRiAYQyaUr7YQNRmkqDKuARfU5810wU
 RHh0eYy+NJgmfCfv78oKheX1WF7hnp3Q+iZr2ANm7j+zIMVXynFBnbDRDx5TWLTXaVfZUCyu1Wx
 dy7lGe8sBuNcIkl+sfaAcaOGzSj9e3AvTlWz5fhfkieLKdUGWaYIHUICPEXBbdYAqmKJj8T2Plq
 xXrUEDv2R86NqX0NJEOvfjY2GUpP45poVfTCB647Q2svuoBMaHmRiW6z35Pcg==
X-Received: by 2002:a05:6214:301a:b0:8cc:f0e0:f90b with SMTP id
 6a1803df08f44-8cee629be9emr235369556d6.40.1780936186502; 
 Mon, 08 Jun 2026 09:29:46 -0700 (PDT)
Received: from
 runnervm3jyl0.dkjmlu0qx43exgo2czqhiqv2jf.ex.internal.cloudapp.net
 ([64.236.131.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd054d2asm170838546d6.23.2026.06.08.09.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 09:29:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Mon,  8 Jun 2026 16:29:45 +0000
Message-ID: <20260608162945.3948-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608155241.270875-1-japo@linux.ibm.com>
References: <20260608155241.270875-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] swap: Add exfat to filesystems requiring tst_fill_file
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

On 08 Jun 2026, Jan Polensky wrote:
> swap: Add exfat to filesystems requiring tst_fill_file

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
