Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E73CEF177
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 14:00:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DCE23C1CF0
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 16:00:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A703C042F
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:45 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14807200B01
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728395983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6yw2YISnPKI4g3fZZKVAyxLBKpc/LcoeeNqEVFj+dU=;
 b=HepDHhjKxBYJij8Alp8lv/QoJfPqoeStg0HfF+wkm8OpBWnN1uQzkgFb/VmY79IUr9ecCW
 7ZO2R/i9HylmMOJ9POsz7MXekV8Rqxlk2TAN/RQUyMeCbiyze9ygJ8QalKozAMK4H8Il11
 xKLwvFzmho8o93PlIgH6KZ9ITdH+KDc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-M9KAWSEXNbatAfJCM1lrxg-1; Tue,
 08 Oct 2024 09:59:42 -0400
X-MC-Unique: M9KAWSEXNbatAfJCM1lrxg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CF761955D4E; Tue,  8 Oct 2024 13:59:41 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.33.151])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5506A1956088; Tue,  8 Oct 2024 13:59:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Oct 2024 15:59:32 +0200
Message-ID: <20241008135934.2491333-2-david@redhat.com>
In-Reply-To: <20241008135934.2491333-1-david@redhat.com>
References: <20241008135934.2491333-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] move_pages04: check for "invalid area",
 "no page mapped" and "shared zero page mapped"
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

While the kernel commit d899844e9c98 ("mm: fix status code which
move_pages() returns for zero page") fixed the return value when the
shared zero page was encountered to match what was stated in the man page,
it unfortunately also changed the behavior when no page is mapped yet --
when no page was faulted in/populated on demand.

Then, this test started failing, and we thought we would be testing for
the "zero page" case, but actually we were testing for the "no page mapped"
case, and didn't realize that the kernel commit had unintended side
effects.

As the kernel changed the behavior to return "-ENOENT" again for the
"no page mapped" case in commit 7dff875c9436 ("mm/migrate: convert
add_page_for_migration() from follow_page() to folio_walk") the test
starts failing again ... but for the wrong reason.

The man page clearly spells out that the expectation for the zero page is
"-EFAULT", and that "-EFAULT" can also be returned if "the memory area is
not mapped by the process" -- which means that there is no VMA/mmap()
covering that address.

The man page also documents that "-ENOENT" is returned when "The page is
not present", which includes "there is nothing mapped".

So let's fix the test and properly testing for all three separate things:
"invalid area/page", "no page mapped" and "shared zero page mapped".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages04.c | 106 ++++++++++++++----
 1 file changed, 85 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index f53453ab4..9fea63afa 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -26,18 +26,29 @@
  *	move_pages04.c
  *
  * DESCRIPTION
- *      Failure when page does not exit.
+ *      Failure when the memory area is not valid, no page is mapped yet or
+ *      the shared zero page is mapped.
  *
  * ALGORITHM
  *
- *      1. Pass zero page (allocated, but not written to) as one of the
- *         page addresses to move_pages().
- *      2. Check if the corresponding status is set to:
+ *      1. Pass the address of a valid memory area where no where no page is
+ *         mapped yet (not read/written), the address of a valid memory area
+ *         where the shared zero page is mapped (read, but not written to)
+ *         and the address of an invalid memory area as page addresses to
+ *         move_pages().
+ *      2. Check if the corresponding status for "no page mapped" is set to
+ *         -ENOENT. Note that kernels >= 4.3 [1] and < 6.12 [2] wrongly returned
+ *         -EFAULT by accident.
+ *      3. Check if the corresponding status for "shared zero page" is set to:
  *         -ENOENT for kernels < 4.3
  *         -EFAULT for kernels >= 4.3 [1]
+ *      4. Check if the corresponding status for "invalid memory area" is set
+ *         to -EFAULT.
  *
  * [1]
  * d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
+ * [2]
+ * 7dff875c9436 "mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk"
  *
  * USAGE:  <for command-line>
  *      move_pages04 [-c n] [-i n] [-I x] [-P x] [-t]
@@ -64,10 +75,12 @@
 #include "test.h"
 #include "move_pages_support.h"
 
-#define TEST_PAGES 2
+#define TEST_PAGES 4
 #define TEST_NODES 2
 #define TOUCHED_PAGES 1
-#define UNTOUCHED_PAGE (TEST_PAGES - 1)
+#define NO_PAGE TOUCHED_PAGES
+#define ZERO_PAGE (NO_PAGE + 1)
+#define INVALID_PAGE (ZERO_PAGE + 1)
 
 void setup(void);
 void cleanup(void);
@@ -89,12 +102,12 @@ int main(int argc, char **argv)
 	int lc;
 	unsigned int from_node;
 	unsigned int to_node;
-	int ret, exp_status;
+	int ret, exp_zero_page_status;
 
 	if ((tst_kvercmp(4, 3, 0)) >= 0)
-		exp_status = -EFAULT;
+		exp_zero_page_status = -EFAULT;
 	else
-		exp_status = -ENOENT;
+		exp_zero_page_status = -ENOENT;
 
 	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
 	if (ret < 0)
@@ -106,6 +119,7 @@ int main(int argc, char **argv)
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
 		unsigned long onepage = get_page_size();
+		char tmp;
 
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
@@ -114,14 +128,44 @@ int main(int argc, char **argv)
 		if (ret == -1)
 			continue;
 
-		/* Allocate page and do not touch it. */
-		pages[UNTOUCHED_PAGE] = numa_alloc_onnode(onepage, from_node);
-		if (pages[UNTOUCHED_PAGE] == NULL) {
-			tst_resm(TBROK, "failed allocating page on node %d",
+		/*
+		 * Allocate memory and do not touch it. Consequently, no
+		 * page will be faulted in / mapped into the page tables.
+		 */
+		pages[NO_PAGE] = numa_alloc_onnode(onepage, from_node);
+		if (pages[NO_PAGE] == NULL) {
+			tst_resm(TBROK, "failed allocating memory on node %d",
 				 from_node);
 			goto err_free_pages;
 		}
 
+		/*
+		 * Allocate memory, read from it, but do not write to it. This
+		 * will populate the shared zeropage.
+		 */
+		pages[ZERO_PAGE] = numa_alloc_onnode(onepage, from_node);
+		if (pages[ZERO_PAGE] == NULL) {
+			tst_resm(TBROK, "failed allocating memory on node %d",
+				 from_node);
+			goto err_free_pages;
+		}
+		/* Make the compiler not optimize-out the read. */
+		tmp = *((char *)pages[ZERO_PAGE]);
+		asm volatile("" : "+r" (tmp));
+
+		/*
+		 * Temporarily allocate memory and free it immediately. Do this
+		 * as the last step so the area won't get reused before we're
+		 * done.
+		 */
+		pages[INVALID_PAGE] = numa_alloc_onnode(onepage, from_node);
+		if (pages[INVALID_PAGE] == NULL) {
+			tst_resm(TBROK, "failed allocating memory on node %d",
+				 from_node);
+			goto err_free_pages;
+		}
+		numa_free(pages[INVALID_PAGE], onepage);
+
 		for (i = 0; i < TEST_PAGES; i++)
 			nodes[i] = to_node;
 
@@ -135,20 +179,40 @@ int main(int argc, char **argv)
 			tst_resm(TINFO, "move_pages() returned %d", ret);
 		}
 
-		if (status[UNTOUCHED_PAGE] == exp_status) {
+		if (status[NO_PAGE] == -ENOENT) {
 			tst_resm(TPASS, "status[%d] has expected value",
-				 UNTOUCHED_PAGE);
+				 NO_PAGE);
 		} else {
 			tst_resm(TFAIL, "status[%d] is %s, expected %s",
-				UNTOUCHED_PAGE,
-				tst_strerrno(-status[UNTOUCHED_PAGE]),
-				tst_strerrno(-exp_status));
+				NO_PAGE,
+				tst_strerrno(-status[NO_PAGE]),
+				tst_strerrno(ENOENT));
+		}
+
+		if (status[ZERO_PAGE] == exp_zero_page_status) {
+			tst_resm(TPASS, "status[%d] has expected value",
+				 ZERO_PAGE);
+		} else {
+			tst_resm(TFAIL, "status[%d] is %s, expected %s",
+				ZERO_PAGE,
+				tst_strerrno(-status[ZERO_PAGE]),
+				tst_strerrno(-exp_zero_page_status));
+		}
+
+		if (status[INVALID_PAGE] == -EFAULT) {
+			tst_resm(TPASS, "status[%d] has expected value",
+				 INVALID_PAGE);
+		} else {
+			tst_resm(TFAIL, "status[%d] is %s, expected %s",
+				INVALID_PAGE,
+				tst_strerrno(-status[INVALID_PAGE]),
+				tst_strerrno(EFAULT));
 		}
 
 err_free_pages:
-		/* This is capable of freeing both the touched and
-		 * untouched pages.
-		 */
+		/* Memory for the invalid page was already freed. */
+		pages[INVALID_PAGE] = NULL;
+		/* This is capable of freeing all memory we allocated. */
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-- 
2.46.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
