Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D23606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n/Lak6hP
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0C8D3EA605
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:51:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43B573EAF79
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:51:27 +0200 (CEST)
Received: from mail-qk2-x07.google.com (mail-qk2-x07.google.com
 [IPv6:2607:f8b0:4864:34::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D07C61A00153
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:51:26 +0200 (CEST)
Received: by mail-qk2-x07.google.com with SMTP id
 d75a77b69052e-53603c3b973so28527281cf.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792507885; x=1793112685; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CQnhGJQETIB8nUMkqrjsEZ7lTJ2XXC7+0nyTjbbULLs=;
 b=n/Lak6hP2KSNIoQ9iLChgU30P5toJbhvUY1U/6MgINs4w2xxxXcEG8zPXN4lE4Hi8i
 FACf/zlvY5YH8VmDkdHoC05+hpQ5DOL2TxHy27Hl94MjxZSXSvAICyEJX1SAFxjGr6+G
 X4YskWaRXQyBmsH/wEiD2nLYaOJVPJfohlfgJs3d0/JoDCPxWERG8gQI0RYoyipG4tXK
 xUYqLFky5cghrzMcvUXRIar2B1QqB/nrspyqcfsJduWCZWczoKM+xjTKUQWDyJyN4JJ1
 xBolGIqodWRNI56jQBJYJXy/CT3x9P/81iurz3+NW2Fx6iBC77UHdA6FNvdIwaUUIk5u
 PA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507885; x=1793112685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CQnhGJQETIB8nUMkqrjsEZ7lTJ2XXC7+0nyTjbbULLs=;
 b=xpEu8bY0PnZ4KlZtDBLEMDoibBlUYz8cCBe7riuPXbQ9bA2wkLqPs3xbuJBgJNcDUV
 9uZQIcMMmu15F/ueh+89MigKLxg+Gw0T6/MBs1+Dpr0gbKZb1ixP+drX3lvjDftLT6bV
 YXvQRPFuPtoVpbQF186GhGNwRAMSkxfRR30Xr68FrpcWjRfzTDcff2BogTGpEaU2dc0Q
 QyMdqhJ+BOLoeI/QReZKKXXGohCAc0w15WMJLB7zFL/dm2f/GYUjFHrIpkOKaUQvaHwL
 tCnr/BCqOV+dFANoeN/GHt+/bKUu5vNHxyu9XZ37F84QqjaRrSRA9lD8z24EKqWRH0LK
 6/HQ==
X-Gm-Message-State: AFq9FYKqFOp3u9Lblg3A7dVVT1v3K8OozJKbcycDb5k5d3cafdLZmutM
 FStGy4qhCjGDv4J4C5Qa0SAD51rFc4D3wfFc4OEyv1xI4WU14VlNALZDCpkW62nh
X-Gm-Gg: AYBFou2TkjcHXyRIRJP+Q1hOA9IWKx99KC4Uve/Tp0KGQBsYw0ysYGvGjMwboUbAHBx
 N5V4K34MLOaV2ff69JTdA1470Y4HSLBUDD3nam2lwtuNYxkVL1QT40X581AaoA6JDylHWsaqeIr
 rQMH6k310CnN3y+mKtuL5rkL0L66pFl211vda23BFpVvtAzEMgeloToLiBy7/JJua+EeJXIKIYM
 ApmUNRsLsddIuczLWgJcqTirPdkrUT7B0+h2khzTAqNlOCJJAQYNemLlpMn99ThfTKVp60/CPK2
 n5zLtowA0qt3n8VmfbrPyIZKpdqeoFGp8OStcPOj+iG7LuvXkH2ZD/NXJvuQK+gSpNQ5NKpbC3h
 W7xfBTFZw909dARCsIL+dP8fLklpY5h7g3HHoY+0zbcHv/htO6JyKAk92R5LVVNo4i2VnMoOsWR
 Pr4PNukXD53Bpmdu49jgUiW7f9UkmlATRuGh3sUyfDB5RDpZOMQ7L9ML0taBHtZ3YaaKV5AMBBC
 ha5P4AuM2JbuJGxh5E51NCpMQ1Yp5ujGPl4sNBsEzAR8fTcBxKl2IKGW3bAeSZsoV/oqz3MYNmQ
 HUHcV97efetAHWcO6V6PwpLNhoDl35Hb3ig5GlwSxtU1DIKmh2l5lC3ONVlYJkWdLHuz
X-Received: by 2002:a05:622a:1308:b0:536:702c:f8e3 with SMTP id
 d75a77b69052e-536702cfae1mr89541411cf.41.1792507885503; 
 Tue, 20 Oct 2026 07:51:25 -0700 (PDT)
Received: from
 runnervmxehtw.d5mdbn1pkn0e3e2pssjcv4houa.bx.internal.cloudapp.net
 ([48.217.35.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53656bcf751sm81024181cf.14.2026.10.20.07.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:51:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 14:51:24 +0000
Message-ID: <20261020145124.9482-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-fix_process_vm_writev_permissions-v3-1-1e92d7a29aef@suse.com>
References: <20261020-fix_process_vm_writev_permissions-v3-1-1e92d7a29aef@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/capability.h: Add CAP_SYS_PTRACE fallback
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue, 20 Oct 2026, Andrea Cervesato wrote:
> lapi/capability.h: Add CAP_SYS_PTRACE fallback
> syscalls/cma: Handle Yama ptrace_scope in tests

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
