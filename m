Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82770CA5FFC
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 18:01:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C33D13E9DAD
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 20:01:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C1773E4B3E
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 20:01:18 +0200 (CEST)
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C281F140025C
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 20:01:17 +0200 (CEST)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-139b659a45eso364794c88.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791223276; x=1791828076; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FoeVYY6+lG8Xo0hDEiwL5IWJ2022F/4XuOyv07y6Rak=;
 b=YJs+rkWxK6pLvKEuf/HqOlpaTkGllugFd+PJWHaiVu2qfPqu5XVKmEjH5NKnJceAsE
 ABcdrQ6SlQCJAAcjfPxo6CN9qsV9Ex/YNTmLrFfiTN1I+c0KkrizujZBOcGZhuTvZMrJ
 0fe0419m6wA4zHGuGEuhl6F+MXfD8ROsLHl2ZaWiWqDROs22tEO9LTFph/U7BtncrmQn
 hW7H7byr9bOu3O4LgMvUACGoxYdmVbmKHvXe2NBD4EhuwSAeksxOHQZzBsR+l/m1sg1g
 bS3I2Qg6wc0con9JZHYvgT38xafjhKiNBLi+aKP/eeOydnEqSbIPi5h0n8HtgJLPKkeN
 NayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791223276; x=1791828076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FoeVYY6+lG8Xo0hDEiwL5IWJ2022F/4XuOyv07y6Rak=;
 b=JdzV6UesDJfc8H6doJdGq48IqxoZm8F6qKSnPOVZ45Y7uGZ6h31BKg4JgeYBIj6WKH
 /ZRD4VAUxdTCkQujFIjAkQJv9MmPlQGilNklEsbbVV5/BKImoEugebaicoCLy4T6K/Cd
 IOzbtDEF/W0Zok6MleUsIy9ntffMpLKZtRY6sA73hoaLhdu1/MW/o+9vPnzFsakmpT3K
 8eMxnaujfAMDETgqMCU46WVOZty/iOAMhC/G4ld3bZlMdmZQ/U3QJGAebNwd0iGOwL+d
 RCXtu2ghoLOhTZlU9GNbE1dScwMvEN/5tsZzYAoMwh+q4nP3cNTK70tTnzsB3LR44M6Q
 8xrw==
X-Gm-Message-State: AFuF++lXcPPoniEzbLY0OBFQUY+EkTaPc0ThzxjEkHwA5ZAQu03qR8ZU
 54l8tpfRr5xIvUe7BjJOUi/PlSWJr4wQVDdP4FpO+UjeKlK8lO28p3r/
X-Gm-Gg: AYBFou2cR4KV13fcp+V730Nc/6FOzeD8YLtgyDAlYp7txjKGCDQVdWsbWAGLzqmXjPk
 z///lKsd1Z1q8CjpmFcvayQUdnvM0vk3Wh/VqLUZCM1ipTeN3nqYkQW5Mxihxg5VQBLhrtXzwtL
 CKVUPI0nHgwtt/JfjVrC3PJEBiFqQOaYbfMDHN8EzWBIfI3NzgTGHzju4+i+6MEmRBiW+TryBSg
 Eljdr7ORMR//BvdqsZysua9OXDvi2lYGfKFxlRIzKWfJ0eP/v7GjHt1niDoRSobT5CO3fu8j0BB
 D2YV+TPpakrz6fIgq6M/dWOzXL0SsM19aR829MfuyFM4g1yxPHv4yuD9cAY4kA338GnZIwguSR3
 Wly5AOz27jvuykSWMsRCxj+SaWagT/c8uJMThqUfdeiIxkCWIm5BtQG4N8pN42KWURfahMbpJ/Y
 j59pbEYZZbBlPk1q2Rp7aZj3buaaQ2x7gNrBvJlJ9ZFgxkawKLBKi226nRPeeI6qQBXR96iQbbG
 jc/vM7xnZxCg23B0B7fTh4eQjiFBRV0OyXgkgNHO3nmDylIZv9hcUb6ZVQr0Dd96vt8iV+Sq3pg
 cu+3cYAHoU8=
X-Received: by 2002:a05:7022:b044:20b0:14d:baf5:c412 with SMTP id
 a92af1059eb24-14f5b311841mr14588408c88.8.1791223275719; 
 Mon, 05 Oct 2026 11:01:15 -0700 (PDT)
Received: from
 runnervm8df0l.xpfrclthxctencl5s5t5gfbveg.dx.internal.cloudapp.net
 ([52.190.138.35]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm163976c88.0.2026.10.05.11.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:01:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Nirmoy Das <nirmoyd@nvidia.com>
Date: Mon,  5 Oct 2026 18:01:13 +0000
Message-ID: <20261005180113.9313-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005131807.904833-1-nirmoyd@nvidia.com>
References: <20261005131807.904833-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_ncpus_global()
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

Hi Nirmoy,

On Oct 5, 2026, Nirmoy Das wrote:
> lib: Add tst_ncpus_global()

--- [PATCH 1/2] ---

> diff --git a/lib/newlib_tests/tst_ncpus_global.c b/lib/newlib_tests/tst_ncpus_global.c
> new file mode 100644

Low severity: Add tst_ncpus_global to lib/newlib_tests/.gitignore.
Building the new self-test leaves its executable untracked; git status
reports "?? lib/newlib_tests/tst_ncpus_global".

Verdict - Needs revision

Runtime review limitation: getrusage03 exited with TCONF because this
environment lacks CAP_IPC_LOCK, so its allocation checks were not exercised.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
