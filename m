Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129C2CC6B19
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 06:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791957784; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Myp4a3nWpzMt/Cnqu1/MpGVZsL6bPzkukIauRF1kfFk=;
 b=pdMB75tkiHFhdoi3cJpLmtO/z+/4+E4EdhvAQgYyWrBVBz9Tv6QbbsUjmJFDVyefgkloN
 wNkaAMoDrUlJzXqmXsqnyPUHbkFR1+xnaLHujuLMHTTKR9UxLtbrspegzuWlCbxCQJtn75K
 5TORiL6iPrEDYkwkodnKA/UexOdG4SM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7EA83E6A0D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:03:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D7983E2B2A
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 08:02:45 +0200 (CEST)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com
 [IPv6:2607:f8b0:4864:20::447])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73A671A0098A
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 08:02:39 +0200 (CEST)
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-88d2d26a8d5so3601991b3a.0
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791957758; x=1792562558; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=noVSiq2HPHzMcIhZvhxUJN5GdovmySiW1mP7yEiKoSY=;
 b=MB+Gkcqtmwy63LX6ESNQljPKVCdMMQwc2ENFjNGNLBwRUwbaXBn45UIVllcr6RIcop
 d7/mpnUJmyongy6eqb/Pb8PNureJeapuocZ6/v6PpW/ZfkZbR2cYO8WGPIkVyLqY/TB5
 yGRdasGzDATzur0WfE0rQ0lQDVPRczOw7SD7VQ+2tyV6tuqmhGoZD2zDOy4YCJ5s8fKD
 PNZ4FvTIJEfWVIdBpdeP0DiMByZ+9QYBfyyKaBswIqjYDlhfh4QlfUUNJF3+bEbLVVr8
 jqmkUILWnZUQMi0y21ir3FCR5Eq6FfjaVY6VUoD8qn5f/oqa/YejVkm/ICXe5pXcRYLz
 S1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791957758; x=1792562558;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=noVSiq2HPHzMcIhZvhxUJN5GdovmySiW1mP7yEiKoSY=;
 b=GetE72grM7UjOckN7WBnC8Ew5PjpMaek/z5aQ5SCZvEPYYCxnjs4H8XiNUtaVDgQaa
 jEL2DXrF8R1KYD/QhWCcgin3dezwweehqZt8W/7Xxn/XzC4XqthYm8rOHoF0unJR1Nmv
 1TSCE1WWvFt7phmZg2CsLJsUs3U1iw4ts+mI9JUdKaJIJIUtyBhvzWy6KdsexebRqdbY
 I9hQOvyURDzU2LF/dlz+TSS9apOgg3h4eXmnpNpABJrpEp+78QgySD1JPbPXXz/GZLCE
 ZLmRA/gBJ+lrrKqR7Fao6r82bygrBnlK1r+jcboDOwsnGei9xVbj+iqI8M81LVhvKHBx
 iUEw==
X-Gm-Message-State: AFq9FYI8xzJQIF6yUZ+TNRvhm0L4aluonyOgFKRT49Mq66IRducquwFN
 FMP/HiiZz8k2qu1Qog+OybVy24ezBcYENVr0ahALwUBOdYyowA04BL62aZ3TPaZhWFRaYayWLtn
 57oemstOYzjy+fjTBaNtl+u+ad/847h7UdNCgVu0bXOompcUVHwF/TREjF8vxhOmZaE92pFvklC
 6BiacejjsD1iQiuEeDT6SsZi/L4RUPyzjGYOH83/gP9shZbGY=
X-Received: from pfhp36.prod.google.com ([2002:a05:6a00:a24:b0:880:eb99:bc26])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c83:b0:891:da2a:6757 with SMTP id
 d2e1a72fcca58-8969540372dmr9561988b3a.15.1791957757205; 
 Tue, 13 Oct 2026 23:02:37 -0700 (PDT)
Date: Wed, 14 Oct 2026 06:02:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014060212.1081388-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] process_vm_writev02: Fix stack overflow with large
 buffer size
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
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Both child processes allocate their buffers on the stack. The buffer
size can be set with the -s option. If the size is larger than the
stack limit (8 MB by default), the test crashes.

Allocate the buffers on the heap with SAFE_MALLOC() instead, and free
them after use.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 testcases/kernel/syscalls/cma/process_vm_writev02.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index aaf4c0b18..15bd66a44 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -23,10 +23,11 @@ static int bufsize = 100000;
 
 static void child_alloc_and_verify(int buffsize)
 {
-	char foo[buffsize];
+	char *foo;
 	int i;
 	int err;
 
+	foo = SAFE_MALLOC(buffsize);
 	tst_res(TINFO, "child 0: allocate memory");
 
 	memset(foo, 'a', buffsize);
@@ -43,13 +44,16 @@ static void child_alloc_and_verify(int buffsize)
 		tst_res(TFAIL, "child 0: found %d differences from expected data", err);
 	else
 		tst_res(TPASS, "child 0: read back expected data");
+
+	free(foo);
 }
 
 static void child_write(int buffsize, pid_t pid_alloc)
 {
-	char lp[buffsize];
+	char *lp;
 	struct iovec local, remote;
 
+	lp = SAFE_MALLOC(buffsize);
 	tst_res(TINFO, "child 1: write to the same memory location");
 
 	memset(lp, 'w', buffsize);
@@ -66,6 +70,8 @@ static void child_write(int buffsize, pid_t pid_alloc)
 		tst_brk(TBROK, "process_vm_writev: expected %d bytes but got %ld",
 			buffsize, TST_RET);
 	}
+
+	free(lp);
 }
 
 static void setup(void)
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
