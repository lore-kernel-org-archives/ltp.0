Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56493F9D0CD
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 12:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9603E2E6F
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 14:44:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCF953C888C
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 14:44:21 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E2E86005D1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 14:44:21 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50d6b9bca48so72762241cf.2
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776170660; x=1776775460; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3UYbWxecNEkIaP97HhHlyUQTBXvpCwmavPESsrI5rc=;
 b=NaT4twjiWXg/TxG4y4GKdxrbL1Zqxn1Sw1UzegJCn8oSaTswd83bXz6Vhq2LCZqoE4
 UW16pJUqXzpYzI50A6RohORo4kF+uw854VIRgKAonYAacXdMX28SyzjA/vzghc0lpwXo
 W7QTLUsmdnV40+5RnR4hk6uJOdETW78FD4+Aw4GfuqGZbS6mx5a91y3QDaehrAjJ0x/o
 tAUACEZM4imlvCGM1CSa1OYWmup6OsgEUfoYpxYkHmkQv3cmRuBE/IFir9ywpgVR8ptc
 iLgQuANF89C9qoYqELvjfsEEjMf7RZ0cQbI5zB1EyDD2bhrzB08fj3sWLs3iMvMPdc32
 AIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776170660; x=1776775460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3UYbWxecNEkIaP97HhHlyUQTBXvpCwmavPESsrI5rc=;
 b=MVlXVH2fzaGINLaKIAQiOsCQcsKA+9WDRK+1a6uTdk9pv9/VWtppIVOhDfh19h+sLc
 ZkVqPATWpGqu6SWREUFLanbrORz6OhVcNawr48KTvK6riNwzjoJLqw7pPlX7BM0QaAib
 11BZir385ftKxXOSp8IMdhLhMdOOtinU4xMDRqglM5wH6yKIsXjEz8rzAIwLnd7aWZXM
 b3DMnx3QyuO6Vp5KJtwvEJxiSpb0+mhUmikVhiM8LJTosMvdWKYYiNRluIASUAAlI8ml
 qeR7M5xZEnbrnn+nvfU+8Q5wAMbUQSNjolIriKspLxevA5C+rQTxWmjaD8Od+7zuaKU2
 LQcQ==
X-Gm-Message-State: AOJu0YxfCVbp/pkb6K4d3dSb2Vkj1s2SguN39smmLF1Rtmyk7qtL9Cou
 teS/vSSfuWovOwrM1121f5HxaU6DzD02TuadsTfQt/VOutFXn2lJPTbSHQ8nqMYw+hmSNMpV
X-Gm-Gg: AeBDiesMrnznpDuXEv/NQf4SUFRp4xPJfXjSN6HTrnzNPN0/5Yx/68+2Dq7mC5qk+uJ
 3TfegHQYolDGV/WQv2k4zaq6JhWyyuLYUGaPud6bJ01LOOL/y25A7nN/cC/XY/mbZEyo1MBAoc0
 sh8Ys1i3XW/WrbmjLTZJiz4oU9bRTlZdCvOPvzTZIQb3B0Z7vpjTATOvp09RBCvqO8EFfXQqc9b
 EVU/WXWTalPT4tVCDqrg4K+ff0CChLGHu9KRpuG4fSuNiNrSpG7EhaJOEhP0wVn//+aZmPeQe4M
 +yMod0L7SkGPukyVbPfoAGea05IYVAY4sNB3HwarSz1j3nEqS5KBsQBmWIubwkK445L1DAQinej
 bcD52dsvGyL02cwNUXQvWd2cRmeI4s7pJMj0aVDNcDNA2M7P5fRs6woxbV/2Kp/qcpHl7z5WRkV
 /mmaZP+scOl6mkOHuZkJIt1swfff8BRU0uKOv/OKWbcIpFRgcvLu/8FoIXSPFY6phEaE1+1b6Ii
 YddzdXWtFvARGKNspNVfA4junY=
X-Received: by 2002:a05:622a:8d0f:b0:509:39b5:a97f with SMTP id
 d75a77b69052e-50dd5cc125dmr227358141cf.29.1776170660199; 
 Tue, 14 Apr 2026 05:44:20 -0700 (PDT)
Received: from
 runnervm35a4x.cjvt5eu2u5teznjqene1d4z5dg.ex.internal.cloudapp.net
 ([172.183.133.245]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50de3a7faecsm82997461cf.16.2026.04.14.05.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 05:44:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Cermak <mcermak@redhat.com>
Date: Tue, 14 Apr 2026 12:44:18 +0000
Message-ID: <20260414124418.3792-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
References: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Avoid syscall param ioctl(generic) points to
 uninitialised byte(s)
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

our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

On Wed, 20 Jan 2038, Martin Cermak wrote:
> Avoid syscall param ioctl(generic) points to uninitialised byte(s)

The subject is a raw Valgrind diagnostic string, not a commit subject.
Name the component and the fix, e.g.:
  userfaultfd01: initialize uffdio_register to avoid uninitialized bytes

> lib/tst_clocks.c: fix uninitialized memory in run()  Reproducible
>                   using userfaultfd01.

The file named here (lib/tst_clocks.c) is not the file changed by this
patch; the actual change is in
testcases/kernel/syscalls/userfaultfd/userfaultfd01.c. Please correct
this and explain why uffdio_register was uninitialized (the ioctls field
is not set before UFFDIO_REGISTER is called).

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
