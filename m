Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FB3C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:24:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEDB93E6942
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 17:24:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD5443E5CEB
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:24:22 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2523E140042E
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:24:22 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51c0184f082so1891691cf.0
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524261; x=1784129061; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vXgG9c7n4KPdOgBmybBYY7rQWmPFbvhg8weHZkr/t2I=;
 b=ZbCbk+erPNKBy4Bath9RTnzFMfJnFDL8LuGY++fvlQBLhIAnP6TKkpprhR9cNDNyHo
 Yxztlb3tv9BnqoHWo73WBr+sx132JQsYsjthDynopT+BxtH3wZPL2bnBjTnetyOM4IXx
 em/10L7N/YcygyT23kcICy1Fe8GxUtJ4piH82F1D6EsCiet0kU124OYWonBX6zfTHRgv
 kL1+KZRHziZw3eUemNnWueu5uR6pUwJ6sOc/uxHo64H917I1u5faSaX5cyIjkU3gL/Nj
 Pyo3NCFGCwXnU0pZV1LnvWo0OokFykkGOU4AVlyqN+42YyWIJGaBXQBkafi8KC3GWZSM
 Nkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524261; x=1784129061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vXgG9c7n4KPdOgBmybBYY7rQWmPFbvhg8weHZkr/t2I=;
 b=Aq9jEgPsTc1WCfpCPVPfZEXe5AxpMl0esuAj0BWsLNWP/Zbrp0/1jqMGaMXfVEaHBy
 vR5GRuPJ1l5uci51sdVqa4S4OtgnA0D5iQmjOA1DLE69bZDTvZe3jIRQIOQ4Rke+TCdj
 /Fw37RtLcF7BIxC2wLZrKugRa3lfeVEgH9IAWvSU2AAflPPMVMk1OKS8CicsQSWTCPaW
 Py4HOlfBw8LHThdwtQ5RNjqIiSWh4T+stJWVeLalQ5ziFvqLFgfQJCC/V7C4tSDTFMku
 ZmcYPohP0bTa0wqgSpVJ1JiVzH/fEAty+9AEdNvH7GR/haoHkAyqofr3gg8peLbnPOtm
 io6g==
X-Gm-Message-State: AOJu0YzFBNijPvfYtMXhXrAjngEfd5zY4Ub5MNHCubNleR0equL1nHzj
 A2TARWuP65R/5uWQ6lQtOopjSCUBuBhl+qZMklLXdPgw4/Lvv9tiDpuC
X-Gm-Gg: AfdE7ckG+Dg0xZf5uB+QvNW+QST0D1qBaKTfBg/q1v2luOmL7CC0bs74Vz79yzizdvh
 /f2rFkQW8PdFroYfyoOc8phFPcuE0yupa5Z6zLFqvVisjJWg3O9Q8Idv33aTHgxd2eBcpKEvdRg
 g1IJC1J3p5yYThKouTrwoUz8BA86s4+mmcZT8colUCJRIaeYpjDUvWBLOcVHvfoS9aNC/5Pv06b
 XuA2UPcnztQZlMzBDYJ/ZrQioK/svPm68/WZgZqKVCsmf7UJrlEMtHOeLZRnLbaBYB7aJp8AD3T
 MxBHFIZ3a6K8PvX2dEPiXSGngCdVqpQb1uNILuCi/sMepyCH4f68ahOyEasHps8jNqCvp3Wgc3h
 IEdCikHqHLytHJP8Glj6sXR31vJNAVmx5nk54QFqzMFfMpG8aljz3HehIc16liZp0J4Z9D/dHBk
 D2MSJlxXv94Wd79ApQQGMMdt2a5yFg01w2D0nd0u8r9qAOF8Q731FAqQI1z8/fpw1fpxqUisca9
 380T2gaGtLUvmHdt4wY7uTZ/6SRARg=
X-Received: by 2002:ac8:5f0a:0:b0:51a:8c9c:7f52 with SMTP id
 d75a77b69052e-51c8b40a675mr29397661cf.69.1783524260786; 
 Wed, 08 Jul 2026 08:24:20 -0700 (PDT)
Received: from
 runnervmkkn4f.oo4emtzcarderlaieotjrbaaac.bx.internal.cloudapp.net
 ([172.190.118.182]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d78101sm135175261cf.20.2026.07.08.08.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:24:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Date: Wed,  8 Jul 2026 15:24:19 +0000
Message-ID: <20260708152419.3877-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708144223.833263-1-vasileios.almpanis@virtuozzo.com>
References: <20260708144223.833263-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] commands/df01.sh: Drop redundant fuseblk pattern
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

Hi Vasileios,

On Wed, Jul 08, 2026 at 14:42:10 +0000, Vasileios Almpanis wrote:
> commands/df01.sh: Drop redundant fuseblk pattern

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
