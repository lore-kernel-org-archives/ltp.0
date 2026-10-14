Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A9CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:20:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2B693EA78B
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:20:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB1F73E2F38
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:20:05 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0573B1400DCA
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:20:05 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 d9443c01a7336-2e4a61a2ff9so19373165ad.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791976803; x=1792581603; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CIckuei7POpgPWSRa6VqDyytq513BkHnnDkCwbkjY7U=;
 b=E1RgRqhlBanRSFgEd8QDhy2iRv43LLGSA0kWzCyDssF/cYVQjcHHMets/ExWVLg+oU
 arcpgpULm33Sj7wr6ZadM+tH+bV41xVPO367JRTzfxZbsg/w9o1/eWRFoWOcTqa/tnI6
 P9jkASUrbVIroURz+K3hauWBt86jPWkJ9x1ehk7lfmN69O46nOtAAUf0gWTK0Qg1pvYo
 Xx2+hcCxPSKff8Q5McVp8ebuBdTasyoDOsPrXP8GVLqwHkcQZ+TBmD7bX4E18Et7cREE
 6mSWi43rQAWiNwc9SIIQY+rimfaruOyf3geygZL+nylNCUWJUhblENP5rU54a11u4OPu
 A3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976803; x=1792581603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CIckuei7POpgPWSRa6VqDyytq513BkHnnDkCwbkjY7U=;
 b=M7xNfdBNWw+EVogNIidmPZ+Q/HbF4GTavqWhFXBN7XFucsx4F7Wk6Q2HpzTskxoBQw
 /WKGlVPtmUD+5D+zq9lPh4oXQPK5SEx/BB21dRkUf/pg+Pf+lAeRbW+3EIHpPHI4fm9o
 Zr12rbB2YCvIcMfP9H/wd1qZzQqaVd/b1m0WnETDiUx65S03ROXAlxR7knmR+1S8Oz8S
 U8aHCh/kJU7TxVXNyI66q3BNe0AmcMc5O1UrW3Z+koK4ztlAxt/Zvr7aiTndvtKBGxeD
 pPi8CFJl1ljBNkzTMMAA0s9oEXwfsDa2BvWExiBzDV79xQDu7GKRK/PtgFEoDw1LfyCq
 VpgA==
X-Gm-Message-State: AFq9FYLlxxWktGzYKCEP3vyBbiwEqYlEMv7zVZFRMt2i8TB0T1PHzbOs
 shgjVzyRmSKvRqw52hQ1mhW0yUFj3ayrJ5X+nUadhcIy9KzHPvJtx1Jz
X-Gm-Gg: AYBFou2V2gcwBvByd2BvcBBpUCYkyMifXJMmsYl9Jw3BCipDjhVKsBLeIFeoJ2jUiTo
 Rw3QE8h4UzIff/Ir6JPee8cWivM0D/Rxwl6ZHbJ2mAmWavgXcsNfaxAn01Pkdw4cxAmUoeQ17JP
 x/gg6Xo+vHpvxTKLlqDLQ0tEEi0CN2Aon6R4GxDFALp5qm4p+56mzuG8G1dKNFXQYGABPvxnoZf
 68iwL3i9UAKh5oYzKqwXCyGJtB+uxtDv5TCA6vKBJM8RjTZy8p1rHS8SolDeu/0o7Ofte9HtU7m
 6oyPZEt+R7970q8EtkBcZlEnQquvHS0TgaOUS2Qxc7IjggGp9bB7YuyISBWbriw4yJmW5hYTBVF
 tiUUwDHlr6zCf/xQX4/U/dYVPyVjGjWYAl1juxb9z/DVABrR34vMWljAIIEK/zSjAxgPlRiyL1/
 XUHloC59x9iHnP9nBGwoZxzMgSIUHtNiP0KurVM2IZjQ5fFze9ZP6pJ8HSa4IxkrSje4EaoDAsc
 dsOJQfrcWgyYHmN4JbKSUO8rcVoBJDis28NmK8+C649C3lirHlOVmCWaE/73cNYVLgmRLTcugdQ
 Kk4X+q8=
X-Received: by 2002:a17:902:db0c:b0:2e5:73eb:a086 with SMTP id
 d9443c01a7336-2e842bbf398mr123053235ad.54.1791976803203; 
 Wed, 14 Oct 2026 04:20:03 -0700 (PDT)
Received: from
 runnervmmprz5.lm5voez41cuu5k0eg3hjwl50ja.xx.internal.cloudapp.net
 ([4.154.22.9]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e20d2sm67385315ad.77.2026.10.14.04.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:20:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed, 14 Oct 2026 11:20:01 +0000
Message-ID: <20261014112001.9502-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014093618.1475191-1-wakel@google.com>
References: <20261014093618.1475191-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] swapon04: Report TCONF when SELinux denies loop device I/O
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

Hi Wake,

On Wed, 14 Oct 2026 09:36:18 +0000, Wake Liu via ltp wrote:
> swapon04: Report TCONF when SELinux denies loop device I/O

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
