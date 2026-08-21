Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51448C5DF8C
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 20:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E08F3DAE58
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 22:26:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C46623C5DED
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 22:26:16 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38CC9200AC4
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 22:26:16 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-9075bf047daso3198776d6.0
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787343975; x=1787948775; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkgf/KlTxDeMsC2M+veBlPGL8P8UecNQ7PvJKwgYjGs=;
 b=BtUbAa6uXA4YnhyunSa/+4mxQgUF7pJUqJQN8fX6xmJtfg2mVsT0WnsG53fzraGKhr
 ApynGxyDuJAiXXPmcTNNNmNH9d8pLpe1q1PbpvRoaFoa/9EGOl0Xyc/pybdMiMZn1FV1
 HmVIe7t8NrHzQqyjKmhm2HydMenBW0JCwC6NfIIpYt2RY4O8Mts2ZYNL391JiPgTtvr8
 d76I7iGbHr4pGq3yv7W4EYjlcVAsIMQ2eptI7Zt34oUYg8GjA/Od0M64P/3Nu9nwpgJh
 ObZLe+7vTsDOwDwVSCq03nLFLDgZ2jww6qAcskmMRF2CKjrM1YeHF8lpCvIhI1rkBm3H
 WMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787343975; x=1787948775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vkgf/KlTxDeMsC2M+veBlPGL8P8UecNQ7PvJKwgYjGs=;
 b=hDl8nRr+0gIS3+8r3Pcp1losgI481+CRkZUAgaysufRbQSUk4R0nrrejiSsHAk5aw/
 2OOG2dNqdZKI9la43/LtE6+ZnAN9P7ioXxmTerNaXr0FvCYR7Q1V+i1L0oJSh1aduziG
 MChG4g53N+ElhkBZkjlRxOmQtTWrBLiA6caB0TP3FTrA+eMIt9tARp0htbnBEGwngPsd
 dulBnQdJJKk2GDXKqVfn8pqiunDAkma7tdFGOXiMPZtXhHq6s9y7ImaH4ZPvCbhbSrd0
 hPno6UpBc8LR/4I/6CjBFKtaRd1hBwmRe7xiEcO0k/MWza1yM5muU+QMRog/StUCWUZq
 qTnw==
X-Gm-Message-State: AFuF++kbfmqZcXhUtbtDoGpr+bxaSxHjvZ8LmobJs6py9678qPdLPFMP
 5brr9EQsBPdqD/XIIjVnS3bMxhjDAyoQ+BBMRpPlFvwbH1NCuSXuqmfJ
X-Gm-Gg: AR+sD13rGvLQVd2+3hBK7DoD/wV04FMt0CRopcP0cUmaJ/KlwovhR5TDcficbwEG+tn
 wtMVGRxNb60niwwr1TuqujlMk2LzPF+GXUXDodgy60y66PqwuB/fYo9sgHVlOFLhm5mOJoeWTN6
 IbACtu5GA9cgylNgxcB4z8goUmrqOeffmKp4ntoLQwKrpbqyiI1uAUtD2VP+ZatMKgl7YeN5xJf
 trb18RSw29GiNcjo4opjaOnii1QpuDeJ43xG7UsPo0ANkcMPjD+IaFnjIBplaKvpWifSg8WJgex
 XSmEVt8lkaj1yhGutraenVoBMx0mnyrgM35tZ2t91LHb7Dio3YopWUBVV/7Ju2XpPdzp0p2Ehwg
 3RaTkkAm/t2OL4AMkPm2vCSz9eXZAJA5n7Is8s/4/5kE2sAQRd8wvQGx0WFnB5SS+1TqTtkLDqC
 nGnHBbP/ip/wfsrA5NjC62TtkeO1qiZ23zyKoKCHlxAijMhImWsme3fjmDBsZ+1gocKxxX2cANw
 VRm3ivApkv0LPFCnDmEs7SDxtQt359aNyfhqjZiYA8fT1yRbV5vykak82Ebvnboex4HXJZG3Rk=
X-Received: by 2002:a05:6214:27cc:b0:8ef:aad6:dada with SMTP id
 6a1803df08f44-90c8fa36197mr10752086d6.20.1787343974919; 
 Fri, 21 Aug 2026 13:26:14 -0700 (PDT)
Received: from
 runnervm76f27.gsykcavn2kru5dskkxkxudirqc.bx.internal.cloudapp.net
 ([4.236.173.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5edb45besm70874456d6.2.2026.08.21.13.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:26:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 21 Aug 2026 20:26:13 +0000
Message-ID: <20260821202613.4033-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821200620.902699-1-zohar@linux.ibm.com>
References: <20260821200620.902699-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE
 is configured
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

Hi Mimi,

On August 21, 2026, Mimi Zohar wrote:
> ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE is configured

> +		if ! tst_check_kconfigs "CONFIG_IMA_DISABLE_HTABLE=y"; then
> +			tst_res TPASS "Duplicate \"selinux-state\" record missing (CONFIG_IMA_DISABLE_HTABLE not set)"

Could this path report TCONF instead? Without duplicate records, test2 cannot
compare the current enforcing state with a fresh measurement and returns
before checking the remaining state fields. TPASS turns this untested
configuration into a successful test result.

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
