Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C868C44515
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 17:16:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B558C3E976E
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 208C43E931A
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 19:16:00 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 724671A006AD
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 19:16:00 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-38dcd98e5easo3794289a91.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784308559; x=1784913359; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTpLtpxBcuUZKzjXSfw+QyvxwFFOkpsDo73WdyAIt3w=;
 b=EHivFIDrlUk5I1atMoafDIWIUNjlQEBsc/MG7TjqPXzwu6u3G7Pc4T555raGu436NP
 4T8EawuLZOORh2jqLi7ZkCfHSASR3/imTVBZZmtdC4fgFz8559hPXqBACjCFmNdVoe5H
 +/pKcKnwYJFtS+KJc77XN5SNzg2Cdk9kcOkE0W1Qo8lUk+4xUcpuw9ZJdmrdETOsaAz2
 AMbOTLNnL0WVHTF0TVKBv7FgPR8H1yBVwUxstcRFp0eiNj1IS5XNN7FK288Myu9zhO01
 giB4g9V6xXuAoVJuz2QWkchC317dC9q90K7TjNJRkUx3A83a7k1Q3lOK7gwQE0q2JA3b
 OfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784308559; x=1784913359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTpLtpxBcuUZKzjXSfw+QyvxwFFOkpsDo73WdyAIt3w=;
 b=D7VV4JAeOrz6F/wlC1bUED08J1eRWb2uGO8yQZljdeyAjjE4YQk4x+drZw5wRWSQa1
 6H9Nf8hRAZ/prHsdK8k6zGQcrHZ56dIBbm50WR97WwmfwsdoHUGOoZUCPCR1NfK9e5rk
 FsBEdlSwR1CSlog3jchn/DJHFjWqTK0wbBaGvG5pkZKCejLRu+rVlnSoFYUD37iQjlZQ
 NkfeCl/bGE7Mt34wYssiRYay1hRgMYE6+GAt1Ke53Ai86EnQRtmkVckeDSF6fheZ+Nnn
 GHv4Cuq5oXKWZZ1ETH77EwYk6/pmp/Zl8nV4RWFLl3JAgmsJsDQpprmOipp3RjG4Qt0M
 Ykww==
X-Gm-Message-State: AOJu0Yz007niBzC0gXOB22yUl/M8MtaDOhGT6BFQYHBm5RqzAveGEtUj
 ybRxfk3YAYLFbP2wfyWynWPj4OWzRxnyoZ0nAsw3pFm7tPVKksYr36Jp
X-Gm-Gg: AfdE7cml9s3Iqski1Kq2ruqKFJcaBE0Bf12L0gKM/f3nO5qq2R2jF5729i4wkAmY5Vv
 9XBG9g5EzgdtQX5MgzB1ThDEBjam9JRlWCw3htLeBHgN7mCnBP2ST/uqZr+W5BMNvDBO30A8vw3
 ZnCW+c0brj2Z67Djnp5+nKTIyjNa/IvEelmnXbdoqXDN+y9LO3gP9kWJq4JT0SlUYjExPeLDjCJ
 0rOvamkFuhNYVr7FS8RN6RHsLs08+UhXwzpmNVJHc0JxGVGqGElljm9PQRka5r502zVTm1cVCM4
 l/6fN7O3npolk96/UN30RY0udOlaoMk1PTZO5GKVSvnZcJ6CFQ6npo+RcuLSDjXYBQ6BAIoW82c
 qLv2tA38Exy38f/jg/oMgb5pXgvSw0uLTD9vB/FRiM3DR1ZYj/1kyke8ySgCZHKEpRga7JolDk8
 MKDe9KtGnAdMBMQopWujrs0je8af8luf5T2MXyjJ8lndUK0KikVLJU4X/dF8uiR/ZJl5haK9x7S
 MHFs8PnGEfwXLzUcyKALvbqTSf9xlQ=
X-Received: by 2002:a17:90b:558d:b0:38d:dc13:6f94 with SMTP id
 98e67ed59e1d1-38e4b586170mr3766036a91.37.1784308558498; 
 Fri, 17 Jul 2026 10:15:58 -0700 (PDT)
Received: from
 runnervm3jd5f.cuzdzfniafce3lfcelrvp0oleh.phxx.internal.cloudapp.net
 ([20.169.98.208]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2a48sm6379374c88.2.2026.07.17.10.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 10:15:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Fri, 17 Jul 2026 17:15:57 +0000
Message-ID: <20260717171557.3827-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717160234.1163566-1-pavrampu@linux.ibm.com>
References: <20260717160234.1163566-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

Hi Pavithra,

On Fri, 17 Jul 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> +// SPDX-License-Identifier: LGPL-2.1-or-later

All LTP tests use GPL-2.0-or-later. LGPL-2.1-or-later is wrong here.
Every other test in this directory (hugemmap32.c, hugemmap34.c, ...) uses
GPL-2.0-or-later, as does the required test structure template.

> +	if (mount("none", quota_mnt, "hugetlbfs", 0, mount_opts) == -1) {
> +		if (errno == ENODEV)
> +			tst_brk(TCONF, "hugetlbfs not supported");
> +		tst_brk(TBROK | TERRNO, "mount() failed");
> +	}
> +	quota_mounted = 1;

The ENODEV branch is unreachable: the test already sets .needs_hugetlbfs = 1,
so the framework validates and mounts hugetlbfs at MNTPOINT before setup()
runs. Since MNTPOINT is successfully mounted, ENODEV cannot occur on the
quota mount. Use SAFE_MOUNT() instead:

    SAFE_MOUNT("none", quota_mnt, "hugetlbfs", 0, mount_opts);

> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +};

Both the commit message and the doc comment describe this test as checking
for regressions in hugetlbfs quota accounting. Regression tests must include
a .tags entry in struct tst_test.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
