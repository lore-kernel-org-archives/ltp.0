Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6DC636D6
	for <ltp@archiver.kernel.org>; Wed, 22 Feb 2023 11:50:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 183643CBCA0
	for <ltp@archiver.kernel.org>; Wed, 22 Feb 2023 12:50:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C0F3C304A
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 12:50:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DCBB200074
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 12:50:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677066611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YdFJ13L8KbHG0ffs2nkRl2SP6ae02YAFdxxEq+yOT1I=;
 b=RGVZsdAMzW7KzTus2Bu14ivg84siOVN8q7yj+OlKGDobXzWt1l0LMDxOAs+PO5M5AyghyT
 2ja7EnAtmCDrUOSt0PE2rTZBpZZpp9vsPBDhDM0XJzYk+C40q4NCX2w7hgSfejnyKZaYfQ
 evENtYxnFrQjJM5OaKvowD8BPVHQ+rk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-xvwZABWPMIScc6BEVoGnWA-1; Wed, 22 Feb 2023 06:50:08 -0500
X-MC-Unique: xvwZABWPMIScc6BEVoGnWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0808085A588;
 Wed, 22 Feb 2023 11:50:08 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79D7A492B00;
 Wed, 22 Feb 2023 11:50:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 22 Feb 2023 12:50:05 +0100
Message-Id: <20230222115005.223063-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] security/dirtyc0w_shmem: Fix test with host
 pagesize != 4k
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Bruno Goncalves <bgoncalv@redhat.com>,
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test can currently fail if the host page size is not 4k, because we
forgot to replace a hard-coded 4k by the actual page size. So if we end
up having to trigger a UFFDIO_WAKE, that ioctl will fail because it's
not aligned to the host page size.

Reported-by: Juri Lelli <juri.lelli@redhat.com>
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Tested-by: Chunyu Hu <chuhu@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
index 9c2b03994..2a982347c 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
@@ -115,7 +115,7 @@ static void *uffd_thread_fn(void *arg)
 		if (ioctl(uffd, UFFDIO_CONTINUE, &uffdio) < 0) {
 			if (errno == EEXIST) {
 				uffdio_wake.start = (unsigned long) map;
-				uffdio_wake.len = 4096;
+				uffdio_wake.len = page_size;
 				SAFE_IOCTL(uffd, UFFDIO_WAKE, &uffdio_wake);
 			}
 		}
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
