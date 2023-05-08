Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6496FC77B7F
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 13:49:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A80923CD74A
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 15:49:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D7FE3CB55D
 for <ltp@lists.linux.it>; Mon,  8 May 2023 15:49:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00B3D140044A
 for <ltp@lists.linux.it>; Mon,  8 May 2023 15:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683553748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Il1Z827e8FWzQH1jaub7wC4FsnPixjZ+pcbjl1HzJQc=;
 b=e3b+I5aN8MYYu/nCAggsd+SKzMmVDIguAYI9Tr9JZL9zjthHPy7JHOUo/6qjdd1ELPNYUG
 35zMJMngQBAtYCmG0WWW0gjgSZEbKs3otajlDes6mwgoU9V/cDy3lfBFmwSfyQbq7HehWY
 tFx2QzAMzOjj5+SK6lFKc714wnGJdKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-FBtjHzVnN1-YogOfTczdqQ-1; Mon, 08 May 2023 09:49:06 -0400
X-MC-Unique: FBtjHzVnN1-YogOfTczdqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AFD88995AD
 for <ltp@lists.linux.it>; Mon,  8 May 2023 13:49:06 +0000 (UTC)
Received: from fedora-laptop.redhat.com (ovpn-12-196.pek2.redhat.com
 [10.72.12.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 443F41121314
 for <ltp@lists.linux.it>; Mon,  8 May 2023 13:49:04 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  8 May 2023 21:49:03 +0800
Message-Id: <20230508134903.83591-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap32: guarantee enough memory for gigantic
 hugepage
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

  To get rid of warning on ppc64le:

    hugemmap32.c:34: TWARN: Failed to close FILE
         '/sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages'
    hugemmap32.c:35: TCONF: Can't update the gigantic hugepages.
    hugemmap32.c:69: TWARN: Failed to close FILE
         '/sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages': EINVAL (22)

  # ll /sys/kernel/mm/hugepages/
  total 0
  drwxr-xr-x. 2 root root 0 May  4 02:02 hugepages-16384kB
  drwxr-xr-x. 2 root root 0 May  4 02:02 hugepages-16777216kB

  # cat /proc/meminfo | grep -i Hugepagesize
  Hugepagesize:      16384 kB

  # free -h
                 total        used        free      shared  buff/cache   available
  Mem:           7.4Gi       1.1Gi       992Mi        13Mi       5.9Gi       6.3Gi
  Swap:          4.0Gi          0B       4.0Gi

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 34b322bfa..7ff23b236 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -60,6 +60,12 @@ static void setup(void)
 		tst_brk(TCONF, "Gigantic hugepages not supported");
 
 	SAFE_CLOSEDIR(dir);
+
+	if (tst_available_mem() < (long long)hpage_size) {
+		g_hpage_path[0] = '\0';
+		tst_brk(TCONF, "No enough memory for gigantic hugepage reserving");
+	}
+
 	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
 }
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
