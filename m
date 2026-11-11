Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD18606A31C
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=oQX/zREM;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PJ4Cmh4Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794389556; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=p+LyHIdNPITcnZS5HDUUTiuwwmwyPR1SKEp0ORWETaI=;
 b=oQX/zREMRQkh3L7M5UtUadXgLmXfeWJHosPEJLHDTKVbxXaAuiG4DMkGl1LyBBvjbTO9N
 1CLaVU5+BrPpaht/JglSEcf4IjFuLoSdJnjrysf6KJ3gBiEb7BY8AK72RMPG4FCMepba8eS
 v3J88M+4KsFdXWjYZsQ1uL9HylB/tX0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B9B63E9503
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 10:32:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F4A03E9500
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:32:02 +0100 (CET)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10024600A43
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:32:02 +0100 (CET)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cdb96533adfso1741533a12.3
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 01:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794389520; x=1794994320; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R5l98SdoUuEwUFPEEO/r90W1EfuErt3pq90/OG7SL0I=;
 b=PJ4Cmh4QoJk2+q/Cd0zBUywwSbssIna7c46dAUFOocoVKE8Yl6m17m9w5dqWUeUyNR
 vcjSX6/KnnS/ud10BBgk6jmNnKM6w2BW8zs8tJRcypWoWZKCIMXbqCdwzrN/uX6kxoFa
 pBW6PXgSZbEA3PAqC2W0cObwg4mTjSFcxdOUQJAM+RptRkhpWyz8RpAZNMorHbGN869G
 EO5fKnuQG43k/BDoT0FLjKbcg39x+hCdALD3y0eIYirtFbpC9Fa53rIJH07bSOGqtHL4
 KZJ1UjRmr+p/BMsLT8A5B+bsq5lcVoSNg3LywXsCy+fiwEoT7A2mdcdQUb4npSAV8uzg
 a9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389520; x=1794994320;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R5l98SdoUuEwUFPEEO/r90W1EfuErt3pq90/OG7SL0I=;
 b=1/0eSgSCVzbHp5rryAx+TAOvirhRp/jcqYFZGgrgdv6T1+GHgaLy/k6xuk9Ll0j0/u
 Eu7ND2pOmNoebm7T8j7o4as6qkPy5anLumPIWrp74fvDz9o1QquZbTMnjEZu/Y0Cq4sc
 a65HLa4LEaLh1soQpYlyAmoFY+EVw6u2Guda43OSvj38mmp9z77yJJGU2paTPHXU7TiI
 +lv2GZ2M34qykrf17Mkd93aGcqPQxh7V3vwGee9TtHzZKNaBlig3P5BfTaB+gdjK+uTO
 JF487PZTCdGtYhVfYUWUqpH3RDF9JwBLXYq0XiZB+c0aJWVgC5UuuOoRW/1wppKCwBcp
 /NYg==
X-Gm-Message-State: APuU4Z9FTBWuvoApLHazkNJafA0O2jQ7Xwd1vYQ0UgXBPZDvLSnF/hlv
 9uuxxLIB6NAyww3e7LNPXNtVuFTQTfN+Cgp9N37tSXunCLewmZ2SJ6akwB6gLuPJxbHg9QmgNvt
 cOeB1Dl1ZetX3zMqnNGlin+bS+4znHwkLgHXxigcJjlY7puNZ8cz8rHMjqcrXbhSKARqifmh/R1
 y9wKyDb4LLGV+DRjpF3oShSbIiMQ==
X-Received: from pgp6-n2.prod.google.com
 ([2002:a05:6a02:62c6:20b0:cc7:dd4c:a852])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7346:b0:3e0:da23:873b
 with SMTP id adf61e73a8af0-3f2fe3cd88amr2008812637.59.1794389520089; Wed, 11
 Nov 2026 01:32:00 -0800 (PST)
Date: Wed, 11 Nov 2026 09:31:49 +0000
In-Reply-To: <20261111093151.374731-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111093151.374731-3-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: [LTP] [PATCH 2/4] memcg,
 userfaultfd07: Populate whole pages instead of single bytes
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

memcontrol02 and mem_process, the helper of memcg_control_test.sh,
fault in their memory by writing one byte per getpagesize() bytes, and
userfaultfd07 populates the page cache of its memfd by writing a single
byte. All of them assume that this populates whole pages of
getpagesize() bytes.

That is not the case when the kernel faults in and caches memory in
smaller units than the page size it reports to userspace, as with the
16K page size emulation that Android uses on x86_64. Only one in four
4K pages gets populated there, so memcontrol02 sees only about a
quarter of the expected 50M in memory.current, mem_process stays below
the memory limit it is supposed to exceed, and UFFDIO_CONTINUE in
userfaultfd07 fails for the part of the page that is not in the page
cache:

  TBROK: ioctl(4,UFFDIO_CONTINUE,...) failed: EAGAIN/EWOULDBLOCK (11)

Write the whole buffers instead. Nothing changes on kernels where both
page sizes are equal.

Signed-off-by: Wake Liu <wakel@google.com>
---

Notes:
    alloc_anon() in memcontrol_common.h, used by memcontrol03 and
    memcontrol04, writes one byte per page as well. It frees the buffer
    right away, so GCC and Clang would drop a plain memset() there as a
    dead store and it needs a different fix. I will look at it
    separately.

 .../kernel/controllers/memcg/control/mem_process.c  | 11 ++++++-----
 testcases/kernel/controllers/memcg/memcontrol02.c   | 13 +++++++------
 .../kernel/syscalls/userfaultfd/userfaultfd07.c     | 11 +++++++++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/mem_process.c b/testcases/kernel/controllers/memcg/control/mem_process.c
index 8ecabb272..f32189cc2 100644
--- a/testcases/kernel/controllers/memcg/control/mem_process.c
+++ b/testcases/kernel/controllers/memcg/control/mem_process.c
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 
 /*
@@ -49,14 +50,14 @@ void process_options(int argc, char **argv)
 
 /*
  * touch_memory: force physical memory allocation
+ *
+ * Write the whole area rather than one byte per getpagesize(), so that it
+ * gets fully populated regardless of the granularity the kernel faults in
+ * memory with.
  */
 void touch_memory(char *p)
 {
-	int i;
-	int pagesize = getpagesize();
-
-	for (i = 0; i < (int)memsize; i += pagesize)
-		p[i] = 0xef;
+	memset(p, 0xef, memsize);
 }
 
 void mem_map(void)
diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 52096f697..6687c6e84 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -27,7 +27,6 @@
 #define _GNU_SOURCE
 #include "memcontrol_common.h"
 
-static size_t page_size;
 static struct tst_cg_group *cg_child;
 static int fd = -1;
 static int file_to_all_error = 10;
@@ -35,14 +34,18 @@ static int file_to_all_error = 10;
 static void alloc_anon_50M_check(void)
 {
 	const ssize_t size = MB(50);
-	char *buf, *ptr;
+	char *buf;
 	ssize_t anon, current;
 	const char *const anon_key_fmt =
 		TST_CG_VER_IS_V1(tst_cg, "memory") ? "rss %zd" : "anon %zd";
 
 	buf = SAFE_MALLOC(size);
-	for (ptr = buf; ptr < buf + size; ptr += page_size)
-		*ptr = 0;
+	/*
+	 * Write the whole buffer rather than one byte per getpagesize(), so
+	 * that it gets fully populated regardless of the granularity the
+	 * kernel faults in memory with.
+	 */
+	memset(buf, 1, size);
 
 	SAFE_CG_SCANF(cg_child, "memory.current", "%zd", &current);
 	TST_EXP_EXPR(current >= size,
@@ -113,8 +116,6 @@ static void test_memcg_current(unsigned int n)
 
 static void setup(void)
 {
-	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
-
 	switch (tst_fs_type(TMPDIR)) {
 	case TST_VFAT_MAGIC:
 	case TST_EXFAT_MAGIC:
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
index e0a1b0d23..dce6d8827 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
@@ -32,7 +32,7 @@ static void setup(void)
 
 static void set_pages(void)
 {
-	char ch = 'A';
+	char *buf;
 
 	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
 
@@ -45,8 +45,15 @@ static void set_pages(void)
 	/*
 	 * Populate page cache so that after MADV_DONTNEED the next access
 	 * can generate a MINOR fault rather than a MISSING fault.
+	 *
+	 * Write the whole page, as UFFDIO_CONTINUE needs the page cache to
+	 * cover the whole range and the kernel may cache memory in units
+	 * smaller than getpagesize().
 	 */
-	SAFE_PWRITE(1, memfd, &ch, 1, 0);
+	buf = SAFE_MALLOC(page_size);
+	memset(buf, 'A', page_size);
+	SAFE_PWRITE(1, memfd, buf, page_size, 0);
+	free(buf);
 
 	page = SAFE_MMAP(NULL, page_size, PROT_READ, MAP_SHARED, memfd, 0);
 }
-- 
2.56.0.567.gdb80ae8cd5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
