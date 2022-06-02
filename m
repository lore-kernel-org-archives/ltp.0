Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7FBC433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 08:14:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 841343C8219
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 10:14:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02E733C28BB
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 10:14:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13E38200AE1
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 10:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654157655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tidy5K9RQceXkZAgTWENsuQS9ETH9xaK0gJIIJf0EPo=;
 b=exgFDQQw5PTZykxfjsOoifjVtYNznKwQgSCbmRMUygAIeAgWluS4uej8vCV+e+mbO3l6Jz
 w+nMU59Oh/f53AZ1Ba5rWVZ+PjnCh0DqBaqgDt6p4klAK5/fgnfEpNqN6sHQRx04dTc39f
 Odsjk4DL8qma+F6aP9/pCc3n7IpGTNM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-xYlwiw4_Maeen9BxXTRB2g-1; Thu, 02 Jun 2022 04:14:14 -0400
X-MC-Unique: xYlwiw4_Maeen9BxXTRB2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CA863C01C04
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 08:14:14 +0000 (UTC)
Received: from fedora-laptop.redhat.com (ovpn-13-31.pek2.redhat.com
 [10.72.13.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A7D882882
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 08:14:12 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  2 Jun 2022 16:14:08 +0800
Message-Id: <20220602081411.33598-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] extend .request_hugepages
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

Changes from v1 to v2:
  * rename .request_hugepages to .hugepages
  * redefine tst_policy to TST_REQUEST, TST_NEEDS
  * remove use array in struct tst_hugepage
  * rename API funcion to tst_reserve_hugepages();

Li Wang (3):
  lib: extend .request_hugepages to guarantee enough hpages
  memfd_create03: make use of new .hugepages
  hugetlb: make use of new .hugepages

 doc/c-test-api.txt                            | 34 ++++++---
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
 29 files changed, 113 insertions(+), 149 deletions(-)

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
