Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52A4CD4F35
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 17:16:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588533D721E
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 19:16:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 349CB3D227E
 for <ltp@lists.linux.it>; Tue, 12 May 2026 19:15:39 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CC632001C6
 for <ltp@lists.linux.it>; Tue, 12 May 2026 19:15:39 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-899a5db525cso36517426d6.3
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778606138; x=1779210938; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhunkdjgGksPcS5I1dcaqMPeYwyWaY4Nf2uYQJPItZQ=;
 b=U8IijbLXHaCjKKwreIbN+6MJjqT1db7iwLsI1VOM2k8g8Saa2isRc58u+AhOPc2rqO
 WY/DgsyAq3VOE1PT0MsvJ6cU3Yh1aC3GUREcI/VMdHagQjy35SdJAk3/qRxUSlz1lQqK
 jKmZH7QImk3L0Wt2bI5FGDr6LqC0/CeRyQ0bdEbJbdwjrA5He8DBMCNb2YVaYNjsvbx6
 l9c2a7/JA/riM8NOn2tg1En5pYcDKndwbC9/QInxVn01WlXcrGljlrLE1dv31a6drzPe
 Mc7s9NNbxswRPJMgIbdURyT8OyWTb3HistwOQMvMPbO6HB8zWNC5/LigyF5lLfDMVgwc
 7/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778606138; x=1779210938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EhunkdjgGksPcS5I1dcaqMPeYwyWaY4Nf2uYQJPItZQ=;
 b=qKUb+TnGGfjd3N7GNcSetXw+nH1t7zBWDrrTT4kl7COy/3KkHC5QGNjvv3p8ik14wD
 GrbfVX01YI+BbhVa6/awlfdYT6fJnRLC+yv7O9vWiWHJbX68YGK/ECZ/ZyHRDo0unua+
 9cw2ajXY536D00ZTwHitAX3QxnZvb8oGqfrzzuhzLYkZ+JQYjQhJ6bbz3uzMVGKS8sJZ
 75c5Deomxy1cISv/V1P6rbJzcwgazeCjniz/SnMiHlk//moFm2clP08PVllQsDQvW0QV
 55asEZUjD0/RHIsNt67NsV0RkYZRQxIYrV5uTFAGN835L5Pwnx1TO5bUeiLu9+d8aSaB
 8llg==
X-Gm-Message-State: AOJu0YyT0Yx5ogJnGsyJ/L7O4/ioncnZ3rT5Bt5KLFTUxByWToiMU3pB
 F0ZbwVoaxvrFQCHuxD4FhILZN4uuTEvrm3in1/sNo+f8yMtwqv2rQiUfFx7N/N6OC8A=
X-Gm-Gg: Acq92OEMSjXx/v+iLzmaGds2cendXweUK8ueRoJqxyCklrx/leehZwMQrjLCUehnPtE
 fDyMFfRcZBjfFI/XQx1wbk773LdFZwS1Z0kSC7UmttUTV81RNJsGljqff28dpb6KG3SSr+3Xi0X
 pLvnMtSiaaOUNqOOOOwhI6fP3GwQoKVi+vFWnqrIhZen5gUoG3aKYTVQ059NQwEWehFX62hrbqV
 hrosimB9MvZjlf63oHP1T3o0LLDtEX8WVAReKkYLPgrRLedtV+JQgIvhJlK1uCrKHrfVBpxZNDZ
 fz/p42bVHlv85le/tfjfT1pOJJsKMb0dj5BEQNF7XhFIJ+UeTAsFpFyCkkGqFT5hJUpEhjPibaa
 dx7omYwESjeP+oX8dRkoQrpdyLNaXz5H6rc6sxoCJMRDQzudTLOpXQvj8+Dy4Cz+NAK1PyLKAvX
 2aI5fsPCw0L9AuS2qZep0c77K7A8wNLT/2GReuwC5z7sgYX2AU1B35KTWIbfvmuW9njYxif++cP
 3he2vBx7+90Qix6zHG/udZx5bO26TVnhg89l4IodA==
X-Received: by 2002:ad4:5ba9:0:b0:8b6:6d70:aaac with SMTP id
 6a1803df08f44-8bc449aff20mr438473786d6.30.1778606137464; 
 Tue, 12 May 2026 10:15:37 -0700 (PDT)
Received: from
 runnervmeorf1.czavsppgnzce1nrf4ae5q21skg.bx.internal.cloudapp.net
 ([172.208.127.243]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm129287766d6.31.2026.05.12.10.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:15:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Tue, 12 May 2026 17:15:36 +0000
Message-ID: <20260512171536.3962-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512152517.4120-1-always.starving0@gmail.com>
References: <20260512152517.4120-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close02: add test for double close EBADF
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

Hi Jinseok,

On 2026-05-13, Jinseok Kim wrote:
> close02: add test for double close EBADF

> +static void setup(void)
> +{
> +       fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
> +       if (close(fd_closed) == -1)
> +               tst_brk(TBROK | TERRNO, "close(%d) failed", fd_closed);
> +}

Use SAFE_CLOSE instead of a raw close(). Since SAFE_CLOSE sets the variable
to -1, save the fd value first:

    int tmp_fd;
    fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
    tmp_fd = fd_closed;
    SAFE_CLOSE(tmp_fd);

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25750070063

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
