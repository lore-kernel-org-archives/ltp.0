Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC0CA9EBB
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791599696; h=message-id :
 to : date : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=cwMhe3bp4bnYAr/B+jzbry97+VeEuhWn2kBPUFqbg2Y=;
 b=eopBGciSmcmXoc7Y81OSikuv0MRGbvaH2wdZm1DDXp6pZH0YVsAacfQInf1yP/ApypRw3
 Xj8WBiTBHyGDK2/HicKti5QQbRHphhkVtft5n5Pbq9odpORFq6EXmNpxsXJLcLg0V2Ws6nx
 KAsMvCiTajPCVz21k+iXaqxs8/nWgNY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A8B43EAC1D
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 04:34:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1443EAA4C
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 04:34:36 +0200 (CEST)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 955061A010B2
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 04:34:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1791599671; bh=4LC88PCmOXG2UubRLES7+hh2iPrkVG9tGQU6G0Bn6HY=;
 h=From:To:Cc:Subject:Date;
 b=vG94lSf9WoB0TroK8leHtQvW1X1Or8T4+lchLVMv84LvAbcMEKf8vgLSvQ1e1sI8T
 EUEzeNoilHpHIP9a6L9yjHOd91Ku1w4cjU5eFtG3TBxJbwtg/rpV3g21B7F3cOU3KU
 4j72hQ3j7FX6MU7t9S9yxemtMtA7hDx+dLUx8Dfw=
Received: from 6PLUS.localdomain ([111.34.209.159])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 89D27A77; Sat, 10 Oct 2026 10:34:29 +0800
X-QQ-mid: xmsmtpt1791599669tqer7rmr0
Message-ID: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQl7rmYhx5VwVkQbNEXqLOAXlnuJVujCHKPmoHuWNiNaWNANmaTdb
 eYem1QJuZP1fniJ9yUDl538aYd0RsZqtoxMGZyDdumTVInZpxMVt7fKfOnLBjj3RMOTBP9VG1SUD
 1d2/u02LBrbePqwyO+dug1gHooTV2vlOqRkKccXyvktaXw0ikVOehm6xFSD3qfdYi43kt2aQDpO4
 q4T1ueQVys1UPIY9JLB72pxF0haqUzrxJwqxKuvwBlOpRQlBwnLNA1ZF8er9JmSXZI1tdE5L8FhT
 +J4jKIRTqSJ6k1iSFhN+5o/IzIFVdPnrYQqGNv4UolXp9JLuoN8xlpSQWfFPOw1NvB0QbiFnBAz+
 RWhY/lwIEIO6rtNrpf3OKjmJBXnZ99mJcT2RpIctE947yiRswf9FyjkFskB4dWmiAD95DT9cxqAC
 +Wq05DLiWghBV/z9fIGVyGueQL0iiYwXnzp8EBxIFvnCy58Ld8KBDN79L2oH0vMP98b2kDq3d7N8
 EYxXNfuRddxUym8MjWLiAfQDJa/9VxD5Cks64YQNS5t1GDTHd1m/0OQx2C8KNTC5xKV1voIK3Fev
 l07ElC5oDcgiyHEOstHr2/lanR1umRVm1L3ak0DqYAVv858jlaLS1h8mZUfpyivju0WD2iXT2s5J
 piajg+fuL6IDx1zTcz+SYyLzeHgsZZi/+nmCvq0cOVzmp1H2dEtHWP9TZncO5QtIxn1804b0TmAC
 WGrs/N55xWgiiYCRwvns0ob07l32OKtT4r4X4FMQOS4omFp7bsLy/rskTCAJcoKE4Iuzb5dNnf92
 OVe1K1zU6aW+gEt5agoRwa+moBXTRp6TYT0oMkguZ2uz37ejOFWr/3rUCNt6V+yk9//Pq6dKtG1y
 Fw3llAA7I6HmiOaHjbTurt/bSZTFssHHZy3FYjZVWnuE3OlD2OV46XMU5MpNiMZAsAJUPHk2QNfD
 C2Vjg6+NL8d7Lb1ZcYutTqIwF8IlY2ex4hg67knnDyrRahf2Kvs+OL7J5lZlEOX40e3U2Isamgjk
 n+HEV0frMjfoJ1InYIQK7nYBaO5zbgPoDZfA5lpw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
To: ltp@lists.linux.it
Date: Sat, 10 Oct 2026 10:34:24 +0800
X-OQ-MSGID: <20261010023424.5856-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/munmap03: Fix addresses passed to munmap
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
From: Wenyuan Li via ltp <ltp@lists.linux.it>
Reply-To: Wenyuan Li <2063309626@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

munmap03 keeps the addresses to be passed to munmap() in a table of
char **, but passes tc->addr (the address of the pointer itself) instead
of the pointed-to value. The length is dereferenced correctly, so the
mismatch only shows up at the syscall boundary where void * is accepted.

The third entry is wrong as well: "&map_addr + 1" is one pointer-width
past the map_addr object, not "map_addr + 1", i.e. not the mapping start
plus one byte.

As a consequence none of the three documented scenarios reliably
exercises the rejection reason it describes. On x86-64 with 4K pages the
addresses involved are not page-aligned, so all three requests fail with
EINVAL from the page-alignment check and the test reports TPASS while the
"len == 0" and "range outside the address space" conditions are never
reached.

Fix the table to reference properly constructed values and dereference
the address in the call:

  - out of range: use the real page-aligned mapping start with a length
    that cannot fit into the address space (SIZE_MAX), rejected by the
    "len > TASK_SIZE - start" check. This replaces the RLIMIT_DATA based
    pointer: RLIMIT_DATA is a resource limit, not a bound of the user
    address space, and rlim_max (RLIM_INFINITY) is not page-aligned
    either, so it could not reach the intended check.
  - len == 0: keep the zero length but pass the actual page-aligned
    mmap() return value, so the request reaches the end == start check.
  - unaligned: pass an explicitly constructed map_addr + 1.

The number of scenarios is unchanged.

Tested on x86-64, 4096-byte pages, kernel 6.8.0:
  - munmap03        : 3 TPASS  (strace shows three distinct inputs)
  - munmap03 -i 20  : 60 TPASS

Fixes: 0c7346cb097440902568856527be7162f5950497 ("syscalls: munmap03: Convert to new API")
Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 testcases/kernel/syscalls/munmap/munmap03.c | 22 +++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
index be607e7..5de83fd 100644
--- a/testcases/kernel/syscalls/munmap/munmap03.c
+++ b/testcases/kernel/syscalls/munmap/munmap03.c
@@ -19,38 +19,44 @@
 
 static size_t page_sz;
 static char *map_addr;
-static char *map_addr_out;
+static char *unaligned_addr;
 static size_t map_len;
 static size_t map_len_zero;
+static size_t map_len_too_large;
 
 static struct tcase {
 	int exp_errno;
 	char **addr;
 	size_t *len;
 } tcases[] = {
-	{ EINVAL, &map_addr_out, &map_len },
+	{ EINVAL, &map_addr, &map_len_too_large },
 	{ EINVAL, &map_addr, &map_len_zero },
-	{ EINVAL, &map_addr + 1, &map_len },
+	{ EINVAL, &unaligned_addr, &map_len },
 };
 
 static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TST_EXP_FAIL(munmap(tc->addr, *tc->len), tc->exp_errno);
+	TST_EXP_FAIL(munmap(*tc->addr, *tc->len), tc->exp_errno);
 }
 
 static void setup(void)
 {
-	struct rlimit brkval;
-
 	page_sz = SAFE_SYSCONF(_SC_PAGESIZE);
 	map_len = page_sz * 2;
 	map_addr = SAFE_MMAP(NULL, map_len, PROT_READ | PROT_WRITE,
 			     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	unaligned_addr = map_addr + 1;
 
-	SAFE_GETRLIMIT(RLIMIT_DATA, &brkval);
-	map_addr_out = (char *)brkval.rlim_max;
+	/*
+	 * The range [map_addr, map_addr + map_len_too_large) can never fit
+	 * into the address space of a process, so munmap() has to reject it
+	 * with EINVAL. A length of SIZE_MAX is used instead of a pointer
+	 * derived from RLIMIT_DATA, which is a resource limit and not a
+	 * valid upper bound of the user address space.
+	 */
+	map_len_too_large = SIZE_MAX;
 }
 
 static void cleanup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
