Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F4DC25B77
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716382106; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=HLRoiCo+VdDyk/JVXgrwT1f7ZsHpV8qHVqa0FEZ1qDk=;
 b=QaiFbNu1qxr5jpQxL1Eeg9tWxAhMVWXx5/XuRzNlbu6oJQOYbgm5kjlOUduW/xznLCEN3
 2kGYSkx6bnEjs5CFMsFtbtvkXCNpwNvj2w+X+WoqZe6TQutQv0b4jaKiZbRlIzUo3VLEznl
 y3hv3mSKK0pe55Fu0iuooqgjjidd55I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BEFF3CB704
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 14:48:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833EE3CB704
 for <ltp@lists.linux.it>; Wed, 22 May 2024 14:48:04 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70150602BD1
 for <ltp@lists.linux.it>; Wed, 22 May 2024 14:48:03 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-578338936cbso1108194a12.0
 for <ltp@lists.linux.it>; Wed, 22 May 2024 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716382082; x=1716986882; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B4WR1yHqr7DAliJlEVEEFhR9hdnYOfADpNyjzlMGjtE=;
 b=fM8ys5tDKZK45f6Jl7crKqrtZ7Jbnsfc9gk/AcL8KZpT/nnfTzcHyAsMkQdqfER38s
 Gk5RjuCpApWk0tTbQboGb1dmRDry3FX7rjr3DKFVQB9jY3YurNxyyiRscVfzHUMTjLgr
 DCMaBDd5rCagKRq/udl3s35xBtzEsvxpke9eF4ud2ezCF4/hCGv7d+r140OrwZI0gy4h
 7qYDMGqWnQSNUEo1lWVE2O6DDwTj464UeIBDgPfB+wL0hpFhuDtxmgZ5gr2XQgfrxJo6
 ka9A90uxjMrW9YIS2Cdu6kPklOmG1G5J0TscgTkzFMwkGdHdqO9B1xP1J59L99fYkQnk
 vIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716382082; x=1716986882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B4WR1yHqr7DAliJlEVEEFhR9hdnYOfADpNyjzlMGjtE=;
 b=T+yLJMFXnj9aoMNtXVEbeYemuwp7MFfgNfmRiPz+lc/Ks0G1Xv30gadQ+WIBX/LFHG
 NsTUmRkDE4RJD/z65hXCNw8EuSMRXtGsi0XPUJoPLXxyxhvUtJ5GOQXJEU9K6hHFpLLY
 mfs+9OS89YISdQUQDhGQ79yPyqYJOfVPEWf0VoaIT8yQrmDN+mv05/8fS3nUsm6wIzYJ
 G6Z/1LqJheDO86e0DYjFmDo3GC2N+24VlM1swi1RqKe7S7tTKRLTbXa6ZswIGHunRlXD
 me8F3NyUkP71Gg3+6HrDF9sAJQ+XI1lyIsMHqvjdpsZFEnMpM2L1Wo6FWdxYstrgdWb9
 0l2w==
X-Gm-Message-State: AOJu0YwIoBSnjanCxb67QPrahSKdtHoQW/hFGcU+gQeFo2U8Ry6WLgsF
 b2PruGGt1+4WxfCXqRRhyM84F5CuDxcAH8VUJP0SGlRwf7tKsg3CD0+24pI5cECoe0KLaftBvtY
 =
X-Google-Smtp-Source: AGHT+IEEEPCQxbdcAaMuN44HATh3byZTWge/b555vMejOc8eTqjLNDAkmK2Yu6yeuo6ysOoseRRz+g==
X-Received: by 2002:a17:906:3791:b0:a5c:dce0:9f4e with SMTP id
 a640c23a62f3a-a5d5ecdc434mr1090815766b.28.1716382082199; 
 Wed, 22 May 2024 05:48:02 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d87sm1777378566b.104.2024.05.22.05.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 05:48:01 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 22 May 2024 08:47:54 -0400
Message-Id: <20240522124754.9599-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] msync04: Check disk content if dirty bit check
 failed
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

msync04 test is inherently racy and nothing guarantees that the page
is not written out before get_dirty_page() manages to read the page state.
Hence the test should be reworked to verify the page contents is on disk
when it finds dirty bit isn't set anymore...

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/msync/msync04.c | 34 ++++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 72ddc27a4..c296c8b20 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -46,6 +46,7 @@ uint64_t get_dirty_bit(void *data)
 static void test_msync(void)
 {
 	uint64_t dirty;
+	char buffer[20];
 
 	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
 		0644);
@@ -56,20 +57,27 @@ static void test_msync(void)
 	mmaped_area[8] = 'B';
 	dirty = get_dirty_bit(mmaped_area);
 	if (!dirty) {
-		tst_res(TFAIL, "Expected dirty bit to be set after writing to"
-				" mmap()-ed area");
-		goto clean;
-	}
-	if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
-		tst_res(TFAIL | TERRNO, "msync() failed");
-		goto clean;
+		tst_res(TINFO, "Not see dirty bit so we check content of file instead");
+		test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY);
+		SAFE_READ(0, test_fd, buffer, 9);
+		if (buffer[8] == 'B')
+			tst_res(TCONF, "write file ok but msync couldn't be tested"
+				" because the storage was written to too quickly");
+		else
+			tst_res(TFAIL, "write file failed");
+	} else {
+		if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
+			tst_res(TFAIL | TERRNO, "msync() failed");
+			goto clean;
+		}
+		dirty = get_dirty_bit(mmaped_area);
+		if (dirty)
+			tst_res(TFAIL, "msync() failed to write dirty page despite"
+					" succeeding");
+		else
+			tst_res(TPASS, "msync() working correctly");
+
 	}
-	dirty = get_dirty_bit(mmaped_area);
-	if (dirty)
-		tst_res(TFAIL, "msync() failed to write dirty page despite"
-				" succeeding");
-	else
-		tst_res(TPASS, "msync() working correctly");
 
 clean:
 	SAFE_MUNMAP(mmaped_area, pagesize);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
