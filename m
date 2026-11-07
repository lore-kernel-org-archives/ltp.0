Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA6606A32D
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MFpPFPSi
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 715463D0872
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 11:46:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 710333C08A6
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 11:46:24 +0100 (CET)
Received: from mail-pj2-x09.google.com (mail-pj2-x09.google.com
 [IPv6:2607:f8b0:4864:39::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0DD8110005DA
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 11:46:24 +0100 (CET)
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-3b0b2cc3b6eso499263a91.1
 for <ltp@lists.linux.it>; Sat, 07 Nov 2026 02:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794048382; x=1794653182; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BZjJDCnBJZEJ1+L/eKvScEaUcTijqStSdfo+cL99VY8=;
 b=MFpPFPSiHcXLOCFQSJdjQorAQG0e0wy2ZynmTDLDllAlGUgVrGUt2W4EYmClZLiws7
 dDOiVTS4NNb8YQheThJl/AUwBcToeySS1LCjUHE3irXTQCnKtGb2Te98VV2MKEfLXMnZ
 1hfMY03SsgZD4vYsLLlW70bbZpjj7anvpJE7/VvUspba4yVqgER1IyXRqZWPPfdnbezp
 bynhFU+3o9NzSgje0FvAS3eB5SiP+l41sSZbBASIKSE2L482tHl80LIx2XLnR8rXXPrU
 uKx5/1Xxa4Qj6yqM97OgwoI8/elNKA5kUB09BboXDE6ugwctWy9jIY2XRk2OCz638MRY
 rgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794048382; x=1794653182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BZjJDCnBJZEJ1+L/eKvScEaUcTijqStSdfo+cL99VY8=;
 b=G0Sx2cOLjAKFHI5HGgRAzIjjx+hePhs6hAHuTCPHVRf80XY4vBCkgmeQeenxYlA8x9
 8UfJJMfXaVyIiE+jb+7eWJfjtF8oewAWRPqD8VRpaqYC2qU0bpk5O55JMCoG8C3bJFXO
 HbJUlzmRqcyH0mo7s0l+DGNKh4Jz7K/wkMMn+IcZb3TcX+etUuOP6NOjpvMUabUeOr+b
 co6c7jf4yHHAjsiBAGe1sNarWQNIEzul8Kk3+qEvTtdrowEkssG0WlDeXpPo4gkFYoQW
 D/2gExEfdwb2DmWSjXmjD3dgOvmD+Xq22TvZd5DlbGM1TCkE7Qzz/VCcssr7bVI5nETu
 OleA==
X-Gm-Message-State: APuU4Z9NT+6vt5NK8qgo3d4TcUo0iAp/xH6XemYuDRd0uBNYZ9JTDSAd
 ob4nBKTB9HptOsuvCJ8DJyHSnMI7b2uq63RlkeLAvsILlcp0+2kEmo9u
X-Gm-Gg: AYBFou08tzmCTMqxaqjaQ9SHa96LVJEFkjXB68AsrNBwFdrH0sqDniGsqypdvJQ3zbG
 2p2ELYk/WjZksuCOB8lib5oJZmB69WdtKflzY+qXf7vDnpkFzddD7sKnVVWouyMF2ht/GzKke2j
 XmKphW9K9kUuEzRyLnqtfeoui3XqqpU8itHqQ01Uso0S7VKHzGC6kvEaB6+u0Fo+jgh1wDf/FAb
 FvXCsxh8ZYX9DqBVyWoL5+Anot9q+kccdFwKT5f3FeNdpLzggtwMDdump85n+g8A79IAg7XWJCp
 khevu2KFJuqqpgNWzQMT9+aEU5dfYJM/zuukS6i8O9c+LajWa3mK6WrGC5lRvKR9BCxrgBs4zUy
 ubzVQ67o/9+2STa/jvkgUbYJU76t3NjkcCKsvh9xyvXUMHzBYZl4HS+06nD0htKs0m1UYxMJC0I
 spTAMpTtpE+Je0GV+oQQnxe3o3g7FLWcmG8SyBGsUBQRsgibfdUBotqgyX46vkwpXUBXORTuSlt
 TMex2rnsTXD2wIIvkPkwG/D5vKNPDicApFziLcb7l/CvBTfps8POe7EoQw03cu+XfIuJQYvFNVl
 3Y0Ucx8ewwfxj/VRVCcMqC/NoQ40jUI7a/5ZPzH6pWFgFHMj+pQJeMskCXtlLOqFVr1EZZiWkjk
 ki2fRNg8zdW/42YRpEY0ZstQRwNxs6rWgiYYgmHQbhmAKnQbxoBnFYjWpvnrBzPc=
X-Received: by 2002:a17:90b:2782:b0:3ab:2737:3396 with SMTP id
 98e67ed59e1d1-3b0db725559mr4677208a91.65.1794048382392; 
 Sat, 07 Nov 2026 02:46:22 -0800 (PST)
Received: from
 runnervmwuk1x.uq11q155qggexclruob4r3w22b.xx.internal.cloudapp.net
 ([20.64.247.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b105854fa9sm3336373a91.15.2026.11.07.02.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 02:46:22 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat,  7 Nov 2026 10:46:21 +0000
Message-ID: <20261107104621.3655-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107044415.35996-1-pavrampu@linux.ibm.com>
References: <20261107044415.35996-1-pavrampu@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmget: Add hugeshmget07 to test SHM_HUGETLB
 with /dev/zero read
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

Hi Pavithra,

On Sat Nov 7 10:14:15 2026 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugetlb/hugeshmget: Add hugeshmget07 to test SHM_HUGETLB with /dev/zero read

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
