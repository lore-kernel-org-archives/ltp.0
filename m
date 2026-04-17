Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959B4F8DFDF
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776414597; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ojbaVGSG/w1UUEpPpHp7ybVC6b5pdwUL5tgvoEhjU48=;
 b=oUCMeWW3WdY3KoNGfTIWSS/diofq2+HoAwtAxYX/EzZqIExe4u3EHmyvibKls1TATyy2P
 HdadPjnm76eNoQGoFPeMM6nCGwczPEIvX0v6hmobST/cY8hF3VC0zM0f9WOxbsaPD9RFk1v
 NB9B+j1qodwMdXxHarQmU1WG9cndGIY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D2B93E2DF0
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:29:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F99D3C2B4B
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:29:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 624291000D35
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776414569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VqJl5HJFnGhru1YI2JjREB1/ZsP72AIWXtp1ZiJ4ldg=;
 b=i+x2NX7Vs9MfbTqbpt2gzZUw5X/e6kAcGg/poLwt+hP0nLEH8sIl/1LUS/UO6ZSp0hqaXr
 XFjsw18/ovEsNkdGOyOz4mn/DBA+pQTCRHz0ZmklB1mjbNIrM7i7Httn716zQjThS8ScFy
 6mF+2wNI5kjxk+6+VoQpVJXlo6mdxmc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-K8i_3UchNIaxbZDcEL2meQ-1; Fri,
 17 Apr 2026 04:29:26 -0400
X-MC-Unique: K8i_3UchNIaxbZDcEL2meQ-1
X-Mimecast-MFC-AGG-ID: K8i_3UchNIaxbZDcEL2meQ_1776414565
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C69A1800578; Fri, 17 Apr 2026 08:29:25 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.44.48.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97D5C195608E; Fri, 17 Apr 2026 08:29:23 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 17 Apr 2026 10:29:20 +0200
Message-ID: <20260417082920.1101928-1-mcermak@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ewp5PGhLAyxQ5KIhDmFzs6HVBc9VZfJUGGBVgjZRSH4_1776414565
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix Valgrind warnings in ioctl_pidfd02
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
Cc: valgrind-developers@lists.sourceforge.net, mcermak@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When ioctl_pidfd02 runs under valgrind, it fails to use clone3()
in lib/tst_clone.c:27, because valgrind doesn't implement clone3.
So, tst_clone.c resorts to a raw clone() syscall a few lines later.

Manual page clone(2) says that In Linux 2.4 and earlier, clone()
does not take arguments parent_tid, tls, and child_tid.  That pre-
dates valgrind itself though.  In reasonably recent history, the
raw clone() syscall takes 5 args.

The clone() syscall is notorious for having different "Calling
Conventions" depending on the CPU architecture.  The following
valgrind source demonstrates that mess:

    || defined(VGP_ppc32_linux) \
    || defined(VGP_ppc64be_linux) || defined(VGP_ppc64le_linux) \
    || defined(VGP_arm_linux) || defined(VGP_mips32_linux) \
    || defined(VGP_mips64_linux) || defined(VGP_arm64_linux) \
    || defined(VGP_nanomips_linux) || defined(VGP_riscv64_linux)
// And s390x is even more special, and inverts flags and child stack args

The ARG3 (parent_tidptr) - this patch actually is about - actually is
the only arg having identical position across various arches, hooray :)

The ioctl_pidfd02.c testcase calls clone() with CLONE_PIDFD.
In that case ARG3 becomes mandatory (ftr. kernel/fork.c:2669) and
valgrind checks its validity.  Without this patch, Valgrind fails:

ioctl_pidfd02.c:64: TPASS: WEXITSTATUS(info1->exit_code) == 100 (100)
==2227408== Syscall param clone(parent_tidptr) points to unaddressable byte(s)
==2227408==    at 0x496215D: syscall (syscall.S:38)
==2227408==    by 0x420E73: tst_clone (tst_clone.c:41)
[ ... stuff deleted ... ]
==2227408==    by 0x404E9A: main (tst_test.h:755)
==2227408==  Address 0xffffffffffffffa0 is not stack'd, malloc'd or (recently) free'd

This patch sets ARG3 explicitly, making valgrind happy.  With this
update, ioctl_pidfd02 tests fine on all the rhel supported arches both
with and without valgrind, e.g.:

el10 s390x # valgrind --exit-on-first-error=yes --error-exitcode=-3 --quiet ./testcases/kernel/syscalls/ioctl/ioctl_pidfd02
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.12.0-218.el10.s390x/build/.config'
tst_buffers.c:57: TINFO: Test is using guarded buffers
[ ... stuff deleted ... ]
ioctl_pidfd02.c:62: TPASS: info1->exit_code == status (25600)
ioctl_pidfd02.c:64: TPASS: WEXITSTATUS(info1->exit_code) == 100 (100)

Summary:
passed   10
failed   0
broken   0
skipped  0
warnings 0
el10 s390x #

This patch also sets ARG4 and ARG5.  Luckily in this case both are NULL.
That's a win, because otherwise we'd need to look into the messy clone()
calling convention and handle individual arches separately, see above.

diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 8638052e2..296cd40ac 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -36,9 +36,9 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	flags = args.exit_signal | args.flags;
 
 #ifdef __s390x__
-	pid = syscall(__NR_clone, NULL, flags);
+	pid = syscall(__NR_clone, NULL, flags, args.pidfd, NULL, NULL);
 #else
-	pid = syscall(__NR_clone, flags, NULL);
+	pid = syscall(__NR_clone, flags, NULL, args.pidfd, NULL, NULL);
 #endif
 
 	if (pid == -1)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
