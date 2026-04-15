Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497C0FA0C49
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776241582; h=date : to :
 message-id : mime-version : content-type : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : sender : from;
 bh=SYc6nW4wlNiHq+3DcTvzw7cpI8qehsLNw8BMvA711OU=;
 b=Zwx3GWeYBvfYCBygT6qCbttJBKCE6NkUG8M/Bhr9FWxbLCqyJaIpnNuxWEIX6nqgh+Sqv
 BwReQ0m4Bs3G6xEyEnjqStOGmW9w9SeCwZ5JUg4KTYNccnxiom51r0yboQygduFZQNMSrLF
 ifdaB7HnGwQekSx8viFwn3RjKjXFXBY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAE283E2933
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 10:26:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 312BB3E20E3
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 10:25:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70D6D10000CA
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 10:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776241555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=ZF7lXqQY8RI3I+31MeQRlrtWJuKoFBAAelIWYcQZGpE=;
 b=KkXSDTEGTSSn5y0++wokcClx2ypxaRfMPK3vE1eW3Q4wTjRGFuccT21cblf3skJ4krq4bC
 vcu2khTyIv69nsrWkfx5jQ9dYSnFr7L6QZRp5apnv5iJ6aZVRDBfCQF9I+qPEg32STxj/s
 vgT8J8OT4NF593xycZca0C5kjEIhiw4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-GWlefzvRNbK52miq8q6aEg-1; Wed, 15 Apr 2026 04:25:54 -0400
X-MC-Unique: GWlefzvRNbK52miq8q6aEg-1
X-Mimecast-MFC-AGG-ID: GWlefzvRNbK52miq8q6aEg_1776241550
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c768a9a9so33212175e9.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 01:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776241550; x=1776846350;
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPubyEEXmc+lU5qo1wO0eMuuG8HhlPKTHhUImCQqAnM=;
 b=bdVoTbgnKIeZNdeLv/MfFvMztUpkJoZmos9mOwWoxhdGXgaRopc4pv2icYxnd5gGL5
 0kXIgrEV854quZPtH6maFhIwuTEGJkigDngYRHOCaVLN6j/h+QC99z+GVbKRL7RGQlmb
 1PUcK3pemk9LoVoQ4VXBBnH9LfOxszEMp1srQVev4QcDYlRZ0dBkzB4Lq8FS6RbWxutP
 MF/mbNHIlREOcEsbSv9eVM/ShyprR2QussR2QXIyIf5xPnijtMLW3wSPaLlnEy0bUqa6
 mZlzrWlgOx1EO0jbjCWTp+cyV+TNNFq6ir68qUPDWi24OigW9HUmjCY4JlayrU7OUOnI
 w9Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9g8ly+8++jZWG8rkF8iaYPljNFpYO8cObR+yHEpgT7n0VYF2Hw849lWOFV2Csg75cX2E=@lists.linux.it
X-Gm-Message-State: AOJu0Ywagc9bT0/KHBsQYkz3WsOxUuXuFc5Ocy8uc0twJDhbBQDjIVqh
 sNPmCiufe2D6G6iprSJW+4Skqzhs0dHpG4ecBYdNo7BnQmtvL+NSJSjvlqu4f6W/0EhCRoX93Vo
 c5SkvBEZZ0QEdcm1faTMME7JYiwiaNFBK0GF2zdCsfi0RTHU4Ucf/
X-Gm-Gg: AeBDiet8MXtH5q5gbewMuzH6Wdt8wKVR4301R42T8ECDbYGD4Xc7Ifo7dTM/W5FPgwn
 s8j1Y3urC6DwZbo+3wzqnJ1cVWwbuzdRSx4YWu7pQoXq5w0DkNg2eaTU0jg9YxB67Eampw4MsWC
 XOMTAk205dNbNHEOrKHL1FD7Svc/Mg3b5CgXihWhgGS7DNnyMgEkEo4vo3fCz+g6bqIEu8ZUE6G
 Y71XXJD48PTEFh3S1ViR7v1W6uY9o2xuqBYDSKwCqlIuLqLHFifG8aTADltbK849RkewbqiPTQR
 acPOYI9JMX+73/SJ54/MF00NMFPt7HfAxq4BbzpZsm03/v/hZ13G6v/DB+R70l4FAsJZMFDhYbP
 ++VmwQykVhZbPTVaS8WAKfMaOdmY5C1VryA==
X-Received: by 2002:a05:600c:890e:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-488d6ad4a72mr185682745e9.30.1776241550337; 
 Wed, 15 Apr 2026 01:25:50 -0700 (PDT)
X-Received: by 2002:a05:600c:890e:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-488d6ad4a72mr185682405e9.30.1776241549842; 
 Wed, 15 Apr 2026 01:25:49 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f1e95130sm31895355e9.13.2026.04.15.01.25.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Apr 2026 01:25:49 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:25:47 +0200
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Message-ID: <20260415082547.vgn23q2aobxy5gzv@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1gSDVpGTjVq6vP3Bdp3LYLo5mUCyfRSqCH7v4VEz2jI_1776241550
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="qllmnoumhnb5r3pq"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Make ioctl_pidfd02 valgrind-compliant
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

--qllmnoumhnb5r3pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

attached is a ioctl_pidfd02 patch that improves the behavior of
this testcase under valgrind.  Please review and check in if
possible.

Thanks,
Martin


--qllmnoumhnb5r3pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Make-ioctl_pidfd02-valgrind-compliant.patch"

From 25c0e052aba25b0a86f844246f14aa17ad47ef1f Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Wed, 15 Apr 2026 10:03:44 +0200
Subject: [PATCH] Make ioctl_pidfd02 valgrind-compliant

When ioctl_pidfd02 runs under valgrind, it fails to use clone3()
in lib/tst_clone.c:27, because valgrind doesn't implement it. So,
it resorts to a raw syscall a few lines later.

Manual page clone(2) says that In Linux 2.4 and earlier, clone()
does not take arguments parent_tid, tls, and child_tid.  That pre-
dates valgrind itself though.  In reasonably recent history, the
raw clone() syscall takes 5 args.

The ioctl_pidfd02.c testcase calls clone() with flags = CLONE_PIDFD
and others.  When that happens, the 4th clone() arg, parent_tidptr,
becomes mandatory, and valgrind checks its validity per PRE(sys_clone)
along the lines of coregrind/m_syswrap/syswrap-linux.c:831.  If this
arg isn't set, the raw syscall() will execute without failure, but
that arg contains garbage, and valgrind fails to check it:

ioctl_pidfd02.c:64: TPASS: WEXITSTATUS(info1->exit_code) == 100 (100)
==2227408== Syscall param clone(parent_tidptr) points to unaddressable byte(s)
==2227408==    at 0x496215D: syscall (syscall.S:38)
==2227408==    by 0x420E73: tst_clone (tst_clone.c:41)
==2227408==    by 0x4135E9: safe_clone (tst_test.c:601)
==2227408==    by 0x405094: run (ioctl_pidfd02.c:33)
==2227408==    by 0x416AE4: run_tests (tst_test.c:1730)
==2227408==    by 0x416D6E: testrun (tst_test.c:1796)
==2227408==    by 0x417427: fork_testrun (tst_test.c:1936)
==2227408==    by 0x417A8A: tst_run_tcases (tst_test.c:2079)
==2227408==    by 0x404E9A: main (tst_test.h:755)
==2227408==  Address 0xffffffffffffffa0 is not stack'd, malloc'd or (recently) free'd

This patch sets the parent_tidptr explicitly, making valgrind happy.
With this update, ioctl_pidfd02 tests fine on all the rhel supported
arches both with and without valgrind, e.g.:

el10 s390x # valgrind --exit-on-first-error=yes --error-exitcode=-3 --quiet ./testcases/kernel/syscalls/ioctl/ioctl_pidfd02
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.s390x/build/.config'
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_iocGIJIgS as tmpdir (xfs filesystem)
tst_test.c:2059: TINFO: LTP version: 20260130
tst_test.c:2062: TINFO: Tested kernel: 6.12.0-218.el10.s390x #1 SMP Tue Mar 31 07:51:26 EDT 2026 s390x
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.s390x/build/.config'
tst_test.c:1887: TINFO: Overall timeout per run is 0h 00m 30s
ioctl_pidfd02.c:49: TPASS: info0->mask & PIDFD_INFO_EXIT == 0 (0)
ioctl_pidfd02.c:50: TPASS: info0->exit_code == 0 (0)
ioctl_pidfd02.c:61: TPASS: info1->mask & PIDFD_INFO_EXIT == PIDFD_INFO_EXIT (8)
ioctl_pidfd02.c:62: TPASS: info1->exit_code == status (25600)
ioctl_pidfd02.c:64: TPASS: WEXITSTATUS(info1->exit_code) == 100 (100)
ioctl_pidfd02.c:49: TPASS: info0->mask & PIDFD_INFO_EXIT == 0 (0)
ioctl_pidfd02.c:50: TPASS: info0->exit_code == 0 (0)
ioctl_pidfd02.c:61: TPASS: info1->mask & PIDFD_INFO_EXIT == PIDFD_INFO_EXIT (8)
ioctl_pidfd02.c:62: TPASS: info1->exit_code == status (25600)
ioctl_pidfd02.c:64: TPASS: WEXITSTATUS(info1->exit_code) == 100 (100)

Summary:
passed   10
failed   0
broken   0
skipped  0
warnings 0
el10 s390x #
---
 lib/tst_clone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 8638052e2..d14f8699f 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -36,9 +36,9 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	flags = args.exit_signal | args.flags;
 
 #ifdef __s390x__
-	pid = syscall(__NR_clone, NULL, flags);
+	pid = syscall(__NR_clone, NULL, flags, args.pidfd);
 #else
-	pid = syscall(__NR_clone, flags, NULL);
+	pid = syscall(__NR_clone, flags, NULL, args.pidfd);
 #endif
 
 	if (pid == -1)
-- 
2.53.0


--qllmnoumhnb5r3pq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--qllmnoumhnb5r3pq--

