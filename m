Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB034CD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 13:43:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54F023E6E83
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 15:43:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 905773C22A5
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:43:03 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48314600723
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:43:03 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-91574384cc2so775437885a.2
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781098982; x=1781703782; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejIjodB3CRCoNUKaMVG/fCalO0bF7zerxZvFvZz7FW4=;
 b=HsY2HiWiGT+b385eFMgyzw7x8AiDxRLlxx91piVQY6dTU0er9uBYg9DCgvzWHQl1/1
 t6DndaxtBCT5u61PEFFcaB5/rh5FOKfXJ2oyFJoJVgxQK5jqWnPhTMRirfjP/mJNeWCp
 3UJJw3x+9O7NCpg3CW768ZOd+pUFwXM/MSMFGLg0aXIvlpoMyUktwhwMYaXK+xo3Aekr
 ITVkJK7ZKSHK13Gk60urmBorodUVi5UG/PZeS2oei2wIbE8phNcLweTYyorIknwzYNzB
 vyaY8/7oJ69+6YaFdDDijHtwfrGyNkq/YiXSP/duKz+jxuJqiPAHH0lPYeP1Nys68WKb
 dM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098982; x=1781703782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejIjodB3CRCoNUKaMVG/fCalO0bF7zerxZvFvZz7FW4=;
 b=L8dVlq2UhLMSIze4BSa3saI0Rkrxc04eQPiRj9Niyfn5fGkHpm1ePDCxwBMe1PcnSW
 VYdRBG8cxTkhD3SFjxjQiuuF+uNQu86UpfZfce0ijM9caBTT25WmQX29JpENKDFDApTb
 RAqvnu2YpKdqpfv7kA/bTNNal+4Lsl1VYAKFA6Uch6N30QyWrHN6/ovfjPx1TWifqzIE
 ckDO+qR3neFyyfMF8KAf9yXYgRrVWip0c6bMJ0nIcDBJTVGQaKFpJFW0QNXWi8CFU5TI
 aNVlOtVxELfmiR6napMEXCNEJhFop47TcfMa+V9diRn5bn6k4rsyXCLG5EzTFXYlA1Dy
 B85g==
X-Gm-Message-State: AOJu0Yy2u5L3wNaOsFDTwmI/4ys+GstZP7uPK+hB40CvNMNlvQFGOae3
 KlX9g2xevDyPDwAau/vf0kSXKKPkLmoSjGAvDROfkrfjbfQ8dTMQIbYZW3w30Qnn190=
X-Gm-Gg: Acq92OF1JNk4dukvW2SUTR6K38Rc9JXLjt7S9n4LRs0sozJileyqGh92G/OySlwbAYf
 oq6AYx3zihQdl+kZZMdeFv5i5MEXc1RiGDe575Xb3PzkcSc2MPjIH9voaG1z7xJU8VE1KvZdcmw
 57RjL1scqO3D9IsPOKYYd4aKIA9qKuNu2gewA2FMcg4VVwkwpvQOh9mW/W2QEkcKGiKjcQgNY6B
 cLTVSWwHZTOHcnbOKbFuZPV/irm3LPqbsQYKdtqdoEIJyEpZhxU2GutB1V1vU60FAtbbF39aiLt
 F7D4A0fUSt5rDAOno8uDkFFQj8l4laBFNKgl4l4cLDnbVJzUG33U50YkWNmxK9PCeno5F+GQQeg
 vQmT+KodrySQZbwC4sNaPJP3qsayV8NWD5Tj8/FPp7U8GFUnH73KgkGN3slaao0UQLYwonylr1Q
 5TltwvzDmCR9RA7w/rt36/ZonlXc4aQ5nYcBtXcitZQpThzJPywwY/dQq2DKn0Zq5xKCP/Rlaaa
 hUBMVjwFv6DN3v7zvCQgF/IpnUhlYqJETDv7LCq2NU6D5ASsdTS
X-Received: by 2002:a05:620a:4714:b0:8cd:b2e9:b964 with SMTP id
 af79cd13be357-915e822a004mr1162822885a.10.1781098981949; 
 Wed, 10 Jun 2026 06:43:01 -0700 (PDT)
Received: from
 runnervm3jyl0.5qj4ms43gybe3fet3unmniotwf.bx.internal.cloudapp.net
 ([172.203.254.216]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm2419831685a.22.2026.06.10.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:43:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed, 10 Jun 2026 13:43:00 +0000
Message-ID: <20260610134300.4057-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610133048.115931-2-piotr.kubaj@intel.com>
References: <20260610133048.115931-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test for testing
 acpi_cppc/highest_perf
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

On Wed, Jun 10, 2026 at 03:30:49PM +0200, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test for testing acpi_cppc/highest_perf

> +//	.needs_cpu_vendor = "GenuineIntel",

This field does not exist in the LTP framework. Is this leftover from
an earlier prototype? Commented-out code should not be committed.

If the intent is to restrict to Intel, the existing CPUID HWP check
in setup() already serves that purpose since HWP is Intel-specific.

> +static void run(void)
> +{
> +	bool status = true;

> +		bool match = msr_highest_perf == sysfs_highest_perf;
> +
> +		if (!match) {
> +			tst_res(TINFO, "cpu%d: sysfs=%llu MSR=%llu",
> +				i, sysfs_highest_perf, msr_highest_perf);
> +			status = false;
> +		}
> +
> +		tst_res(TINFO, "cpu%d: %s", i, match ? "OK" : "MISMATCH");
> +	}
> +
> +	if (status)
> +		tst_res(TPASS, "Sysfs and MSR values are equal");
> +	else
> +		tst_res(TFAIL, "Highest performance values differ between sysfs and MSR");

Results should be reported directly where the outcome is determined,
not accumulated in a flag and reported at the end. Per-CPU mismatches
are logged as TINFO, meaning they won't appear as test failures in
result summaries.

Could this report TFAIL directly for each mismatched CPU and TPASS
once at the end if all matched? Something like:

    if (msr_highest_perf != sysfs_highest_perf) {
            tst_res(TFAIL, "cpu%d: sysfs=%llu MSR=%llu",
                    i, sysfs_highest_perf, msr_highest_perf);
            status = false;
    }

    ...

    if (status)
            tst_res(TPASS, "...");

That way each failing CPU is a proper TFAIL, and the redundant
second TINFO on line 99 can be dropped as well.

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
