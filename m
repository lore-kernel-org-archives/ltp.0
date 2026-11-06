Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657F6082BFE
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uohELTUQ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F6893CFD9B
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 12:34:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33B4C3C281A
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 12:34:43 +0100 (CET)
Received: from mail-qk2-x05.google.com (mail-qk2-x05.google.com
 [IPv6:2607:f8b0:4864:34::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE3151000A1D
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 12:34:42 +0100 (CET)
Received: by mail-qk2-x05.google.com with SMTP id
 d75a77b69052e-5337b59ef7fso2731641cf.0
 for <ltp@lists.linux.it>; Fri, 06 Nov 2026 03:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793964882; x=1794569682; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=udyiG03BCfsdTRdo4htRicdk3CwCt8trw2c8cbJVdq4=;
 b=uohELTUQ1EywQixEejDUCNooFGDk4UKVnIGuOVa8Jtbte6vBDSck2WTn8lvHfPFwNR
 KrOk29ypK7jJCjo2+77E9DKM3CBlgyX5UlSc5HBWqT43mMt2PuPnm9/QGnB42d3ZbQZo
 7ipd0FQ9cCzNvH6hFpY/3Tl3OBXfNEed2+n09ySh/Q0ZG8N3mujCz7UJX/M7JcnDDzNZ
 Pp8QHd7Xt1U38oNron2A94Tl2rRhdKvhKL2NjqLvY3IRYDBxG8j6S2mRwcXx156jYIr7
 D9HDPDx5271Eglzspq/lMi8oldP00/TVWORuIhUM93syp7VKbdhozX91s+j6+4712Qi6
 Kt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964882; x=1794569682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=udyiG03BCfsdTRdo4htRicdk3CwCt8trw2c8cbJVdq4=;
 b=mGc3RgA+ULrbVYONHcraljb7I0C2tUo0ISB3fJM14IKauKKqx3s37ia6Ml2sua9sJB
 NoARI1/i0l6rhghQcN4JEw7K/JikX05vAoCVlORsM2JuOfpzcB3TdmKGYewhpk13xUvy
 cqxv0UTur5jj1aDroHrJB1adguePRbAgceEYbbSMkzy/XDLJU9jOTv63vNM0aVc+6uLZ
 eLfxRZN13xjotqQfW7zsaIIBYAvBkAKaLobFMEV7bXTxn8HwIynkYzt+igkPyyysNqX+
 1KaPSSqnwiLbK3/CctB1scpuXhZLwuSO5MPl5vVZOPgcubKtEfrPaBFAaV+/PVtc6+kE
 FNwg==
X-Gm-Message-State: APuU4Z+xcvlc3uM9K8wsOcbMIdzg1azVX8OrMyl+SeFIFzhE8zR/TRMz
 QqTcWm2ysiJQw5L2ulmGOsZqRGXoMc1gpdsyH2H9CrMdOYgP6L5P1EFC
X-Gm-Gg: AYBFou0o3ri08+5dlwwyaNlNcwvU/flltfxPTN4Mp/BAeuoxPyu88MsD7t3pIEo7wKo
 jf6/KD5Z67LbS9NwCZxQDI/0224NF1hzw3O4Umj5dItdRQB3sEH7eBHEw+6dhRkmudLU8PaSQL1
 ZJdhNYkw/O2wQzM51xaBF7dOySVpPYowNTTQtdJUinDz9X5FQitXzdUOnXY/ZararTyAhyqofxI
 IcMOiOdXVafILKYsTtWWGEskJazRLEj5nMvdNI7gXc75JJVYe4i1uq2HfNTuOSnYX+BbVKgZTne
 ZbqwsQZEGpylG5MpJjFyP6wlWmzEbReNNxFnQ7MNnYiY1Yt/d82JlTCohDro5lrSfZnbyJxpTXV
 NKFssZcQw+ghYXrKshEBmlHzEjqM/Y7FOXNCYPKru+aFcqDWBpNt+QdJKiXsUfvG6piIk5y+TOI
 3tjxmDoM6xVp42hTy6PiRdy3XDKp0ZOvQ/kRy2Oe8uN9FIKa9vjMcs30PlhT/8KqRmJO5fPHd3n
 pTb6DrLptcasJWiONRBuYwam3+aQKux5sTnJOcqlaYM++kxjKilfIdt2MXey0UUrAAYP20s9gLT
 ZXBDLtzBzAzwfvXc8/4soDa1L369zWngQNDS1xrS1Il4JwWv0arFGLhi7auvc7SSzq9JvIlNXXw
 u7IF6D7fLjvmBvMm966WDUqG7psjYrRLTVsyqPsmdQw==
X-Received: by 2002:ac8:6545:0:b0:537:b9f5:4682 with SMTP id
 d75a77b69052e-54e15170c9dmr30839611cf.61.1793964881373; 
 Fri, 06 Nov 2026 03:34:41 -0800 (PST)
Received: from
 runnervmwuk1x.12xziortip3ehm5r4a2ohvh4oa.cx.internal.cloudapp.net
 ([20.109.38.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e2750172csm18008041cf.29.2026.11.06.03.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:34:41 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen_ky@163.com>
Date: Fri,  6 Nov 2026 11:34:40 +0000
Message-ID: <20261106113440.3874-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106032251.62288-1-wangxuewen_ky@163.com>
References: <20261106032251.62288-1-wangxuewen_ky@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases: sysfs: Add sys_thp02
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

Hi Xuewen,

On Fri Nov 6 11:22:51 2026 +0800, Xuewen Wang <wangxuewen@kylinos.cn> wrote:
> testcases: sysfs: Add sys_thp02

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
