Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DE9CCA472
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759735629; h=date :
 message-id : to : mime-version : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sX1N8/eUthXxgDt7j9DlsSuSGlzZUcTTVWe7JRfKYSs=;
 b=l7b+my2irO63c9gz6s/iBDx+fX4pDqoFD0w7bxdViGM7w4aqHLp74ljvK/XCWjdWa6eWI
 YGTagjexb/gMNBs6XPsr7wMb9iAFB4d5Ay24g5Z5aoLqVBQnLpoK0UVYB8Labg2lLw0Dbla
 nmQPb5/+VcHHF4oN9yolp1sWhGfRIMA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A05C83CDE64
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 09:27:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE36B3CDD3B
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 09:26:37 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61E77C0FF54
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 09:26:37 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso3437354f8f.0
 for <ltp@lists.linux.it>; Mon, 06 Oct 2025 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759735597; x=1760340397; darn=lists.linux.it;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to
 :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
 :reply-to; bh=yTR0CyiAIr67VQqq00olrSMeF2cnaGO7A1U+4VJPX1o=;
 b=O0gSv3BWL3ZCBjUm2BdOsrF7r6W46y0S1rJFgZPstB8yci1Lb7ydR2IYytieXEgEHI
 srl9tO2KHFQKfYSyETZXP5FUE5HVLL2VKmnM1I2yWFKBd7IrZDrhkNxDnpL4ilnexLLi
 x/AI4pAttM2tR9T6sGl0ZNN/UDvFLvv+hmak6UmmaxhBS3LSEM9LNVkYqD2qk4BeWkZw
 AXHMoWe8RvzOhuu+tKlm+JfpsfgY29GGdQzRGgxnO0TPAHDWCPYU1ORH+kq0vNYqYH3n
 3Hr/Ojzhf/ffPtQdNmRJeSLPMB/TOheWV52nTkNGYCpC/aF4GqIblGJJrtt8zpvHPiwM
 ZVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759735597; x=1760340397;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to
 :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTR0CyiAIr67VQqq00olrSMeF2cnaGO7A1U+4VJPX1o=;
 b=YKfqHuXfqmHv/KlsxQRv2Fz00MMAg1xmfkNPrfW+rMzs4ua1oG/cW0XvTbIUCYzH/j
 IXh4OxEU/L7bvbzESyAGXWapAaSaGSTNyMWiPLCjc232dsCeNyvzNVw1rGu5b8jXKxzz
 g2QYoANMqec3qkNqQD93P80Nh5CTVVdFFS6FR6feCwHt8QXA36t3AX+v9mNliAAcD0CB
 8YQK2BKrZc4O61BLbr/PfrSJ8oIpOHqHpIW+I5Cu0jA/Ly6KQclFCGthlvT0ge21isxo
 t2omByJwHnu38TL4vQ5m4o3uPH6mvFHoIy/2wR5KtqxlzkYk3C9CgxJcYW7TWhEfZc9V
 /DJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV927xLn+e/QJxBTWpc0Qr6vMNORaFI72ogEKYZvjRp/0v4ZYZPpzbPBtQkH0Cfi2nnFMw=@lists.linux.it
X-Gm-Message-State: AOJu0Yw6xZwUGJYtQrMHQGqAEX3uJipb3t7wAmnHJ3AqDmOvKuGTuvU0
 228UxxTH28ZWfFU8R2KaQfiB86Alp0XSFh/q002PRja0+rZbs0/qO9MdPLWDU7Lt9MQZ9zVbtvy
 pBhbJMn0=
X-Gm-Gg: ASbGncuYQNegzkF9NlYP+TytzhxlFpl7+i4AvQXH7m05vQuAXL827CvPcbdZkmYdHQF
 kl+l1IvPnJL5K4HprAUNMq6HMRU8lcksMCYv4gRBNAf0QMXJsi1Y7JocCtdxSqC1Zluvvi9Shnu
 O7g5cbVrgLFVhQX/gXlbuLRU5HP6tPcQ3SnovtEG4gtFS5aWUctBaHjJVmOKk8dZ+uy26UgA8RJ
 AB3HByYgiSgT48J1+HLTD6+ZC6C93h/hXbFqznKtzxUAqoKg/WEABJhtMobZ4fv72GxswceKqMP
 f7VLYdZLN6JkYu73mMWtVJnQMdSXVYhIvNksGpUdHNzl17hJeQSaZJAMw08Gl7N7FR94EorJDmG
 R5sBS/2KljUg9kOoZ0zieNqV9wevukHf0tq4a/wEMyeCFK7xBl+IlTb9WbF/a4yykWH4=
X-Google-Smtp-Source: AGHT+IFHEH19rfceHAnCRXrpoJGYzTt6CqW8DJ1a31IQ8jWN2W99GfnTaJf8FmBZ6mOHdQ4uPZ3N7w==
X-Received: by 2002:a05:6000:2010:b0:3eb:5245:7c1f with SMTP id
 ffacd0b85a97d-4256713ac87mr6945703f8f.2.1759735596677; 
 Mon, 06 Oct 2025 00:26:36 -0700 (PDT)
Received: from localhost ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53b8absm108152536d6.22.2025.10.06.00.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 00:26:36 -0700 (PDT)
Date: Mon, 06 Oct 2025 09:26:33 +0200
Message-Id: <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
In-Reply-To: <20251002083701.315334-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Thu Oct 2, 2025 at 10:36 AM CEST, Petr Vorel wrote:
> This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
> (disabled by default in mainline, therefore disabled for some distros,
> e.g. openSUSE Tumbleweed), if SUT reboots.
>
> The downside is creating user account 4x instead just once.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/ima                                   |  5 +-
>  .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
>  2 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/runtest/ima b/runtest/ima
> index 01942eefa3..c8d0c6801e 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -6,5 +6,8 @@ ima_violations ima_violations.sh
>  ima_keys ima_keys.sh
>  ima_kexec ima_kexec.sh
>  ima_selinux ima_selinux.sh
> -ima_conditionals ima_conditionals.sh
> +ima_conditionals_uid ima_conditionals.sh -r uid
> +ima_conditionals_fowner ima_conditionals.sh -r fowner
> +ima_conditionals_gid ima_conditionals.sh -r gid
> +ima_conditionals_fgroup ima_conditionals.sh -r fgroup

Why not using multiple test cases inside the test?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
