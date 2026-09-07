Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30781C79F99
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18FA33E950E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 16:58:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EE6B3C6135
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 16:57:45 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1F2B1A007E8
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 16:57:44 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso2243885a91.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788793063; x=1789397863; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VeTESQ0l8LBuFrYF9H60XX2l/mJICvHJwRa7yjshIzE=;
 b=r6z160ShcmljSETCIrwoD4USzvEAzg/zUsRH2pa66KrTWD+LXGJ+V+ZaJ5qSQ8FDth
 Ju0Rx/fVTsaqNfgL0MIA0H5l/76jM9T3vKic5ZaLwViJAlQveEGSonHtqg7Si5g0W74w
 s/jExSv4wp21WyirkDXhnOE4FQybOD6+02S1wM+MJd3D9tBBIccI7kgwSSSXTItZxCql
 x/lUJaYhnI2eJcr/8BRD2Vog+6WyqfZXuWcwrVJN3PdJUbVP4DP9ENR24hXJx63Svb7p
 R1c7zZLTlnxnrNNKHy6rBG+4Zf2yLEszFdetnOfy1I+O1Q++UTZevFFsFgqhFAHuiGzv
 5d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793063; x=1789397863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VeTESQ0l8LBuFrYF9H60XX2l/mJICvHJwRa7yjshIzE=;
 b=fwihsgDef/Y6cAsAskNW5z9uIEd0LstYQqonGoSYAdInVG4iAiKp5nnRvR94pIsuss
 bUQW4XcgH1uSnfEumWXYXKPeGD8W2B5/GqAZ6tb9PVbjXS0IRB88s7tsdzV9kMSuWhAd
 tKNyZ1j8/AFZ9xOJlXXhrWaXSCumZEZ1DmjfbSxlGsgTPeRa91+zB2SkzgnhQBycPUpZ
 17vSvm6YS6c3Qwnn1A8AqiRqNQWi+1WS/E1wQTqtEzAAhO6NunZyhCjlLlHNFxnk509z
 3P/DjkLshfUlmV0rjnmWMx99KDLDS8Mtt/R2I7LMyodkPWxEfkXg01d7S0l+5V0tqDV8
 Jngg==
X-Gm-Message-State: AFuF++nGMdI88ZQekLy7NyQC+Q9pVhROKU/TPfSfpNEl0SEAf9qPWORw
 t6+7/5mnd0k8/sQgKlEhQZ2IX9/nK5S6TayxGdezMSLODN6HPOyzKUwsQ41Xvst0
X-Gm-Gg: AYBFou3gNSA5lCQ6tccBuGR7FqMdOwpqHYaC4Ls8PxsX/wtbbr4izkUYxGBRDgzkwFH
 Az6thnHWs6cs3RjvMXgDbnK8xdgojONJ9iiLBeCFLFQTXGvTLdI7RRFkXqGn6eesPDV1gCHa4uE
 PkRLsM52wf6FKNXqy1E2FyWpC1pDSPadM2pG+9FtByEf1Ty6uaaHg07NKyQKPKFzkEEFrVQUkKN
 nYWnOom4X+5Syze8kHE2qn4FJC4hGGxixT+TjmgogpcnZ+tCsKM86+aAOFhMgD5/l9zv0DKUewu
 sdvT2LJQgxZWMfHo4QuJjhPvTwGywR3Q2/tGMIHiLZkWxIXL8Nw4NgOhSGSf0mRkJQZ14PrK3fX
 9m6Om9KeYbgxeCmnh6m+XT0bI/NiWFMVvyvD8Dl0iTUgNFRaq6MW/0Pp0DCjxWO8FwLo3qGi2Oh
 YQOwPL7QJ5XDaCauf7LR6CHNv42zN9EXwMVCxfrDtF4zILX+BlrTpe/jWyN6IIc7LJPEHPZJuav
 cRTrYnGNKei/nMt8gX4i63hYXsXS9YgZYkdD8Uh0/vBhSMN/7hWEAsIniGb6otf/HykaPKUkoTT
 jg==
X-Received: by 2002:a17:90b:2f87:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-39b260fe42amr34248128a91.5.1788793062805; 
 Mon, 07 Sep 2026 07:57:42 -0700 (PDT)
Received: from
 runnervmejwal.tpeq4opckxkudcgvnjlaud5nje.xx.internal.cloudapp.net
 ([20.120.230.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26155324sm20700206a91.17.2026.09.07.07.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:57:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  7 Sep 2026 14:57:41 +0000
Message-ID: <20260907145741.4178-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907-ci_patchwork_apply-v1-1-95d71dbacc5e@suse.com>
References: <20260907-ci_patchwork_apply-v1-1-95d71dbacc5e@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ci: apply Patchwork series via REST API
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

Hi Andrea,

On Mon, 7 Sep 2026, Andrea Cervesato wrote:
> [PATCH] ci: apply Patchwork series via REST API

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
