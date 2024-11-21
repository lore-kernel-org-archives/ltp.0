Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A21D690ED
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:51:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F9103DBB6C
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:51:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66AB33CCDAA
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 04:02:05 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7272C62B200
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 04:02:05 +0100 (CET)
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-50d3998923dso193525e0c.2
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 19:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732158124; x=1732762924; darn=lists.linux.it;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5qELBMJH/N5VIHrSBFXgCLOHb9PjbL8juf3vwNKKMvY=;
 b=niv9o7NxL7qBWYLQvecSnyI8CixbZs38uXYmUPtihGx2LLOAXzD3JcNy6ZjNs9Qszk
 Ya5+c5n0x3zQjfknETpHpA9hP2050bphaggPZ3bQPN3UQpKZ9m+G+9R5ORP6k3evXY52
 p/O3Djted8BCGfEhRSliRYU0wPjpVTRLxMGjcV+aDdHz+gjcQQOevqYPGWxUGQg06bXH
 NohX0IYYJjYBD9ZBVsrAUXjbsRvcPXUPAXD+8TkeFm/8DiLbSBKS8jZM7059IVZQsFhh
 hjAWiLBOPYB8ZNKDJ5b2l6OIMAADIrRmR22Zk8u+wG1ZDStggxD5dgB6PBUx39T86bBk
 NiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732158124; x=1732762924;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5qELBMJH/N5VIHrSBFXgCLOHb9PjbL8juf3vwNKKMvY=;
 b=lMje3sDg0lmWrzApoVoaSlHcG8Af79rlb+jxcTIeX2/wq1VcWtmOYvsRrVd0nJyowM
 fGAkWcFVks/gFpDwnb09dBs/AoMo2m0DEZVR4jf1YKxxnaRPcytf0ztvFdQ3WLm+V5PZ
 In4PYzPLEdIrjGr0xU6S9gyhko1tRbi8VBZU4+WO1osTf6rPcEyimxayJmT6V211gRMT
 qj/0ri9s57O98JmlMLHFLDTiuaGtZ8eJ+uuG8rRb6UXHo4IrmPoHzrqmsPbLl5XmkZDH
 s9i7Y27nBvCybfaizB7Q3xJHZtMmITVAtSMq/6ebAFW4EnByrPOuConL0r7JxJzU9mCy
 TtPw==
X-Gm-Message-State: AOJu0YysE9zxkBeXRLMZqMbjesJy7IfRpoBA3zEDxwlDhCtTbT8xiDsw
 OSJkUvVfIK4REBGZ9Ba2g620c3SnWEEHK8D/1dhBRGvEArm1IwbonU7SzibfbTGeN9M+jFZZzEk
 eaURyKKyZ2GYyg3xCYELjH6phPrFNHhBRYHVWf1Io7Lc=
X-Google-Smtp-Source: AGHT+IGT2Ur7EEDNJkB6HLCZcxcAMikCtejggc6V2fFW0O5RTA/0kBkK/bv3xHTl55SuAMInYw1CkTw9RfxegvbOdeE=
X-Received: by 2002:a05:6122:2025:b0:507:81f0:f952 with SMTP id
 71dfb90a1353d-514cf95f123mr5663991e0c.9.1732158123566; Wed, 20 Nov 2024
 19:02:03 -0800 (PST)
MIME-Version: 1.0
References: <eb40aae4-1b25-43a7-a592-cf03690edeb8.jinguojie.jgj@alibaba-inc.com>
In-Reply-To: <eb40aae4-1b25-43a7-a592-cf03690edeb8.jinguojie.jgj@alibaba-inc.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Thu, 21 Nov 2024 11:01:52 +0800
Message-ID: <CA+B+MYSAN9kYUvmRF7ooox3koJjFf+6o73kfEWZ9oiYU2eLDjA@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
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
