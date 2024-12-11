Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BC3E77180
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:55:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D61813E7D62
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 11:55:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D62623E7D55
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:55:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB0772171A0
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:55:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7E8C1F38C;
 Wed, 11 Dec 2024 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733914507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6dp0gshfBcnvq+cjEWBZGBU+1qlg5qfGLJj0glGJyX8=;
 b=e1nCUH+WShBe06bB7NIaTlzHNeVRfSyS6deJzqOF85YofAnYyFz7RfP95mHVBBZVP9QeN/
 4OJ6sAAULx/Lg6R9P/qRPI67d/hDNMmy1MBx4YIE4P+g+XxRlg69qjkUTsUEvEDvjG8Uc3
 KtAevP3eRQqcEfdrbh05i4sAATKLNA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733914507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6dp0gshfBcnvq+cjEWBZGBU+1qlg5qfGLJj0glGJyX8=;
 b=LvSunT2wBChn/19pYSUCqChP6AjgJu+x7EG/cQ2HGCcXkPSJ4uopC4IsoDdabnh/S3Dv+X
 U/V9zh1k21h84UCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xWJ3TVzg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OWCwcpIx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733914506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6dp0gshfBcnvq+cjEWBZGBU+1qlg5qfGLJj0glGJyX8=;
 b=xWJ3TVzgUi14dWsgBTw+fXVcVk6g7BC1SZVGsaaZuDDkpk6GqP/h3RnTn8wKqNIflJ71ES
 9QImMyGdjqU90VRQnCkh2lIhmH6Q2cOsmZdfgO2CnvV7/TNuXZ51KWHEhp4eQJOAm1PF7h
 X5KojSv6TXCTFLfuTSJmpEGgFcE1TI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733914506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6dp0gshfBcnvq+cjEWBZGBU+1qlg5qfGLJj0glGJyX8=;
 b=OWCwcpIxZ8RsjxaX7PduRji6V7l45GEaBevtSN9TeyLCEFej0ntyZ8ddz1OAk9lv2tnZxC
 sUdx0OoudsS2pRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B93E81344A;
 Wed, 11 Dec 2024 10:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8l3ILIpvWWdKZgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 11 Dec 2024 10:55:06 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>,
	ltp@lists.linux.it
Date: Wed, 11 Dec 2024 11:54:55 +0100
Message-ID: <20241211105500.13530-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: C7E8C1F38C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_creat_unlinked(): Add missing mode argument
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

The open() syscall requires the mode parameter if O_CREAT flag is used.
Add the missing mode parameter to the tst_creat_unlinked() helper function.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

During investigation of strange hugemmap11 failures I've noticed that
the test tries to create a scratch file with uninitialized access mode.
This was unrelated to the failures but should be fixed anyway.

 include/tst_test.h                                           | 2 +-
 lib/tst_test.c                                               | 4 ++--
 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c | 2 +-
 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c | 2 +-
 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c           | 4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c           | 4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c           | 4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c           | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c           | 2 +-
 31 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 8d1819f74..9da411a13 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -682,7 +682,7 @@ void tst_set_max_runtime(int max_runtime);
  * Create and open a random file inside the given dir path.
  * It unlinks the file after opening and return file descriptor.
  */
-int tst_creat_unlinked(const char *path, int flags);
+int tst_creat_unlinked(const char *path, int flags, mode_t mode);
 
 /*
  * Returns path to the test temporary directory root (TMPDIR).
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8db554dea..19d59b6d6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1101,7 +1101,7 @@ static void prepare_and_mount_hugetlb_fs(void)
 	mntpoint_mounted = 1;
 }
 
-int tst_creat_unlinked(const char *path, int flags)
+int tst_creat_unlinked(const char *path, int flags, mode_t mode)
 {
 	char template[PATH_MAX];
 	int len, c, range;
@@ -1120,7 +1120,7 @@ int tst_creat_unlinked(const char *path, int flags)
 	}
 
 	flags |= O_CREAT|O_EXCL|O_RDWR;
-	fd = SAFE_OPEN(template, flags);
+	fd = SAFE_OPEN(template, flags, mode);
 	SAFE_UNLINK(template);
 	return fd;
 }
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
index e4bb21e40..b7ab4e035 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -33,7 +33,7 @@ static void run_test(void)
 	int err;
 	unsigned long free_initial, free_after, free_after_delete;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
 	free_initial = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
 
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
index 4a25666ac..d03f43d67 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -36,7 +36,7 @@ static void run_test(void)
 	free_initial = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
 	max_iterations = MIN(free_initial, MAX_PAGES_TO_USE);
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
 	/* First preallocate file with max_iterations pages */
 	err = fallocate(fd, 0, 0, hpage_size * max_iterations);
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
index 90cefdba2..2404ffad1 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -66,7 +66,7 @@ static void run_test(void)
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index 846d22ff2..663d925f4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -112,7 +112,7 @@ cleanup:
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
+	huge_fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index f01a9f365..e3dd43087 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -117,7 +117,7 @@ static void run_test(unsigned int test_type)
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
+	huge_fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 336ccdf65..2a80edca9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -59,7 +59,7 @@ static void run_test(void)
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
+	huge_fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 0e1b64541..24cb117e9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -58,7 +58,7 @@ static int kernel_has_private_reservations(void)
 	void *p;
 
 	read_meminfo_huge(&t, &f, &r, &s);
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
 
@@ -182,7 +182,7 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
 {
 	long et, ef, er, es;
 
-	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0);
+	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	map_size[s] = hpages * hpage_size;
 	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
 				map_fd[s], 0);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 67fca2ddf..a98594af6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -34,8 +34,8 @@ static void run_test(void)
 	void *p;
 	char buf[IOSZ] __attribute__((aligned(IOSZ)));
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
-	nfd = tst_creat_unlinked(NORMAL_PATH, O_DIRECT);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	nfd = tst_creat_unlinked(NORMAL_PATH, O_DIRECT, 0600);
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
 	memcpy(p, P0, 8);
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
index 81367c513..848986cea 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -33,7 +33,7 @@ static void run_test(void)
 	void *p;
 	unsigned long initial_rsvd, map_rsvd, fadvise_rsvd, end_rsvd;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
 	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
 	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 42b80064e..06b5f8e08 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -102,7 +102,7 @@ static void setup(void)
 		tst_brk(TCONF, "Machine must be >32 bit");
 	if (hpage_size > FOURGB)
 		tst_brk(TCONF, "Huge page size is too large");
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index c54a746b3..d262b65b2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -134,7 +134,7 @@ static void setup(void)
 		tst_brk(TCONF, "Machine must be >32 bit");
 	if (hpage_size > FOURGB)
 		tst_brk(TCONF, "Huge page size is too large");
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index a84ba6476..ecfd51d0c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -204,7 +204,7 @@ static void run_test(void)
 	SAFE_SIGACTION(SIGBUS, &sa, NULL);
 	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
 	for (i = 0; i < NUM_REPETITIONS; i++)
 		if (test_once(fd))
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
index 2003e7013..e0238636b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -33,7 +33,7 @@ static void run_test(void)
 	void *p;
 	unsigned long initial_rsvd, map_rsvd, madvise_rsvd, end_rsvd;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 
 	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
 	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
index b8105bbf3..cca0291ad 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -79,7 +79,7 @@ static void setup(void)
 		tst_brk(TCONF, "Huge page size is too large");
 	if (TRUNCATE_POINT % hpage_size)
 		tst_brk(TCONF, "Truncation point is not aligned to huge page size");
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
index 607072937..afd7ad3f7 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -129,7 +129,7 @@ static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
 	page_size = getpagesize();
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
index 11060125b..c0e41dfa3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
@@ -123,7 +123,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
index e6b6bda76..3d3a95866 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -35,7 +35,7 @@ static void run_test(unsigned int i)
 	void *p;
 	struct tcase *tc = &tcases[i];
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	p = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE, tc->flags, fd, 0);
 
 	ret = mlock(p, hpage_size);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index 7abfda92d..faebbd228 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -94,7 +94,7 @@ static void run_test(void)
 static void setup(void)
 {
 	hpage_size = tst_get_hugepage_size();
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index c2deab477..d9be8113e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -29,7 +29,7 @@ static void run_test(unsigned int iter)
 	char pattern = 'A';
 	size_t size = NR_HUGEPAGES*hpage_size;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	m = SAFE_MMAP(NULL, size, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, 0);
 
 	for (i = 0; i < NR_HUGEPAGES; i++) {
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index d755161c9..3bcba0580 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -197,7 +197,7 @@ static void setup(void)
 	hpage_size = tst_get_hugepage_size();
 	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	addr = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	memset(addr, 0, hpage_size);
 	SAFE_MUNMAP(addr, hpage_size);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 3ba0985dc..ab6a3310a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -85,7 +85,7 @@ static void run_test(void)
 	long p_size, q_size;
 	int ret;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	ret = init_slice_boundary(fd);
 	if (ret)
 		goto cleanup;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 71beb90d3..1ad8a4141 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -76,7 +76,7 @@ static void run_test(void)
 	void *p;
 	int ret;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	p = map_align(3*hpage_size, hpage_size);
 
 	SAFE_MUNMAP(p, hpage_size);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index 609f2b63b..21be2d376 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -55,7 +55,7 @@ static void run_test(void)
 	void *p;
 	int ret;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	p = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
 	SAFE_MUNMAP(p, hpage_size);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index 218d9e190..bafae1ca8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -99,8 +99,8 @@ cleanup:
 static void setup(void)
 {
 	hpage_size = tst_get_hugepage_size();
-	fd1 = tst_creat_unlinked(MNTPOINT, 0);
-	fd2 = tst_creat_unlinked(MNTPOINT, 0);
+	fd1 = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	fd2 = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
index 060d1c858..660c93953 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -26,7 +26,7 @@ static void run_test(void)
 
 	initial_resv = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
 	q = SAFE_MMAP(NULL, hpage_size,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
index 6bff2c8e6..67857615a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -29,7 +29,7 @@ static void run_test(void)
 	unsigned int *pl, *ql;
 	unsigned long i;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
 		 fd, 0);
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
index 7ed9046f3..61b28c781 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -27,7 +27,7 @@ static void run_test(void)
 	void *p;
 	unsigned long initial_rsvd, map_rsvd, readahead_rsvd, end_rsvd;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
 
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
index 9072e9de4..171dbb070 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -26,7 +26,7 @@ static void run_test(void)
 	unsigned long *pl, *ql;
 	unsigned long i;
 
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
 		 fd, 0);
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index a7a88fbb2..f4c4eb85c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -107,7 +107,7 @@ void setup(void)
 	SAFE_GETRLIMIT(RLIMIT_STACK, &r);
 	if (r.rlim_cur != RLIM_INFINITY)
 		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
-	fd = tst_creat_unlinked(MNTPOINT, 0);
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
 }
 
 void cleanup(void)
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
