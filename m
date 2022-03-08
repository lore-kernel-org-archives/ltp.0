Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8911BC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 07:37:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA21F3C20C4
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 08:37:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2ED93C1B93
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 08:37:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD1C01400BEC
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 08:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646725035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZs+Wn77LAK9IjlE2qYHgGTNlgT8RcScuS6NYYPCY8Y=;
 b=VFl0OcO7cd/6Sj0QqdOeu/AB70Bq8n4uFqtJf98BzVysHThQek+loOa0/XC4tUxE6ZKRtm
 sBat5sbm381gzH/sFMoy/q7vYJKva7UsmcU+j89bFerjCh8m0FD4yV3u2xFDR8XO7bogE6
 CsifxU3AfQyd9gWZ+bW/3BaHkHGRYFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-5-uX_FQ3Pw6MEgVxRC3nrw-1; Tue, 08 Mar 2022 02:37:13 -0500
X-MC-Unique: 5-uX_FQ3Pw6MEgVxRC3nrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B389800050
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 07:37:12 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5883101E59D
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 07:37:11 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Mar 2022 15:37:05 +0800
Message-Id: <20220308073709.4125677-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] enhance .save_restore to support set value
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

This makes .save_restore to support set expected value after
saving the knob's original to be possible, the main change
is convert the NULL-terminated string to struct tst_path_val.

And the rest part is preparing and cleanup work.

Li Wang (4):
  lib: move struct tst_sys_conf to internal
  lib: enhance .save_restore to support set expected value
  testcase: switch to the new .save_restore
  ksm: cleanup work and make use of .save_restore

 doc/c-test-api.txt                            | 16 +++----
 include/tst_sys_conf.h                        |  8 ++--
 include/tst_test.h                            |  2 +-
 lib/newlib_tests/test19.c                     | 14 +++----
 lib/newlib_tests/test20.c                     | 10 ++---
 lib/tst_sys_conf.c                            | 19 +++++++++
 lib/tst_test.c                                |  9 ++--
 testcases/cve/icmp_rate_limit01.c             |  4 +-
 testcases/kernel/containers/userns/userns08.c |  4 +-
 testcases/kernel/mem/ksm/ksm01.c              | 42 +++++++------------
 testcases/kernel/mem/ksm/ksm02.c              | 29 ++++---------
 testcases/kernel/mem/ksm/ksm03.c              | 29 ++++---------
 testcases/kernel/mem/ksm/ksm04.c              | 28 ++++---------
 testcases/kernel/mem/ksm/ksm05.c              | 29 ++++---------
 testcases/kernel/mem/ksm/ksm06.c              | 10 ++---
 testcases/kernel/mem/ksm/ksm_common.h         |  2 -
 testcases/kernel/syscalls/add_key/add_key05.c | 16 ++-----
 testcases/kernel/syscalls/bind/bind06.c       |  4 +-
 testcases/kernel/syscalls/madvise/madvise08.c |  4 +-
 .../syscalls/migrate_pages/migrate_pages02.c  |  5 +--
 testcases/kernel/syscalls/sendto/sendto03.c   |  4 +-
 .../kernel/syscalls/setsockopt/setsockopt05.c |  4 +-
 .../kernel/syscalls/setsockopt/setsockopt06.c |  4 +-
 .../kernel/syscalls/setsockopt/setsockopt07.c |  4 +-
 .../kernel/syscalls/setsockopt/setsockopt08.c |  4 +-
 .../kernel/syscalls/setsockopt/setsockopt09.c |  4 +-
 26 files changed, 130 insertions(+), 178 deletions(-)

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
