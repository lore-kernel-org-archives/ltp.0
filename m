Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D51EA3F27
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770801132; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/49bzQWSMIQqUJC86zcc37F0U2E9vxNIxE0f83L5V+I=;
 b=NnuLPOPWFWkCzMVMPJlIZLdI4IS8exNsv6pPggTcTxqiBcelzNCL2hFjDZ2zxhDsXBQO8
 sk5VrohKkHc3z038mPCHR1z7fxbf/OvAo/kZApn4UnlcNGL+f0S/qlye9fJZXgz7tS4ytBB
 Z36RacJ48547pgMuWo7kULkxnyKNO5c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AA0C3CCCED
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 10:12:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75A4D3CC237
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 10:11:48 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DFDFF10006CF
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 10:11:47 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-480706554beso53739725e9.1
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770801107; x=1771405907; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNx0SRRF4p19f0pl2fNt6w9bN/NVZPlmwCFOtpuyvWU=;
 b=OswJXUFL3b7D9t+TkHDlSiyClCvLSqBm6yOWaVehodTw5qBh6y2VBX5Z234T8JG9vc
 YacawrkBo8/tc0x8egjjQPN9GSNFSuLxWNFpH+Invbuv0oYEepONTHP4KWDyx50CAi1f
 YQD+GFj5dn3dBh62ryqVzbgll6XCNVIaE2gVVRKkT72ujeDX5bSGvKKU2BV71BWAkt+i
 VK2bvfnJPWi5Q0HEo6jqfMjZl2MphrLxswYtOLnZSSE071Cb8zoz0eWNqczyay5zCJQt
 fSPhVeoRrZSLK/2yG3IEBdlm7PfNhhJ7vBNt9resP7vnl6kn70Vtn4whSUGLdxkTiQ+g
 pwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770801107; x=1771405907;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNx0SRRF4p19f0pl2fNt6w9bN/NVZPlmwCFOtpuyvWU=;
 b=rotkxx4J94L7qTbpLsk3l6gZh0tG44AD4W9xFQQKvpfzHMW1yaR+qLW2w7LIAWPOhc
 WBP1hP1hxQivllpp3pUI15nfxNbVUyUkvoImaFKNPy0GlRif+ldP4ADDFxH9HNzYeo7I
 vNwBLTcxpdA+q5sd6RP7kMtV9xJA0SHvMwlQ4N3ztcvkuPgrT5nnmO+bbGDDC7Wzu9A6
 i5hUMXQsqVpVDp6wpdBieSWNxP7BhbEa1ZzFwkLWUhfdXLn6QPXajFqr0KlFbYr6GjnP
 hKu3PvYESMjkc4v0yayZhBUwbrlS4fLGieR9/THG9FTcvyRGlawi22kJvEk6cikJrtAU
 A96A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN2EtuySothul1Wz01bUSgfZ/AFOi4cZm9yb9HvUzpR6lsXFjErUd4tNgZsLkNdTxEIpc=@lists.linux.it
X-Gm-Message-State: AOJu0YxIB14cXDxXkf34OBGhFkWPY0Hpn4IEsvGTkAZV7iOfRj/RLt38
 hmrxz5yxWPrk+31O5efECwsu5eWsROZyl0O640z2v+/PLc2GObjtTya1htWKbX+FXAg=
X-Gm-Gg: AZuq6aJ5JRIyXS3xQ+7qLn4CqXzvyqVeUL49f0keKahKwf/qOjsj9av6GMCl91w3yfl
 tsLkYvmRGkFMKS9WlsOHENzJKQKYtlOhuvA5FR02vv/Goj49iLdO0LebmV1ehivotzFgK0LzmSV
 I9oTFr0dFawQ+Z3LVYYfj12V3lRfXOUpB17bCc+4wmS40RoXqMUVbnmZabkoveNJ6SX0U5cSSeW
 XAQ5MalqcxuByEMokDqMBrh6GmxxHI1ED7NQ9uaOV23qxagfwxnX9rpcKFFwTA+D2Mcy2sPsG1p
 9GCKFubuhCJ6cM+lKKH9NjLHoEHRNbydYmPizk9PUvRaBlj2rD8NdtIF1hduWdPUm9qdgF3MnlS
 uFSF6XkXWO7kOiXQYDPKxHQ1XxECvx6VGKFFlefcQWODfKPNM/UiTdKC6OZlpmvu7WmVbvYOdrm
 RKtOqmYfvjzeuoRrtYQT2sca+s40VdkGZI2bhp/yU7T7AMBvGKUnaGcSz7JdsRzBVQzPeEdrFAd
 dDtti3VlnJ0o4Bi5aM=
X-Received: by 2002:a05:600d:4448:10b0:483:612d:7a5c with SMTP id
 5b1f17b1804b1-483612d7d04mr4785625e9.25.1770801107216; 
 Wed, 11 Feb 2026 01:11:47 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba506cesm18496605e9.6.2026.02.11.01.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 01:11:46 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 10:11:46 +0100
Message-Id: <DGC0LPS5JBO5.DEZE7CY4YTHU@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260207170632.2795-1-always.starving0@gmail.com>
In-Reply-To: <20260207170632.2795-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify: modernize with SAFE_ wrappers and fix
 minor style issues
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> +	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

is there a reason why you set `len_strict` to zero in the SAFE_READ()
macro?

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
