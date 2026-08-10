Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85218C5AD4E
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:23:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EFD13CE188
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:23:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 168123CE141
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:22:50 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8964D140044D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:22:50 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so4050429b3a.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786353769; x=1786958569; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qHbUdm+W8Jxz3y7uR5/FinVgyinpITyeONokPzESUfE=;
 b=Irr82R2oJlKa4IoSO9DbizqdHEVhA/57SNRpk7XlEECEI+yYceTc5ZC7mK1tG9yNWB
 cu7XfZyXKPWSfS+DtJxvw3tzveenVDp0k0OmEEu6zYjHCks94pF9uSkzwsPAwTgl76r+
 YcV0MivBVCDooGMYJa06M5NOvyRMkJ5xMzRQEQB4WM1SwK+KLclVcouciFM0MczyApDI
 yu2hDeWLeqmOJFH55jPzmY1n/A1yCXU49cisZxqiXY39lsE8l5MGTOBty3jSBxCiNAnn
 baEyPe/o5H45lCp2KS66HquGAVJ+QgaTfI1QjrViD7jok3UkVcibHxpEeJ9uPjhWGpgG
 SEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786353769; x=1786958569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qHbUdm+W8Jxz3y7uR5/FinVgyinpITyeONokPzESUfE=;
 b=cs0NQ9aKNgvtVdw8ct+nVNGmM7m+Qr7SLMixv/pDgzSAuXB3zbeAIpqrTFoHa156Td
 MqHzbdESm1GfQLHfn6uvSQLHgytPH54xo5FTB2q5fjAlqixgcrafduoUW+a/II4h6Tlk
 dM1T9ENl0ZNumrGVD8Fh4vP81h4tpUZoC8qS/GVIsqpEQqN/LX3TtO/LO0jMI4YNA74X
 +9ERv9UID6pUdnJlZajoi4I9jJuPOv+tUznUOu5zc5vA52kFUGJ08w6NEKvbDKHyfxj6
 A0XzFn01kuMVwxGxTj2HeIWBg2CIRSMVS/coqkqRw73LRYXn6m7SnE/p0kAMwNSFn9Lo
 P4Ag==
X-Gm-Message-State: AOJu0YyKJeQYq4N24XU6QAynomQ9pmqRoIvnXe0G/BwtVeJOhoWBHsdC
 qhQrVZpI5HI8rX5hDVrv/X05iWUUiHeActMG6t/97F44IpPCZLLdk3Zfb67Thrxj
X-Gm-Gg: AR+sD12IR9Plh0obHfoOeOI6L/wD1S3UL5EETNNsXeSlaqABRTrHg33+9jsF2JLSIHr
 /YTulhBUBS6887ktjHJHmrSaC8/egzgT3ySD4qY+ppuQdIfqGoI0PBzLTsIJfbk+rHjACamQvIs
 n523CllK13OUNGogLqOtmfzPEiYkj3E5YD8CYQbOToi9JkpdulbxsYapBS28hOkrEy3qI9hR/pF
 +5MvOKic+GhF+sDJ1bDgZTgD2LhC8xJmlDrd+f4j9K3MyMvH74z+0KBjOpKL0EqxhpGou18qBp9
 boG2Xyzx1/z3pSTQbrht4ElTwEo4LwLcXRxXQkoWMz4RjiLMtMSy+gKYHttqI1+0MnQZaUfakVF
 IMyvMiGJtH0bbo7uOTpIM6kIBGzOHWO31XFIHLDIj7goYxr0/pFrTb/SJKj7FrXe0jX9WGyglji
 8z9COKyRbd72EI54GmKKbrx8o2cYoJ5yggOWMkHYz0d3Vom7a2a63CM4+YYrt8C1ijsjvxWJeh7
 4G7K+liTrmjpx0pb/gUSG7dXs480Nl67Fa0jqDziQ2iyFHsy0dLRZGftGAVUYZbACPdb5mKyoLS
 97k=
X-Received: by 2002:a05:6a21:3393:b0:3c3:75c5:48d5 with SMTP id
 adf61e73a8af0-3cbd37eab5fmr17645301637.4.1786353768816; 
 Mon, 10 Aug 2026 02:22:48 -0700 (PDT)
Received: from
 runnervmvrwv9.35g3lvyscibefissrjt34svvng.phxx.internal.cloudapp.net
 ([134.33.67.167]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bebdf796sm38746913eec.22.2026.08.10.02.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:22:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 10 Aug 2026 09:22:46 +0000
Message-ID: <20260810092246.8667-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810083009.1846957-1-wakel@google.com>
References: <20260810083009.1846957-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] controllers/cpuacct: Dynamically adjust cpuacct_task
 execution time
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

On Aug 10, 2026, Wake Liu wrote:
> controllers/cpuacct: Dynamically adjust cpuacct_task execution time

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
