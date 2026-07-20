Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4A9C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784558714; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mGFW6vT5EFJXDgZuuOQIqQWH4xtiLye9C9l/c3/Nu5U=;
 b=Gf8ibRBDU2iStQtrg5/p8EDYHfHTOJXuO9q5IedwlRvntCRR9X1znKq/u/6drJH3TTrWv
 7SoXXhttX7FwUsTEgcWciG6Yz6Dzl2Z4DShxJNpiWDXrQrMjP1XJYUYTgxQ5Mi0gSHY0pav
 vnUQVHpIYzIkxZL24LdkMXp2ogIYIMA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 930D73E62B0
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 16:45:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C3653C0571
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:44:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5FAA7600136
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:44:53 +0200 (CEST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D21B93FC01
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784558692;
 bh=kosqE9jYEKjL6tRY/3Hj1JWkBUTtjKjJeNk2GS1Nxuw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=e6i4ZuA3j7+ZyWCPbQwdMPv+teTDs7BCP28cM0BjegpHNJKx9E+pmEXJGccymiu47
 qqozOpA0NzUEIJnbBYSRc8gYQhl/0fHMbrBZrRRjtk6GGG7tOCMCfVSB6I2rySyt3E
 yiY8Xfmx51D6ICPS9IgtP7K3QTCudv0I9L54gVcfgyLbHvFfrr3qk+CFySR02oA/WY
 ltNb8VjAydDzDNBnMvDhn7rFEbY1hwzVpQZmvBgpUtzlZEUpMgGLm7rsVY7kF1d//G
 MkulRG0/3cNaI5WaNQ8fvukPRw4Tn3gHjtzz11hQrR/yrq0WMOHu3e63zJzWzksJrf
 ZsC8B07a1a0QWtzXQ+OJsxemeV+qNYWPSbzhmOJ4oJYEBvmSFOiK+SuA+soR7Ub29P
 POr/VuxZ3w7R7mI064uOh5Rd0C9ILwg4lMBZaxBsjZcAQs2/sL8XmNjeaI+fbC/CLN
 UZrr242hNkii/Bj4JikWHr5Tlrakfi9v0cXzcMpdb8hI1JnnicZoN4wqo8bdnY3gVW
 XIuZofjbQ9ibcttH6lPRlBPMzStNNxwVYhFJXseFWVk4AP1trzsdUOq+1bvXyL6H5a
 eWyfYz12aRhzUbcKDBZldy3fPthytcN3YWv01/cZ7AMgEur5KfbhgS6EGCMr3dUkuv
 n53T+EWu7pwshwQlPYLCDlA8=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-475eba52438so6033864f8f.3
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 07:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784558692; x=1785163492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kosqE9jYEKjL6tRY/3Hj1JWkBUTtjKjJeNk2GS1Nxuw=;
 b=KqxgIjv+rPzrBXVa6te8jF7yU6c1N0lQEfn1iLf6ohX0iwqn1Ee7IT3rmmJPh9+iqc
 ILopYa8kMVIZF+uR7XdpL9WqmN5GgEY0y7p+xR86NI0XKNK+Ttrs2/tA8ejtp6wrc6Jo
 ZcFPgICRmSWHN8PknXawEbgPPyjiOJ/RCf2rlyu9u0lVPN8PJOlmxQH5gMZtSsaRbDlw
 1vmUzpXMXyK1+mDqdpAN62NNmktPapNNWDvWF/xdev2RyoPnfY6DTwaIdH8X1D7G/OTQ
 KdnzwC0ofO1JqyyNytdZEKO4OHyTlT/wIn/zi//nlbNm8lnR4pbwh5UUYmBSoAOikL22
 8aWA==
X-Gm-Message-State: AOJu0YwKeTM2WloNN9u2iaX0eCq5ZjeRfHoun/7qY/5m9ju2d2JrKIj1
 0472BO2cOgFVtrZyIDqQGd7wk6WHqiWX+ecXiYbAw6Y2IT022dR9xZVn2oNC55NUF+eX4Bk5ZKI
 frKylH1xNXsdNbZvVbnofro2vOOgJa4kFtom7DVuIrDu5jaDEju2BWHdV2F2GXjgJfnd2nczydd
 He
X-Gm-Gg: AR+sD10wxN8XWPYrq1Hrf4k9SkNZ79k+ebDlgFD4UD8Ddfhe+DRhM9S4kFrr2+r8Vl8
 JGAiZuOtGLgP2Mp/TPxfIdBTaZ7ouSMj+/Rh7r8AsBZJ1Dbm7lIRkNydpth/H02YxFhtUklnkd5
 BIShWFQfVqEITYetdUsWYugexIyu83uiJeboWtJ5gjOfXFHBrPJYuW49G0rboNrIefO91tHEghZ
 ArpfixIM7WzvisJ9VJXxHWgA8l8MNmSSAJOLvEVaIzSYJWcYWcNiTPmqBmftJux1v8CBJP7w86d
 ALHnQsjMlVI3B3n1NCnwGS9cLB5QreSsi/6mzypCfSUHJm2kcxr+oSq3G+tYB49VgB73olM8g1Z
 pi00j8vnHzxnCeZuyYp7lSQmKOoZoAFMbBckCaw+RoOV2x0RBFnY8OYJqXhA3
X-Received: by 2002:a05:6000:22ca:b0:461:a16c:a5f4 with SMTP id
 ffacd0b85a97d-47f62318b75mr17158578f8f.33.1784558692333; 
 Mon, 20 Jul 2026 07:44:52 -0700 (PDT)
X-Received: by 2002:a05:6000:22ca:b0:461:a16c:a5f4 with SMTP id
 ffacd0b85a97d-47f62318b75mr17158539f8f.33.1784558691905; 
 Mon, 20 Jul 2026 07:44:51 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52f81sm31422005f8f.9.2026.07.20.07.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:44:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 16:44:47 +0200
Message-ID: <20260720144447.1668891-1-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
References: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] rtc02: handle RTCs that do not allow
 setting the time
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
From: Kuba Pawlak via ltp <ltp@lists.linux.it>
Reply-To: Kuba Pawlak <kuba.pawlak@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Note: I forgot to include a cover letter when sending this v2 series.
Adding the intended cover-letter text here for context.

This series makes LTP's rtc02 cope with RTC hardware that does not allow
setting the time (e.g. Qualcomm PMIC RTCs, rtc-pm8xxx, which return -ENODEV
from RTC_SET_TIME when configured without allow-set-time or an nvmem/UEFI
offset). On such devices rtc02 currently fails a valid, working system.

Patch 1 fixes a pre-existing fd leak in tst_rtc_ioctl() that the new probe
in patch 2 would otherwise hit on every run (the RTC chardev is
exclusive-open, so the leak causes a follow-up EBUSY). Patch 2 probes
set-time support in setup and skips with TCONF when RTC_SET_TIME returns
ENODEV.

Changes since v1:
  - Narrowed the skip condition from a broad errno set to ENODEV only, as
    EINVAL and others are used too widely by the kernel to treat as
    "not supported" (per review feedback).
  - Added patch 1 to fix the pre-existing fd leak on the ioctl() error
    path, which the probe now exercises routinely.

Tested on arm64:
  - QCS8300 (read-only RTC): rtc02 now TCONF (skipped), was TFAIL.
  - X1E80100 (writable RTC): rtc02 still TPASS.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
