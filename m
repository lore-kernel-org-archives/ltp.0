Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B124CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:16:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3D73CD43B
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:16:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3E113C888A
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:15:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E81C9140004A
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:15:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3C1521846;
 Thu, 12 Oct 2023 09:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697102151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oc88qmdO0WHpAjdNiirBhAHqzFcWoL4szj+zDpe742o=;
 b=dOalQD+K3m9yOmqmh1/z9vPniw94nG1c5mWEGId/uP01p6WQRa3g33rDZoX96RnyrKyOb4
 ZBX1XHfVTQqMN7vOkZsVuCDh7XJqsWOqymG/7+llNbxqr4HHyojlTOkGgirOaMEyg0qNYG
 eZc3wLAuzzBbSUtbhyEZJMV/fDOy7Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697102151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oc88qmdO0WHpAjdNiirBhAHqzFcWoL4szj+zDpe742o=;
 b=FeABRMViYHldTUTNhpR9BdbVQarrkVi5i0iuFuD1hKXmI2GBtE7Lc4kKRXzGq60DcmpSR0
 gFCjXJxWnvNIEJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF4AD139ED;
 Thu, 12 Oct 2023 09:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T6SEMUa5J2UDZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Oct 2023 09:15:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 11:15:46 +0200
Message-ID: <20231012091546.607702-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.99)[99.96%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_clocks.c: Fix stack smashing on 32bit
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

63e8c1eba introduced a regression on 32 bit compilation when compiled
with -fstack-protector-strong, because struct timespec is probably too
small for timespec64.

    PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS="-m32 -fstack-protector-strong" LDFLAGS="-m32 -fstack-protector-strong" ./configure
    ...
    # gdb ./abort01
    (gdb) set follow-fork-mode child
    (gdb) run
    Starting program: testcases/kernel/syscalls/abort/abort01
    Missing separate debuginfos, use: zypper install glibc-32bit-debuginfo-2.31-150300.52.2.x86_64
    tst_test.c:1690: TINFO: LTP version: 20230929-7-gff6cdc67f
    tst_test.c:1576: TINFO: Timeout per run is 0h 00m 30s
    [Attaching after process 3357 fork to child process 3360]
    [New inferior 2 (process 3360)]
    [Detaching after fork from parent process 3357]
    [Inferior 1 (process 3357) detached]
    *** stack smashing detected ***: terminated

    Thread 2.1 "abort01" received signal SIGABRT, Aborted.
    [Switching to process 3360]
    0xf7fd2559 in __kernel_vsyscall ()
    (gdb) bt
    #0  0xf7fd2559 in __kernel_vsyscall ()
    #1  0xf7e08aa2 in raise () from /lib/libc.so.6
    #2  0xf7e09efd in abort () from /lib/libc.so.6
    #3  0xf7e4d91b in __libc_message () from /lib/libc.so.6
    #4  0xf7eeb2cc in __fortify_fail () from /lib/libc.so.6
    #5  0xf7eeb299 in __stack_chk_fail () from /lib/libc.so.6
    #6  0x0805c501 in syscall_supported_by_kernel (sysnr=403) at tst_clocks.c:27
    #7  0x0805c80d in tst_clock_gettime (clk_id=1, ts=0x807cfb0 <tst_start_time>) at tst_clocks.c:66
    #8  0x080531df in heartbeat () at tst_test.c:1374
    #9  0x08053ba2 in testrun () at tst_test.c:1458
    #10 fork_testrun () at tst_test.c:1608
    #11 0x08055afa in tst_run_tcases (argc=<optimized out>, argv=<optimized out>, self=<optimized out>) at tst_test.c:1704
    #12 0x0804b3f0 in main (argc=1, argv=0xffffc414) at ../../../../include/tst_test.h:401
    (gdb) Test timeouted, sending SIGKILL!
    Test timeouted, sending SIGKILL!

Fixes: 63e8c1eba ("tst_clocks: Fix unaddressable byte warning")
Reported-by: Petr Cervinka <pcervinka@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_clocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 2144a6ae5..29f4b420c 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -17,7 +17,7 @@ typedef int (*mysyscall)(clockid_t clk_id, void *ts);
 int syscall_supported_by_kernel(long sysnr)
 {
 	int ret;
-	struct timespec foo;
+	struct __kernel_timespec foo;
 
 	ret = syscall(sysnr, 0, &foo);
 	if (ret == -1 && errno == ENOSYS)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
