Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E76F8D743
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:53:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A9D83E4AD7
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:53:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E28523E2928
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:52:56 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B3CCC1000A32
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:52:55 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso9605531eec.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776347574; x=1776952374; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQ3Ql+zzhhwPo9z0WdnZgViC8aomBMjbI3Zpdqw0ZFY=;
 b=H8syu/GqsnMYjyHDKBm10a4NfMjqsmDBv5lNvhBfIQaZvDcVjGApNa/RbaGRn597RY
 0PIdeK4nQN3eIq4MNWGGjO5JBkQQFoJAxjt4Hk/Ax4mhxrFJzrjsHTIPAnREBcRIeM26
 gRssSiteJp/C1SWxKuGeri2T5dvfBxTCB3m1I0FP4eh6epbEflGHJjz4rTURnsUcF7T+
 gpiq1g1F/uaMd6yTmOl9v33Pu6Yey+wc5LR24Fi4L77HqBRSQRV2WO96xRelDFlglElP
 AWQ6aCd1JCTvpKsBrTRvI9X7BNoQcewvb5EvBuDpwq5bLSvAXGpxbAiUbGTyhw8lSe3f
 w3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347574; x=1776952374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sQ3Ql+zzhhwPo9z0WdnZgViC8aomBMjbI3Zpdqw0ZFY=;
 b=TlpJUPF68m6Km4X/YCcvKJKJFhtMMFcKZGW0kGxuV6taZpEGnnSLyvbNrUveIfRwNA
 oH8mCK2FEBkS82n2cnrV9CXT36M1QBIAla3VuMDeDFxq+JPMVG3pLj8cQ35+7yAFz/Ui
 De08Z2m3BE9WUwxWA/dZeug+Cv76FoTn5gXxAa33WSbeAQr9VpktuKuH5n5R2i+zZ1Al
 VdECK9xqbCfQXO3KZpuytSKC878J1vn9YnVosd2hXLOuAA1F+D4bCJldgjDXou+WItc4
 NqExLSXYmPzknb5VSbvsKfHWtxCshjXT5TxWAVu9PSNn/2U1zr7WyLRfk38E0Ks9wJMg
 pjHA==
X-Gm-Message-State: AOJu0YyVEqolosvKaC4MjThgWo0gYPQklDiIBAgodWAX3Al9R1WdEqPn
 Sb3x6IP29YQFOeVp7HlWNkRUOzFoUSR+nIODBoNQnzbJU/mjC/oB8VKsZdKTkf6uqyk=
X-Gm-Gg: AeBDietqAF3pHfsLfycFQ7H2sXCRRZmc/0h4mweCDuuAy2YaKd0ch5NtxS97YtOga8X
 EIMK9lGVFj4HFZXCkz/77kiMwUe7Q1xDApxo2MwKigA/SWIVg/sUfQmMBPT0q+tbRxexAGMNPQ1
 FbTuBAq1hJiU2nUCgFtmApvPHnSbYbDnBhvrY6uUO/zMHsQ15AxQx4tP2vA63ixaxU121DhYT0g
 HSuMyPQ6EHwlIXcRvgBrXtdGw3+ZjZOePWZAxIV62usFqY79DhyTL9ZgGOVh0LJQZejQN4bcpD7
 yFKJMwykCaKslWHktEeGbH46pzH6Rmj7BGMgrW+BICBxb4+mpA8kjeog+sxuKXT1jL2L1KN8wrI
 V7zsCKE37+6MNtL4J7kQNYLTtXW6DhOLD7NpaiIC3rPiXmJ6LzQKfuCXif+o7cUAe8lUmvvJ9qh
 yTLUD2VddlDjeJJDy7DVRAXf5dif7oXSGNZAslx3q36YBDNlccBAy3i20RZ4vlLJ8dvDHk0lF/Q
 eOOjsVc0tjoMUYMfgeud2Unv00A3ZKoRX8/V60=
X-Received: by 2002:a05:7300:dc06:b0:2d3:f3fc:bb6b with SMTP id
 5a478bee46e88-2d586381157mr16587771eec.1.1776347573886; 
 Thu, 16 Apr 2026 06:52:53 -0700 (PDT)
Received: from
 runnervm35a4x.13zhbfioaj5ujjbwrwpeydmywg.dx.internal.cloudapp.net
 ([20.57.198.225]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c016305sm7742053eec.5.2026.04.16.06.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:52:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 16 Apr 2026 13:52:52 +0000
Message-ID: <20260416135252.3834-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416112611.23057-1-wegao@suse.com>
References: <20260416112611.23057-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

On Thu, 16 Apr 2026, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +#include "old/tso_device.h"

`tst_acquire_loop_device()` is not part of the new API (`tst_device.h`).
Please use `tst_find_free_loopdev()` + `tst_attach_device()` from
`tst_device.h` instead of pulling in a legacy header.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,

The patch has a `Fixes:` link to GitHub issue #1169, making this a
regression test. Add a `.tags` field:

	.tags = (const struct tst_tag[]) {
		{"github", "1169"},
		{}
	},

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
