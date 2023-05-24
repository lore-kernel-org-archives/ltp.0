Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D96C7EE31
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 06:57:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7599F3CD1A3
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 08:57:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 902053CB92C
 for <ltp@lists.linux.it>; Wed, 24 May 2023 22:26:06 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4CB781A000A9
 for <ltp@lists.linux.it>; Wed, 24 May 2023 22:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684959964; x=1716495964;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=voU8Ho1N9K6r5Hlb6VgigeAjmWQok0HyKnAXkSDSFtU=;
 b=OgzxY9sA1AxfKxz3STyLMIAGQiZjTqRDlfifZfumosOFihjN0QyPK0Oi
 X33jzKTymTrGN4KN1jo9ZGHjzf0hwf68nRpohyaG6m1N0dCbkPPtQ1pY8
 njHI8Zb3Wg9PAZJWP8LXgkmPioDEM7VF7sEoUWtGG3rlYiGZhzbgBsXDW
 u9kZeDS5JkShIaVYKcMnGyn9R62qJMpNB7YCnYeJpAUuc55EmQq3N2Zd8
 48qRGXP64OM5AGVMxLJxlheEggX7f63ltDrS7gN/5kSXGID04ZJ1Kxzyp
 rXOGz/YncDKBwLbhTVymdEDDaJ08v06FpTatIWftC/4gSRrJ9VVjEYQBl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="333304930"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; d="scan'208";a="333304930"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 13:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="878812803"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; d="scan'208";a="878812803"
Received: from kmevada-mobl.amr.corp.intel.com (HELO
 rpedgeco-desk4.amr.corp.intel.com) ([10.209.81.107])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 13:26:00 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: ltp@lists.linux.it
Date: Wed, 24 May 2023 13:25:16 -0700
Message-Id: <20230524202516.2190903-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 25 May 2023 08:57:44 +0200
Subject: [LTP] [PATCH] security/stack_clash: Add test for mmap() minding gap
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
Cc: rick.p.edgecombe@intel.com, Liam.Howlett@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The existing stack_clash test only verifies if the stack can grow too close
to an existing mapping. It doesn't test if mmap() will place new mappings
in the gap.

Add a test for this. Have it fill all the empty regions below the stack
with PROT_NONE mappings. Do this by searching /proc/pid/maps for the
gaps. The code for parsing this is based on the existing
read_stack_addr_from_proc() in the file.

With all lower spaces taken by the PROT_NONE mappings, the search down
path will then fail for new mmap()s. So mmap() will search up and find the
gap just before the stack. If it picks it then the mapping is in the guard
region, so fail the test.

This logic is somewhat x86_64 specific, but may work for other
architectures. Make it be x86_64 for now, but document the assumptions so
that others can be added after more verification.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Hi,

There was recently a regression around mmap placement and mmap guard
gaps. Today the stack clash test only tests if the gap can expand too
close to an adjacent mapping, but not if it mappings can be placed in the
gap. Can we enhance the test to also verifiy the latter?

Thanks,

Rick

 testcases/cve/stack_clash.c | 95 +++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index cd7f148c2..bbd28b4f1 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -18,6 +18,10 @@
  * to infinity and preallocate REQ_STACK_SIZE bytes of stack so that no calls
  * after `mmap` are moving stack further.
  *
+ * If the architecture meets certain requirements (See not above
+ * CAN_DO_PLACEMENT_TEST), then the test also verifies that new mmap()s can't
+ * be placed in the stack's guard gap.
+ *
  * [1] https://blog.qualys.com/securitylabs/2017/06/19/the-stack-clash
  * [2] https://bugzilla.novell.com/show_bug.cgi?id=CVE-2017-1000364
  */
@@ -45,6 +49,22 @@ static int STACK_GROWSDOWN;
 
 #define EXIT_TESTBROKE		TBROK
 
+/*
+ * The mmap placement part of the test works by forcing a bottom up search.
+ * The assumptions are that the stack grows down (start gap) and either:
+ *   1. The default search is top down, and will switch to bottom up if
+ *      space is exhausted.
+ *   2. The default search is bottom up and the stack is above mmap base
+ *
+ * Case 1 has been verified on x86_64, so only do the test on this
+ * architecture until more have been verified.
+ */
+#ifdef __x86_64__
+#define CAN_DO_PLACEMENT_TEST	1
+#else
+#define CAN_DO_PLACEMENT_TEST	0
+#endif
+
 void exhaust_stack_into_sigsegv(void)
 {
 	volatile char * ptr = alloca(FRAME_SIZE - sizeof(long));
@@ -78,6 +98,57 @@ void segv_handler(int sig, siginfo_t *info, void *data LTP_ATTRIBUTE_UNUSED)
 		_exit(EXIT_SUCCESS);
 }
 
+static void force_bottom_up(void)
+{
+	FILE *fh;
+	char buf[1024];
+	unsigned long start, end, size, lastend = 0;
+
+	fh = SAFE_FOPEN("/proc/sys/vm/mmap_min_addr", "r");
+
+	/* start filling from mmap_min_addr */
+	if (fscanf(fh, "%lu", &lastend) != 1) {
+		SAFE_FCLOSE(fh);
+		tst_brk(TBROK | TERRNO, "fscanf");
+		return;
+	}
+
+	SAFE_FCLOSE(fh);
+
+	fh = SAFE_FOPEN("/proc/self/maps", "r");
+
+	while (!feof(fh)) {
+		if (fgets(buf, sizeof(buf), fh) == NULL)
+			goto out;
+
+		if (sscanf(buf, "%lx-%lx", &start, &end) != 2) {
+			tst_brk(TBROK | TERRNO, "sscanf");
+			goto out;
+		}
+
+		size = start - lastend;
+
+		/* Skip the PROT_NONE that was just added (!size). */
+		if (!size) {
+			lastend = end;
+			continue;
+		}
+
+		/* If the next area is the stack, quit. */
+		if (!!strstr(buf, "[stack]"))
+			break;
+
+		/* This is not cleaned up. */
+		SAFE_MMAP((void *)lastend, size, PROT_NONE,
+			  MAP_ANON|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
+
+		lastend = end;
+	}
+
+out:
+	SAFE_FCLOSE(fh);
+}
+
 unsigned long read_stack_addr_from_proc(unsigned long *stack_size)
 {
 	FILE *fh;
@@ -130,6 +201,26 @@ void __attribute__((noinline)) preallocate_stack(unsigned long required)
 	garbage[0] = garbage[required - 1] = '\0';
 }
 
+static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
+{
+	void *map_test_gap;
+
+	force_bottom_up();
+
+	/*
+	 * fill_gaps_with_prot_none() used up all the spaces below the stack. The
+	 * search down path should fail, and search up might take a look at the guard
+	 * gap region. If it avoids it, the allocation will be above the stack. If
+	 * it uses it, the allocation will be in the gap and the test should fail.
+	 */
+	map_test_gap = SAFE_MMAP(0, MAPPED_LEN,
+				 PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, 0, 0);
+
+	if (stack_addr - gap <= (unsigned long)map_test_gap &&
+		(unsigned long)map_test_gap <= stack_addr)
+		_exit(EXIT_FAILURE);
+}
+
 void do_child(void)
 {
 	unsigned long stack_addr, stack_size;
@@ -179,6 +270,10 @@ void do_child(void)
 	dump_proc_self_maps();
 #endif
 
+	if (CAN_DO_PLACEMENT_TEST)
+		do_mmap_placement_test(stack_addr, gap);
+
+	/* Now see if it can grow too close to an adjacent region. */
 	exhaust_stack_into_sigsegv();
 }
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
