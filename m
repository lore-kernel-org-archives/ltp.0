Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF8FA0C28
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 04:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776228435; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=fcFotkDr7j11UfPxg5HAbEbQdrmGedT+arTDA+m1rh8=;
 b=XLxqEAsWjprC/FEgn0G4R1nYvUBchWTPO+WjvCiAxbiMsW7zYaqMl7yv8WQLLvAR4cLdN
 VmyV1ndv8ePOvRFcC9abo56cVoByePYneVKJKvGfxTVxDbXf6OdasDmpzxLoIMgJgJLQu4d
 Ao65IHB69R5vc++RLLy7xXcj3s/yewA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C95E3E1685
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 06:47:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9C203E148A
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 06:46:48 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 69635600043
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 06:46:48 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so2734001f8f.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776228407; x=1776833207; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fiKARQmPy7P6rcF42a1gBE71XHmkOzemAUiAV/wEVMs=;
 b=YyENI6yXnyIg3k3GnU9Rh1WeFgjHYPy2yUArz+GzyOzhmb5FtuC6DyW0Ol2ioNqga/
 f6DCXhvqUCQz+nxnkNC4/6gihk+UGj8AKMLVnjgFv0wIjjMkcv0CPdSsLF5Flrdt9LB1
 tx5dkyWZypPQgB+G8xvWpHdMXdsOC6YlvTGXsjyTtyVvuT9nA8ZkUSTPxhu8QifITA9E
 edl0Hul/Z9D2miXokErRl254uC32WOzC0eOJtDPPOkfA5pwxTrTC9pKWX34yg0CtT+BD
 p4+J29kbIEagVgLnib0mP/9jcM+f1P5P+rI1pqC3cuIZyU8iRNjuJ+KvuXn6MYdDunOx
 isOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776228407; x=1776833207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiKARQmPy7P6rcF42a1gBE71XHmkOzemAUiAV/wEVMs=;
 b=JJStum/Z0+ti6lM5vRb2s3Uil2pz/7MwSZSXvVHBshc74aoIOp/0FrjGIYUl2+PTLj
 alq1e7rSjwIadcgax77cCjMJSYfKXTvdxV6HBqC7494ngjwoP5YyiV9Eeq+ZXNj506Fv
 cvAn3BfVwEWc58hIDInN6Sx1BhbiMXd0+W5kSOVm0jtgq28myCuSElvpoZnLB5aEJu/L
 /dXRj1VkJf4KnmDLoWx9DQi2lOs6O18a3tsro8aFI67CTX4xLknHUYuWdkCtwyiWbt5O
 /B9uDQvEb1O1YyOKGnuwsLp/EKoG0TEzg4X4SAg5yDrrNZwHcE5FQCgAa0Cp5+kmg6/H
 gkJA==
X-Gm-Message-State: AOJu0YzREJ1msdUKh2bToBCHvmyGs4lIT80ravYw60zKgV4J1Iqn1SCF
 0GyTOjzUc5f6gwy3B8zuftLTdBq/ZTwkdITwCQgaV8h8eggtRzCXBclxKshfs7+0xWj0BsBuh/s
 OqfZzkp4=
X-Gm-Gg: AeBDiet09Z4a2TSHeQKS3eSWdU8hDUWqS5wpOzmc7s08x9lha75BGc86N8+uErsKzr0
 oQfmNZt3j3C91G41pWjwdi1fZCVKvnBdaEjZFVb++scnJ9ZXhtufhMJxXYizbrs8jJZaJ6s2V55
 JadPVvlMO74830T/xEJy40uI/35g+5FP1A85MfikzEWejFH9USe68/js/bgk2TogH57j0MnZ8jH
 1QqeIadMDc0uO8gTF2q5a6UUwneFyimBWcH4p0RZ3nTlILVgTLF+JW6c/6dbOy3CsVnw01jcVkL
 nBx6VTJwRXDFcI78xAmw7yMCIBAoaoi8O9aL4vMUe3jp1NLJrbAvzM74uE1+oMd7b3mnoMiWJVZ
 vowT0aQrtqRs204mqw3LJaXvvTqI/8iT6DzZ8z/26XEVMWqS1ozqUBIEr0jb3vXhnV0MwWDiBG2
 dvX0vPFFts6R1Hfyk10XZ5ZIwfgyZR
X-Received: by 2002:a05:6000:24c3:b0:43d:77a8:3bb6 with SMTP id
 ffacd0b85a97d-43d77a83df5mr16050485f8f.47.1776228407310; 
 Tue, 14 Apr 2026 21:46:47 -0700 (PDT)
Received: from localhost ([2401:4900:891c:489f:72d7:98bb:9ebc:a99e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d665sm1725484f8f.7.2026.04.14.21.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 21:46:46 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 06:46:36 +0200
Message-ID: <20260415044641.97806-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima_kexec.sh: Use %s in printf to prevent evaluating
 cmdline backslashes
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systemd-boot systems, the kernel command line contains EFI paths
with backslashes (e.g., `initrd=\opensuse...\6.19...`).

Writing this to a file using `printf "$cmdline"` inadvertently evaluates
these backslashes as escape sequences, corrupting the expected digest
and causing a false test failure:

  + printf 'initrd=\opensuse-tumbleweed\6.19.11-1-default\initrd-...'
  + cat -v file1
  initrd=\opensuse-tumbleweed^F.19.11-1-default\initrd-...

  ima_kexec 1 TINFO: testing kexec -s -l /boot/Image-6.19.11-1-default --reuse-cmdline
  ima_kexec 1 TFAIL: unable to find a correct measurement

Fix this by using `printf "%s" "$cmdline"` to ensure the command line
is treated as literal data.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 4732df653..bbc82f30c 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -24,7 +24,7 @@ measure()
 	local cmdline="$1"
 	local algorithm digest expected_digest found
 
-	printf "$cmdline" > file1
+	printf "%s" "$cmdline" > file1
 	grep "kexec-cmdline" $ASCII_MEASUREMENTS > file2
 
 	while read found
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
