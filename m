Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A93C3DA42
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 00:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720658575; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=rCh2r6qIj6zGDvovLzHpscA0QquNn87SrtV2FJEb7Y0=;
 b=P8944J3+fkfU/S+ARVFpBVJtq+3LU4yaIKJG3z1YOZN1aC36s/AK/qRPhDPkLr4Tk7SBB
 M66rTgo0UJGZbAp1rlC4UKBzML1QilNimTGNds1sfRPC8oq8SIijySNafT7PMsvS+JF3WXJ
 5cmz6toWR0+61i+Fjyz3kHK20HSGjnQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21F863D388B
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 02:42:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E03D3D0B18
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 02:42:34 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2309602BCD
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 02:42:33 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2c95c80c6f7so319060a91.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720658552; x=1721263352; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TpfzVRJYoEuwIPduWXyNl+KcCXX2TMvR9Ofkpb2GCnQ=;
 b=gnEIHA1MSOuy/Vd2wa/Cd0gtwoX0kGLqUefDdkUbnhBG1Rjdu4WVUUVgQuNX16Ehhr
 2Ii5VJm3JzoXZm+GSMkz4EeK2ItXHUeA9uVIp72GZCYG+c2L/y1bM6k/CvzBSuvkuvNT
 oBmfyKSF4+qfHeCnnluAgmZbvW7kCbpclnwyUe7bFJhMeHjoSRh4nTcoQEr2fg1SOMPE
 MqPZ82OyRJygeQXfjGsSuZ7aui/ormhT0yddwG0zKza3F+NGN/Pw76/PnAR+MJf7KRP7
 rM2Qg0JIwHYjuwQSxxOXIalQv2h2/hSs+yNzOkfmqfAqFh7BvMYH4K2TKSJ9zITjaR3k
 Mpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720658552; x=1721263352;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TpfzVRJYoEuwIPduWXyNl+KcCXX2TMvR9Ofkpb2GCnQ=;
 b=OhXfLq1skXk1jNQp7D0WIa31/KBSxWYAZXf7XJgLvpxBc79JkhGuJR83NBQbYDmnI2
 TuOY6jB9xrxE+2D9Jkmac2ZhFc77C6BpR8E3/gBPecGogi9GZfQ8rjwlXVBRy7Mpwk7/
 VXA+r+KM5mLXH/+WQTc1Zy7nzOjreMI+RGbD+NpRmXByrtM8LxRQp+Y62NbqEaOyAoyi
 IAfffO4K1NgCFEXINTQIxToMt5dnIoJlb0L6ciNIU+xj6d1i5pH9pHD+ePPgghlVLalQ
 O9oUmTv+4soqH4lwafkmjbT4cE0uPuBjpY5IC8bsQb+N/ilR0TnEHAchMdJGZWlpp3y5
 4HEg==
X-Gm-Message-State: AOJu0YxtxToLJ9y2KZmuy/ett9kH/0h/xuRFZXk9t0uTke1iiwcBZJro
 1VHnAkLxhartCODU18gdQPm5URG0GctUuFfdoAJziKmarfFEsNCgB7OXZ1+kFw9bwrQ+f0IpP3K
 fEiT891/YydKnDLpH6GR72NiaoEVFfyTJoIkoMCUb6hALKKtYsh7fIa2AE2nouysLZA6QmB8Cd9
 ywYOSPneRtigJhyEvIRS/0MPTXHo8=
X-Google-Smtp-Source: AGHT+IFttQHcymr/oC7VEVze13VdwMiGBSJc6cJ9ksvRoSB52E6aQlMQCfjvS46DuN0cL/ERRImrBRhzIkQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:f48e:b0:2c9:6d40:9892 with SMTP id
 98e67ed59e1d1-2ca35be21cbmr17859a91.1.1720658551783; Wed, 10 Jul 2024
 17:42:31 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:42:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711004220.1338086-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/syscalls: Add fallback definition for
 memfd_secret on arm
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

memfd_secret is not implemented on 32bit arm, but this change creates a
fallback definition so that it will return -1 and ENOSYS when calling
syscall(__NR_memfd_secret, 0).  This will allow tests such as accept03,
readahead01 and splice07 that use memfd_secret to skip with TCONF

Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
I didn't see a follow-up to
https://lore.kernel.org/ltp/1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp/
so I am submitting this patch based on Cyril's recommendation.

 include/lapi/syscalls/arm.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..82df54819 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -394,4 +394,5 @@ pidfd_getfd (__NR_SYSCALL_BASE+438)
 faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
+memfd_secret (__NR_SYSCALL_BASE+447)
 futex_waitv (__NR_SYSCALL_BASE+449)
--
2.45.2.803.g4e1b14247a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
