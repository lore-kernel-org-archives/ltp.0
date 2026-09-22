Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98273C982FE
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 14:28:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352743E6CEE
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:28:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51B393E65D1
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:28:20 +0200 (CEST)
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD72E200ACA
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:28:19 +0200 (CEST)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b3759b7ff0so1983214b6e.1
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790087298; x=1790692098; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qp5Sy2L/mYPm3BslQKxGszrmtkjvUFD1MJxeQv6VQTE=;
 b=MmdkUSUlG3L41j6wnmPv36wTW0A9ZNiPlx+VCWLMMKphJkhm8VAFBXtA5pw/xQd7/B
 YRdwvzGnefst32RVNCtuP9FuZfw7j+ftlDUQE+JnKu6T14qNQo/8FnaP/RRI/N11LSn5
 oS1Yh640K65gWWbeR8FeziJ9KyBJPZMHPsnVTyLLxpExP/te/hYZFHdm3Sr5oXiSNUAR
 b1PMq1mSIfLNFd1mh3oH7Vm1QXCvFkxzFvnjtNJ3xg8EZZqKrPVg0/8hq2aDTOyFeImZ
 QTwrscA5ykKSG7jc99Hek1lq+4NMYejcTu1BofbyGOJg46MmeEyK7tVg0IjZmqA9q8wo
 N9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790087298; x=1790692098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qp5Sy2L/mYPm3BslQKxGszrmtkjvUFD1MJxeQv6VQTE=;
 b=Ey5qIavgSuLlfVDdQ7CsNcbKtUIiMtsMwU76SNKFVXtlRn1SmMZAuxFWixdeZwPBQl
 EZvRcYzUh0ezwzgpo9Mtu9fx2MZGrsqJaiTdHUvYEVQ4sjQ1EtgALemEejln2tO9PApp
 uIKS+cD2hgH6mv/H3ZkjdyvgiOnD9N8v+apfACUCfqxwfV8kwJy4P/mgNoFuAas7jKpg
 KT9OFKQdbjnWmbIPtvldBuP9jZ+r51NtSJ29bfyN8y1nrePzlbD06NDfJG0x1XWdEbt+
 z504FkNd4wahs1Ycv4h8c9rlvJHl++tJdMufJH4/OP7BG5ZpQw4dY52YSemvIIQIRwK1
 F/qQ==
X-Gm-Message-State: AFuF++no86jwERpgELNZIaeFYnc2jPPe8Tk8j+rLMZclmRvWF4COXb+5
 WP8FkKv5d3XL4zDB4AnpdLQ9JJZ3zcd08f4samagjXgHewt89mIXlWqV
X-Gm-Gg: AYBFou1pI5Eq69RySaEW6/K/Z9Y3suwcJsDRWBYZ+rRAECdFO5di6VoQZwIldCGf4l7
 uEJotvMB74HiwgTETyUeM29cPFpVRvQZsK89P5O9KcLM9hjcZ6Oh8qH+H8nKPk0YLnklSHZCJ2u
 gX+CbalRJeglHAXyqKik4HRwfGmFl97BQw1etMxBssCEBMXpQFynI4GGji96FZj54NxrifC2nWB
 KW9z67D6Ie5Mg+oh7Ds8W7P7+HUT98KAUHKkaG/CEYRsyISyPEPDmCGHr5H9H/Rwl48D3qDr9pF
 KxvDf9Lnm3eOoklQ1qz6FGI4OJDTcRHBxMqjmiUfcgfsR/g4kOd1OSuytn6Q+iUGNiWRhKL+hGe
 1RczqLj2cmz0tw07DSmtq5RKnScV+ZrMSxFBDSsWCR5100W64QGPXjRo59HPjVFHNtJuQbmY0af
 SrLg3XCfwjiI7HV7lHYjMjZfkXhic0yNiKiOz5hr5e9rdZ5fgnMWMSs62Gb7aVdThUqO6VaYxmV
 KZwLWJslSOGdgKxwtno5t8P1Nd+7LezK2//s4kZ14BjxOCLZ3qx8fZ8MP3GaKFsMS++huwmhV1J
 vTJ8IJch8N6b
X-Received: by 2002:a05:6808:509f:b0:4ab:2c58:4514 with SMTP id
 5614622812f47-4d45fdc4f60mr2952442b6e.0.1790087298185; 
 Tue, 22 Sep 2026 07:28:18 -0700 (PDT)
Received: from
 runnervmtr4k5.evme1urblkse1bxsqfphtjfyef.gx.internal.cloudapp.net
 ([52.242.243.199]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d4c1cce6e5sm1537807b6e.17.2026.09.22.07.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:28:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Sep 2026 14:28:16 +0000
Message-ID: <20260922142816.4918-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922122059.4087109-1-chrubis@suse.cz>
References: <20260922122059.4087109-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kconfig: Add CONFIG_* mappings for keyctl tests
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

On Tue Sep 22 14:20:59 2026 +0200, Cyril Hrubis wrote:
> tst_kconfig: Add CONFIG_* mappings for keyctl tests

> @@ -165,6 +165,8 @@ static struct config_module_map {
>  	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
>  	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
>  	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> +	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},

Typo in module name "pcks8_key_parser"; change it to "pkcs8_key_parser".
When CONFIG_PKCS8_PRIVATE_KEY_PARSER=m, tst_check_module_driver() fails
to find the module and marks the kconfig as unset, causing tests like
keyctl30 to be incorrectly skipped with TCONF.

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
