Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9369CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F03C3E5C31
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:18:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B1923CD509
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:17:57 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EB821140024E
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:17:56 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8ccef9eabccso44697066d6.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781529476; x=1782134276; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFlU7Fevbrvwnsn9ZaFaoLGpsx0pnKGaJ6UObTF/Hx8=;
 b=q35gL4NRmobpYFzec+z9cqiul7l20ueRQw7OFf+CfhF7g4l7xaJfWUxRyG+U/9cTZO
 jAb6G6HWzxbShvAB0jZpamEf4x8sf1ppfwWm+nj4Cp29DJTvMS4PdHtQrU5BYM4y/GM1
 tSScco9PdjLVa7bj0FpVeVfdNE30D0aYYSOyu6MAGQXN8corrcz4vMkVsfJ473Z18k6S
 l4BVvO6CvDwtcM2lFw29PBnICVyV6fw4Y34Wy+LjaRSpbE8nSC4lnfoxvpVG1copY+ZW
 XIL6cu8cVbVRBuuXTJCWxl25fC7+hdARXbqB6/l25MGFRsPUM3E8tW1ijOOb3zdNhMih
 /7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529476; x=1782134276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vFlU7Fevbrvwnsn9ZaFaoLGpsx0pnKGaJ6UObTF/Hx8=;
 b=sE/V+sQ6blzRcXfLK6zlTfoDdpSZWkTr8YkCSwgr95VaHS66iQFCGCnMwf42vSXsi1
 zVXKI8j4e7wmuDL+0TRvj8QcnWkW1XMnTYt/wiDFx5xBNC7jNqjeYycU+C4P7Gdvv2lZ
 cxxm7CjjpYovnywKfo1r66FwcVGwYiLXK/oXIkz3b/Q7/CeaYu0BiMm/rF+nemuHX1i8
 a6/3hFi9so3CF767hlsl4gwCmRATyfdTiPs4sFY7ufiJ+hiYAEZ09As3/nW9HmxyOO3w
 JE/Z1u5Au+LJ8CGZfD72J6shbcA4HbhtHEw5KDMaFJOwr5WFo/HFSl9uVvwEEkA+VlzX
 9J3A==
X-Gm-Message-State: AOJu0Yw7Sui7QFNDz2UwDBQCwXcQ9wMNZ3VEz3a7M37M6UG3+BSxzH22
 PbVE5MuU0OVbKw3LjfC57jjuJt1G5VAQ+x2CiUsRYShukab2/aPw1NKo
X-Gm-Gg: Acq92OE9DNvq078mVY04mrEbqdQ7MnAGPxDdTXBMdBj78ewd8TIGO1hAuSh3YzUl0mh
 XUYMyJcDKdh0UZBJUvMw8U97dlBRaEsgTTL0XO8gmeTbFOZFkJ1Upvl5DDHoDEWx0COvJ0Iboxt
 JKzCX0+5s87PNlqnMkBh/cM6fCvKC/j7Zo7agsDgooDZwHhdvSsNir/kZ1j/5F69O6t1T8wElAk
 wOsw5tbkHKxI74U3+d06Ied1xf06PIAyjztXtnqbmEYf6zhhEnllhZ5JXRczO011xIF1QaS7A22
 11+esSLpPoEjstZRp9m1j8w/03siTCLNdJtnHbaRE/MdlEQtVLewm4crQI0+OtR/M5xqeysgiSi
 Oq91qiKJ4RDHZeZCJ4dcTBMD8HjqjjeTyLkVJR14bYsU6thxgRmYRMWx/WEKAu/zKHFtDDmgED7
 b26xl7+FjjPMvwrinT4uFFriWu2LYYGYaO1NGM2URpbYvSMKAN24qBLPA1SutBEVB0BE70p26LP
 0s94GEhx0ES1bsifcps4W1KrEzsI2EpvSo6TQ==
X-Received: by 2002:a05:6214:459b:b0:8a0:7ce5:2696 with SMTP id
 6a1803df08f44-8d315832acdmr194718666d6.16.1781529475625; 
 Mon, 15 Jun 2026 06:17:55 -0700 (PDT)
Received: from
 runnervm1li68.2tg4hgjfpjju5jbvojso0hkr2f.cx.internal.cloudapp.net
 ([20.161.69.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d30457764esm118395466d6.26.2026.06.15.06.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:17:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Mon, 15 Jun 2026 13:17:54 +0000
Message-ID: <20260615131754.3990-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615111358.73462-1-avinesh.kumar@suse.com>
References: <20260615111358.73462-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_security.sh: Use enforce toggle to trigger SELinux
 measurement
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

Hi Avinesh,

On Mon, 15 Jun 2026 13:13:57 +0200, Avinesh Kumar wrote:
> tst_security.sh: Use enforce toggle to trigger SELinux measurement

Verdict - Reviewed

Pre-existing issue (not introduced by this patch):

tst_disable_selinux() at line 122 uses "cat 0 > $f", which tries
to read a file named "0" rather than writing the value 0 to the
enforce file. This should be "echo 0 > $f".

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
