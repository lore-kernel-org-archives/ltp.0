Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42159C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 11:04:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E89B73E7011
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 13:04:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DBCB3E700A
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 13:04:34 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02BDC600D31
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 13:04:34 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7a345f51so23961335ad.0
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786100672; x=1786705472; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FCRnQtw0Ydd6q52Mll/2bQtoQBxgjpD4EzRmho/QALo=;
 b=rIGHZ5kgTu5nMmO811iunCAU8k9q5DIcUoK1Tvnsox2ZWu8CcSCHzr94wfH4FeLlIo
 odAGkvSDF4wN8zO67qA7KY/YMQKREH6caSEs4+4+jRo34v3vp6e8hMRsRSZUieyDBOd4
 GXEoPTLJ0hBvXaxX/sQ4bhJWwXp/Ku/1IqAxSxE49TAY/FjomAtQyTkqHJv64uBXmDkU
 w0Flgi2OVHPve1e5pEfkaAPyiT+GzxHzz3djEaP2hPLR1XoU4TxJ9jbkbMr8ECws093P
 BZp/9M3hBgXP/e3P/j7qJlrPU5lQz34SjEPZSTJ7D9ioaElMfOUZ2woCi/ob6lFkT4Pz
 l0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100672; x=1786705472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FCRnQtw0Ydd6q52Mll/2bQtoQBxgjpD4EzRmho/QALo=;
 b=rUB3YmMpi+X6iptMj+08vrItyaPuhSygwbdWcfnhv+JYLIEg35CI1zk66pFzZoQ1j5
 U8SCb9cu0o4md2sC18FfN3Z+gUSXarNmfF1ISsALL/7BaZ0JX28nHE4MLqqgFOn6EHim
 mkxLLGefL/7qYlLWGeUgXZEhVOzTjoU9V7CDQc4tpsmsbKheVtkGZoNLPWik4f+cHp1e
 h/72+J5K7ti527BTOolALYPwJtEJ+PJLEOYYn+w036uvtd77HLgGL11xmzmpMSvv15zE
 M/mwjh6Sb51KH/m9gP2+dkPzMPUCa972nbFaKIzTb0EKjVirgHNxo6lzYUDQ330Bf96D
 a6fg==
X-Gm-Message-State: AOJu0Yz47k3L/86qG6n3LuKjIlJdgYyWdukZ1bZWWyAOJxkaeZKJJpXn
 AnyB9gs0VtrmBwM4ItSEYDg20SD+66lWQpRvyv5wurz88iMVJq85kt5i
X-Gm-Gg: AR+sD10dBbciaiVImsQLPQok8wzlFTJqtaWNXuw+IE/EIjfi7w2lO1PbV52Dpe6wG42
 naPuc+Y/KzGcKQndCCrEbdz1JTulkOJ9gfslkw8laieTnPxH+YbEaM0a3mkuDCEqDYvu5TVSqc+
 Y1Llg7+cGPoF9+82ubmAwlY4OEJGIKfuFeeJfNQfwA/IDw108RJdrSLexbPPNBBHNf0LeDoWqvQ
 ++r1oFr8TDJMtsF6+ZkCHHHWsEEDyFFLnlTtQuWuz4u5ne1QLVbY9eNuUb+F7/k999VWPlq4gqc
 xdzdOfXgRatYVP/qMwYg+lEX6IRBBymk+b0bvE3AhSQ4YA2x0kvGdd2RF2efiu/qnSWslLpuWfW
 bvUMQv/IvVc+MWw3JH9UDWPu5goeAmcmFffmtlfYOQj+R7YoujRhv5pX/WK/saT9k4TYxAUBhfP
 /YJ5OTzO7kufqTASC91LW8O2mcT3bUDWK5i48OckM/aAI8tV+ryDvhcZGWLXPFNL764h84HQ5me
 dSQUeQzS8ASBX6ijP76e+0L4A80hN0J9brPRLBabY5luSd1LkDs9u4D8LYE6cSNHg82/A+Cu+jo
 Yw==
X-Received: by 2002:a17:903:1aa7:b0:2c9:feea:4e4c with SMTP id
 d9443c01a7336-2d0ca77d255mr266593155ad.15.1786100672223; 
 Fri, 07 Aug 2026 04:04:32 -0700 (PDT)
Received: from
 runnervmvrwv9.5stfla1q3uye3n3w3gwdd2oodc.dx.internal.cloudapp.net
 ([57.154.167.222]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec128a0sm7241268eec.25.2026.08.07.04.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:04:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri,  7 Aug 2026 11:04:30 +0000
Message-ID: <20260807110430.9432-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807104442.2831991-1-wakel@google.com>
References: <20260807104442.2831991-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/file_attr01: Fix EOPNOTSUPP expectation on tmpfs
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

Hi Wake,

On Aug 7, 2026, Wake Liu wrote:
> syscalls/file_attr01: Fix EOPNOTSUPP expectation on tmpfs

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
