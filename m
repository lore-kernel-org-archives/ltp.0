Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C4C88E50
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 12:03:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75E763C0857
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 14:03:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 044F73C0857
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 14:03:23 +0200 (CEST)
Received: from mail-yx2-x03.google.com (mail-yx2-x03.google.com
 [IPv6:2607:f8b0:4864:41::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8AAFD6001EF
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 14:03:22 +0200 (CEST)
Received: by mail-yx2-x03.google.com with SMTP id
 00721157ae682-865048c34c0so4521737b3.0
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789387401; x=1789992201; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0/dKAcyEDieDQwKRB8y9gAwu94V5VJf1NdXPXSIxZ4=;
 b=c09DHy2IXcnhUW2gXQb1GINe9ewlUaQlVu/27SpFAzzaSFaz6j5BwTBmrpROpOqnSp
 bdHuMwbyXxU6xehTGRUVspHgPfWI8MJ45keA23N4gmhavU9sI4SwM3XBmol8bqEePO3j
 vZWWZfncbfFM8r9aQ6EAA5WiFoDZExFitHw7D3sSH3PwtccPb6qUIZ0OlUGXf+q/dC/9
 9HTGwppO1CoeX5pCW5Etxrlh3ebwPDkRi0aJtWr9+CokzZTROlxIVlEyHAw5NAiSGdYB
 5ARp60r5+jFYA1oJoTiIlExkm4FMcuG9/dI7bjDIXHVcUvFBJQanbckOqX6k2K5q2Oq4
 hGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789387401; x=1789992201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0/dKAcyEDieDQwKRB8y9gAwu94V5VJf1NdXPXSIxZ4=;
 b=JaspKSU8n5D1cRHxv005YXWTR7ZzEZw2wheVaDi97xtWMRKaywewEeTlT9TTUqgKos
 jJSGOr7Q9wUvEmGpfk17ne8V4Knq/8nzETn9aBWquAuvOCEpZW9LDL456PVpDDouP1UR
 SWKCGRFLQQh97E6d1TAQAcc73bl43w0KLcUqIXVDnFS6rrpSHGSSzeieudywKSEYaG0g
 P1VTsT1U58uJPy56nmTNygwKJiJKLZnALITtng7xrEm3Zqz6ZOq4a+ooAbqdSoIM0UUj
 VvvLhm9vZ9YD4nLEHAhXHDQ1js3EbQXvWk02GPU0I+2XCU649+LxQGQ29A3aaN78vtpO
 1Neg==
X-Gm-Message-State: AFuF++naKTYzAqabv4K4e4Y2EHHMiwApQk/vzNFptNsoeEQfgeUABhd7
 2gNRsCIsRvxIuBEDMOEQH9/ulG+YcgwM/f7sacEqFUAqvImtEmqMCrQrquHMdUxXAAU=
X-Gm-Gg: AYBFou0VTpKY9jSg4NYNUQHlgxSsIiUgUFhoxDMfmwuflMDEoUmlsQXL2vDmA0xjWhX
 6wISpE2X/ADzdEnMAAEDZlxXvqnHXxRfSopp7ySUZ/ii6ZvONK1fqCmQBHfTVhxycF80iofotgw
 tCXfZJ/h3g16arQ6YzN6A7nPdX5H8f7FgFO7B3Mmtf1KydTk3LKM7uiZb3RrvjrhJXnlAr9CvKs
 wYzHWfjUjhFkOOpkTtJkH6bRTcV1ljTiEYEy7kECkGpB1F2a4XHIr4nIr48NPp7cuHJcmmV2l/X
 zkuUJWJem4qYHLAuNq/VxT/v0i+9qRNLrzaHuBMDaEB9CRVzLMZUN3SVdtlrWQf2c6CjyRIRd5/
 vl4S8qJ+P02k7haxXfeTYYDy122a90dVAYek86SXDksoiF2utpPjLvVbXEsv2xKjoAlEkQDFsV3
 QJWrWjofl0M1wEiLCg9v0S1q/HORWRxf6Bkfpe4IG3Q1p1mxPfqLeY6Q152i2mAMIkk8sJZLLYb
 5yLHe0iSD06Hs08gCcwx/j75Q6YATyMjPIJN1XTFCJDdLvBK9Uq0NVkhCPT744H7tXMMjJfEStf
 qE9SK/T/zk9P6HseocHE9xM=
X-Received: by 2002:a05:690c:387:b0:87c:349d:b755 with SMTP id
 00721157ae682-88d21834f5cmr5294537b3.39.1789387384836; 
 Mon, 14 Sep 2026 05:03:04 -0700 (PDT)
Received: from
 runnervmlun5p.yxtqycod0cee5c3osj2c14abtb.bx.internal.cloudapp.net
 ([172.172.158.10]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93a09b85dadsm593737885a.34.2026.09.14.05.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 05:03:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Mon, 14 Sep 2026 12:03:03 +0000
Message-ID: <20260914120303.4213-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
References: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Account for memory policy in counter checks
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

Hi Huaisheng,

On Mon Sep 14 11:23:59 2026 +0800, Huaisheng Ye wrote:
> hugemmap10: Account for memory policy in counter checks

> Note that a kernel patch has already been posted for solving Hugetlb
> reservations defect. Without that, hugemmap10 would fail when mapping .
> https://lore.kernel.org/all/20260909074642.7308-1-yehuaisheng@open-hieco.net/

The referenced kernel patch is not merged in mainline or the latest stable
release (7.3). Tests depending on unmerged kernel changes must use the
[STAGING] prefix and reside in runtest/staging rather than modifying
tests in default test suites.

> +static int node_isset(unsigned long node, const unsigned long *nodemask)
> +{
> +	return nodemask[node / ULONG_BITS] & (1UL << (node % ULONG_BITS));
> +}

On 64-bit systems, the return value truncates to a 32-bit int, yielding 0
for any node with (node % 64) >= 32. Return !!(...) instead.

> +		if ((unsigned long)hpages > allowed_free)
> +			shortfall = MAX(shortfall,
> +					(unsigned long)hpages - allowed_free);

allowed_free sums sysfs free_hugepages, which includes pages already
reserved by prior mappings. Comparing hpages against allowed_free without
accounting for reservations on those nodes undercalculates the shortfall
when prior reservations exist.

Verdict - Needs revision

Pre-existing issues:
- In per_iteration_cleanup(), map_fd[nr] > 0 is used to check file descriptor
  validity instead of != -1.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
