Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36F6C44508
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 07:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 917FE3E5682
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 09:59:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD58D3E1D74
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:59:08 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E78FD2001B6
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 09:59:07 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784102345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Od3ThtW/acgG+tLUcXV40xkd6RjUwqdU0PULqgoTDA=;
 b=VTXcrw0T8pA11Z3G05UFQbbWU9liLJdRea/MnFC5i22238QpuU34Zk2MLaYbHDumqNpskX
 QzONlENoVNVjHo81I5+tfrXbygLanYUhk15bm9xieQj8OEApi4PcU3IAwpGwtxi7Z3sGo7
 FHL75+5/Y+SsPTIwiRAQC0CNTao0QvU=
From: Gang Yan <gang.yan@linux.dev>
To: ltp@lists.linux.it
Date: Wed, 15 Jul 2026 15:58:50 +0800
Message-ID: <20260715075850.66118-1-gang.yan@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] loongarch64.in: add memfd_secret syscall
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
Cc: Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gang Yan <yangang@kylinos.cn>

memfd_secret(447) is already supported on newer LoongArch kernels, but
the loongarch64.in was missing its definition. This caused tests using
memfd_secret (e.g. accept03, readahead01, splice07 via tst_fd.c) to
incorrectly skip with TCONF even when the kernel supports it:

'''
accept03.c:46: TPASS: accept() on memfd: ENOTSOCK (88)
tst_fd.c:261: TCONF: Skipping memfd secret : ENOSYS (38)
'''

This patch adds memfd_secret(447) so these tests can run normally:

'''
accept03.c:46: TPASS: accept() on memfd secret : ENOTSOCK (88)
'''

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 include/lapi/syscalls/loongarch64.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index 5407b86ea..a1dfce79e 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -297,6 +297,7 @@ quotactl_fd 443
 landlock_create_ruleset 444
 landlock_add_rule 445
 landlock_restrict_self 446
+memfd_secret 447
 process_mrelease 448
 futex_waitv 449
 set_mempolicy_home_node 450
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
