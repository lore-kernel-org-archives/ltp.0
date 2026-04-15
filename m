Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3348F9D0F9
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 09:25:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 746783E59CA
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:25:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A43EE3CDE01
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:25:35 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 551C020005C
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:25:35 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50bbc41677dso90960011cf.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776245134; x=1776849934; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6K5LOrKzp5tcOdKH5nhH7YP8Yhrysrs+XICGraVkCE=;
 b=LzA95juwRVntWmTbLxgWvesDGqRb0mJfXpFtdni62twKKaplsTmPWdpFoIKum2nKAd
 hFF3FsEDVs5PWJlR8o57M6VDg44CKLvXrfugUYP1BT/I4Mnj46ZJ9jQWV8TDSA3UAUlu
 qF8e78FPRpn+rhWBh7kS6zcVEJV6HQcyXXZAf0sTvahdL3CvfDtQYE8guF3MfGGTI/UV
 56f4z2K2Hih5IVyUFcsuO68+365+fYacn9qfZVTblUfbJJzicTe3evOxTpUX7WKapI2x
 GYbuHTJ3mN2ghAJNopKs0WL2EoLV5NXpOztgeAMsbcuo37ZNtMEyhay6chHjogABVJET
 Qsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776245134; x=1776849934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c6K5LOrKzp5tcOdKH5nhH7YP8Yhrysrs+XICGraVkCE=;
 b=Cr2zvE1QQrCE3GRSmw0F+Wz3d/CJnw/SA7LjKJY3Njg0fKxXzzTWZ5bps0qiq7B5Q8
 9BYoppPM4WfPLGDQF1OjopPp+UQ70iuVCTQkn2NS/tiL7ULz0rT+XfjqRe5QTZDUhrKT
 LnZGAijRbcX60aAB8joq04Zo59qo8f076EUvmKZZrwQcvLLMj9q0iq2WnMmI2Hjtt2q6
 qtkFEO1iNQeRrLzl/vDJAE/Bo4YIP1wHl78W7+W+NA9L5tIc7p4dnYAbbsbAfg+twcWZ
 GxjhWvJBTuBjLGMKu+Swp0ShYR2GpTnKwnklWstAlCFz5PoKjlrkw+Ak43NWC9RCNLgZ
 isyQ==
X-Gm-Message-State: AOJu0YwMBlu6fRxYO7h/2X1AjjjTWRtDCAEwywfGkbGmtgyujgDToc6b
 d4Z7t604Emyxz/euJ+bo3HzBXkF195B26tasaw3+aN0/NCpRs2yshPES
X-Gm-Gg: AeBDievO4trt9QP31VHCmE/tiBXKDpiRD22k09OjUPP+RBcXwcupEWDw39Gf3JchXPI
 JEg1/AontthcaA91BpUCrGcOitZ7XIjY30dcKqLuR8+kJVehI9GpgFlidGLy0+in36dbJoCzN2K
 BkqqAYc+mU2eVGLBDl7cLi75mh2iGIIKpp0YXbId/7mgm/oASWAJFCR3QrT1RmEUUHihVuZBD46
 8DobcgqCoYlOqD3YwPNncKhrEXD1Zh90O8D7JV5UVix+zy5Q3qtMq3yxcuR+OWOSNd81eTg1yOS
 ZAldK7gOId4TujyoWB3nS87GKsYAUOApfQl2eNb3QnidgPvDUsJwUTzXIHvjDjzJNBG6Gbeachv
 XmonaGPzjEBaA5zL3BlkIuaxLG8MRxyEmogPRslzyPvmdbwtEwDwqeey8c8eDb6V/rcXSQRQJJS
 Chwn0man5h37c0500iGzkEVuOOpczftepoAfk939LqN1BES3JYiK1cxAi/75LCHYnf8pax5LY73
 kaRC4N0Cv3j9kLeqqwFovoYzh++EWaY+9Lf7KA=
X-Received: by 2002:a05:622a:438f:b0:509:2448:410 with SMTP id
 d75a77b69052e-50dd5d10d86mr255167331cf.47.1776245134132; 
 Wed, 15 Apr 2026 02:25:34 -0700 (PDT)
Received: from
 runnervm35a4x.tsmti5buv0aevewz2pijjmw21c.ex.internal.cloudapp.net
 ([64.236.193.18]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e1afdd385sm8654851cf.25.2026.04.15.02.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 02:25:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Cermak <mcermak@redhat.com>
Date: Wed, 15 Apr 2026 09:25:32 +0000
Message-ID: <20260415092533.3877-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415082547.vgn23q2aobxy5gzv@lida.tpb.lab.eng.brq.redhat.com>
References: <20260415082547.vgn23q2aobxy5gzv@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Make ioctl_pidfd02 valgrind-compliant
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

Hi Martin,

On Wed, 15 Apr 2026 10:03:44 +0200, Martin Cermak wrote:
> Make ioctl_pidfd02 valgrind-compliant

[...]

> This patch sets the parent_tidptr explicitly, making valgrind happy.

This is a bug fix; please add a Fixes: tag referencing the commit that
originally introduced the raw clone() fallback without the parent_tidptr
argument.

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
