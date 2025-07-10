Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB67C83F1B
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 15:26:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33D843CAF64
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 17:26:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167043C2122
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 17:25:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3EE376007A4
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 17:25:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE249218D6;
 Thu, 10 Jul 2025 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752161156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSp5dyoFzGD2MQ1tCHKeC2KQ4X6FJV69x5r9uu/OWmc=;
 b=ZavXiUzRjOuHAapaoUs3IhAD0FzgR5PTkxC2Ot1wkjgBeUlTIcnpIK97+xyI8GzZIJhq4m
 kcSY2OxKfJh/pJJApNWzmlyLR4lkFj+Hky8jh0cjwNzPY0hbhT1Ab4gdKEnbCNvZGTFWnD
 HKtMsaZ6TvSzaU3j5H6FdBdqzGs2V0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752161156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSp5dyoFzGD2MQ1tCHKeC2KQ4X6FJV69x5r9uu/OWmc=;
 b=73DOaowfaZS/e69VdTUFirsRnvOKekNXeh3ilOcpmBXq8VbjpdURHmLKKvXcyXLxVAgpxt
 4t7FGYICkxuj8pDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752161154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSp5dyoFzGD2MQ1tCHKeC2KQ4X6FJV69x5r9uu/OWmc=;
 b=lFh9Ryotqul+AOa66SZvWermaUDH4AgHTc9g2oj+zpV+FvaIw1oCCeG3ERBA+mbNk3RIib
 HWZsohsQ4V7TAwjRB+So7D8xsxUPfFb7xQlepDebH3UQY7oakHUJQOjEtJ+jxVERBq7kuW
 GuXB1y2nWyUponTcY70s5ozF8QA8DIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752161154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSp5dyoFzGD2MQ1tCHKeC2KQ4X6FJV69x5r9uu/OWmc=;
 b=oUgkkkOKgbirPbHrL2rniV4tQtYLP1y82DKRE/ptfRaYb19e/tMTAMZfv5BPW3fBXAY+Lc
 +CJ0CUvEqrvpcoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F3BA136CB;
 Thu, 10 Jul 2025 15:25:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kWq6JYLbb2hdSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Jul 2025 15:25:54 +0000
Date: Thu, 10 Jul 2025 17:26:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aG_bpRMoMs0XCGiD@yuki.lan>
References: <20250113055231.5908-1-wegao@suse.com>
 <20250226125141.27417-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250226125141.27417-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl10.c: New case test PROCMAP_QUERY ioctl()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've pushed the patch with following changes:

- removed .needs_root since the test runs fine without root

- moved the check for ioctl() support into the test setup() and the
  check for availability is only done on kernels older than 6.11 since
  it has to be available since that kernel version

- made use of guarded buffers for the procmap_query structure passed to
  the syscalls

What should still be done:

- we miss a few more errnos:
  - EINVAL if q->size is too small
  - E2BIG if q->size is larger than page size
  - EINVAL on invalid q->flags
  - EINVAL if only one of q->vma_name_size and q->qma_name_addr is set
  - EINVAL if only one of q->build_id_size and q->build_id_addr is set
  - ENAMETOOLONG if build_id_size or name_buf_size is too small
  - possibly ESRCH if we attempt to get memory map of a process that did exit and was waited for

- the invalid tests should be split into a separate test and stored in
  a tcase structure as we usually do, which makes it easier to add tests

Full diff:

diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
index 7ab3e4c43..6af2bb1f2 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl10.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -41,6 +41,9 @@ struct map_entry {
 	unsigned int vm_flags;
 };
 
+struct procmap_query *q;
+static int fd = -1;
+
 static unsigned int parse_vm_flags(const char *vm_flags_str)
 {
 	unsigned int flags = 0;
@@ -85,93 +88,108 @@ static void parse_maps_file(const char *filename, const char *keyword, struct ma
 
 static void verify_ioctl(void)
 {
-	struct procmap_query q;
-	int fd;
 	struct map_entry entry;
 
 	memset(&entry, 0, sizeof(entry));
 
-	fd = SAFE_OPEN("/proc/self/maps", O_RDONLY);
-
 	parse_maps_file(PROC_MAP_PATH, "*", &entry);
 
 	/* CASE 1: exact MATCH at query_addr */
-	memset(&q, 0, sizeof(q));
-	q.size = sizeof(q);
-	q.query_addr = (uint64_t)entry.vm_start;
-	q.query_flags = 0;
-
-	TEST(ioctl(fd, PROCMAP_QUERY, &q));
-
-	if ((TST_RET == -1) && (TST_ERR == ENOTTY))
-		tst_brk(TCONF,
-			"This system does not provide support for ioctl(PROCMAP_QUERY)");
-
-
-	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
-
-	TST_EXP_EQ_LU(q.query_addr, entry.vm_start);
-	TST_EXP_EQ_LU(q.query_flags, 0);
-	TST_EXP_EQ_LU(q.vma_flags, entry.vm_flags);
-	TST_EXP_EQ_LU(q.vma_start, entry.vm_start);
-	TST_EXP_EQ_LU(q.vma_end, entry.vm_end);
-	TST_EXP_EQ_LU(q.vma_page_size, getpagesize());
-	TST_EXP_EQ_LU(q.vma_offset, entry.vm_pgoff);
-	TST_EXP_EQ_LU(q.inode, entry.vm_inode);
-	TST_EXP_EQ_LU(q.dev_major, entry.vm_major);
-	TST_EXP_EQ_LU(q.dev_minor, entry.vm_minor);
+	memset(q, 0, sizeof(*q));
+	q->size = sizeof(*q);
+	q->query_addr = (uint64_t)entry.vm_start;
+	q->query_flags = 0;
+
+	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, q));
+
+	TST_EXP_EQ_LU(q->query_addr, entry.vm_start);
+	TST_EXP_EQ_LU(q->query_flags, 0);
+	TST_EXP_EQ_LU(q->vma_flags, entry.vm_flags);
+	TST_EXP_EQ_LU(q->vma_start, entry.vm_start);
+	TST_EXP_EQ_LU(q->vma_end, entry.vm_end);
+	TST_EXP_EQ_LU(q->vma_page_size, getpagesize());
+	TST_EXP_EQ_LU(q->vma_offset, entry.vm_pgoff);
+	TST_EXP_EQ_LU(q->inode, entry.vm_inode);
+	TST_EXP_EQ_LU(q->dev_major, entry.vm_major);
+	TST_EXP_EQ_LU(q->dev_minor, entry.vm_minor);
 
 	/* CASE 2: NO MATCH at query_addr */
-	memset(&q, 0, sizeof(q));
-	q.size = sizeof(q);
-	q.query_addr = entry.vm_start - 1;
-	q.query_flags = 0;
+	memset(q, 0, sizeof(*q));
+	q->size = sizeof(*q);
+	q->query_addr = entry.vm_start - 1;
+	q->query_flags = 0;
 
-	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, &q), ENOENT);
+	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, q), ENOENT);
 
 	/* CASE 3: MATCH COVERING_OR_NEXT_VMA */
-	memset(&q, 0, sizeof(q));
-	q.size = sizeof(q);
-	q.query_addr = entry.vm_start - 1;
-	q.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
+	memset(q, 0, sizeof(*q));
+	q->size = sizeof(*q);
+	q->query_addr = entry.vm_start - 1;
+	q->query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
 
-	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
+	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, q));
 
 	/* CASE 4: NO MATCH WRITABLE at query_addr */
 	memset(&entry, 0, sizeof(entry));
 	parse_maps_file(PROC_MAP_PATH, "*r-?p *", &entry);
 
-	memset(&q, 0, sizeof(q));
-	q.size = sizeof(q);
-	q.query_addr = entry.vm_start;
-	q.query_flags = PROCMAP_QUERY_VMA_WRITABLE;
-	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, &q), ENOENT);
+	memset(q, 0, sizeof(*q));
+	q->size = sizeof(*q);
+	q->query_addr = entry.vm_start;
+	q->query_flags = PROCMAP_QUERY_VMA_WRITABLE;
+	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, q), ENOENT);
 
 	/* CASE 5: check vma_name_addr content */
 	char process_name[256];
-	char pattern[256];
+	char pattern[258];
 	char buf[256];
 
 	SAFE_READLINK("/proc/self/exe", process_name, sizeof(process_name));
-	sprintf(pattern, "*%s*", process_name);
+	snprintf(pattern, sizeof(pattern), "*%s*", process_name);
 	memset(&entry, 0, sizeof(entry));
 	parse_maps_file(PROC_MAP_PATH, pattern, &entry);
 
-	memset(&q, 0, sizeof(q));
-	q.size = sizeof(q);
-	q.query_addr = entry.vm_start;
-	q.query_flags = 0;
-	q.vma_name_addr = (uint64_t)(unsigned long)buf;
-	q.vma_name_size = sizeof(buf);
+	memset(q, 0, sizeof(*q));
+	q->size = sizeof(*q);
+	q->query_addr = entry.vm_start;
+	q->query_flags = 0;
+	q->vma_name_addr = (uint64_t)(unsigned long)buf;
+	q->vma_name_size = sizeof(buf);
 
-	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
-	TST_EXP_EQ_LU(q.vma_name_size, strlen(process_name) + 1);
-	TST_EXP_EQ_STR((char *)q.vma_name_addr, process_name);
+	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, q));
+	TST_EXP_EQ_LU(q->vma_name_size, strlen(process_name) + 1);
+	TST_EXP_EQ_STR((char *)q->vma_name_addr, process_name);
 
 	SAFE_CLOSE(fd);
 }
 
+static void setup(void)
+{
+	struct procmap_query q = {};
+
+	fd = SAFE_OPEN(PROC_MAP_PATH, O_RDONLY);
+
+	if (tst_kvercmp(6, 11, 0) < 0) {
+		TEST(ioctl(fd, PROCMAP_QUERY, q));
+
+		if ((TST_RET == -1) && (TST_ERR == ENOTTY))
+			tst_brk(TCONF,
+				"This system does not provide support for ioctl(PROCMAP_QUERY)");
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
 static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = verify_ioctl,
-	.needs_root = 1,
+	.bufs = (struct tst_buffers []) {
+		{&q, .size = sizeof(*q)},
+		{}
+	}
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
