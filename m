Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8B606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oqr0PEXR
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 774623E4A2C
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 08:33:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D2D13C13F5
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 08:33:21 +0100 (CET)
Received: from mail-qk2-x0a.google.com (mail-qk2-x0a.google.com
 [IPv6:2607:f8b0:4864:34::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1E4F1A007F0
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 08:33:20 +0100 (CET)
Received: by mail-qk2-x0a.google.com with SMTP id
 af79cd13be357-93e67431372so277596585a.1
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793086399; x=1793691199; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rcn+OwSMlBmRT2f+7ElaNUdwhpwN0JM/ba5E3XhD8fc=;
 b=oqr0PEXR0Gajl2UWFLgDHByQrTTIYN4/ey65ZUTiFD2VRWe2Mcy2JIsEaa9dLDmzo7
 iVgolHVcXM53gDa7qhqiDE1NHPkvf6sYl3aluCJWnsiPjnZ0keBqSZuPOMqVNs9rEXc2
 3jlmS+sAzD9m5j5qd7xsIp1yCs6cjbToKjn7BqvjwOAo+359+nSZ6rsi98lTKhm0qBze
 LioPkJ0zIhBDmSr8nBqqUtR4UcfNGuK7FCkCdczepmm2Mh2fy7yBq6oZNC290mD2TpF2
 QkU4u9mq+zSoxCnIZ3kjHYxYf7HgTsEbAVlfOP6KUyGmISL4u+GrVteXeuOGxwZ87DJu
 cS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793086399; x=1793691199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rcn+OwSMlBmRT2f+7ElaNUdwhpwN0JM/ba5E3XhD8fc=;
 b=gS5vyxDD+eBnibEuO3HaLlP49mXjzKv4llyWIbygFjL2rTt5bjXlXnC8eR0CBLJlUH
 6lj3DXy/7Q71unK30bNTXbieoEryC9qQpOr9cb008mEqRRGJ8triOTJZXSzF7sERQLT5
 VrqwnPekcBO/RYeSdYUHH4Ei8nksBD1lwZQmh2mDuesK1f039vGsmBwktwLouQggHEJs
 8x1aasRB9vOZdsJ8wgY0UNkt5eJ9kmoSP25vIj9gf1OHnhi0y6R0w1pqY7eyboWhq8s1
 uxzGSKE0SnUtj2lxJo0c8N0igYv/aar+npRdme5eOMuRXrX5bGIsYgIXEDNPyxAVpAIN
 5f/A==
X-Gm-Message-State: AFq9FYKErzFf2Dm3X23HKKzvZ8hTiMFaWrTRuKCUYH43hWGDKKEjeqlJ
 nzYzC01JMGaomQerwid3dzm0ySLFDPpJQyBnowFMhfne201XtWe7W1iCgmZuQYQt
X-Gm-Gg: AYBFou2gpT2ZMpiTPLkuQW8apTt49M1g4gjAwL/oJECW+JJ2ysCMz7C5VGAMbAYODU3
 de+/bSZqufghJKHgPLuqVWLD4TvQVepUAsf7BTiGNwKBxN7xe72rrePz02BSflERtnveWdQwNXT
 qNo63gKuK/rZzbJt+Rhq20JKqghj9UJbB3rk0YCUMC69Ddk6F7eUWd4t3WMxmCmwKYMK8FskMix
 YeetlK9nfO/xhTc909+H2PWLtCOdV4lTLISPP6xZcoGxBZ3TZUD3hTfqEiP7FYsvL2jeHQjXJpW
 szrKc9+xhqq8COW3QCIG1e9nkBQwnxzshLa5JG7WvcKWtnpcr+fo3O/3NILbp9nlFx48TXNSAoE
 xavMitXmBsDcp7Dlvol2kpnZJTVv+JqPNE+2YOwQBjlewyTawQc8g5vIA2wtyNdetLLlr2K+FvI
 ocsIkJRMHhXQG26GPY0LIrN0DfWf/Ctps7RilcdgWwvCvXTD6QPFJStWsEmgvMpBOLEWkCghrLP
 qno6MdSmT4NyZW1QtlGIUGLbDzXJV6fORs8Zky27Wc9Wteux6U1xXlwsiX43M2c9/tS8UQrOuy6
 pseihEVZiKnmKaCGCBZ+DIS9XGFrBycmwxPXtCo8n2z7SfxnbPxW3dmnb47WMM9LkJSR3y0=
X-Received: by 2002:a05:620a:40d5:b0:93e:fd69:9a93 with SMTP id
 af79cd13be357-940ef8d837emr1459297485a.31.1793086399582; 
 Tue, 27 Oct 2026 00:33:19 -0700 (PDT)
Received: from
 runnervmtai0g.zm1gstafu1aubcwruotojqkf4h.bx.internal.cloudapp.net
 ([74.235.134.166]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f05af648sm907177985a.1.2026.10.27.00.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 00:33:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Tue, 27 Oct 2026 07:33:18 +0000
Message-ID: <20261027073318.4440-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027-statx-atomic-write-v10-1-c12b6bc271c4@suse.com>
References: <20261027-statx-atomic-write-v10-1-c12b6bc271c4@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/statx13: Add test for STATX_WRITE_ATOMIC on
 regular file
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gaurav,

On Tue, Oct 27, 2026 at 12:36:25PM +0530, Gaurav Pathak wrote:
> syscalls/statx13: Add test for STATX_WRITE_ATOMIC on regular file

> +static int file_fd = -1;
> +static int mount_flag;
> +static char *data_buff = NULL;
> +static struct ltp_statx *buff;

Initializing a static pointer to NULL triggers a checkpatch.pl error
("ERROR: do not initialise statics to NULL"). Remove the "= NULL"
initializer, or make data_buff and file_fd local to setup() since they
are only used to create TESTFILE.

> +static void verify_statx(void)
> +{
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff->buff),
> +			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buf)", TESTFILE);
> +
> +	if (!TST_PASS)
> +		return;
> +
> +	/* Check if the kernel populated the atomic limit struct members */
> +	if (!(buff->data.stx_mask & STATX_WRITE_ATOMIC))
> +		tst_brk(TCONF, "Kernel may be too old to report atomic limits: STATX_WRITE_ATOMIC missing from stx_mask");

TST_EXP_PASS() records a TPASS before the TCONF checks on stx_mask and
stx_attributes, which causes do_exit() to suppress the TCONF exit status
when atomic writes are unsupported on both XFS (v6.13-v6.15 without
hardware support) and ext4. Use TST_EXP_PASS_SILENT() here (as in
statx10.c and statx11.c) so TPASS is only recorded when the atomic write
fields are supported and verified.

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
