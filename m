Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88CFC5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B78CE3CF68D
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:57:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEFE03CE39B
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:57:32 +0200 (CEST)
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D41C1A00793
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:57:31 +0200 (CEST)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-45958a0c7c4so423390fac.0
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786381050; x=1786985850; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gD4IgrBwMit6632jJ8hyXr5tTkoQF1YhjsZunbmAfIw=;
 b=cvSie5tVJQqxf+N4dCKbw2399o2uYjN8UASY8vDs+cyMtCrxDmDarVSnszkh91s7qZ
 bt6OvTGeBfFw+7Z8QMBj/ekMCRBU+GWoyuYFeQHKnQ68MZcRXNzUjc/VzqF3pMXBP2VK
 zje8WajvA28DPwQoBJm/AvypcApDXl7I8oq6y1hoi9fLqpuCmbrRZ3EhgUlzbm4p/lsx
 Ok5t8zLKa4FQwpFSw7IxuIqDPtl6HSDtsXrElp6I4Rwbl7TBOT31D5mmXjtWvseqsOLm
 OnCNnqDGsz1XKhyXpFWKXBIWJWx0Fg1IfDXITnYsAtWC3gtBRqTdXzEATGZuwZRtb2sh
 iv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786381050; x=1786985850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gD4IgrBwMit6632jJ8hyXr5tTkoQF1YhjsZunbmAfIw=;
 b=J5BSMqrkm/0Puh+Np6mAWHT6JneSsL62RE5A5lKhtgay6t992ILryk5rAX7VT0tvjZ
 0dIiXvXs2hie0b3zPFxBm4KIXvArMApqqm4uogsMZjZJ9h63BYVKXFw7g8AzIE3aVoKq
 FV0YIzz+pTN4gwD89UPW4NzI+0FrYjx8E+sDGGprjMqPNDtQMMgN39FZ2wzP5d0CMwPK
 n+gdKRATUAmX4gK5hcfhiCaKwO18j05boklUegnR3si0tRYGaq31rtq3lX6zQXDbe5o2
 pc4OaZYYwWwy4SWxmAPzSfv7pfNB253rmTAeKjxgHB2f0cKuXKtL0slkclkHt+ZYe+9F
 MF0w==
X-Gm-Message-State: AOJu0YwnjXs4y4rUZXw6y+G5bE6dKg27PTHWF+TRN+7UdNautsZUdoiV
 CGyHcvzy7lVystb/d2MOldl4be6bnOcnHIRRH9ifD5EGhDabl+zB1eX4
X-Gm-Gg: AR+sD13h+h45aRBg7QefuiKSAHIJcHlMxeQkdJlgL4Crvez1q4lPPh5MLkdb5ssmrKC
 tx8xZ/CPpfeMjrwD5kq776KnEVZu6QZc4y0Gdry0lnxoogr3D4az6u/gXd5R6KmnZuk3qrhkOcM
 9MsAIymRxXKBkn+Yo8u2PIfnok9EdvG4/H7JUz06DCmzCYiccnK9nPSAhfB37jX6wT34RUyxTCq
 0CGvNW68LdlMX3khnUAMw5PhGa8HRhNnWCGceJOwrcpPSKzjU2JmZNDX5RLHvu8FWPl/pXDadJ5
 +XEdXlOf0uA9ynVmLnddfTN1MHj0qP1djxVGtOmowNHfzoivzin94sUon7I5oT+OzhOGXopyFSP
 aOvUcIFYiZrjrQwq9zF0Wq80t4TZ2NVEAey9THXd3/db4OYr/DugBQsVGmsO1RsSWZy0NYaorPr
 b1ksRWIOS06M8x6ivfoil7VjsOI7HFb70CpNL+EClYkwmX510w3vGJqw0qdbqKxHHkKb7Ev9cwS
 VO2Veicqr0m1GMrjO/XNgmQClrGED19OAd0eraGgh4i0/yp1jsvm58cx37fs5WuxcaRQz95nhY=
X-Received: by 2002:a05:6870:b0e3:b0:456:f700:dd75 with SMTP id
 586e51a60fabf-45e054d46ccmr1508297fac.7.1786381049878; 
 Mon, 10 Aug 2026 09:57:29 -0700 (PDT)
Received: from
 runnervmvrwv9.ugd2vj5l4uoe1ofxiuw3zjeule.gx.internal.cloudapp.net
 ([13.89.124.18]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a0586asm8897212fac.2.2026.08.10.09.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:57:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Aug 2026 16:57:28 +0000
Message-ID: <20260810165728.3981-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810160048.1040517-2-pvorel@suse.cz>
References: <20260810160048.1040517-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi Petr,

On Mon, Aug 10, 2026, Petr Vorel wrote:
> [PATCH 1/7] tst_kvercmp: Factor out error handling

--- [PATCH 2/7] ---

> This is a preparation for struct tst_test max_kver member in the next
> commit.

Could this avoid referring to the next patch so that the commit message is
self-contained? For example, it could say that the rename makes room for a
corresponding maximum kernel-version check.

--- [PATCH 3/7] ---

> NOTE: Mainline release is sufficient on any stable release (test with
> .min_kver = "7.1" runs also on kernel 7.1.5). Stable releases are
> compared as expected.

Should this say ".max_kver" instead? This paragraph documents the new maximum
version semantics, and the corresponding header uses max_kver.

--- [PATCH 6/7] ---

> static struct tst_test test = {
> 	.setup = do_setup,
> +	.max_kver = "7.1",
> 	.test = do_test,

Could the changed PIDFD/TID expectation be handled without skipping the whole
test on 7.2? The second case,
FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME, is still a valid
success case in the 7.2 fanotify_init() implementation, and no other LTP test
uses that exact combination. The newly supported PIDFD/TID combination is not
exercised elsewhere either.

--- [PATCH 7/7] ---

> + * Basic test to test that .min_kver and .max_kver can be used together.
> + * Test should TCONF or TPASS.

Could this test use bounds that make TPASS deterministic? runtest.sh accepts
both TPASS and TCONF, so a regression that always rejects tests whenever both
fields are set still leaves this self-test green. On kernels newer than 7.2,
the callback is not exercised at all.

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
