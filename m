Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E37F34C64
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776095883; h=date : to :
 message-id : mime-version : content-type : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : sender : from;
 bh=iytvKNxM3qLY0zit/coRruxLPKlVTror/Er2Ln3b0ms=;
 b=FRS18wHP/pVHaG8PkHIUgBrxkIC7ZSmHLsjRHl+mkVVOY+q0Y362T9AbCpss+v+Od8T4M
 o/GKwmFartbpNyMgaoEdlVwtV6zC/OQQg4ew5njyBHEyYQKHRfP7x/LQlQ1GB3xqACJvPsT
 y/vH5QiUJhxwYms/hOlEGkB7z+fWpOY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95DB3E4B35
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 17:58:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4D033C5676
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:57:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04DAA60070F
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776095857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=YYGhYzIXlx8G5otRk5q0c4CeWFZICKhio3rXkh5gUAE=;
 b=IuKDnXyNm4hxWLOld99CU4ltc99t2PTHc35kAG0zWv5RqdN5wChaZL1E4EpJsrSAPhJBff
 a/OGV3j/YBXgBStK80kHb/aAdX/jDXpBVQxOGZbq4wwn/eCCIHfbZ//qLf6m5H5XJwjQ0s
 1jdU/aaEdGuwgBNAUlm4hqlbhGGjOTk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-Ol7oBoSKPAakCYmjBBXO_g-1; Mon, 13 Apr 2026 11:57:34 -0400
X-MC-Unique: Ol7oBoSKPAakCYmjBBXO_g-1
X-Mimecast-MFC-AGG-ID: Ol7oBoSKPAakCYmjBBXO_g_1776095854
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d1bfbd219so3330995f8f.0
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 08:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776095853; x=1776700653;
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxKUdX6Ej9lDsdublRnxchwmAfIb4Xh2pz8kUuawL2c=;
 b=rbMm9iJLq3esvqvNezZWuOlA7wnW/2DFc2tpBQbW72RplDsKAw5TFIoqzpegifKxk2
 DoiqVUst9MCRCY30ODYPMOYV96/5lw4uIrsPuQplE1v5CtKS0ntq0pgw0kZXc7xMUDt6
 0XqJtRO/KgPF1VVdMiawCGLH7n5u7GI3bEll7vT+x/oM9oaWDUc2G8ROLrZLUZ9YK/ZD
 YpSEl0XoDCzvQetmv/eMwucDUn4aEYdwMMqzeSHonae7vNDRB1DJwbkZWBeqswFEdZiV
 5p+UdIpXZEYZW2+HGWAR26mtX5auG/Epni8C5bM6JKtwmyFsIQjJWjZtG0eqSHEMiR52
 e/bQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jtMotDtNlyLmfB2icj0drbLiOm/E+q2J1Q5IWZxz2K9Ye20riBNRLhwePxwBgfVkqGoo=@lists.linux.it
X-Gm-Message-State: AOJu0Yz9fMMpW4m3luM8IHHHFI6Knz9DqaTR/iiJaugH2WOdf06Nxe5V
 B0F662YZvT/L5mAZHFGGdkIgH9hyeru/aOpB8pVQmi+VJIOAcntb9y4Q4dtQjRJu5tWvWJB2+Ae
 roKnPkzqHPtI0hzTvpIaywrTQgmHO2pKp9gr6z3D1TJKLU/chfN4s
X-Gm-Gg: AeBDiesJax50EuKcJ3Fkja7fx8/yfSZmm5ntk0r5yFHQXj/BN5M7LbfF4JacXDJj1r6
 ugjYm9AFd0+AsEVNWrTOIeR+CkurxJzLR9OlLby5Q+E3FFrZuzXXZmwv/ipMm9S2KzA+gKLe8y0
 DbimYjg3lc5JqnVMUNiVY6gGEvMDeKpFd5c1SXE9vVv8+yzg7P4eTH05xlVL98/odQp1eYh8lZa
 h+XeRnnqk6sXX13kj0i5R4TF+zsCYEWRz8aVx1iubmBWj0e6XkHddeU6chK7mOt25VVFECcgIC3
 kN1GkiCP2QrSyJZEWXUYTXZQZdKBcPOQ3P4PIO7269D2fm7a+W/Uf3UG9UiEA+VhcYO0/2aZGHj
 E4DKasUBHt5vDMjdMhJTtHs6mTHNzWxSSgg==
X-Received: by 2002:a05:6000:230c:b0:43d:7a97:78a2 with SMTP id
 ffacd0b85a97d-43d7a977965mr5472557f8f.28.1776095853481; 
 Mon, 13 Apr 2026 08:57:33 -0700 (PDT)
X-Received: by 2002:a05:6000:230c:b0:43d:7a97:78a2 with SMTP id
 ffacd0b85a97d-43d7a977965mr5472518f8f.28.1776095852918; 
 Mon, 13 Apr 2026 08:57:32 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6fc9d525sm16444801f8f.36.2026.04.13.08.57.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 08:57:32 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:57:30 +0200
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Message-ID: <20260413155730.fnnhbyzqmmrxgfur@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: blge84PQ3t5aRTA_bt-mmpoT0MML0UJ2Ns6zK9hvWUM_1776095854
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="lbb252ntq2nnxcsn"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Syscall param clock_settime(tp) points to uninitialised
 byte(s)
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--lbb252ntq2nnxcsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello there,

one LTP nit attached.

Cheers,
m.


--lbb252ntq2nnxcsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Avoid-Syscall-param-clock_settime-tp-points-to-unini.patch"

From 1acc76579c81b37814b0111044e1a1f8282cfbfb Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Mon, 13 Apr 2026 17:48:43 +0200
Subject: [PATCH] Avoid Syscall param clock_settime(tp) points to uninitialised
 byte(s)

Without this update, clock_settime03 fails under valgrind with an error like the following:

el10 x86_64 # ./vg-in-place --track-origins=yes  ./auxprogs/auxchecks/ltp-full-20260130/testcases/kernel/syscalls/clock_settime/clock_settime03
==1638250== Memcheck, a memory error detector
==1638250== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
==1638250== Using Valgrind-3.27.0.GIT and LibVEX; rerun with -h for copyright info
==1638250== Command: ./auxprogs/auxchecks/ltp-full-20260130/testcases/kernel/syscalls/clock_settime/clock_settime03
==1638250==
tst_test.c:2047: TINFO: LTP version: 20260130
tst_test.c:2050: TINFO: Tested kernel: 6.12.0-218.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Mar 31 08:07:36 EDT 2026 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.x86_64/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 34s
clock_settime03.c:35: TINFO: Testing variant: syscall with old kernel spec
clock_settime03.c:103: TPASS: clock_settime(): Y2038 test passed
==1638252==
==1638252== HEAP SUMMARY:
==1638252==     in use at exit: 0 bytes in 0 blocks
==1638252==   total heap usage: 17 allocs, 17 frees, 13,761 bytes allocated
==1638252==
==1638252== All heap blocks were freed -- no leaks are possible
==1638252==
==1638252== For lists of detected and suppressed errors, rerun with: -s
==1638252== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
==1638250== Syscall param clock_settime(tp) points to uninitialised byte(s)
==1638250==    at 0x496215D: syscall (in /usr/lib64/libc.so.6)
==1638250==    by 0x416780: syscall_supported_by_kernel (tst_clocks.c:24)
==1638250==    by 0x416780: tst_clock_settime (tst_clocks.c:104)
==1638250==    by 0x40DB67: tst_wallclock_restore (tst_wallclock.c:63)
==1638250==    by 0x407E06: do_cleanup (tst_test.c:1671)
==1638250==    by 0x407E06: do_exit (tst_test.c:1054)
==1638250==    by 0x40B280: run_tcases_per_fs (tst_test.c:2025)
==1638250==    by 0x40B280: tst_run_tcases (tst_test.c:2065)
==1638250==    by 0x404D8D: main (tst_test.h:755)
==1638250==  Address 0x1ffefffbe0 is on thread 1's stack
==1638250==  in frame #1, created by tst_clock_settime (tst_clocks.c:92)
==1638250==  Uninitialised value was created by a stack allocation
==1638250==    at 0x416710: tst_clock_settime (tst_clocks.c:92)
==1638250==
==1638250==
==1638250== HEAP SUMMARY:
==1638250==     in use at exit: 0 bytes in 0 blocks
==1638250==   total heap usage: 10 allocs, 10 frees, 10,552 bytes allocated
==1638250==
==1638250== All heap blocks were freed -- no leaks are possible
==1638250==
==1638250== For lists of detected and suppressed errors, rerun with: -s
==1638250== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
el10 x86_64 #
---
 lib/tst_clocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 704ce9551..107938e4e 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -19,7 +19,7 @@ typedef int (*mysyscall)(clockid_t clk_id, void *ts);
 int syscall_supported_by_kernel(long sysnr)
 {
 	int ret;
-	struct __kernel_timespec foo;
+	struct __kernel_timespec foo = { 0, };
 
 	ret = syscall(sysnr, 0, &foo);
 	if (ret == -1 && errno == ENOSYS)
-- 
2.53.0


--lbb252ntq2nnxcsn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--lbb252ntq2nnxcsn--

