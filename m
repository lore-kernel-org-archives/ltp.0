Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EBCC7EE23
	for <ltp@archiver.kernel.org>; Wed, 31 May 2023 23:57:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 558373CEB16
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 01:57:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7F443CA17A
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 01:57:42 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01F7360071A
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 01:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685577460; x=1717113460;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4a0Df6VumTCMoZXs195e22gcDeXgW6Nem52NufZEo6w=;
 b=n3htvt4O+JgjVln1loxZQ+aGJdTnc5zkyYl5FGkxQRt2q7R//vLI/ksE
 mjAMXwKCQq0QLbL0n96I3bGXDznrd03BfYMv1kKuK5UPeFfrV0IV/sFxw
 B6tnRj9CC89ViogndlojA1IMgUjD0w9Pw32tJ3Lhj8p0Y0SKo2EcHHdQb
 +6Wp+hVIoFlSntWnNSX9Ysjl5/GZfBuqxQ1lGPQEalpKkABWljSa0RBfH
 ZFh+gHDlAr8UXNWxKWo6J1A+UjNwuN3xC8MOOAH40HQdfejVI8IazxD7j
 2h4Z+R02+fxoX8UFkC8y8Mw1s4Rk1T757i4Y3pI3flXcCvJuDMXQfGe4v g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="383666499"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="383666499"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 16:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="710260815"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="710260815"
Received: from tonyshi-mobl.amr.corp.intel.com (HELO
 rpedgeco-desk4.amr.corp.intel.com) ([10.212.189.211])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 16:57:35 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Wed, 31 May 2023 16:57:25 -0700
Message-Id: <20230531235725.389539-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] security/stack_clash: Add test for mmap() minding
 gap
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
architectures. Make the test only run on x86_64 for now.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v2:
 - Add fixes commit (Cyril Hrubis)
 - Report placement test failure separately (Cyril Hrubis)
 - Use SAFE_FILE_SCANF (Cyril Hrubis)
 - Don't quit after failing placement test, so unmap the mapping that
   caused the failure. (Cyril Hrubis)
 - Drop CAN_DO_PLACEMENT_TEST (Cyril Hrubis)
---
 testcases/cve/stack_clash.c | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index cd7f148c2..d1ce93326 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -18,6 +18,14 @@
  * to infinity and preallocate REQ_STACK_SIZE bytes of stack so that no calls
  * after `mmap` are moving stack further.
  *
+ * If the architecture meets certain requirements (only x86_64 is verified)
+ * then the test also tests that new mmap()s can't be placed in the stack's
+ * guard gap. This part of the test works by forcing a bottom up search. The
+ * assumptions are that the stack grows down (start gap) and either:
+ *   1. The default search is top down, and will switch to bottom up if
+ *      space is exhausted.
+ *   2. The default search is bottom up and the stack is above mmap base
+ *
  * [1] https://blog.qualys.com/securitylabs/2017/06/19/the-stack-clash
  * [2] https://bugzilla.novell.com/show_bug.cgi?id=CVE-2017-1000364
  */
@@ -78,6 +86,49 @@ void segv_handler(int sig, siginfo_t *info, void *data LTP_ATTRIBUTE_UNUSED)
 		_exit(EXIT_SUCCESS);
 }
 
+static void force_bottom_up(void)
+{
+	FILE *fh;
+	char buf[1024];
+	unsigned long start, end, size, lastend = 0;
+
+	/* start filling from mmap_min_addr */
+	SAFE_FILE_SCANF("/proc/sys/vm/mmap_min_addr", "%lu", &lastend);
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
@@ -130,6 +181,28 @@ void __attribute__((noinline)) preallocate_stack(unsigned long required)
 	garbage[0] = garbage[required - 1] = '\0';
 }
 
+static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
+{
+	void *map_test_gap;
+
+	force_bottom_up();
+
+	/*
+	 * force_bottom_up() used up all the spaces below the stack. The search down
+	 * path should fail, and search up might take a look at the guard gap
+	 * region. If it avoids it, the allocation will be above the stack. If it
+	 * uses it, the allocation will be in the gap and the test should fail.
+	 */
+	map_test_gap = SAFE_MMAP(0, MAPPED_LEN,
+				 PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, 0, 0);
+
+	if (stack_addr - gap <= (unsigned long)map_test_gap &&
+		(unsigned long)map_test_gap <= stack_addr) {
+		tst_res(TFAIL, "New mmap was placed in the guard gap.");
+		SAFE_MUNMAP(map_test_gap, MAPPED_LEN);
+	}
+}
+
 void do_child(void)
 {
 	unsigned long stack_addr, stack_size;
@@ -179,6 +252,11 @@ void do_child(void)
 	dump_proc_self_maps();
 #endif
 
+#ifdef __x86_64__
+	do_mmap_placement_test(stack_addr, gap);
+#endif
+
+	/* Now see if it can grow too close to an adjacent region. */
 	exhaust_stack_into_sigsegv();
 }
 
@@ -252,6 +330,7 @@ static struct tst_test test = {
 	.test_all = stack_clash_test,
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2017-1000364"},
+		{"linux-git", "58c5d0d6d522"},
 		{}
 	}
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
