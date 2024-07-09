Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BEEC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:19:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 558693D393D
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 14:19:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2193D2BB5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:18:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8D6B8600689
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720527535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/zZ2FxPzU+JyqgtP/lxk/xXpRBrgS++lRxGTxXGfnUQ=;
 b=fAZGAkIXDozMddZJs0NlGUt0deF4wmmBOizStTei38nQzRwaxC7zF9hpLU12b8BsVL9Eu7
 v31TLS+0U5pc8sdGazwCOdWTLAQfC9RU7vkxKJqC32y1PeyzDHntyMdhZ4KdI+qiOAfuQ0
 29B4x0eGi/8KXHiL7PwQxTcsPTIajFE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-BqXvYNSVMKqAnm7J-of2gA-1; Tue,
 09 Jul 2024 08:18:51 -0400
X-MC-Unique: BqXvYNSVMKqAnm7J-of2gA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB7741954B31
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:18:49 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 471071955F3B; Tue,  9 Jul 2024 12:18:47 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jul 2024 14:18:38 +0200
Message-Id: <09c8813ad86c4a8034e3e35a183355c4f887f1b4.1720527432.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kallsyms: skip user-space mapped addresses
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RHEL9 s390x with KPTI enabled has been observed to sporadically
use same address ranges for user-space libraries as the ones
occupied by kallsyms while in kernel-space.

The test currently (wrongly) assumes, that a write to kallsym
address should fail and doesn't take into account that same
memory ranges could be mapped differently in user vs. kernel-space.

Add a check to see if a kallsym address is already mapped by user-space,
and if it is, skip it to avoid false positives.

Before:
    13	kallsyms.c:115: TFAIL: Successfully accessed kernel addr 0x3ff8060787d (r) (__kstrtabns_nfs3_set_ds_client)
    14	kallsyms.c:115: TFAIL: Successfully accessed kernel addr 0x3ff806007a0 (t) (nfs_init_server_aclclient)
    15	kallsyms.c:115: TFAIL: Successfully accessed kernel addr 0x3ff8060a058 (d) (nfsacl_version)
    16	kallsyms.c:115: TFAIL: Successfully accessed kernel addr 0x3ff8060a078 (d) (nfsacl_rpcstat)
    ...
    kallsyms.c:130: TFAIL: Caught 103102 SIGSEGV but expected 153738

After:
    kallsyms.c:175: TDEBUG: Skipping userspace mapped address 0x3ff80220024
    kallsyms.c:175: TDEBUG: Skipping userspace mapped address 0x3ff8022003c
    kallsyms.c:175: TDEBUG: Skipping userspace mapped address 0x3ff80213b20
    ...
    kallsyms.c:184: TPASS: Caught 103473 SIGSEGV in access ksymbols addr, skipped 27234

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/security/kallsyms/kallsyms.c | 68 +++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/security/kallsyms/kallsyms.c b/testcases/kernel/security/kallsyms/kallsyms.c
index 2a5cbaa325ea..b07cb9cda268 100644
--- a/testcases/kernel/security/kallsyms/kallsyms.c
+++ b/testcases/kernel/security/kallsyms/kallsyms.c
@@ -54,6 +54,8 @@ static struct kallsym *sym_table;
 static unsigned int nr_symbols;
 static sigjmp_buf jmpbuf;
 volatile sig_atomic_t segv_caught;
+static unsigned long *ranges;
+static int ranges_size, ranges_len;
 
 static void segv_handler(int sig)
 {
@@ -89,6 +91,49 @@ static unsigned int read_kallsyms(struct kallsym *table, unsigned int table_size
 	return nr_syms;
 }
 
+static void read_proc_self_maps(void)
+{
+	FILE *fp;
+
+	ranges_len = 0;
+	fp = fopen("/proc/self/maps", "r");
+	if (fp == NULL)
+		tst_brk(TBROK | TERRNO, "Failed to open /proc/self/maps.");
+
+	while (!feof(fp)) {
+		unsigned long start, end;
+		int ret;
+
+		ret = fscanf(fp, "%lx-%lx %*[^\n]\n", &start, &end);
+		if (ret != 2) {
+			fclose(fp);
+			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
+		}
+
+		if (ranges_size < ranges_len + 1) {
+			ranges_size += 128;
+			ranges = realloc(ranges, 2*ranges_size*sizeof(unsigned long));
+		}
+		ranges[ranges_len*2] = start;
+		ranges[ranges_len*2 + 1] = end;
+
+		ranges_len++;
+	}
+
+	fclose(fp);
+}
+
+static int is_address_mapped(unsigned long addr)
+{
+	int i;
+
+	for (i = 0; i < ranges_len; i++) {
+		if (ranges[i*2] <= addr && addr < ranges[i*2 + 1])
+			return 1;
+	}
+	return 0;
+}
+
 static void setup(void)
 {
 	struct sigaction sa;
@@ -117,17 +162,30 @@ static void access_ksymbols_address(struct kallsym *table)
 	}
 }
 
+
 static void test_access_kernel_address(void)
 {
-	segv_caught = 0;
+	int skipped = 0;
 
-	for (unsigned int i = 0; i < nr_symbols; i++)
+	segv_caught = 0;
+	read_proc_self_maps();
+
+	for (unsigned int i = 0; i < nr_symbols; i++) {
+		if (is_address_mapped(sym_table[i].addr)) {
+			tst_res(TDEBUG, "Skipping userspace mapped address 0x%lx",
+				sym_table[i].addr);
+			skipped++;
+			continue;
+		}
 		access_ksymbols_address(&sym_table[i]);
+	}
 
-	if (segv_caught == (sig_atomic_t)nr_symbols)
-		tst_res(TPASS, "Caught %d SIGSEGV in access ksymbols addr", segv_caught);
+	if (segv_caught == (sig_atomic_t)nr_symbols - skipped)
+		tst_res(TPASS, "Caught %d SIGSEGV in access ksymbols addr, skipped %d",
+			segv_caught, skipped);
 	else
-		tst_res(TFAIL, "Caught %d SIGSEGV but expected %d", segv_caught, nr_symbols);
+		tst_res(TFAIL, "Caught %d SIGSEGV but expected %d, skipped %d",
+			segv_caught, nr_symbols-skipped, skipped);
 }
 
 static void cleanup(void)
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
