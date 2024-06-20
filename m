Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF82C2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:05:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AA5A3D0F63
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:05:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2727E3CB74E
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 18:25:03 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=arnd@kernel.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C825201174
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 18:25:02 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5D49ECE274D;
 Thu, 20 Jun 2024 16:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB57C4AF07;
 Thu, 20 Jun 2024 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718900698;
 bh=9tNBDm896BjzUxmnfvW1e6haCDwe3E/atZfPgTf6dvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=abvyrJ/X+WgKBcKLB26W63xGzrJswPTiNJDtrvePABOWadxaiMVdFVIIrjjZH7EMt
 i3yfbG9sxIhKzIMCfECn8jajIwt5EnHTKwWgtPNsnEm6eH5VPX4iHwPOT/KLGXygLR
 Y8UtKQhQMTPuDEykuGSASDGG1jSbMq6hu59HuuOGBaXNiJXkV1zooHon61XOPITCpE
 SFmK3OLp8gXcumhP0tivnIEFTlCHa7lpiLvSg28jj4kABCTLi6W7v8y4Et1OD6DAcD
 5NN8lrWx/ZkRbGl97bKzVpQphPBlvW7EqUaJZymCAafGjzXa4xCR+daUY33mNKb8As
 9i6pj/PklBLgw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 20 Jun 2024 18:23:13 +0200
Message-Id: <20240620162316.3674955-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620162316.3674955-1-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
Subject: [LTP] [PATCH 12/15] s390: remove native mmap2() syscall
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
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>,
 Guo Ren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-sh@vger.kernel.org, linux-csky@vger.kernel.org,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 musl@lists.openwall.com, Nicholas Piggin <npiggin@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, ltp@lists.linux.it,
 Brian Cain <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Arnd Bergmann <arnd@arndb.de>

The mmap2() syscall has never been used on 64-bit s390x and should
have been removed as part of 5a79859ae0f3 ("s390: remove 31 bit
support").

Remove it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/syscall.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index dc2355c623d6..50cbcbbaa03d 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -38,33 +38,6 @@
 
 #include "entry.h"
 
-/*
- * Perform the mmap() system call. Linux for S/390 isn't able to handle more
- * than 5 system call parameters, so this system call uses a memory block
- * for parameter passing.
- */
-
-struct s390_mmap_arg_struct {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
-SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
-{
-	struct s390_mmap_arg_struct a;
-	int error = -EFAULT;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;
-	error = ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
-out:
-	return error;
-}
-
 #ifdef CONFIG_SYSVIPC
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls.
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
