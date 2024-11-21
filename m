Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3C4D75BA3
	for <ltp@archiver.kernel.org>; Thu, 21 Nov 2024 03:06:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E50733D93FD
	for <ltp@archiver.kernel.org>; Thu, 21 Nov 2024 04:06:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30F223D93E5
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 04:06:04 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 836521000EB7
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 04:06:03 +0100 (CET)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-514d560507cso197322e0c.0
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 19:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732158362; x=1732763162; darn=lists.linux.it;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5qELBMJH/N5VIHrSBFXgCLOHb9PjbL8juf3vwNKKMvY=;
 b=bcnMsiQZFY3IYjU5t1fPhR1998vqchIRBGDmjFxCHEs/ahH5b9O3DFadJbMFHLxbNI
 Jfz6BxMT0kVsUNtTtQuyF5q9ZclYlrEqasDLSFXOVwfpUE/DFr6EdVX9+4GfTEwNGUJh
 ZinS3QVJbFm4WaWe6Bcc98co6IyiGpHPABIUGKc81uuFmjpDgFwVGeUPqE4zBbziuHIs
 xB8qm+NbTOdp9Wmk/G6YhJ/fSE1CtOTkCEODm//dPhh5wWzhkCono9g/6At4Oh6Mphlv
 uY2UbmmGA5ayCvDvXKdkMnTCVQFFAFK+JFNInihhYvmoIhXTbK2bD6GATt53h5REoRup
 YzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732158362; x=1732763162;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5qELBMJH/N5VIHrSBFXgCLOHb9PjbL8juf3vwNKKMvY=;
 b=WlFoX12KxeEdv6lP7rv2GwUFGnGuMCs9HR1adr64kuMd7kE+3dWNZx3F/4WqBrnz8C
 HyaYs7AdW0KYQUb/GuvBzNpVog3NUe4aIwtTabuZ8SyNhINBnihlFH58fZQJXTJ+NeQG
 XPYdln+Q/rYGeU+TxTJUzATDTKOUx61ZaBjDPzCF10ERFTlFrqiUKKD4kQjSTxjYP/Bx
 vW2uhSmTBUJf4iiaehNUXXyQKm7dDDHGdLbpr54Mt4A64uhabTCr6cPDbBAdVX9duM0y
 5pmf+Imj7GsUgvagcieNDL/dgiHa4sr8r8hEAoP9zRfU6llwDSXf6C9a7Kx6FSCPuI03
 yi9g==
X-Gm-Message-State: AOJu0YxU5b9l+lT9nu8xmXDppxlxR4y8zlnNt7CdUa3uKMNa/fiJwIao
 k19mPyHKKyHpYXcMJFggqG84GwW6f1JCzBxWiLv6j6ej7GkZVj8MLTB/7tk2ByGYu5x43w3tXuQ
 q5OGYHFZJ74U4wN48y8fEHBLD6d0YCMREGvC0mTKTGI0=
X-Google-Smtp-Source: AGHT+IFmYrOib3hcl1J0I2xp0ZhuyRMr4Sn8xsn6ZOiTv/Nx8ELx4QMD629KEYiFIQrrSr4/hPRD4NlpD4JwwbSuRVc=
X-Received: by 2002:a05:6122:1d07:b0:50d:354a:19ae with SMTP id
 71dfb90a1353d-514cfb88abcmr5793359e0c.10.1732158361947; Wed, 20 Nov 2024
 19:06:01 -0800 (PST)
MIME-Version: 1.0
References: <eb40aae4-1b25-43a7-a592-cf03690edeb8.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSAN9kYUvmRF7ooox3koJjFf+6o73kfEWZ9oiYU2eLDjA@mail.gmail.com>
In-Reply-To: <CA+B+MYSAN9kYUvmRF7ooox3koJjFf+6o73kfEWZ9oiYU2eLDjA@mail.gmail.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Thu, 21 Nov 2024 11:05:50 +0800
Message-ID: <CA+B+MYQPoqtKrnTiVsqyJEvo1_=r3-EJqCQT+RxqfaSG0xXgYw@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg/memcontrol04: Fix the judgment error in
 test_memcg_low()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When running memcontrol04, TFAIL results will appear on various Linux
distributions, kernel versions, and CPUs:

(1) Test platform

* Linux distribution: Ubuntu 24.10
* CPU: X86_64, Arm64
* Kernel: 6.6 longterm
* glibc:  2.40
* LTP version:  commit ec4161186e5, Oct 24 12:18:17 2024

(2) Error logs

During the operation of memcontrol04, file systems such as ext2, ext3,
ext4, xfs, ntfs, and vfat will be tested.
For any of the file system, the same TFAIL result will appear:

root@vm:~/ltp/testcases/kernel/controllers/memcg# ./memcontrol04

tst_test.c:1823: TINFO: === Testing on ext2 ===
memcontrol04.c:208: TPASS: Expect: (C oom events=0) == 0
memcontrol04.c:211: TPASS: Expect: (C low events=437) > 0
memcontrol04.c:208: TPASS: Expect: (D oom events=0) == 0
memcontrol04.c:211: TPASS: Expect: (D low events=437) > 0
memcontrol04.c:208: TPASS: Expect: (E oom events=0) == 0
memcontrol04.c:214: TPASS: Expect: (E low events=0) == 0
memcontrol04.c:208: TPASS: Expect: (F oom events=0) == 0
memcontrol04.c:214: TFAIL: Expect: (F low events=412) == 0

tst_test.c:1823: TINFO: === Testing on ext3 ===
memcontrol04.c:208: TPASS: Expect: (C oom events=0) == 0
memcontrol04.c:211: TPASS: Expect: (C low events=437) > 0
memcontrol04.c:208: TPASS: Expect: (D oom events=0) == 0
memcontrol04.c:211: TPASS: Expect: (D low events=437) > 0
memcontrol04.c:208: TPASS: Expect: (E oom events=0) == 0
memcontrol04.c:214: TPASS: Expect: (E low events=0) == 0
memcontrol04.c:208: TPASS: Expect: (F oom events=0) == 0
memcontrol04.c:214: TFAIL: Expect: (F low events=411) == 0

......

Summary:
passed   55
failed   5
broken   0
skipped  0
warnings 0

It looks like there is an error in the processing logic of cgroup F.

(3) Cause analysis

In the test_memcg_low() function, 4 subgroups (C, D, E, F) are created under B,
and 50MB pagecache is allocated in C, D, and F. Therefore, when checking whether
it is successful at the end, only E should be judged to have low_events==0,
and the judgment conditions for all other subgroups should be low_events > 0.

(4) Fix issure

#1209
https://github.com/linux-test-project/ltp/issues/1209

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>

---
 testcases/kernel/controllers/memcg/memcontrol04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c
b/testcases/kernel/controllers/memcg/memcontrol04.c
index 1b8d115f8..0dddb7449 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -207,7 +207,7 @@ static void test_memcg_low(void)

                TST_EXP_EXPR(oom == 0, "(%c oom events=%ld) == 0", id, oom);

-               if (i < E) {
+               if (i != E) {
                        TST_EXP_EXPR(low > 0,
                                     "(%c low events=%ld) > 0", id, low);
                } else {
--
2.45.2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
