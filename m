Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0327CCEF177
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 14:00:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 942C93C1C21
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 16:00:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DDA23C1BE2
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:52 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E90F1000C61
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728395990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTS3ZLpPjyGZgSp2NaESXZHWtmCUlp+MMiVbeEmP++Y=;
 b=KTwmjKKQb/e/DGCKly5JZDP1uweFxEYhNduOgB6Sd1uHVTbd/91lMDrNQZUItkRSDBczkk
 L9JeCQ7jqF2u6+qpFqZwmpvNu4gDMn4Y1olAtVw/OnSG4oWTfxDx5P4Ly/401ygoqpHFOm
 4dpWWqRdE5lj8EAVfyY1S8MdBlgny54=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-NKw_vV4ZOY2SlemLQgNxcg-1; Tue,
 08 Oct 2024 09:59:46 -0400
X-MC-Unique: NKw_vV4ZOY2SlemLQgNxcg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BA6D1955D92; Tue,  8 Oct 2024 13:59:46 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.33.151])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E4E01956089; Tue,  8 Oct 2024 13:59:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Oct 2024 15:59:34 +0200
Message-ID: <20241008135934.2491333-4-david@redhat.com>
In-Reply-To: <20241008135934.2491333-1-david@redhat.com>
References: <20241008135934.2491333-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] move_pages04: convert to new test API
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let's convert the test to the new test API and cleanup the file header
a bit.

It's worth nothing that the "-c", "-P" and "-t" options are were not
working although documented.

Suggested-by: Cc: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages04.c | 287 +++++++-----------
 1 file changed, 108 insertions(+), 179 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 7ad4ba78c..16db3f918 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -1,33 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
- *
- *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
- *   Original copyright message:
- *
  *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-/*
- * NAME
- *	move_pages04.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *      Failure when the memory area is not valid, no page is mapped yet or
- *      the shared zero page is mapped.
+ * Verify that move_pages() properly reports failures when the memory area is
+ * not valid, no page is mapped yet or the shared zero page is mapped.
  *
  * ALGORITHM
  *
@@ -48,21 +29,6 @@
  * d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
  * [2]
  * 7dff875c9436 "mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk"
- *
- * USAGE:  <for command-line>
- *      move_pages04 [-c n] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	05/2008 Vijay Kumar
- *		Initial Version.
- *
- * Restrictions
- *	None
  */
 
 #include <sys/mman.h>
@@ -71,7 +37,7 @@
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
-#include "test.h"
+#include "tst_test.h"
 #include "move_pages_support.h"
 
 #define TEST_PAGES 4
@@ -81,162 +47,125 @@
 #define ZERO_PAGE (NO_PAGE + 1)
 #define INVALID_PAGE (ZERO_PAGE + 1)
 
-void setup(void);
-void cleanup(void);
-
-char *TCID = "move_pages04";
-int TST_TOTAL = 1;
-
-typedef void (*sighandler_t) (int);
-
-int main(int argc, char **argv)
+static void run(void)
 {
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
 #ifdef HAVE_NUMA_V2
 	unsigned int i;
-	int lc;
 	unsigned int from_node;
 	unsigned int to_node;
 	int ret;
+	void *pages[TEST_PAGES] = { 0 };
+	int nodes[TEST_PAGES];
+	int status[TEST_PAGES];
+	unsigned long onepage = get_page_size();
+	char tmp;
 
 	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "get_allowed_nodes: %d", ret);
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		void *pages[TEST_PAGES] = { 0 };
-		int nodes[TEST_PAGES];
-		int status[TEST_PAGES];
-		unsigned long onepage = get_page_size();
-		char tmp;
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		ret = alloc_pages_on_node(pages, TOUCHED_PAGES, from_node);
-		if (ret == -1)
-			continue;
-
-		/*
-		 * Allocate memory and do not touch it. Consequently, no
-		 * page will be faulted in / mapped into the page tables.
-		 */
-		pages[NO_PAGE] = numa_alloc_onnode(onepage, from_node);
-		if (pages[NO_PAGE] == NULL) {
-			tst_resm(TBROK, "failed allocating memory on node %d",
-				 from_node);
-			goto err_free_pages;
-		}
-
-		/*
-		 * Allocate memory, read from it, but do not write to it. This
-		 * will populate the shared zeropage.
-		 */
-		pages[ZERO_PAGE] = numa_alloc_onnode(onepage, from_node);
-		if (pages[ZERO_PAGE] == NULL) {
-			tst_resm(TBROK, "failed allocating memory on node %d",
-				 from_node);
-			goto err_free_pages;
-		}
-		/* Make the compiler not optimize-out the read. */
-		tmp = *((char *)pages[ZERO_PAGE]);
-		asm volatile("" : "+r" (tmp));
-
-		/*
-		 * Temporarily allocate memory and free it immediately. Do this
-		 * as the last step so the area won't get reused before we're
-		 * done.
-		 */
-		pages[INVALID_PAGE] = numa_alloc_onnode(onepage, from_node);
-		if (pages[INVALID_PAGE] == NULL) {
-			tst_resm(TBROK, "failed allocating memory on node %d",
-				 from_node);
-			goto err_free_pages;
-		}
-		numa_free(pages[INVALID_PAGE], onepage);
-
-		for (i = 0; i < TEST_PAGES; i++)
-			nodes[i] = to_node;
-
-		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
-				      status, MPOL_MF_MOVE);
-		if (ret == -1) {
-			tst_resm(TFAIL | TERRNO,
-				 "move_pages unexpectedly failed");
-			goto err_free_pages;
-		} else if (ret > 0) {
-			tst_resm(TINFO, "move_pages() returned %d", ret);
-		}
-
-		if (status[NO_PAGE] == -ENOENT) {
-			tst_resm(TPASS, "status[%d] has expected value",
-				 NO_PAGE);
-		} else {
-			tst_resm(TFAIL, "status[%d] is %s, expected %s",
-				NO_PAGE,
-				tst_strerrno(-status[NO_PAGE]),
-				tst_strerrno(ENOENT));
-		}
-
-		if (status[ZERO_PAGE] == -EFAULT) {
-			tst_resm(TPASS, "status[%d] has expected value",
-				 ZERO_PAGE);
-		} else {
-			tst_resm(TFAIL, "status[%d] is %s, expected %s",
-				ZERO_PAGE,
-				tst_strerrno(-status[ZERO_PAGE]),
-				tst_strerrno(EFAULT));
-		}
-
-		if (status[INVALID_PAGE] == -EFAULT) {
-			tst_resm(TPASS, "status[%d] has expected value",
-				 INVALID_PAGE);
-		} else {
-			tst_resm(TFAIL, "status[%d] is %s, expected %s",
-				INVALID_PAGE,
-				tst_strerrno(-status[INVALID_PAGE]),
-				tst_strerrno(EFAULT));
-		}
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
 
-err_free_pages:
-		/* Memory for the invalid page was already freed. */
-		pages[INVALID_PAGE] = NULL;
-		/* This is capable of freeing all memory we allocated. */
-		free_pages(pages, TEST_PAGES);
+	ret = alloc_pages_on_node(pages, TOUCHED_PAGES, from_node);
+	if (ret == -1)
+		tst_brk(TBROK, "failed allocating memory on node %d",
+			from_node);
+
+	/*
+	 * Allocate memory and do not touch it. Consequently, no
+	 * page will be faulted in / mapped into the page tables.
+	 */
+	pages[NO_PAGE] = numa_alloc_onnode(onepage, from_node);
+	if (pages[NO_PAGE] == NULL)
+		tst_brk(TBROK, "failed allocating memory on node %d",
+			from_node);
+
+	/*
+	 * Allocate memory, read from it, but do not write to it. This
+	 * will populate the shared zeropage.
+	 */
+	pages[ZERO_PAGE] = numa_alloc_onnode(onepage, from_node);
+	if (pages[ZERO_PAGE] == NULL)
+		tst_brk(TBROK, "failed allocating memory on node %d",
+			from_node);
+	/* Make the compiler not optimize-out the read. */
+	tmp = *((char *)pages[ZERO_PAGE]);
+	asm volatile("" : "+r" (tmp));
+
+	/*
+	 * Temporarily allocate memory and free it immediately. Do this
+	 * as the last step so the area won't get reused before we're
+	 * done.
+	 */
+	pages[INVALID_PAGE] = numa_alloc_onnode(onepage, from_node);
+	if (pages[INVALID_PAGE] == NULL)
+		tst_brk(TBROK, "failed allocating memory on node %d",
+			from_node);
+	numa_free(pages[INVALID_PAGE], onepage);
+
+	for (i = 0; i < TEST_PAGES; i++)
+		nodes[i] = to_node;
+
+	ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
+			      status, MPOL_MF_MOVE);
+	if (ret == -1) {
+		tst_res(TFAIL | TERRNO,
+			"move_pages unexpectedly failed");
+		goto err_free_pages;
+	} else if (ret > 0) {
+		tst_res(TINFO, "move_pages() returned %d", ret);
 	}
+
+	if (status[NO_PAGE] == -ENOENT) {
+		tst_res(TPASS, "status[%d] has expected value",
+			NO_PAGE);
+	} else {
+		tst_res(TFAIL, "status[%d] is %s, expected %s",
+			NO_PAGE,
+			tst_strerrno(-status[NO_PAGE]),
+			tst_strerrno(ENOENT));
+	}
+
+	if (status[ZERO_PAGE] == -EFAULT) {
+		tst_res(TPASS, "status[%d] has expected value",
+			ZERO_PAGE);
+	} else {
+		tst_res(TFAIL, "status[%d] is %s, expected %s",
+			ZERO_PAGE,
+			tst_strerrno(-status[ZERO_PAGE]),
+			tst_strerrno(EFAULT));
+	}
+
+	if (status[INVALID_PAGE] == -EFAULT) {
+		tst_res(TPASS, "status[%d] has expected value",
+			INVALID_PAGE);
+	} else {
+		tst_res(TFAIL, "status[%d] is %s, expected %s",
+			INVALID_PAGE,
+			tst_strerrno(-status[INVALID_PAGE]),
+			tst_strerrno(EFAULT));
+	}
+
+err_free_pages:
+	/* Memory for the invalid page was already freed. */
+	pages[INVALID_PAGE] = NULL;
+	/* This is capable of freeing all memory we allocated. */
+	free_pages(pages, TEST_PAGES);
 #else
-	tst_resm(TCONF, NUMA_ERROR_MSG);
+	tst_res(TCONF, NUMA_ERROR_MSG);
 #endif
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- */
 void setup(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
 	check_config(TEST_NODES);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at completion
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.max_runtime = 120,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d899844e9c98"},
+		{"linux-git", "7dff875c9436"},
+		{}
+	}
+};
-- 
2.46.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
