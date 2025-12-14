Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B76AD78771
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766151428; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=2uX0IWI893yBu9KnXfLy9ueLFLGeywBYWEz4BrqXvlg=;
 b=OYzy7M16a58Sp6/atruAiPALxa6bdD1csRFWoU2aAQLmZsTIH2HqGVF3jTj59zOBLswK3
 5RITFRLfQeUCzYjIgGhezStapNqTpTiivlPB11TzAyKUMz9f0NdQTyXTtnmwjSPp82dIssV
 BrXraSOZvm06K0hIK2ycDfWVAMt9lHc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 840073D0525
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:37:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2913C0F89
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 07:06:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16236600481
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 07:06:52 +0100 (CET)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 88DCB3F1D4
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 06:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765692408;
 bh=fIcGqfeXEPfoTtJ54VMgfUHcSs1U8EU2i1av6jfhOCs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fsGVXwNvlhzlfFHEcFqsXjZDlqSHZjAJOwpFwZU4Sm+j+VtzgQY96n08/cAFUL0+G
 UcsCfAqAUoa8Ns0qcDLIuE8BzSQjV4trmkGnYuh8vJD7qNLlDsqB4ltyijSn4eUSyL
 1I3YftJtKVoORFIX08AJgk/W0sGBiwWrxG/cCjP7hB6w7hIeQYVcxBgf74DhsBiZ4n
 FpvdBCDGt6ZjI1Dlfbddnjt0y5A/EGXtnPPFxl3eVIR2/ohzLcWtnLNDMuk7KGKVcn
 LxHkgc1wMgCc9Y73xhr4BbKihhduKL6v6t/hkAs7QilT/Ohfpxrqu53dX5s7tfjMNa
 dyszajiunve4KTkxo7mJzLsH0VuGYZ3vFGWcqNupEd5Ufhved+exBfcO68VtGw7bsY
 PA6uusJ4PeeapTmj4K5sPAW/Nza+T8NA++Y1nuWgoj1Zny3R47Pqn292qXmXLajPE3
 fhjSbTP2qrlfoufigAjHPRk4inKFanPqWXet37MBe7J98se7+l07P9oZES/8Z4T595
 IaOvcvXqFzIeMtZwaU8LHdJ97kwuVLGNUkIZmrmH/IjsFTIzU1vzTqp78zwzUIc8TM
 9+0fGr/+cm3gG1O21HkFgGlqDMTbbQOdQiFv706x5SnGVUtOTZ23100TVtK5fARG3/
 qs0e7eDWYeNEIBOSd5FS14IQ=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b80de683efso4039661b3a.3
 for <ltp@lists.linux.it>; Sat, 13 Dec 2025 22:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765692407; x=1766297207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIcGqfeXEPfoTtJ54VMgfUHcSs1U8EU2i1av6jfhOCs=;
 b=OWY5vWrIuTFvNjWrAj+6LGENTACOHIxxWlxbjDRgiggayuNdhxAYUmL6A1lMxuoDwA
 7uKFlfJUEkU2gzjLetQ78Dvi+iyFvUiyV419CFZxuDhUeP2kMLJ4ylQ2bCywC+d39yMO
 7j6XvFHnnJE6Osk/GSr3V4KkFRyRI3wHsyv/GYnDb4F/FsokvXz4dr8hI4PBrsdMU15z
 ZCbDrYaNb3oJkWDSXtnPOCuH4JCtAXn2ots9VMcauxEXTkpQP8jDV5hiBISA7+ZgKhXW
 hsQ9rlEUZDxhC1DK6Edqjv2lZRKHN/yM+4zq1Lwe0Q3pbcoSc2Fn/DlJ5wOAN1+kCLFB
 E2XQ==
X-Gm-Message-State: AOJu0Yz6t998qMwLqPfI3viMe5ZIKnSxozWJYMQjgZeH4/bluB96Gzj/
 Sz1OPppqNJx9mBC4w9DgpMy57CbuvmzjH3WxwywWX/Afxj1c911bhvURKxLbK8VvE5gzc1AODiI
 H/UfPfGKU4hCpFtn2bc/UE3boJNiqyXNzKFw00VMPOzVfdmLyXp4j3pxNwOtPTp31Se4Guif4M3
 iq1gE=
X-Gm-Gg: AY/fxX6QI8cmYu/wd5W2DeQD9Vbx0iz/y6GvUdIwzsNtGHInltwUFsAYRg9Ye4Dhx7G
 6LGcNmYZvUKySOPMQL6N3Pd/5EK2sdf5oMw4KjevCJR1kCPFYL45ujLpxnfUwx9HaipPHmh3Jsu
 A3psfAlU2JXCJM4HosBDz9jRSwwm+uoeMrmr4EqU+gVYZSGa/nR5wjE00F1a9qbFnJE+4LbbDBb
 2n0mmXqBuj8/kh5PhcDE/CGJAceTkWHKYRcMkWlQtqnQQ3A0bxKD5bxAiz2UzWdgVHMSZQ5X9cN
 ngTi4YImDOpowhOLrpI0SqfpTrOjVrmd5o9pij4w33HHE7q7HsVg4SJDKqL37jnvKPtmUT4EARB
 AZddQU4mE2etn30/dsIWqX47cv5ZGS+E=
X-Received: by 2002:a05:6a20:1584:b0:351:2c6e:6246 with SMTP id
 adf61e73a8af0-369b7089f9bmr6457842637.56.1765692406780; 
 Sat, 13 Dec 2025 22:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAO925YmefyZng84Pm5ZOkqUFC4WeVcxNDEvS+W4IdVpCc/rWmzt960iqhq8dIvdv1Xkp1iw==
X-Received: by 2002:a05:6a20:1584:b0:351:2c6e:6246 with SMTP id
 adf61e73a8af0-369b7089f9bmr6457828637.56.1765692406371; 
 Sat, 13 Dec 2025 22:06:46 -0800 (PST)
Received: from localhost.localdomain ([123.208.221.96])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0ec080cce0sm6100875a12.12.2025.12.13.22.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Dec 2025 22:06:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun, 14 Dec 2025 17:06:40 +1100
Message-ID: <20251214060640.41555-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 19 Dec 2025 14:36:46 +0100
Subject: [LTP] [PATCH] splice07: require kernel version 5.10
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
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: changwei.zou@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Linux kernel 5.9, the splice07 test fails as follows:

  Running tests.......
  tst_fd.c:260: TCONF: Skipping memfd secret: ENOSYS (38)
  splice07.c:64: TINFO: directory -> ...
  splice07.c:56: TPASS: splice() on directory -> file : EINVAL (22)
  splice07.c:56: TPASS: splice() on directory -> O_PATH file : EBADF (9)
  splice07.c:56: TPASS: splice() on directory -> directory : EBADF (9)
  splice07.c:56: TPASS: splice() on directory -> /dev/zero : EBADF (9)
  splice07.c:56: TPASS: splice() on directory -> /proc/self/maps : EBADF (9)
  splice07.c:56: TPASS: splice() on directory -> pipe read end : EBADF (9)
  splice07.c:56: TFAIL: splice() on directory -> pipe write end expected EBADF, EINVAL: EISDIR (21)
  ...
  splice07.c:64: TINFO: pipe read end -> ...
  splice07.c:56: TPASS: splice() on pipe read end -> O_PATH file : EBADF (9)
  splice07.c:56: TPASS: splice() on pipe read end -> directory : EBADF (9)
  splice07.c:56: TPASS: splice() on pipe read end -> /dev/zero : EBADF (9)
  splice07.c:56: TPASS: splice() on pipe read end -> /proc/self/maps : EBADF (9)
  splice07.c:56: TPASS: splice() on pipe read end -> pipe read end : EBADF (9)
  Test timeouted, sending SIGKILL!
  tst_test.c:1918: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  tst_test.c:1920: TBROK: Test killed! (timeout?)

  Summary:
  passed   121
  failed   1
  broken   1
  skipped  5
  warnings 0
  INFO: ltp-pan reported some tests FAIL
  LTP Version: 20250930-60-gb446dd4ed

This test passes on kernel versions 5.10 and later.

Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
---
 testcases/kernel/syscalls/splice/splice07.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index c750a14bf..10206514f 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -69,4 +69,5 @@ static void verify_splice(void)
 
 static struct tst_test test = {
 	.test_all = verify_splice,
+	.min_kver = "5.10",
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
