Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F174CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781185767; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KYqcNmJKDvw0bh+BAhVXJl4iIdb7UeBj7TOCgG9gqtY=;
 b=jh2iZpqMwKmafCCxgimrGO2VBlZQeVV3tNqRCNruxlrOpUpXx4RwqWSuZmQf4571f9Qj2
 24THHryU5BH6tSbxT2XcAIQCH6PcL3NCwLm+x0XlezXFYo92cX1Rh8+qAW2p6JrIr70M9es
 f8CDNvl8qTctDUWpEcKQZH7RtCwQqcE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 697FE3C72B5
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:49:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F2B63C0FCC
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:49:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC69460074D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:49:07 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso57854175e9.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781185747; x=1781790547; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sccggBy284MhxXHGhV5VzgMTLi1Sw6s4Dp9o9tLa4eA=;
 b=GHzZp3S+gXx7TmXBBSOVKs105HW2/AZ7XlEj+RtpZER26UvRGcIx6s76zAsvNyeisq
 qVC/8jQfPI4nTp6oL79QnUR+GO7TsqDSDKgVfAWHkXcG9sWPpWnylq+E8MRnW1YObTib
 abba3hGsh8Bhs5GymCaz4gXQyyd+wkPyVodwqGAGyNyRJ93SHfwjvhukE2Gi5ryPzD0p
 hfSjbHyNOc6XOS+BoNdgND6zvExiRD7B1bvxFFxxZoNJ0hfwwLIVakCzfddRONd8fqus
 pGcNPWx2u9GIwAbJZSDdILl2/CgBX6RwlrFecmLGlTGo8uZHA8KOmbtrQ4+RCN2frXoG
 wgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185747; x=1781790547;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sccggBy284MhxXHGhV5VzgMTLi1Sw6s4Dp9o9tLa4eA=;
 b=mqCKmDlAZtlIiFSjuxYIKP7vdwlVG/WJm+sC3POsyoPD/l67kOA/9QggV/S32uWI6l
 bRw1IiMlXKu6pC8nFEsfPkW/1/8vcF0oIAYyx0+hyqVa1YO9APIUvc8RrN6clBbpRpfm
 VAa6KD1Dm6fFOFLWDeeP/9sWbagd7XLADe36mtJsaRw2TeUKV/ItQ8Tzs3RlWG+nH8P8
 dAChW4yxJw6XudDIPV4FLmLXo7JwD+HqRsoxrQqcfkImk2SRZKUBhrFvMLRxVm0C22jN
 XpHL/0nTbET6JBPMrJABe2nTk0bRsp6xSYs2kCEcgSz7G1e+LF49Jzl84uo2sZ4FwizU
 0DBg==
X-Gm-Message-State: AOJu0YxbV3j7p2EpTTq6sj9yOHZu/N+CZG5xwyqeYTa/e9bPbnH+O1ne
 zMpj/w4xnpciFvahe4OHMU8RptME9zdonMzi0KuM7hFM0KkL9F4fmDnbur5KfvoFUb6bsQnfzmj
 h8c+hE3OHQQ==
X-Gm-Gg: Acq92OE3whu7nEsLVA/amPGK56nWYRF7jMN5omTur9UgEb+Hwimf+stQVsIGnLuWPYR
 ikxzh0R/bY9dwOVVZ8dcRWq3gUx6LJwQV2zAFVNAMG9osX+gEyrbHbSyY+VwE0ybDCeqPSvsm3u
 U9QOcutdHPsV1jZLGA8kWlPpQ7yImfejCEbUVm6VDi1H6355FcxjpHDywLtijMwtZgWk5qrJ6rO
 Mv6SGH9jrFG+bJl43qz0AsMkO4usTV9p+QEWQqL4TUowcxvU7mpm864amBUKgkY2wFoSJ5LmPey
 xErm4v5FQAHpoDrKXERfaXVk31LaTgunUxsoMcdxsJUBB8+tPwxk1XcYqaZTrAfDA7zbQ5Rzo34
 UpsK2wukhaMT/TOtAJirrWOZ+6L0qsI64bJuAezDlDaMnJer11lUvTaLZmcWdneYDqxecRXKeMV
 H8fkYH71Ri0aRvI5j9+TNNpYpCgduPAWG2Y0QFfFF4AxEjbTjDrru+cMhLJ924iLPuzJl/ogm3C
 RdNsPE+sQ8AEVztT6373A==
X-Received: by 2002:a05:600c:c171:b0:490:b3e7:4614 with SMTP id
 5b1f17b1804b1-490e561f010mr40343275e9.25.1781185746941; 
 Thu, 11 Jun 2026 06:49:06 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5314dedsm59811085e9.9.2026.06.11.06.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:49:06 -0700 (PDT)
Message-ID: <6a2abcd2.5e46ca1c.2b1c04.eb86@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
Date: Thu, 11 Jun 2026 13:49:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] xfrm: Skip on EOPNOTSUPP in compat mode
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Added the suggested @Martin message.

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
