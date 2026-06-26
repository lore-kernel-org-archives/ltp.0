Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA567CD4F26
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 09:33:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E7A93CF91F
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 11:33:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5EB43C5BAD
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:33:06 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F416460092B
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:33:05 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-51a84669e39so2342801cf.3
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782466385; x=1783071185; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIVxwc5xrBgsTZG2syCkyfXC8XqZ/RM7H8jMt5eAMqQ=;
 b=g6gdb5NuJlUKiO/imVhkHNIKVKC7WlkH32n/rx/+ES6046+quoJiLg64VOJeeTzucH
 PRgZnHY4H76w0us5ArpgBl0+ckhWksB71WLg+p3tA060O5vXuQrZn/FYnm7GgtdfYjgG
 WKYloro4ncIPA44YITZhHaTKAcxn8x7VTT9BLv69Pi5EmU0X477yajPFF7KYpimM6P1Y
 b7zfop9LnhdWrNsfzfmhy+/0qQtDHAQlYEFrJLksgBv+kL8K1ZT2PIaT10PcB+sEnyWj
 mL2K3JhhBu+P87cwqADdcRt64MHSKWRVn2skC/4Te94hbsuayDw5/uf9+wY/lt8lkUkv
 tG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782466385; x=1783071185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gIVxwc5xrBgsTZG2syCkyfXC8XqZ/RM7H8jMt5eAMqQ=;
 b=k9ZtY3R6UW0KNsuvsWwABOnRRDXAI41dwE+VOosXCXBx1P9MjHL2ZZ5P/FLdv02xCN
 oGfxg6lvyrQuEatV/hpaqQqlfDq2xgYRMBDiXxfewQEg0bfO4hmwtHf54YP8HXDBSF/J
 5654x3dgJZjWEc9n5deYKCeUrCEncDIt/uun39z3Wh9h7PUf2atjb8SWhwImwnPqy+TV
 Tj6zB8+3+MBxR3YojZaSfPiDVh8LDDg/0Dworm1WapmQjaSHy8mvwIvwJzILcq0VLR84
 tydy/DVpVdqx9+TH7TaiSMHUqG5BM49lLTEIpZWT4BamEkTY5leeK+JGMRjB9OL2Ahd9
 gb/Q==
X-Gm-Message-State: AOJu0YzS9Bs256lQeGUWKDv3rXZvwx8+v1SF0+LED6mZL1RWmUgOxLxW
 1cGNDLUC3xpv7quJWeLulZKjxMWAKMiLkF48t4AQFMgDfhD4HRHD0IRIk4+uDNsF
X-Gm-Gg: AfdE7cnBRdYtIYPPVRnEbhEcoPmc6tWQVvnhPgShu5mQUfCDR54v0fgDI8ytFMUQW65
 a7yOUcXj+eRDZ9iDevKipOSNYccJCz6NOEM4MOqaGGZIptHPhYSewD+c721H/p6KoaVmm5TYGud
 uvOG4nUNJAP6dgzfl1ruyPO1kis2AYICON6nV3+xCuuwVNy/EOolKdJQiMdin2kWh7SDeQCac0v
 LuMX4qOusPx7h4zp1B3VzQw+tOPkKXzsE8j28j5yBLhQVem2JmGj0+IumNtNConMfTO42ybPI7v
 OLZ7+rfh6QigttrRgXaeB2YUHxFWDykR7CbMo9MDewYv7LdG520jgGuNeBVBgwYI7YhVfcgRCZO
 xykW75gVv4GXX+X7NuUTh9esDm+lH/i7RVqIrdsLBspeM63kz+v4T6Izzj++tP/zYH+drBWGa5r
 wiBmNxxbs8DCmGqfralXwnT+9FBPBDU7HfDQ//qUnZfb6PJHjRU/b+ajDuqRSePQETb6qC5IMYh
 1llgFolMAUqFRsJNt0vmhRKyMJiEw==
X-Received: by 2002:a05:622a:230d:b0:517:75d8:b960 with SMTP id
 d75a77b69052e-51a72a77c93mr81780541cf.43.1782466384744; 
 Fri, 26 Jun 2026 02:33:04 -0700 (PDT)
Received: from
 runnervmmklqx.ye2brnatrrxexmvihiyqbnv03a.bx.internal.cloudapp.net
 ([57.151.123.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51ae79e9sm92890401cf.25.2026.06.26.02.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 02:33:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 26 Jun 2026 09:33:03 +0000
Message-ID: <20260626093303.4067-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626061436.15253-1-wegao@suse.com>
References: <20260626061436.15253-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Fri, 26 Jun 2026, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

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
