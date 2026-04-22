Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D55CF9EDCD
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 13:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF6573E53FB
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 15:29:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAFE13E2DC8
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 15:29:21 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 79AD71000479
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 15:29:21 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50faeb8317bso21544731cf.2
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776864560; x=1777469360; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QM9j5mOFwrWhpzSIyQCMJIkyzNFJiSJWe55BHjuBLJI=;
 b=SpWdjYjcznqb84+Hkvtbb4EStsIx8VbQ6nsE8z0ymf/ja9EtdqCclntNXY/+QWiZmQ
 Aoc/0dS4Vc2a8XII16JkJ3usM8pJlPPK2XXPNCRlIHPnpxE9AzH8Q6Zh07zemnJspGMV
 ZK8Hr6ikXSqkzd6Q8zgUu3dVtfgSEPaqoHvI3fi+wYBQOg3+VVu9oEd1Fcbm0I4vNpWp
 zgR2HDnRNboMY2lTNyMGi9sSXLlPRgjXMK9uDdH/EMpb+S13m3SqfBTGewmx3j7bK5Gi
 92VegPjX7vF/F6bwoaD6l/Ltbt8nXVIubxc6Vh/zMSz+nFDCzwLe+Ttq20hZbxzSLiP+
 JvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776864560; x=1777469360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QM9j5mOFwrWhpzSIyQCMJIkyzNFJiSJWe55BHjuBLJI=;
 b=bxlW3v9w7k6cwSosucnwVyG5S/lXgPVLb+vVE/WLsseW1dX2SY0JgWbOxpz62gu5ba
 iVgFoTykNq2iSyngUYBgFWPz3y+XoK/NSXMCa4C3iFg2RezKFJRj6RdkwYGTdFKV+XBu
 AA7TgFxZsdiDWEmdjHs+lSkFjvVkS9mXWlgVTAZj4zDwxgD5d2B3h9iY9bF7XlO9uXG0
 EBPAGyo7o+O3udLNW807bVuaqtRhT+Qu/0LK2MY0N3sZf3z/u8KNJPIj9qifUt558YWr
 EI0kZiyM5G+LwXrTQ8swCNK/9FuYjEc0vFEDtar2gNL+sqzKesaziZBbb7XLfVsF1W0V
 iSQw==
X-Gm-Message-State: AOJu0YzxFGy4AHh33Uo/tFVggiTl1JmF/6O8YkJFYfoxzAl9lZ/z00TX
 S/BMc5vCFZyZ1R7zPIjC07HdD2WhfOfiiqheWMhdqmBtLtspvT7JE5gUt8HaZtPQtv4=
X-Gm-Gg: AeBDiet5RMEx+j632TKec6D7Bv9frjZm4lOMG8p8Q9lfwf8IqDUXVjS9FsSPkWxjC0M
 ULTosxEN+nkwcT2+kaxiqcgFOJZK+HcaRonizwdyJOUNz+zp0rfMSVZXcOx6r8+wTHPy96KHOV3
 yOi1Z2HZR6GzqXLV9d9cHqKPKqMJxgqK2O57uQUQrjgvth6ynqFDanzjlaR3YnLNcG+hwCT6kea
 srOUUl7Og9YWp6xD2gk59KjR0FmmjFAraRwrvwq8D65tKeHjwxidAGGQfoqK3AwzpiJ9EYacYAn
 81Kq79blKUO9UZTLByPlIRgqIgQlLCrgroJGgmPplHCyODY7W74P9Ujdn92Pkcm+3jdmpGFb9Rp
 CZpEpB+f/QUzoxFbfSWSKhc1JeOh47VuLNdsNktJcTqAT1u1DLB1oKU5n74nLtE68owPUwO7sFW
 +5cKuh0CiUZXR2VTBN7s36f4HqJYIw700JE0JQ9PKJ73C8z2uzgBXiYDuDlbSHdU9YbHs9tkyaC
 oq0sbSfee91E7YSiPzfrIAYh9yQOYu/x27sTkjnwf7NIfWo
X-Received: by 2002:a05:622a:5a0a:b0:509:127d:ee06 with SMTP id
 d75a77b69052e-50e36c9140dmr53569551cf.58.1776864560147; 
 Wed, 22 Apr 2026 06:29:20 -0700 (PDT)
Received: from
 runnervmeorf1.ahhkzqflhvruxcz0lwfxlmk5ff.bx.internal.cloudapp.net
 ([20.55.15.102]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394c1fddsm140337981cf.30.2026.04.22.06.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:29:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Apr 2026 13:29:18 +0000
Message-ID: <20260422132918.3932-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422113136.416482-1-pvorel@suse.cz>
References: <20260422113136.416482-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] include: Remove 'make install' support
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Wed, 22 Apr 2026, Petr Vorel wrote:
> include: Remove 'make install' support

> +# Copyright (c) Linux Test Project, 2026

Nit: existing line above uses "(C)" (uppercase); "(c)" here is inconsistent.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: <review_url>

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
