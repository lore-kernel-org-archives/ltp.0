Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4A7C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 11:55:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547553CD199
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:55:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CDFD3C857A
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 13:55:24 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 03F56600B45
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 13:55:24 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ed50e588d8so2533266d6.0
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783684523; x=1784289323; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIsWJUVzNTdmAhh4iQuPWeqIutBy8h7o0+PBXPS3HN8=;
 b=WiBcCcyqqAv3U6l1J+1CkmCZPJQF3jfkx/Usew3wr2o/jjbp/emxXk1kKGiHHFnrBb
 hMSx9jrFwEcmkG8VqdrCfIx7konxdbFa/URg9DkH1aL9ox9yW/jeNr7FU6jzGdEcSeOs
 H1VGmx7Wkk49v9gl895HpwH6H7NoVep5N9z0s+lss+hgt/zNc1s9n+ddAqj4y4VaGN6p
 u3nB0Og75BME1vdG91SbO3uK7PWb6mkZAkZyQo6hDFCFL2jbSZs26oTgY35JgZ3kMVYk
 qQmu9OpXjCBcwAL95gfHOfmBFbseuw/C4zkabZrEqQW7lNCY6qkzsTX/yHQf/Vj1F6WI
 gwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783684523; x=1784289323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fIsWJUVzNTdmAhh4iQuPWeqIutBy8h7o0+PBXPS3HN8=;
 b=NQf8CWmaZet1r9gd7k0vZS11LBdmxpU7TrDWZ+zGRxMpD/Z54TQznDSm9z+M8Qk/lA
 JR3cg1/+HZBNBqshGsq18pD0m+M8kvXC84//gqZwhgGk9D/hydxsGBwi/mau2Nfi2+CX
 gHr+KhgbmSyIToULv2BSJn5fDdePiFM/LymT37P25Y98UXdaLdhrsOdhxpjRPyhfxwlc
 GtzvtRdQSQjGOQL6RGimD2wSYtTNUhcFlKPqSChHv3gYxZJe7AenKqWa6++z4YU1b504
 DzeZ3eubRFBekOnlAfBAMnYvPvbleaukAcdfNXJ7SH9fetAARMRJs++XAZ5TcnD6Z0sx
 kXpw==
X-Gm-Message-State: AOJu0YyVRwB00Q0gjeWTkJdo/QBnmDqJ1kG0/+lA39s59QTieOlfPsyT
 X6q21GXS0IW20MoFqk6qIBgkKymNslIcLZudhorggLvQ1VnM4bjqdY6d
X-Gm-Gg: AfdE7cka85KurlZvBn1AjHaaMl4QUb0W8W3r2Zres8KuNoJjWiHuvOG8wOBsSq/gWXD
 44Dy/p3TzLtlnmXBGf4MBY7TQ+VpsH75WIreP1vnxzNa1hP6+FW7lVq2wA4waaIXXBRk30VOBwh
 KM2fVgtCpiHjrldBKOSrX1f6cb/r0uhlL3oJ1Bxsa2LRwBHKt/YXIVge6EPmtkh3kcPiFqz1uMp
 ww9rV0gI0y5/KKu9UA+kQWNHfyH/w6bxmoBarN9dWj/x67xzM578bdgXvDLzEH6IOsrVzUxqB1/
 qjE69yghz2PkQCH0Fi35L48q9k1u47Lc90lwRJq/lS0tfju0WfhdhoSCp3z97tF+r30u4UuZGu3
 lM12NgqgxJa3TfJnMv21kx59TYkDIpFgCMJrdpj5CcMgbZet0qkVGPP8R3QePT6zuP03Wlq00j4
 xSs7Xh3/HImG0CGKkm2TSTR7SxRHdZ97ik46Y14uIajqcvokZ/ZSBx6ZYfW7lFaAJDI6leRoyWO
 9ewn9Wvui4tmZPG7z1sm57ExH+5
X-Received: by 2002:ac8:5ccb:0:b0:51a:8d31:9a06 with SMTP id
 d75a77b69052e-51c8b403b76mr126045101cf.16.1783684522567; 
 Fri, 10 Jul 2026 04:55:22 -0700 (PDT)
Received: from
 runnervm5mmn9.yo2jsnv3aaiufmiidgoerdg2xa.bx.internal.cloudapp.net
 ([172.174.165.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caae5e91dsm13840051cf.21.2026.07.10.04.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 04:55:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2026 11:55:21 +0000
Message-ID: <20260710115521.3898-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710083337.1185184-1-pvorel@suse.cz>
References: <20260710083337.1185184-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] test_macros: Add TST_EXP_PASS_OR_FAIL()
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

On Fri, Jul 10, 2026, Petr Vorel wrote:
> test_macros: Add TST_EXP_PASS_OR_FAIL()

> + Fix macro parameter name in TST_EXP_FD_OR_FAIL() (upper case).

This is a second, independent logical change bundled into the same
patch. Ground Rule 7 requires exactly one logical change per patch.
The doc-comment fix in TST_EXP_FD_OR_FAIL() should go in a separate
preparatory patch.

> + * TST_EXP_PASS_OR_FAIL() - Test syscall to and expect to pass or fail with
> + * expected errno.

"to and expect" reads as ungrammatical here. Something like:

  TST_EXP_PASS_OR_FAIL() - Test syscall to pass or fail with expected errno.

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
