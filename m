Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E562EC43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 15:15:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA2803E946D
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 17:15:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E74B53E1A5B
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 17:14:54 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6843A14010F8
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 17:14:54 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-380a00aae61so568477a91.0
 for <ltp@lists.linux.it>; Fri, 03 Jul 2026 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783091692; x=1783696492; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1iXRp+ZsojD7muHyGAONEe16OlljbN9T+o1gN6J9WQ=;
 b=htz+PVdQd/0Wg808ciTg+zjibBWDrGFsY7CqHnInI9aORW/63Hf05MPHm9islxfxdu
 eEAvCyffp4/+VRm5S2TmSet9FEqRrxLeYYgHDj+xZAeVC4sSBrqqYn00RkDs3fNJ10Ya
 Rb840aaP68xofAZeWqEjIvkJ4eVPvk2XTY11BN9BwdCSOKCvW1ETasv22/rXf2+BR2yP
 cV5C1AuYyxJ8IlB/xTKbCODP+ocUrLlymnqxME9hG6tCoMuSEaaGMSeuVQt2RhJwCrrO
 8NEl7hBVmPrpMqBEvVCBHQMI0bzyKUwnl6vt3ROvWkF1BChzxPBSYsht1YTJ0uoysVwT
 cufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783091692; x=1783696492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1iXRp+ZsojD7muHyGAONEe16OlljbN9T+o1gN6J9WQ=;
 b=VxajrrbzD13UwUe5c51JYhsndW1Xw6oTPEP6JY4qBstqjNFNI4gVI0UMLT5XYFq0jC
 to5G/Y8Bsjn1PjC+TOw7duV0a6dfAmP9TWyaUBgG6u1AbdAkKOPFzTSZBuHDIWQv/r2+
 qa2Xy1dBaY5RbrqUfGSHwJrAt13kvBSv4ap53ZNsW3wQEPgrtqfGOijQcEzWh7hNptg/
 WqBUCEWcJYeBII1ODq596APO+2Tmkfa96xrBYqA5oF5QR33ixQvnHi4qyDGTuOFGOg0I
 QQGcGVW2mFWn+ZwIznCVksUbTj8veSCK5+LERKbILE8MlEFTHetNeS7FffUnuPSRcakx
 QZLg==
X-Gm-Message-State: AOJu0YwZVTXAxcuc2UFGGhRq0vXReMM6c409EVLTpAb+9uW+Dn+AZgup
 WPxrAX/f68PXoEU+baom53DzgIuOkWwVw5OS0kTGK90LocYMkBL+LVcW
X-Gm-Gg: AfdE7cml0Az2udNIdAdAZbNRzmwgzcQXe2HMyFVfPKITqY/pAtTTlTM2rWEaQO7UtBB
 DHPAwfalt0tpybP8BdruekZB3Ig8WvE3NJKuzej3VkRl7BIZelH8ColGLK/gI0intpwrpYv0rE0
 JFSyNWt6XBnOaeHHehdPPBmLFDRR7oPTN+18Tce8w+75haxqYSdeYv3M0BIfh3g1e5NnFUnNNce
 E/D6D9D6zWz3reQz9PFMJhXop9eEKqv3RcTFeNaBpIBBJDBhPXHEnpwmxYhlExnnZj461u5RyRl
 Pk33qXaDQ3mLtrtDzZ9aBm1i+98JluFlxNuJDxD2VKBrCMCdsvkUsP3WQQF1HaBJqDWs9+pHTpb
 pZJsSXKbRJkxsci7+DQn5q/ZHk/r4Y811uZ9n0rjVVuw2JVf4P7lS9s7ErpJlnHsxuImWO1cxz3
 BTTI6sHOMBTFe9X1IdoxxhIHGmjW+Uxzm6t9meyb0INW1V/X9A47GpE+WI5FUYrw0zBOEjBpNWu
 8fMPeH9bmHqB9/i2+tn1eMOPRK25Y7y
X-Received: by 2002:a17:90b:2c87:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-380aa0e0512mr10938399a91.14.1783091692434; 
 Fri, 03 Jul 2026 08:14:52 -0700 (PDT)
Received: from
 runnervmkkn4f.c41v2zfaraieda3n4uxiuojluc.phxx.internal.cloudapp.net
 ([20.168.108.226]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f3b252222sm1909939eec.23.2026.07.03.08.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:14:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri,  3 Jul 2026 15:14:50 +0000
Message-ID: <20260703151450.3866-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703125958.21260-1-wegao@suse.com>
References: <20260703125958.21260-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] statx/statx04: Skip vfat and exfat filesystems
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

Hi Wei,

On Fri, 3 Jul 2026 12:59:29 +0000, Wei Gao wrote:
> statx/statx04: Skip vfat and exfat filesystems

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
