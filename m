Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2113CD4F5B
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779201920; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=X2oN+z34n2qCQXvrv2hyK7jMaRqObBd50U+izD1QPq4=;
 b=CBRr1apN5rEcp1BxAsnrOf/8NTz0Ewvu3qgau2guJAjpuXzKiQ/uAVf+285MM2bAP20SD
 1ZZGXrJCbSYBlft78wXUJ4OSrrI0MRMJM1kgDpA6+1zj0nlXTji1BlvzOVluAXS1Z+6G0a4
 d6D8GITwMdAjW5xBprXy4iBxW9lvLrU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C5BC3C6FF5
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 16:45:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 135A53C6FEB
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:44:55 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7927310004A6
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:44:55 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so54826355e9.2
 for <ltp@lists.linux.it>; Tue, 19 May 2026 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779201895; x=1779806695; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Xr3fq0JcocwBX2Ppb1A6NJavRnqXsEEt/Tg0BXFKFyg=;
 b=KqTafO4HFfdyrrmiIUVWQ42jFFh8O7RZtOHKsa7cZFKN8mx10OszGBDbYvmyFDaUX0
 aMFi/OowmH2n1pG5Hyg3BzmVGKFKDLdhv6t0f4BjEbOdeJnq6iTbI0fPcs8Gaa6sL9dW
 mg+1yXoLLFM39P8E/czdtsyNm//YQDPrRUtD+morC4NB3X4xd886PXJlhXjv7COa0Vj8
 H8fT93+yB8Gvp3cY6unbIMuFjIHFLXdeMcyAJE4IuECuEAoH+sN+b8l3+o/XGwgtreTS
 LJ9DPnObctFW2FgLyW3ZEw+UKIhylwI0Oo2YfOGt4kWmTcUcfDgcOV8bZnLzmAWEqSq9
 TFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201895; x=1779806695;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr3fq0JcocwBX2Ppb1A6NJavRnqXsEEt/Tg0BXFKFyg=;
 b=QMlUhapInzv/aE7N+hRkFemByH8whiu5SsYI5LfviOslRge8fqB7nmdTnwQ3bQ1AJW
 8skerkxRnWLlMGUKNvQDkDF8LX40Os3hYQcxh55nzMpxn2t7G44qsMsnUWa6J+Jjh7E1
 hcGE0DPFoymEuJ3iJXRKuz2MpaG5CqJC+DcUDJktcSslkt1XW0ezIi437xDt9NFXvVLB
 xaHnk8DKJp2w66M+rYQR0LChq00eurg4Z2iK5Qm9bm6hoLfi1W4Cw2cCN/pu5WFrKTeY
 lozvTpcFPcj8CcARTxRAoLLeduhklSk6U9/NKllj5pJiqqYEplUi6hLrzIc0PGa5CQE8
 Yj1Q==
X-Gm-Message-State: AOJu0Yy4O2b6VG/xar9drKA6h3CsmDOFSOFEsiwBcZGolvLQRk9cTK/u
 8ulcBPCiGwndW9RNTpbsIbaqxmQ24Frp0H4w8cfNZXV3/QzarRjSrp8jarkgOiJWy3MPhBxQGsJ
 n4yJET9E9cw==
X-Gm-Gg: Acq92OEC6Gx2kJkdXCHmSdwgbzZ5NIzZ5w+EsZjIeGx/Viow7/UymK/K50Rfn5aKu65
 VFYgyfZ6x+XFE4hl3PVAlLCY6a/uiDpe+qmMQqWjmUFW23zi1NSOKi9EgaCmvXQ1UfPCwR5bNY3
 WcOwDlXoDmCM373jaG6treByANSnpT4lczrJQN5/7t+se8XxmWyx/fE/PgUhz4Ma31uV20vHxrK
 UrVrLhGSHAGPb4zSrGA8Co4er9mKw6M1YrpQQpyXzr9RpJUhrLIJnIAilHIvGzz6BHL6UsIZtZF
 2E35C/n+CPjQXXt1u+I1bdYSoz4b1LpfGHkTa0FDIkXUVaAW3rH6PPfgEE8BwKnovmX5wmbjsS5
 EOkgsVb3GIAkdma6ZYVOHinxa8aRlw4ObDey7NMRkxLwYVKAiS6VUnxQtUtp94EcSRcQ7OrKeo8
 faYMEhSyofX7hNklTO256Xo182zEBizASjyHTwEp9SNk5WbfVo1l4MaQUsPVqrsA==
X-Received: by 2002:a05:600c:3487:b0:48e:7f22:d90 with SMTP id
 5b1f17b1804b1-49017d45a80mr109329935e9.4.1779201894556; 
 Tue, 19 May 2026 07:44:54 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767cb9sm44390222f8f.2.2026.05.19.07.44.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:44:54 -0700 (PDT)
Message-ID: <6a0c7766.10c0728e.160297.c17e@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260507111809.28934-2-mmenashe@redhat.com>
Date: Tue, 19 May 2026 14:44:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] futex_wait06: Add EFAULT error coverage
 test
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

> +	SAFE_MUNMAP(bad, getpagesize());
> +
> +	testcases[0] = (struct testcase){
> +		.desc = "uaddr points to unmapped memory",
> +		.uaddr = bad,
> +		.timeout = NULL,
> +	};
> +	testcases[1] = (struct testcase){
> +		.desc = "timeout points to unmapped memory",
> +		.uaddr = &futex,
> +		.timeout = bad,
> +	};

This is not the standard approach. Test cases should be defined at
compile-time with a `uaddr` double pointer pointing to `&bad`.

static struct testcase {
  const char *desc;
  futex_t **uaddr;
  void *timeout;
} testcases[] = {
  {
		.desc = "uaddr points to unmapped memory",
  	.uaddr = &bad,
  	.timeout = NULL,
  },

 ..
};

And in the `setup()` we will only need to initialize `bad` memory
pointer.

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
