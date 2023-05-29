Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E58C77B7A
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 06:12:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B423CCFF5
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 08:12:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B0003CA128
 for <ltp@lists.linux.it>; Mon, 29 May 2023 08:11:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85E4E60012C
 for <ltp@lists.linux.it>; Mon, 29 May 2023 08:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685340701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjDs22wlgZk73vAcXclxtNMYkJOlcOHq87mWURS06hk=;
 b=QsZ/VI0uzYGODWtex6ujrAHq3jb5es3erGkUNxBIZE36QCzvWa6yg3T6iCyk8KWG1dYmnD
 zovlOOVEr6aQTBjoISR7cxo9LaMmNFbbfXTFH9BvKTHXCM6t6gZIIIaEqJxmnzpjAOGedx
 IoS1vrHi5IBY+zEfOJst01P7BIeqEzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-6sOHW1adNP-2IZWONXoaQw-1; Mon, 29 May 2023 02:11:40 -0400
X-MC-Unique: 6sOHW1adNP-2IZWONXoaQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3408385A5BB
 for <ltp@lists.linux.it>; Mon, 29 May 2023 06:11:40 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 425E63543C
 for <ltp@lists.linux.it>; Mon, 29 May 2023 06:11:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 29 May 2023 14:11:35 +0800
Message-Id: <20230529061135.24261-2-liwang@redhat.com>
In-Reply-To: <20230529061135.24261-1-liwang@redhat.com>
References: <20230529061135.24261-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] hugetlb: compacting memory to reduce fragmental
 pages
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

Kernel memory compaction is a process that helps to reduce fragmentation
and optimize memory allocation by compacting memory pages.

  `echo 1 > /proc/sys/vm/compact_memory`

When 1 is written to the file, all zones are compacted such that free
memory is available in contiguous blocks where possible.

This can be important for example in the allocation of huge pages although
processes will also directly compact memory as required.

As this introduced since v2.6.35, we could safely use it via
SAFE_FILE_PRINT() in LTP lib:

  commit 76ab0f530e4a01d4dc20cdc1d5e87753c579dc18
  Author: Mel Gorman <mel@csn.ul.ie>
  Date:   Mon May 24 14:32:28 2010 -0700

      mm: compaction: add /proc trigger for memory compaction

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_hugepage.c                                 | 1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 728a8c3ec..d2e70a955 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -47,6 +47,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 	}
 
 	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
 	if (hp->policy == TST_NEEDS) {
 		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
 		goto set_hugepages;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 76b790a95..d27e5b8b2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -65,6 +65,8 @@ static void setup(void)
 	SAFE_CLOSEDIR(dir);
 
 	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
+
 	if (tst_available_mem() < (long long)hpage_size) {
 		g_hpage_path[0] = '\0';
 		tst_brk(TCONF, "No enough memory for gigantic hugepage reservation");
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
