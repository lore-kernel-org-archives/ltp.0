Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE891FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 09:15:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6846E3E52F4
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91E813E210C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:14:42 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E027600943
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:14:42 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50e63771eb0so6123931cf.3
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777540481; x=1778145281; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PphSzoFVTQE3usJCeq2xgklr4aX1CdquLHr7LWOrI/0=;
 b=lPdHGeS9qiPbrWN2XyiSCPXmezn6O+icS+Ucbx0wrANQ8Tvb3AZ9NDqbjvu79vGw4y
 V1f+nXL9ibDkoWxuvNKK4plJfIn+Ujd4g6Ecl+2UCS+RfvW3kEK0oO0jhGqILlREJjD6
 ufDQ7TEHFq2BClhXzeNxcpG5G6q26tfRsNwavcwg2i9XFRpkbeB8Kg//dDP+UtkXsyLJ
 oiS09ECdt4qxtuzg286IT4IgTSGWF+AKsBRHKvADyhDyaBycmnWeQhmn90vdEBNYYBmk
 tZ7kXLQ6scV+s0SswEPHbwYJeBfjgfKLPxSeQvSxAAANi/9t4QrXtSFea6ICOGJFWWKn
 Tamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540481; x=1778145281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PphSzoFVTQE3usJCeq2xgklr4aX1CdquLHr7LWOrI/0=;
 b=qTn6YWazxR7nzyxpdItx88iIjVQ37Yqzl2qznqGHFfgveR9fWK/EBoyueHjlPIVdKM
 xYCP66jrjZMu9FUfZRasOaQRfhtKHdPBBN59IKUKjGEWpkqCagoGDneWcBNmjad2APAE
 KpDGpYMdI6/+n0LYAZNuUGnkDUK1CmJiBns9B8eIg7Tz9V1qglmWXpqaVlxjckAjmMY/
 l9IsLfPWVWr9Jmia8GNjy3f2eKmVLPVh64MTiLFSEObo75QLX00RQ4jVR3CmPitxCixZ
 6IkMKAR0pdSTtGVApcwVsnh9mdpyooP5pUhqgffqCw9uCe+NEphgOXaAY3A6uDXrtZYz
 8wEg==
X-Gm-Message-State: AOJu0YzxM/RgMRwxNCk+30asAnpxMLiHq2jVwKKdkgR09nbLOZ86jOIB
 wr+nWDEHipbq4My97Hc2vbWeLWlpRQin0aPjbRi5+CtIp1Bx+G3kikAG
X-Gm-Gg: AeBDieuRUI5Zi0qGvalbXpW5VfOmpmhOSueGT6eJDYXELeKDp44U2HTqas26ptY/xy8
 oavIX1Mzd0JH1z4VJLlR4rhQioXc4FOuIQ23e29yyDqwyoxNLeRMuqzHWnn3JtzPHtBxQgyjoDR
 bNvA9i7QYwWV6vBGM8N1LVWE/onzpyWoTxTIvODAenfWc6WslQFC5GlN8Pe4x9Hos/v1RFMrLdz
 8QXlaOaSz0w9dKegSVdjAN+Uha3OC3dFJLZhqhYSsWwn+NzaSWOcOXIoVlm+oQzUTedtx1e9iFY
 f6raOb0nP0VtzIFgkVHkcclNBznhOi0K3yzSl+8k437cWFXTcNIC4SeYwB/rq2+VLNz5+gUpuxV
 Kv39kvR9QV7+K4WAtqJ5yhrLYTiFPDiXlC5WiUTxbHV9UN5SoYCnGQBPQCDPuZ5G99Ye2ZIqwe8
 8iXd2koW5eAnWT6UEXFQo383BQsyvvsOM3Iz5Z3nYr0AB6lpvMwAQir+xrHzAjmNPqNDS6Lv9OG
 dP3Jz4S15o6XvXKGLHaXD36XBFAuqweWTqmAxk7TJipztePfw==
X-Received: by 2002:a05:622a:1354:b0:509:34b8:a373 with SMTP id
 d75a77b69052e-5102add7261mr26454121cf.32.1777540480859; 
 Thu, 30 Apr 2026 02:14:40 -0700 (PDT)
Received: from
 runnervmeorf1.jxsy3roshjiupjxqdac0o4tdme.ex.internal.cloudapp.net
 ([130.131.15.90]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101ae8771asm38815711cf.23.2026.04.30.02.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:14:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Thu, 30 Apr 2026 09:14:39 +0000
Message-ID: <20260430091439.4017-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430063326.53566-1-avinesh.kumar@suse.com>
References: <20260430063326.53566-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/fsmount02: fix invalid-flags test failure on
 Linux 7.1+
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

Hi Avinesh,

On Thu, 30 Apr 2026 08:33:23 +0200, Avinesh Kumar wrote:
> syscalls/fsmount02: fix invalid-flags test failure on Linux 7.1+

> -       {"invalid-flags", &fd, 0x02, 0, EINVAL},
> +       {"invalid-flags", &fd, 0x80000000, 0, EINVAL},

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
