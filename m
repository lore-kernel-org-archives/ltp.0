Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F14EFF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:42:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EC7E3E4923
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:42:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E08373E1A46
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:41:40 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 885BA600714
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:41:40 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so1451832185a.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777387299; x=1777992099; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7RzkY1Zv30PEa2WknaLkTyq2OL1lc41K3rnz7lct6M=;
 b=Uqf2CZZ2JiY/Yw7VeTXv+6iNW4iX8Ubvz3YCRXWGFdJg/Tb8y+ZWVRt/SxbpuTv8uW
 ifgkam3IBw9swMshF1O4EXfcx5M8N+IFygzMW3Zyh2KJzGr6IbSZqp6ue3g/RAiK0x4Z
 DtucxjZUU7o23xw5eSuxUwGccjHq82DfHriGYtNu2KphZUOeLXkYH655L4ADtdLilaxD
 8EIdU5Us/oxIxVWIKoxIJCBYETeLvA7gNT3JoeVGalIByfSbgvkt0yZT2krjmekJahvr
 B7K2cEaSUn1E+3JO9vE9YnVJT0HrgCkpjJ8mAZhhxgyklbBZCodeer3locXK2aes30jf
 fjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387299; x=1777992099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G7RzkY1Zv30PEa2WknaLkTyq2OL1lc41K3rnz7lct6M=;
 b=AhxzC/l//361/jzxT6dff1T+8N2VufED+m+etKe2u3j52lG3zuLonalRXpPDjmXcPo
 rvxtnVHXvxUSP2HUe85xSSHkJsMKzHO3t22alYULBDAV3fNt5WOUH+JTQcyhLIM4mld4
 NvVBIno8Uqi2sqgEgrjf5ETw1troUBBB1dPDAD/V3G14ZUP+KIMwQY0ou2ulm3CfJIdc
 mVStBIZ3VxxYIxrC0HCH/h82uPwuCr+VW6sKoVDpYud8lhWwXjxHp+sadh1EF7zqQ2IU
 BwGvbC+ngOYa9IU0TS9/+C8b3vVEqhPL/DVcSEjM31/MfXudcyIp/FHegoXjORwm5EmL
 ccng==
X-Gm-Message-State: AOJu0YzjBWHSNAI4uHa94aCyleGCDBHd4RL2u6daREGwXoaOyfRaB0xb
 x6GWSTOGjN5LVrj1Tu+tkpb8VK8X+sCY7z/3NlTHboUGErEIYikY17f6
X-Gm-Gg: AeBDievnkatLP4bm/kWO5WCNRjdajOF14mVxRQVZE0zNqVMHE/6xdGDjzICkTpMIfel
 eVN0ulMRZVEMJfR+farjdMFDE/dRXobJKrvBH4vL5ZcZ0ryVHVt/Yu3ZPTvQR3hHgNDZgS59U5O
 BhVAtVo3PX6NjGSTBTOhvDPkdTfO3zY+XrsjUNW85TYuzozf9jjsaooME2cmcHmZVYYkl/OXJ4Y
 aBBo1qmgNhbaRcQsMqC93l6V2yUfTBRytxt9Q9/p8361HQf1DWByW1mkjZiXNkPlgxZ5mi4Cy7C
 8369jKqWmuaWrhAULoG9nT9Hzsj10/WbMaR9rGhsLzgTuYQBajYM2SYxmNIDqTCZqF9sTGzHsBZ
 rilji32G/1K5qA6eC+MjrPt5r8wmNX3NZS3rgVge17maz9V4dNAzTRJbrWHnRKD5/9I09DOusYW
 jRN4LyZvUP22D/z4UGHPNkhWCm2ltA6vcmWUsbeWZuPyD3GHNbzplSb0zSs5K4LQDBE3n28Uelb
 i14oohjwXtyimJJbOhosUTPlEDuTsL4ArYcihAyJWA5MpyWgAc=
X-Received: by 2002:a05:620a:170c:b0:8f1:7ce7:5aff with SMTP id
 af79cd13be357-8f7ccfa6b37mr370830185a.1.1777387299202; 
 Tue, 28 Apr 2026 07:41:39 -0700 (PDT)
Received: from
 runnervmeorf1.net0ibprzlqujb4ppu2xd1znfd.ex.internal.cloudapp.net
 ([64.236.177.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c48c71fesm248077585a.5.2026.04.28.07.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:41:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue, 28 Apr 2026 14:41:37 +0000
Message-ID: <20260428144138.4068-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428124629.259405-2-piotr.kubaj@intel.com>
References: <20260428124629.259405-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

Hi Piotr,

On Tue, 28 Apr 2026, Piotr Kubaj wrote:
> thermal: add new test group

> +# Copyright (c) 2025, Intel Corporation. All rights reserved.

Year should be 2026 (new file).

[...]

> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> [...]
> +			if (ptr == endptr)
> +				tst_brk(TBROK, "CPU %d: interrupt not found", i);
> +
> +			if (errno == ERANGE)
> +				tst_brk(TBROK, "CPU %d: interrupt out of range", i);

Both tst_brk() calls fire before SAFE_FCLOSE(fp). Close fp before calling
tst_brk() to avoid leaking the file descriptor.

[...]

> +		sleep(sleep_time--);

Sleep-based synchronization is not allowed (G2). Replace with a polling
loop using short yields or TST_RETRY_FUNC.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25059182102

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
