Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1C606A884
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uy950WiP
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92EC13EC335
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 05:49:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 043643EC2A2
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 05:49:17 +0100 (CET)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9708E1000932
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 05:49:17 +0100 (CET)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3b3d125637aso91792a91.0
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 20:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794977356; x=1795582156; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eeCBMG909S7MRsVKwrk67mv2UXzMeaUY/FPOYSkSm60=;
 b=uy950WiPjkmMXtjT1TVKjO9RV4AGBNTmBwgP/XvwaiAgAWjKAWYOffTeHX8B/V0a6Z
 qWbnQoakYQ3Si1yxRyuPVnsQfjD2JvcmmVNkEU1fCsGQXh0W21qXTd/j64qyEKa8IwRi
 XNcwhF0jK6kZsnm2/k2hAl0tyfgoOTkrfxvmu1nOcOsIM8a/xHaei/rMm2vgVvNEDHu5
 /PDh+Rpzm/uXban/YViW6qeH6HOmGaNjNI6BBgIiC/ThdQSSXUxyVFTQJU8Ygub7XSjg
 tgiQdaZeOe+lpPFPVpnhYQ0nRsg/jGF4bQpZdlqoVhW1C2Jv+DnCv5axIhsuB/I6vNBJ
 seBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794977356; x=1795582156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eeCBMG909S7MRsVKwrk67mv2UXzMeaUY/FPOYSkSm60=;
 b=u5+Ea86BcFkzLCNBG7RnpTwkjv1gk4JAbfBMKTy77hV0yxkBgHiDc7R5993BJj4wMk
 cPqWXE3equjdMYZ6fGNR69QUMsjjYHKTW9urQSsoE+7prIgO6wOmzF6u91hbt5UxXOBZ
 4+wy3i15vVsa+fdZn5DN4wx7bKD4aRJKbjl0x791CHnRikUcf3drcrWo99ayT4VUwzp3
 0zL9L7ErWxED4eaKMJDUGH++dthdvpu1+oiOR0wc1P4XjX9hNrHw2vFhk0RBr5yr5Su3
 VVh1G0p1swd0Xuafht4+G2TkyQDuKtQGDHNrjaYXwXRVNsjZ3nnPCmr6e28vITpK59Ek
 Vgew==
X-Gm-Message-State: APuU4Z92mtdl4mFTY8CnFq2hfPQ2jST7SsEozuDaXUvtOzbp33dj5A1C
 W0Mj3xNxV6hzrqAOeKTmZwFsF3F37yiuj5ATIC8j9IUN82WDtO8T7Ads
X-Gm-Gg: AZFdTZfSic3MZCXuPfXWRZwD0tcI3IbIGKInGQDPbuyquNOEuIIJB0ye7zMw0jK8jzb
 EisnhaaHlfB27p6UHjEBB9rQvup1r8+AyNH1TiR5o83qnbo/GQl2Jd4TtDU92OWvpgnQlCZZstx
 mZ6sz62KRVYVMS1pIw/YWLtjJnyac27HJ186mSr0MisYCJZQOLGpLXuOXGp1bEfCnzYAoTk6q65
 ISK0Tom36MNOr++zTCXACv6JEticJDiYaB4OWER9cvIw7Wk+GwVngTQLc8D5I+snIML5QnSHW4k
 7dK2rjCjRqspfCtDWzEwydeLZxpoLT/RFQj6cmRroG5Vl/pyxq2MPQ4KsKVCuEoCAnNh4UYyJGp
 lubTi6jPme0Hh3sBrUL4+VJ/svQSIupKbrAj+N6eGjomA+m8SN1JT4Qj1x61NylHTSThvy4hHTB
 5gPFC3FOHINRZaEU+PvpeWAQaASCCESmvunh9IgaKnwRSJwxWcal/zmREjZVxp+lxfnJMJ3bmL3
 Eo8dOL7c5C3Jwzvub3rh/Uqgrk1waE8wvfzz1HXMnWTP+qN+3imUUOpHY0gIjLagz10hnvwq6U/
 48Se9cebxNqVMO4WV8HOFWORgrEGVAMjPXatBpJr6Zvjp3z4ldgTBe6fDiJToHo5Y6TISaUAZp3
 aCyr5RJxcrHBwtvSRMpZrDGmiyz8Zj71JFZyUpss=
X-Received: by 2002:a17:90b:1e4f:b0:3ac:8741:e2e4 with SMTP id
 98e67ed59e1d1-3b3d07e0309mr1626763a91.52.1794977355775; 
 Tue, 17 Nov 2026 20:49:15 -0800 (PST)
Received: from
 runnervmccnms.m0crtnpzqczephvj2uvkmxfcme.xx.internal.cloudapp.net
 ([4.242.63.37]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4cff6fsm7098638a91.12.2026.11.17.20.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 20:49:15 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed, 18 Nov 2026 04:49:14 +0000
Message-ID: <20261118044914.3815-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117235848.2975548-1-wakel@google.com>
References: <20261117235848.2975548-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_rtc01: Report TCONF on system time mismatch when
 STA_UNSYNC is set
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On Tue, Nov 17, 2026, Wake Liu <wakel@google.com> wrote:
> sys_rtc01: Report TCONF on system time mismatch when STA_UNSYNC is set

> +	} else if (is_clock_unsynced()) {
> +		tst_res(TCONF,
> +			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
> +			name, (long long)since_epoch, (long long)sys_epoch,
> +			diff, slack);

STA_UNSYNC is already set at boot by ntp_init() and rtc_hctosys() (via
do_settimeofday64() -> ntp_clear()), and it is only ever cleared when a
userspace NTP daemon calls adjtimex(2) with ADJ_STATUS. On any system without
an active NTP daemon, is_clock_unsynced() always returns 1 even if the clock
was never stepped after boot, making the TFAIL branch unreachable and masking
real RTC vs system time mismatches. Conversely, when an NTP daemon is active
and clears STA_UNSYNC after syncing a system booted with a wrong RTC, the RTC
can still diverge if CONFIG_RTC_SYSTOHC is disabled or unsupported by the
driver.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
