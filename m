Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7242DC61DE2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 09:13:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EB533E9480
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 11:13:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A42AF3DFDB3
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:12:46 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 297F31400B7F
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:12:46 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-398e03cc38aso428248a91.0
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788167564; x=1788772364; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dzh3NU+jR1xny/RSqKLnPVyvIjx79VIAF+llPb327YI=;
 b=f2yFzWgAGei8XD8JMt1FcY85mPnfz4PQ1X3F5SRwD/UYKw4cjFb7SN/30nnhZpK97b
 /UAlaArPcec35mGL59jf+OqtOZHpe1Ejn1DJJoKHzXfMn/BLQJWC/HyNXc0BoLcv3oHo
 RMvdiPfchYoXMTaCNj8POlip+R0+LhY+NRChH3Z1Svj2vRtOmqN0FLEue8jDUPrme80e
 k509PoXLuQ0n9q4F70CDrpeDKVGmYHHMi5RHFt/OjE0BN78JGW1uBU9dbjYq/DnBEtAu
 /16jjngP0VUjN6qcBmoCWtFCliV/v1lDZa1w+Lmpx/ejDkFxFZrFaMxnATHb4fqQoEvh
 6CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788167564; x=1788772364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dzh3NU+jR1xny/RSqKLnPVyvIjx79VIAF+llPb327YI=;
 b=isY5th9b0x5tpC1bnaLERUwjMlW5+4KYqwkBefPELINI/PXQlueEV5KhYZem1YHbiD
 L5+vqJsB6A928quVZEiBT1X8I+ComVbE1NDe36Eqm1q6kxRfkkAq/lVCXhtDy+xMt4uw
 NE6eEoUWnmYFiJvMSlNu+HhBzspkTHQX5M5kr35Xsoob9Tvojof/vWT5nYQldBWAH4WJ
 txDo+HE5eSJjMW8qECxFdFMwuj5/O3urRH2RuOPcnJnete6297O6Sy8pie/Jh8d0IvMh
 CGuNVw8sJSpJHHNYKMX/3c2asnOeXKXP0gvm7eHf0cgSJ7BvWz4WdYcTEpegRnznej3w
 uoTQ==
X-Gm-Message-State: AFuF++kUZ33PoXanq5DA6zh7SXAuN1wWIz2UM1djET0n+VEMc+PiX0TB
 uGfA0aNcgd411eBiwiAeUBZQ3AOKIO6entFVXdRS5R7fcfCRcDH5ReMcfW/OGdbJ
X-Gm-Gg: AYBFou2zRiEk+Ioz0XgJYfYoiFC8k+sBKGPs8VyJABY4+eSgvO9+XHqtvTw3mTL4fX7
 LkNL8+MWA9Epf8jE3YPJ2f0rACO9aMVyeRzlJPLYNYT2i+eo814poNta9wX98XGikUnTnmIwpSp
 vuMtVtlvG6/O+sh5wgrR6WDuJEyz+36txyiq7/Ou2UJrfWD1tJXIF4meiu9SYV8pbppk+eTm2Yf
 UIi8RaRh54rw9mZBAGFEV95JetN4pPt80Ch7tADngzqSqyrbHkESCbGGg2iOR5Ua2/OpkU6yGTE
 pBGavdawMc+v9zvEHfnYXbuZO2xKgiZ+mQWVF71Bt/i9Kz3tpvPkVziZ5K8EHFebA8Eq65GEOF5
 Ztve7WO/0sjRuEG8GOwSxVJpmNGHryy+jKzjJRkqGpmKC8VB5mWMmkOnmpZOL4lZSvy3mCk40D6
 gbKhlt13MZZL7kI6YLDXIYVyHE2uP7mxmbhAXv3juW20xrFNVpb2unn2hQWyGw4ASps28eVJlXK
 pvgy2sbcJCthz1gyZQ13aMQp7/2jIkqaqwLyaVL1tBKc7ShGSrY7TOm9IwgP8U4gP3+omsTttI=
X-Received: by 2002:a17:90b:3ec7:b0:38e:250b:122f with SMTP id
 98e67ed59e1d1-396d1041324mr31756559a91.16.1788167564212; 
 Mon, 31 Aug 2026 02:12:44 -0700 (PDT)
Received: from
 runnervmgx7h7.ldcbmbo2laxuhg0cuwrmeuiwuf.xx.internal.cloudapp.net
 ([4.155.111.2]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea80a2sm20704404a91.3.2026.08.31.02.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 02:12:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Mon, 31 Aug 2026 09:12:42 +0000
Message-ID: <20260831091243.25657-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831041909.312922-1-pavrampu@linux.ibm.com>
References: <20260831041909.312922-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Aug 31, 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> 	for (b = a; b < a + size; b += hpage_size)
> 		*b = 1;
>
> 	tst_res(TINFO, "Testing unused quota cleanup for untouched mappings");
> 	run_quota_test(verify_quota_ok, hpage_size, MAP_PRIVATE);
> 	verify_quota_stat(1, 1, 1);

verify_quota_ok() faults and instantiates every page, so this does not test
cleanup of an untouched mapping. Use a map/unmap helper that does not access
the mapping before checking the quota counters.

> 	TESTPTR(mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0));
> 	c = TST_RET_PTR;
> 	if (c == MAP_FAILED) {
> 		if (TST_ERR == ENOMEM) {
> 			tst_res(TPASS | TERRNO, "COW mmap failed as expected due to quota");

No copy-on-write fault occurs because the second mapping is never accessed.
This retests private mmap reservation accounting; exercise a private write
that requires COW, or remove the COW claim.

> static void run_test(void)
> {
> 	tst_res(TINFO, "Testing unused quota cleanup for untouched mappings");
> 	run_quota_test(verify_quota_ok, hpage_size, MAP_PRIVATE);
> 	...
> 	run_quota_test(verify_quota_ok, hpage_size, MAP_PRIVATE);
> }
>
> static struct tst_test test = {
> 	...
> 	.test_all = run_test,

These multiple cases are manually dispatched through .test_all. Represent
them with a tcase array and use .test with .tcnt.

> +/hugetlb/hugemmap/hugemmap33

Test binaries must be ignored by a .gitignore in their own directory. Move
this entry to testcases/kernel/mem/hugetlb/hugemmap/.gitignore.

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
