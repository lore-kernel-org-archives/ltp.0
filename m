Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8438C624D3
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 12:27:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 847993E49F7
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 14:27:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66E043E234C
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 14:27:06 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 484386002A8
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 14:27:06 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so2705166a91.0
 for <ltp@lists.linux.it>; Sat, 05 Sep 2026 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788611224; x=1789216024; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bspXTtPHAsf2me3gcaENgy8rsmeC7YEEqKM5tIBAbhI=;
 b=IalG2TDwQlarA9VLSa/0KkC3lnMfreJy9DGbxDhjX82LP6ZauJBd8q+3Z5ntB9uMdl
 qL7UVFLodusqYq2ym+K5bPgjwI+c0etIRHWmGc9L21grF5SXTA6AkGoK2o9VQltcLiJ3
 qvLTwE86FQjLY///YYVDZ+sAdbQHQ4LnsAX1LpKQCViVSmBg5smrjfsbCkvAiO146cbH
 zu7zcQROnYmj5FneIfg2a3e28eboXLCZbRXhsnATM6RyVc6/kjFpEj0uq/L9G3VVnzkm
 5NC8m3ueQCyDr+ok7boiQgbwyX6TFQTK+JkPr0GaeX9+LTq9oqdf9vm/3aZur3ZJFM4D
 33Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788611224; x=1789216024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bspXTtPHAsf2me3gcaENgy8rsmeC7YEEqKM5tIBAbhI=;
 b=DUbACEnWC+W176jN26VerE1RuQsuXs8g43bzaJifdy9lheDt53hJYhf8P0TIEa7lvy
 ULaOxYsxtCfTE3jzIIXYMjttbNXKYCPO+5RWBNg+aJiAGvHa5bdE1tntud4Jtjmyb9ts
 8vqS8Si8qK32qQC4zBGiJAImmGPj18Q7KdDxHdfuTnj7y6dH8hs00FVWEJfn0Z50sYGC
 YjzIEII+IZmiJ2jWK5ZQVJK0MpMucB5gKrWwCZT5OAzK0qzwO24zNKrY/BJ4fakcTIhO
 h7n0KLeuZoTETzrdCeTFkxABtmkaI1jsR6o/7Z7SZsRPKNadYc6BnJrlJ2bFnAy54ciB
 lQAQ==
X-Gm-Message-State: AFuF++ksrqpHWnXnNKkkAipbt6dcJe85lXIfiJPJdCH/c9w3Okt6vMrp
 Y3fiyPi86ToKFJyiPt5UXEzt1rpLMC5j7fTcrBQNyl9J5oXhCT5kuQq8
X-Gm-Gg: AYBFou3BFtH91DG9EenS4Vm9ZNbJA9lwVaflyjZCCFL2knWu8oo5dgGbINtwd1keqpS
 6APjPoZejSxT4jrcYZNpbjmKQOH06+h6OvWoLA7rwPnF8UPVOrWjFcHqnu4FntVzrwLOymIgszE
 etzGGIg0qPKhClEfaKAoAbo0ZvAtoo1FDk8pr2DUhISJISB0qkP71E8oWRf7NXQ0fKlEQmiWxNM
 TS6NK5mUjuKfj0PZCT7m+ZN/iTF60q2gF9c08xLKWKNg8KFn/GERtkkN1+JXDLtSzFSWZJiXiXT
 fwL6lNUzBegpy1Q//bX7ZN+9ylrykeg99Ic6a+/kb+Uaxmbm6cdMyb1KIbvpCWN8dd7C8aeV9l1
 ZHJjr+5/wxa9NlgaCod9MzgC6cilOnPWLoGXuiWs7xvfdyNMC/oNKiL4SDkzStoCmvNzFnl0nD2
 Ev7QF1Zd1seFFO3D969DXmKQa+gVvY96UFfiOl0vE/y9tdasHJWcbUwMN+GZyyyQTzYoLcA9oFQ
 11DgKHJfzv1X7bFQt7UIzZYs8PK5ZB+bM7IOHrSGiMv0elHnayYdWMbn/mJ4xvZZDJxPhmz1+Zg
 TQlE
X-Received: by 2002:a17:90b:5804:b0:398:9beb:a2b6 with SMTP id
 98e67ed59e1d1-39b087e4c2fmr21238280a91.24.1788611224514; 
 Sat, 05 Sep 2026 05:27:04 -0700 (PDT)
Received: from
 runnervmejwal.zf1dmesvmtkutp4hjplct3ykqa.phxx.internal.cloudapp.net
 ([172.182.242.248]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143243f780csm12869005c88.13.2026.09.05.05.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 05:27:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Sat,  5 Sep 2026 12:27:03 +0000
Message-ID: <20260905122703.8536-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905101953.17464-1-changwei.zou@canonical.com>
References: <20260905101953.17464-1-changwei.zou@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: count only the test file's page
 cache
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

Hi Changwei,

On September 5, 2026, Changwei Zou wrote:
> cpuset_memory_spread: count only the test file's page cache

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
