Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D61E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736858454; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IGOQuCP+S/9hztr3OvE28TIlynwFGY+VSVyZGWhlxD0=;
 b=PnMaaANBYRuP85cSEzC4YUleWSy9KbTS/iByWkfBSnh0SLhfRTIYFtx0IgSGCSLEUNipE
 pGDEu17U3zFRIqdu6JuyEACQn/6TVlKPbpjdOnvcYCXGxF1CUxGL5USWWGUk1ywsNzi1nTe
 LUMNDWgMMMF1o3cDcXbgFnSQDPoWMws=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DFF13C7A53
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 13:40:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651023C7A26
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 13:40:33 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8D7F6320CB
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 13:40:32 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283d48so38823435e9.1
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736858432; x=1737463232; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edR/CHX5PLMi2pfrwnyb9trwsvokk+j+wsObX2V/3Aw=;
 b=bVHId44Ds+NDJnp7e0XO9wtRqDAcZfeZOdVQaB5DdqAUgiyolY08SF2N236aFbJetL
 saVtgHtZPLmr35Cpv1o++wLAySg/T1LZNdAp1xVtGHO7z+x07p8m25vkApYSg0S0BPRP
 vs32EaLWW1WTYaqhQAVxATMZ6HBdMuT8Iw4kcYfXBhk8r1p93PyUFNn/Oi10X0gZcPJt
 A/B5lwbP4ocfeOl/aJ6jI3ZRWSmuZqK8xqXbnXlGY3TLI/wsiky//OOPYz2LPh2OGlsu
 6cUOHJvwKN/4FgIchlbD3QQGebfRSFMoWwV94+quyFYZzs2Q5bHMKsqERq1xITohv7ba
 04wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736858432; x=1737463232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edR/CHX5PLMi2pfrwnyb9trwsvokk+j+wsObX2V/3Aw=;
 b=w/Fz4vtrxgaOaKy+WNUOmTGeOpXa+Wt64hyTc4jdpEsX5FVYy8kQt7FQqkTQvjisEs
 wGrnqy3LDoRJDQXswITLuq3CkY99KP06fcUCdiNdGLN7rBSIVfmWrGkSPK0/WD3MmqMp
 8TXAxLMxM+QN2edMGjZSoTVJeCNoxWPRHlAIEunU+z1INXnmvKKKYM4KeKP+4UxbWqOv
 fgcqqvr7I5WIt2RM2G83aRungeT4iB+UxZY3czDIvDJIuNB/CnF3P/2kN6vf+L7xNvig
 Aob2imPlWoh0tIt/f0mu+dXqk72WQp03HT09HpeE6OQz4mib9gXOYiF9UMW8ZBxtoyy7
 1Grw==
X-Gm-Message-State: AOJu0YyjJXW+JOxD/ADwO6LuHECY6WU1umTZb3HOpZQuLn0cqT/aliZL
 LHoAnJXMvW25worha74HLtQsxoIkxFSkj7hmkLkvwPuHWAAg626LWBaXTZn5/AKxx08TSodHZAY
 =
X-Gm-Gg: ASbGncsinvGXraqMDtaLE7lHxuA919C3UiyU7Ml1AtRcHqocA65b5Cn2Shj/sBNWKwg
 kh8to6Wv4uX74RbxGpTZkTPTPki1tD1VmTApsSjxFe38NBT43FPqupRo7Yxh5zq5Ipm8E5bn5do
 LAbBe7syIHXmXuDfOG4EsI5sfN6fMC0KRR0IsJCtxzaQvh0T9A/uu2EYeYQLxZf8fD39XJTMd4L
 rIov5XkazSpraxag5imRSDeNHM3fUP0JUiSU/mP5l72Vw==
X-Google-Smtp-Source: AGHT+IHA/i/898g4OgrUDP0GbWUF9ofAAh5uwGF4uWrCd02cHF4WidH4jnRHei9LTjIDRaWbzlCbxw==
X-Received: by 2002:a05:600c:4f49:b0:435:194:3cdf with SMTP id
 5b1f17b1804b1-436e26bd59bmr98148885e9.19.1736858431945; 
 Tue, 14 Jan 2025 04:40:31 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436f67192a1sm105196945e9.27.2025.01.14.04.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 04:40:31 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 07:40:21 -0500
Message-Id: <20250114124023.4702-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250113081622.28942-1-wegao@suse.com>
References: <20250113081622.28942-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] ptrace: Refactor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  ptrace05: Refactor the test using new LTP API
  ptrace06: Refactor the test using new LTP API

 testcases/kernel/syscalls/ptrace/ptrace05.c   | 220 ++++--------
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 3 files changed, 257 insertions(+), 304 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
