Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB4CD8CB9
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 16:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 826D33C8679
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 18:00:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E8763C230D
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:59:48 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C130E201745
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:59:47 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-307d0405e07so1286282eec.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781020786; x=1781625586; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jx076x3qIxKJ5Dry19oc57W4y+pnZVEc7mJqQBHevKI=;
 b=Lmg4qAzCcjnlogLBe6l50dCv41/8gqJzGwI6E8b4ng67Ew+bKBgj+cXTPGiIFKEWZe
 5KKIR1TYLDpXHbOfVSeBaWr+JlQE34pGDuFPb9gYKtjVGDz9DAKYDoXuTpKM3XFbBQM0
 Seh4XF7FYw4wimo+AMUtfqCkbQEDBeHlq24qe5d7Qhm7Q8IC2KclpjQpX3bFbH3pPa5r
 NtFl+beN3cxH1UQzPOrvCxqVr3BVt9oSuzxzdyQW4i5kILj9WH/5BEVM214U/0KYx1ma
 JhvnQx4J8AKBk1jZfc0qdx7U40/PAo1luAL46MseHDYPndLT5HG4LLp7FdCiTrrArD9n
 uyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020786; x=1781625586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jx076x3qIxKJ5Dry19oc57W4y+pnZVEc7mJqQBHevKI=;
 b=Z5WtIYPL0/li5phvkE3Uelj6rBhzhtmAAhvogUagj7MqXtXN62cpJyiMcf7eiY5eBb
 7kuIlBqaFHLQwXeuDhIxYrF5gQ2YUy4pGXCEL8wuUCN2waQSEUo5zcKww3aK9aIBjb/w
 yqhKmWVkqWAAlYnCLnMr9mMOxNs9Qx1omttAdBMPiZqaraclaL57M7gx9VauGkasktZc
 TszApcJVc+GPp/NZ3CL0gv191pe5zvTBe7kLFfxEKIBG71zkrBXULOUXbulAuAhNEM3Y
 SSUyzaH9xtP6eCcUc5C0Kys6+efJvMzjEpYfktyJ0u4eCGSUmjU1/qI4//qj6BB8Zbbg
 besQ==
X-Gm-Message-State: AOJu0YyRVCdNbboCwjeUYKnQEYK/zpw5HqF9kMEz7/Ik+9tzm7QfgCpS
 nci7KdNhvc/m+u3r1WKb4lrXOIZo+GK0S8ecuT8fef83QAE2pao1NmHo
X-Gm-Gg: Acq92OEB5gMYptFjnRSQnRWHxnn1IFIpwVWW63G7EMQsWRw2EKJDJUP5WytKm5osAvD
 RvI7tk2r+jOTJSzdjcqAXXCKXhGxckF939c5wc5wZofPiu3sh93qrjIJv5zH9ojn7ZakNICuSAM
 BkluaBiz4xI9tIn4UdZQ79yGqWcCgx7r/FfIAWKYZsR4h7p4Ola1FjUZXZcmgPNgOrxZxRy3ZxQ
 98ZvNVLkMw52onJxhFM64nl116KDs3kvi/k8bZlvoMIKaFAphfubL74Hpuzqt3Qfszl7FIyMjUm
 aDpQqdkezpUTe/BSYefWlQ8bkl6oca0idVdiAyL0hCcGTOIOP3A2z6obMdcv4LwQFEbYOxpfuEV
 0eKdVN9VQOAvW/YSdy67++ACd0GtWcvtebsJduNeUTt38XOAW9wUKfNmsRr2vMWeBnRQJwqzg/O
 Br2vpRmJXY+o5xegywfQTu9KteKrgciGGaLYp1BwcFlaV6mFxhlIGCuIomOd9zSs9mYYqIIOsJr
 S5Qi7ZNkf9cFV26YGlxqNj+fJV2QkPu0H6HuAAc1OmiCG+KhBI2
X-Received: by 2002:a05:7300:ec15:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-3077b2d9d1dmr11601116eec.25.1781020785950; 
 Tue, 09 Jun 2026 08:59:45 -0700 (PDT)
Received: from
 runnervm3jyl0.da3kbe4elcuundlem0cemmerod.dx.internal.cloudapp.net
 ([172.184.210.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm30547228eec.5.2026.06.09.08.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:59:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  9 Jun 2026 15:59:44 +0000
Message-ID: <20260609155944.4024-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609152305.1248443-1-chrubis@suse.cz>
References: <20260609152305.1248443-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/madvise: Make use of .min_swap_avail and
 .min_mem_avail
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

Hi Cyril,

On Tue, 9 Jun 2026 17:23:05 +0200, Cyril Hrubis wrote:
> syscalls/madvise: Make use of .min_swap_avail and .min_mem_avail

> -	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapTotal: %ld", &swap_total);
> -	if (swap_total <= 0)
> -		tst_brk(TCONF, "MADV_FREE does not work without swap");
> [...]
> +	.min_swap_avail = SWAP_LIMIT / TST_MB,

The commit message describes this as moving the existing runtime
checks into the tst_test structure, but the madvise09 change is
not an equivalent transformation.

The old code checked SwapTotal > 0, i.e. whether any swap is
configured at all. The new .min_swap_avail check uses SwapFree
and requires at least SWAP_LIMIT / TST_MB = 16 MB of available
swap. This tightens the requirement in two ways: it looks at
free swap rather than total, and it raises the threshold from
"any swap" to 16 MB.

If this is intentional (which seems reasonable since the test
does need swap space), could the commit message mention the
semantic change for madvise09?

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
