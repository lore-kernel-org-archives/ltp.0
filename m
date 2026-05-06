Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC459CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778078884; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LAGQM3bZK9Wm6WC61UpoGiHWQFFYil2QWxNXj3W8jtI=;
 b=Oma3x58bgX9gUFw3Oh0d46LV5EtuJEmXcRmyEcMPCNo7osJcfYXVhYR8sHxZl4m/PfJfU
 6qyt2kC6/Do1ajKjWyfc834ZGL8YEA96NdwUnIABP72dg3YBmLKy7ZMcClC4gf0EBsUqjBk
 Lf/DAOYfO4Bq59SQ2Ic1uiaiG9kLRQA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D93C3E6A91
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:48:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13C1B3CC6A7
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:47:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D97401400C68
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:47:38 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so82202305e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778078858; x=1778683658; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RQ/ylbXZc8W0oHJlQkOkaLkxV0LYbYh0izpcUAIMgMY=;
 b=KSor4joNQRVU36vPW73P8DmhhUnqeyji/6lQ0xpvejOv4F9GitzQDfvfBiTiYduqm7
 L0DbjG6Sx1sQsxUfb7Zjg9ReZNE/DwBFVatodKM1gpjaJiiIwiyB9IxSq7dpoBup0q3j
 erU43nRLt5WM0ZOOQt34KED/n6gD1kD+/Uq3JQiELQ4IVrIteGVJPF8mgPsYunGxAZqN
 0F8DQt+NLJEoAQ0lL6EjW1jn/DKdTuVMdtG+RJuKl67WxrFuX+i3ZOTQVAmduJLJgWen
 aAd858pQ7p0rjmpguHMEhOSgjK2gvRhNnIsiWrVktWUXxttNnTvbzHqDavR7BEQoYDwS
 u7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078858; x=1778683658;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQ/ylbXZc8W0oHJlQkOkaLkxV0LYbYh0izpcUAIMgMY=;
 b=KPqsc/0LPAHGeHvrmDdfy3k9r/5rhGivecBD6Cd35wk4NtZOk7JxcHNVtRxNBhRDwy
 XIXoLrC0uPpKOQc1rfZK/FeZfySbmIlrBqZjgzFMqPc2k+RRd1ZKtokWH5E4ONCOMu44
 1xWU58sLX1Ctl7rb8LAwbLfrJVjRJnaF/qzIxQeTJQ6b0PToJppjF5DVcgMYQ+s2HaUT
 h5ofIv8ohoquIFTM35Hp3+G8DmtkbNOigpQhsffYEtuGVlKBtvqIAIn7FAsK6zR3H2Gw
 qCaRU5r+6FemdSKPZ+OD+T68WjGfz3+7NcabQv7U4me91xiZJbr5GL9VIk0jzZZ9Ov7j
 gZBQ==
X-Gm-Message-State: AOJu0YypkrERsoMNNCU04EE+2N0B3m8i8pmZSpxAWu1C3dotDcqvyDQ+
 OJbq3mu+feFdlRKwbTuHBA5usQfyY1syHS++zCAEsJszf1dF1uW5mEG6GAcdUF0TbyU=
X-Gm-Gg: AeBDiesUV6heKT/Br9r742j/4rb6IIn7TgKFCe75/GUVA59uP7OZ8M1hhLYWTSPWtOr
 MKtS7Pi54647nhmQH7l4O6oalK0XquwZXlirvqnbO2VG5m7PYiFlb2SIiY3XpfKhq1kECiGXz9L
 IQtBi0XQFTEbfTXcUsVMK5UCnd44gPteXzOSy9k0rFX9+SCIV4k8CqVBVn/y8fyzEvpabapJfq2
 zgD3izalNHGTxfluagsOa4zChUkHRNgf+r8LwHILxPie2Fz3mdmLHUD1kVi+n4ymLRaLWyRLz+J
 YY3XyuM8LGv8HAT4UXcUyEVFfUi8Ud+JCVGoXJoxhbYFbGHTfQUAEVH8S25tZ3MOBWi7ZdvcKLi
 PkaNxGWQbI81/lEjnNjSHEx0e//4DQRE5nWy2RjFSsdSBdVTU8XnZTm623+WFviMyM/Zqgzf+aE
 XZdaEdTthkGRLtTkFZGgrGXrgd4sTNXq0c1sQsVKtpBhxq4/g5K+abfS/j03qm9gR8NhjPlArOu
 r06/zgMJtSyZpdhluE6KgBFul8mkGfIbeDkEC5M0n6GjQ==
X-Received: by 2002:a05:600c:a305:b0:48d:364:6c54 with SMTP id
 5b1f17b1804b1-48e51f4144amr46904055e9.23.1778078858177; 
 Wed, 06 May 2026 07:47:38 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm13135107f8f.17.2026.05.06.07.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:47:37 -0700 (PDT)
Message-ID: <69fb5489.5d0a0220.d655e.18b1@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260503085544.16915-2-always.starving0@gmail.com>
Date: Wed, 06 May 2026 14:47:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] getpid: Link manpage and fix minor issues
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

>  	child_pid = SAFE_MMAP(NULL, sizeof(pid_t), PROT_READ | PROT_WRITE,
> -                              MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> +			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);

Also here, please don't change other lines but the ones related to the
commit message.

Regars,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
