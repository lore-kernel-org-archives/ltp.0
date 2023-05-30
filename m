Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32AAC7EE23
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 20:37:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7FDE3CE720
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 22:37:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 572F43CB939
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 906D01A00FDE
 for <ltp@lists.linux.it>; Tue, 30 May 2023 22:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685479041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RoHl2ZFo27eD9Pbs3IBEqZ2Nbu73cGYgIjc4u5jU/E8=;
 b=PCrc5H03CKTI/HWe0K/9K2CLdCQaGp8xg+yjcKcPIB+ovrn1mvbypS5dTwYsHcTU/8dNOx
 LD6qQY09uCO8CG8KU7Rhl996q0jvmFdDwAYm2FrhnAlDSdrG9Mz8O11TECBPhBmjsY0SpZ
 Kv7ZtwYC6/hNoIxEbTbXTB4qaxsUhHA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-niRyLn4oNaWZT3okGZk2Zg-1; Tue, 30 May 2023 16:37:19 -0400
X-MC-Unique: niRyLn4oNaWZT3okGZk2Zg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B74529AA386
 for <ltp@lists.linux.it>; Tue, 30 May 2023 20:37:19 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com
 (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7458720296C6;
 Tue, 30 May 2023 20:37:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 30 May 2023 16:37:02 -0400
Message-Id: <20230530203707.2965684-1-aahringo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] fcntl: add more testcases
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

Hi,

this patch series introduces more fcntl testcases which was found by
testing fcntl on a Linux gfs2 filesystem. They can also be run on
different filesystems. It was mostly compared with the default Linux
behaviour e.g. tmpfs and gfs2, it's getting usual interessting when
a filesystem implements it's own posix lock behaviour like it's the
case for gfs2.

First ltp contribution, would like to get some review.

Alexander Aring (5):
  fcntl40: test for owner values on classic posix lock
  fcntl41: test for owner values on OFD posix locks
  fcntl42: test for F_SETLKW interruption case
  fcntl43: test for identical F_SETLKW lock requests
  fcntl44: test for kill child while others waiting

 testcases/kernel/syscalls/fcntl/.gitignore |  10 ++
 testcases/kernel/syscalls/fcntl/Makefile   |   6 +
 testcases/kernel/syscalls/fcntl/fcntl40.c  | 188 +++++++++++++++++++++
 testcases/kernel/syscalls/fcntl/fcntl41.c  | 178 +++++++++++++++++++
 testcases/kernel/syscalls/fcntl/fcntl42.c  | 153 +++++++++++++++++
 testcases/kernel/syscalls/fcntl/fcntl43.c  | 140 +++++++++++++++
 testcases/kernel/syscalls/fcntl/fcntl44.c  | 128 ++++++++++++++
 7 files changed, 803 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl40.c
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl41.c
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl42.c
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl43.c
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl44.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
