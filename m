Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9399C4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 08:37:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096783CE9AA
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 09:37:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B69DC3CC8EC
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 09:37:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DC0981A01119
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 09:37:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2A6B1F750
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698827843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z+UZxHWI4nbeH4+puE5X3Wzy3+6EZ4fD4LjlcGwwfBQ=;
 b=sX3c4NtD3TEgXGbvr37jPeaqO3Orx7prDLub/zkj884n/73XyUrk1u8L0PgUfcUM5yotg+
 c4UhqMpUhqe0YxYP7fXk/N8FvBJf6YukAgAD00DuL0fnDfDcRpOsQvcXKVd7j5NiFeSI7a
 wYc+qcJdMjOey38Rt4Wh6J8h80F+jss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698827843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z+UZxHWI4nbeH4+puE5X3Wzy3+6EZ4fD4LjlcGwwfBQ=;
 b=5X92M8GPasYvtkeFh2E+jT7EC97vOz5dd4hd8D5Ax+wZaJpYVGzJ/TqdMcJf6RZKMTIxI+
 KBZto9ajRVFOsKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D11571348D
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 08:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /woMMkMOQmWYbwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 01 Nov 2023 08:37:23 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  1 Nov 2023 09:37:55 +0100
Message-ID: <20231101083755.4093-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/ptrace04: Fix s390 build
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

s390 does not defined PTRACE_GETREGS

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ptrace/ptrace04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace04.c b/testcases/kernel/syscalls/ptrace/ptrace04.c
index af35fb3a2..0b25e982b 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace04.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace04.c
@@ -49,7 +49,7 @@ int TST_TOTAL = 2;
 
 void compare_registers(unsigned char poison)
 {
-#ifdef HAVE_STRUCT_PTRACE_REGS
+#if defined(HAVE_STRUCT_PTRACE_REGS) && defined(PTRACE_GETREGS)
 	ptrace_regs _pt_regs;
 	size_t i;
 	long ret;
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
