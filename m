Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5C6C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 10:00:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D32073C8CCD
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 12:00:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F4DA3C4CA9
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 12:00:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1E4CE1A006B9
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 12:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654509639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qe7jBvkrJgcUHmV9hL0gCF2JGvQwlXYEQd9InFJx9t0=;
 b=NCACkYa/EVHbfu2wrB/EU11cugFcil0GpMD6fvULfsQX3Vo7JPQCyVqTzBHRwj5Ly8s3aM
 j6VucLYwgJa/0euFhwZWKWu9DyXYvuiCCkZ3sPI0W1Fi/FtzqKdFWK8V3H+v7XUDhLVNqr
 F+GiRrx5AwMTtqGbUd/078p0wTgQBSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-y7SvmNQEPqe759r4yB0SjQ-1; Mon, 06 Jun 2022 06:00:37 -0400
X-MC-Unique: y7SvmNQEPqe759r4yB0SjQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D54A811E84
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 10:00:37 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A50D401E5C
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 10:00:36 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Jun 2022 18:00:32 +0800
Message-Id: <20220606100034.169493-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] extend .request_hugepages
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

From v2 to v3:
  * Merge patch-3/3 into patch-1/3
  * refine the documentation
  * simplify the TST_NO_HUGEPAGES usage

Li Wang (2):
  lib: extend .request_hugepages to guarantee enough hpages
  memfd_create03: make use of new .hugepages

 doc/c-test-api.txt                            | 37 ++++++----
 include/tst_hugepage.h                        | 14 +++-
 include/tst_test.h                            | 26 +++++--
 lib/newlib_tests/test20.c                     | 14 ++--
 lib/newlib_tests/test_zero_hugepage.c         |  9 ++-
 lib/tst_hugepage.c                            | 22 +++++-
 lib/tst_test.c                                |  4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |  5 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap06.c  |  4 +-
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       | 12 +--
 .../mem/hugetlb/hugeshmat/hugeshmat05.c       |  5 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 .../kernel/syscalls/futex/futex_wake04.c      |  5 +-
 .../kernel/syscalls/ipc/shmget/shmget02.c     |  2 +-
 .../syscalls/memfd_create/memfd_create03.c    | 74 +------------------
 testcases/kernel/syscalls/pkeys/pkey01.c      |  4 +-
 29 files changed, 115 insertions(+), 150 deletions(-)

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
