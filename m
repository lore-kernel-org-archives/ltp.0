Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA248CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:59:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CA5C3E65B5
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:59:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADC323CBC10
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:58:43 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 536711A0092D
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:58:43 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso264316eec.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778083121; x=1778687921; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ni3qzZy0Zw8COfp2lTr5LrX4L75NcN85OqlQbWYkuXs=;
 b=mGYDl0SOMZ8Ud8R7ou820wQgCD5jM3jza4sXqKxPg8uWS0UZwUC1JmO45iCfL5JcJ2
 /7YhkC3yhQQ2tHdGyKQf2+tk9pLEtJc/5RsKPyXMOZ92OOESsu1gM541nGfOJaad9AYU
 6X/lGeZOgP1060mNyygJ2WzPsiOO4R41Qxffa8LIpWE7dhqLxWneLNnQPzqFQgdsJoF4
 tlKeldG+Vfoe7pF1KI2TTegxPjZP23HQrTiZ2Wf42mbzW7xXQEv8qtAiVhTCDPGutt2k
 yF+rOd5HiHR74hN85ZOu76OMKmk4tC9cGqbJ0vMzz76TVBwJ26BR7aFKAoQ+pD1UZEDR
 w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083121; x=1778687921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ni3qzZy0Zw8COfp2lTr5LrX4L75NcN85OqlQbWYkuXs=;
 b=D/QKHyLiNsBCNGPT2zpm/8D4MHk7MiN40ZDTFIg3R1kA/CIEJ5TtzFxCHtr5A2TtJE
 3LezhOT7LiFLQoaGNR/wR7jT4mZ+Ope7kH2z4ayulQaWZCyfPcSy7PQ1+7K+DIuXR6rq
 n0knpCygPOl/8fuYFpqWQVRHbk16rnjTKDZOJqukP0oiGz/JYkFvQ16T9bIxUW7s5QsN
 N02Tm9gWaOTHpPhY20o3BapMcRxBTSSA8kbwUnuxFd5C8/4qwtHHsDbuVCVe7C+PgUAb
 IfoP0Jn+JHiKFwLQkI77Ihqopne4lqdTxzshuJTUiiFsx+mOj73Fb0NmQ7nl1vjLwB7L
 cjGA==
X-Gm-Message-State: AOJu0Yy/Alvlvc9BKZDGxbbZcpe8IEPfaFsNRWK6ENQ/v1+Za9fWyPuE
 wiLOgFHxDg8tV1aCeermY7Jj4BSnnvAH4AJNL+7CSTvubM0V3ggqQSMvSKaumbI2tAI=
X-Gm-Gg: AeBDiespwz37g55v0vwP0BJKpxDP2vqo6vVphFXcteK0GiwYG3RQiQuD2fOUz3tbUpM
 tyw9V6o4W+tSqzpwSEh5vjmeCsvmZmbyE/lOu62F57/X1+mcDRbwLWDjU3MMcVFuuprGdfJwI5N
 hKOcsAatK3Nhco1UCuJ49x4/vVqSdkXIrks0OHiKwFlqvFDy/7XyxcitnXA6fqg6YcCS/yNc6J/
 SzEWPyhvajF8DYldPIOTKiMiVTUQAKYLpyPKMNWKFrKfCzgrcv7SrYVeHYbaN801Gu0PO90cdMb
 WTrTk5tNzoVjhMaVdPaYFP3EJcroBKFvZ4OAUfLSnzvuzzC2U0BkxS4YWInpyIh2S5z20CzNbBf
 WT5SBLB46hzwCFxZu1vZlNWveGdyXlZ6HOFWA3y3rHlcpkkXQkzbp+/KpCxoNPN5wPZVKXc8wNa
 CFd6ZfH6JycFOySKaaXSLLTPDOFJJHTrAbqPcZPb6gKrRPCy08O1pFkvNS3dDSwGMT25dQW0w+x
 Bp9HCQzNf3/0vZFA3MbxVgfu5ezfqMbntGP2vKkTCRg+DlvElVMohI=
X-Received: by 2002:a05:7300:ac82:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-2f54ad75680mr1959976eec.18.1778083121196; 
 Wed, 06 May 2026 08:58:41 -0700 (PDT)
Received: from
 runnervmeorf1.n2uxqdsfspmehakds0m4kccnuc.phxx.internal.cloudapp.net
 ([172.182.226.195]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56ff82f5bsm3632773eec.24.2026.05.06.08.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir <samir@linux.ibm.com>
Date: Wed,  6 May 2026 15:58:39 +0000
Message-ID: <20260506155839.4015-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260412141039.1075095-1-samir@linux.ibm.com>
References: <20260412141039.1075095-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/hugetlb: use SAFE_SHMGET() in hugeshmget setup
 function.
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

On Sun, 12 Apr 2026, Samir wrote:
> mem/hugetlb: use SAFE_SHMGET() in hugeshmget setup function.
>
> I updated hugeshmget02.c and hugeshmget05.c to use SAFE_SHMGET() and
> configured the setup paths so that shared memory allocation succeeds
> as expected.
>
> In hugeshmget03.c, I also simplified the tst_brk() message by removing
> the unnecessary __func__ usage and keeping a straightforward shmget()
> error message.

The commit body describes what changed but not why. Add a sentence with
the motivation, e.g. "Replace the manual shmget()/tst_brk() pattern with
SAFE_SHMGET() to align with LTP conventions."

The SAFE_SHMGET() conversion (hugeshmget02, hugeshmget05) and the
tst_brk() message cleanup (hugeshmget03) are two independent logical
changes. Please split them into separate commits.

Remove the trailing period from the commit subject.

> -       shm_id_1 = shmget(shmkey, shm_size,
> -                         SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
> -       if (shm_id_1 == -1)
> -               tst_brk(TBROK | TERRNO, "shmget #setup");
> +       shm_id_1 = SAFE_SHMGET(shmkey, shm_size,
> +                             SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);

The continuation line is not aligned under the opening parenthesis of
SAFE_SHMGET(); fix the indentation (use tabs+spaces to land at column 33).

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
