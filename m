Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB71CC433FE
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 11:06:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 208893C9800
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 12:06:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B00B63C94C1
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 12:06:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DF151A00819
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 12:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643627201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3FdJTbgW1vdF7MMCR60b3rfOwJYQfqMLRZ0K7J8cWrw=;
 b=aNZLFUWn06nXTZvEaG8PYeinhCnm44y2dItdcLoiQs1p6QWU2QtsEkDb2hF8fIXKNuAj9e
 rA5bEh+gMAN9+ewHaUq8TN40/gx5FoBGCpetmA5Ob6GLhv4F+NzfWXpcOhwJhgLOMei0/b
 GSXKlGNfmHPeMZX6z4dEyNsP/WJS9aQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-UU13LTumPASpL10SB_IRSw-1; Mon, 31 Jan 2022 06:06:40 -0500
X-MC-Unique: UU13LTumPASpL10SB_IRSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7489E1923B82
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 11:06:39 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8AC87AB74
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 11:06:38 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 31 Jan 2022 12:06:33 +0100
Message-Id: <0e15e1df7251384368ae363cc4f19528d0e77a39.1643627166.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pread02: extend buffer to avoid glibc
 overflow detection
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

Test started failing with recent glibc (glibc-2.34.9000-38.fc36),
which detects that buffer in pread is potentially too small:
  tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
  *** buffer overflow detected ***: terminated
  tst_test.c:1484: TBROK: Test killed by SIGIOT/SIGABRT!

(gdb) bt
  #0  __pthread_kill_implementation at pthread_kill.c:44
  #1  0x00007ffff7e46f73 in __pthread_kill_internal at pthread_kill.c:78
  #2  0x00007ffff7df6a36 in __GI_raise at ../sysdeps/posix/raise.c:26
  #3  0x00007ffff7de082f in __GI_abort () at abort.c:79
  #4  0x00007ffff7e3b01e in __libc_message at ../sysdeps/posix/libc_fatal.c:155
  #5  0x00007ffff7ed945a in __GI___fortify_fail at fortify_fail.c:26
  #6  0x00007ffff7ed7dc6 in __GI___chk_fail () at chk_fail.c:28
  #7  0x00007ffff7ed8214 in __pread_chk at pread_chk.c:26
  #8  0x0000000000404d1a in pread at /usr/include/bits/unistd.h:74
  #9  verify_pread (n=<optimized out>) at pread02.c:44
  #10 0x000000000040dc19 in run_tests () at tst_test.c:1246
  #11 testrun () at tst_test.c:1331
  #12 fork_testrun () at tst_test.c:1462
  #13 0x000000000040e9a1 in tst_run_tcases
  #14 0x0000000000404bde in main

Extend it to number of bytes we are trying to read from fd.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/pread/pread02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index de2a81fffc37..fda5fd19037c 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -39,7 +39,7 @@ struct test_case_t {
 static void verify_pread(unsigned int n)
 {
 	struct test_case_t *tc = &tcases[n];
-	char buf;
+	char buf[K1];
 
 	TST_EXP_FAIL2(pread(*tc->fd, &buf, tc->nb, tc->offst), tc->exp_errno,
 		"pread(%d, %zu, %ld) %s", *tc->fd, tc->nb, tc->offst, tc->desc);
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
