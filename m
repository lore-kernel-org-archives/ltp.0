Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5B9FF886F
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 06:35:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11F8A3E2106
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:35:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B50DF3E2CFE
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:35:12 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 340A8140033C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:35:12 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so863029c88.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777530910; x=1778135710; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwQyJO50C0oXmA4DMVirP4fFlMiZ+p20Gx96/k+F4Hw=;
 b=FLksZh7Rg8S2dAFUOV+BOQaJ7ol1/4PpB/MKisW+LKYmfzcBE67jJRoQskwNdyeuZg
 SyQQxDNKe6uU1uxDgKven6CLBNW0+6cFFfRG9CwEPJymSMQVtpuWElckNjXrg9VvKZVl
 obJY4jlkiZ4erIyEfqN+ehCrbuGXxBOpm2BReN3IIZi6Xw4rD+v/+IL//vvLekdeLywY
 QN+lCdG1tf8ejHMeU5JJaF6rhbLjY95SBLmHZUS8Xz5nkIDc4G36rNuBxf8EcsV6+uVg
 Ya1xQ+W9lpauxSm7VmlWPOjCHtiVI0DGd/P1UD7H2q95InjA8TeuCQM7eKJ17u4OiFua
 lpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777530910; x=1778135710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LwQyJO50C0oXmA4DMVirP4fFlMiZ+p20Gx96/k+F4Hw=;
 b=WjWbi634+hiOUu0LGwJuSiyZkTwt/qrsxZATwGjg3bDsav9gU+4VaG7NlwNXGnliA8
 AsO6jxmcHLQzgr17SiBV1TdnTTMMjhqOtiff9AvgiMGVzqNQo9OPM9HzlETeF0HKCjAH
 3hAqkChOkzSVniJhdu2u0tCUC0xIY+mDFDlq4cYf8kFgk5cEmkmxGYT56gU/8rdygifp
 ny+OJ7ZzcnU5Ypf8xJU8SIqXX1a7qzE55uvfqJUNHPw/Kpu25kUYU7uWq783deLbWe1E
 HaZS4t0c4HXJOe69ZTeQiq1zIz0qp5LutdxXMMBtt2ve3YvKNy7YLt4moBw014x+tNhq
 FeKA==
X-Gm-Message-State: AOJu0YwxcwgH7ITzAOB7b/iXtyzaeFx4TPhvX+fdZEsIgJmvQUGO7Q9w
 /hBLZ1L+9tWp0ejfv8ZqvmVgf6Og7Mz5QrOQagP8liJua1KzhY+aZaw4
X-Gm-Gg: AeBDieulGFUON7HL4DlsV/UOHqzbMXIen/VzGUWhSXbNDFxpL1W6giaJ+yJ1PcRAWdy
 6OT58eBG81QBCd/0p0BOMe36QTWX5qrw4TlWWUox/DCh15o7v6a0CZyXKFrcaUBjpYrgQ6quewr
 I30BYBiYliMci/KTyLH/cTOY6d7xnFOEW2BePj6sKhMVnJjntq6LqdhMJ2ug5bkBpNN5RrBAwAJ
 pbUaO4qG+86kFOw01M/qKmfixFlYA1CSio7AT3vqOkQP1rYveIcK9uyTROcp/oCbkYbkOH5rG4/
 jIMDmiwY/ORBix0oiw4WXvCxBcbUYomX6ocTa7H7RSNrNj2hHr5XUHCYF2U2vsd75/VhEHq07tV
 FqhJyKPPbiwG7om8Ys8VObvjLF9P1bb/rMHxY+DVK9xTiJv8cL8LvsFtJtusVTbGTIK2MJpl06u
 nFO/TSx+VAfay0kUPK0gXZ+HzyZo86Ebs5cx/k+BDx1OPSRXIBMUKqJWraJIFHa6TnGq6Se3pLD
 0S0enmUtBU1QEf1XDpG2d/bsl+LljYy+8sE+StA2jH6rvy+nVM=
X-Received: by 2002:a05:701b:280d:b0:12d:ed19:e69f with SMTP id
 a92af1059eb24-12ded19e77bmr233893c88.22.1777530910411; 
 Wed, 29 Apr 2026 23:35:10 -0700 (PDT)
Received: from
 runnervmeorf1.g5u13dfph0depip0q4sluubs0f.dx.internal.cloudapp.net
 ([52.159.226.242]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de321f1cesm8132687c88.8.2026.04.29.23.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 23:35:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: priyama2 <priyama2@linux.ibm.com>
Date: Thu, 30 Apr 2026 06:35:08 +0000
Message-ID: <20260430063508.4014-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501151420.1042995-1-priyama2@linux.ibm.com>
References: <20260501151420.1042995-1-priyama2@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/kernel/device-drivers/nvme: Add NVMe device
 discovery test
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

Hi priyama2,

On Fri, 1 May 2026 15:14:20 +0000, priyama2 wrote:
> +++ b/testcases/kernel/device-drivers/nvme/Makefile
> +# Copyright (c) 2024 IBM Corporation

This file is new and added in 2026; the copyright year must match the
year of creation. Change 2024 -> 2026.

[...]

> +static int nvme_device_found;
> +static char nvme_dev_name[256];

[...]

> +static void run(unsigned int n)
> +{
> +	/* Reset state for each iteration */
> +	nvme_device_found = 0;
> +	memset(nvme_dev_name, 0, sizeof(nvme_dev_name));
> +
> +	switch (n) {
> +	case 0:
> +		test_detect_nvme_controllers();
> +		break;
> +	case 1:
> +		test_enumerate_namespaces();

With .tcnt = 4, each run(n) is a separate call, so the reset at the top
zeroes out nvme_device_found before cases 1-3 can use the value set by
case 0. On a machine with NVMe hardware, cases 1-3 always TCONF. Move
the device discovery into setup() so the state persists across all run()
invocations.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25150858409

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
