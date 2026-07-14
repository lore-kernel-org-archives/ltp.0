Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD9C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B585A3E56E5
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:50:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCF1F3E56AA
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:50:01 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FCAD2005E1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:50:01 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-51c8dd6cd77so18962951cf.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784026200; x=1784631000; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aK6vvqQL6M4YJsLbLGLEiS3X4ZY6bRdBG+WK8NMFUPs=;
 b=j8iBet2F3HsD8z+tZeV9k7dyD0UVPjtGZhaLciqjbVd8nExTbR67/pOGNuyaYYBdse
 22ause9Ptkq4gEYsleLV0A+kihFdIwpomzNpsgtvOFATMgSIj9r/WNCku65qrSgUtaSk
 j13i5agOFCXWJIx39UQLoW6EtXWj66dWTqEAm/T9JASD74//6CMgEN9HSc2HCeJUGH4k
 MhJpldBJEiD7/uU6lKv2pCh+KRhZtqMp34cnSLp9B+0BvHm8u8mRfBq2fr354ggvjI0v
 YeAEPlNaOBvhUG6Op1+FXtJRmPlsAcE+54KFIJoQ9F9aYSO4ISYKt1tV5aMj6TxRlPZo
 1L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026200; x=1784631000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aK6vvqQL6M4YJsLbLGLEiS3X4ZY6bRdBG+WK8NMFUPs=;
 b=sH6Hip5ZUIFPVDXtBePD3msllu9/Z4v7eVU6W/DbSZ09Ng/0+Fqnw+88AiP3D6sEKK
 oUoU69nqqnxlftniPP3MRuE6lT1/AOecHyQBVsDFn7P3MDKBBeUbltlcuFkHN1KP5n+p
 6qSRnCB7ZZml8INbv5Tma5l/d6zxdMIAGHYUaOIWG2h5+10Dv2EygyYLkKCKVNOwxElW
 5JC5aQHoMHFmGfWczTRA854yQqDRvKfBDHV3VL6iX3prylTAlYaVqtH936CKn/ghHFQo
 Wp5Ibccd8I4bjv8luybGyXNGV4qzlcmBpkXjrtCwak0gr2UVeQ34hiCr1pyEp9SKnzS4
 2Bzg==
X-Gm-Message-State: AOJu0Yz9CzGrf8WTmv+nk0uaIzKFVlIN01Fmyg0HCEuPKgjkPmYeY6G3
 6IzrKF/kOWvWFUfRIBlZ1zo83YssjSPjm9pzqQ6fgAQwQbbW8H4fn44SBGNZvvEX
X-Gm-Gg: AfdE7cktJ4eROfe+ci43dv3bHypRyjwyLQObI+tQLQwhpQjarMrDhj4tx3+7QGjvXsZ
 lTqasoloVpZScFEOJlzCd7Ksgmb7iAIjLzWe+jVQX1lOZl8kNTr5WNeVx0A98ygSRBn9Ly8wjLm
 Uu2cPhHKeJpTuKI/kIH59Ov0UI4yS5wMWUIskrwZk0QdyTDwt1xXIYsZ1Uxzq7KMhH3xApnRXct
 OboE3qCz2eMCqOhjai3465nNSh9jCjis7yiubnfgYg+3G+Bf8Z0x3br08P78MrMTLmUrmVeEmnA
 fDKBS/gXDrL7Da+zSGvmrv7GJvFAF5snxKexgk0SRY9mUAkEf48GDetKDvBwb07RNBW2iQOWWvd
 /wqCf8f7XuhC34z3Mg43PCqTt1HBFzei0nh62EEMXUq5akHR7fPzVSXcDpQ5XBPgBycLQS26i08
 Gc88lEbq5kuefpbrmg8MuM0mVwGOvzOTJrDWElS314/bLvDXLlU2v52xlOVVrrqEzySCjtjCmxa
 Q45FHxUb/HCPy2YpoPe6EhK3YZmtg==
X-Received: by 2002:a05:622a:60a:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51cbf12f90emr115135761cf.24.1784026200344; 
 Tue, 14 Jul 2026 03:50:00 -0700 (PDT)
Received: from
 runnervm5mmn9.zm1gstafu1aubcwruotojqkf4h.bx.internal.cloudapp.net
 ([74.235.134.162]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caae206b6sm110540091cf.14.2026.07.14.03.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:50:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Hongtao Zhang <zhanghongtao35@huawei.com>
Date: Tue, 14 Jul 2026 10:49:59 +0000
Message-ID: <20260714104959.4018-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714090632.2910506-1-zhanghongtao35@huawei.com>
References: <20260714090632.2910506-1-zhanghongtao35@huawei.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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

Hi Hongtao,

On Tue, 14 Jul 2026 17:06:32 +0800, Hongtao Zhang wrote:
> Revert "tpci: unbind driver in test_assign_resources()"

Two small commit-message issues below; the code itself looks fine.

> While the patch fixes a use-after-free in /proc/iomem by unbinding and
> rebinding the driver around PCI resource reassignment, this approach is
> too dangerous for a general test. Unbinding a driver from a critical device
> (e.g. a network or block controller) can instantly break SSH connectivity or
> cause filesystem corruption. Such side effects are unacceptable compared to
> the original issue.
> So need to revert that patch.

"So need to revert that patch." reads informally and is grammatically
incomplete. The motivation was already stated in the preceding sentences;
this closing line can be dropped entirely, or rewritten as "Revert the
patch."

Also, the body is missing the standard traceability line that git revert
adds: "This reverts commit <full-SHA>." Without it, bisect and git-log
searches cannot mechanically link this revert to the commit it undoes.
The subject quotes the original message, but the SHA makes the link
unambiguous. Please add it.

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
