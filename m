Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A9CC54E67
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 09:39:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8A7B3CE6F5
	for <ltp@archiver.kernel.org>; Sun, 17 Mar 2024 10:39:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82F9E3CD512
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 10:39:11 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3D286008EC
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 10:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710668348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2qAlKeCgGwERrajVMETkelb5NoTATDRMbUv4fTQb+hc=;
 b=jJl9ANi0C6kuDgcCr08nE6UA+EVj7IXSuB4XFZsHqGmPct06QXbAxasz61JHzI3CDdIGry
 ZkYQB7jngUZXAVCzLtGlmAh1v3x3BV5gDQCug2akuSZaeYYVIdJWwox4MCQxwVGPqgX/gD
 vECxnVOSdcL/6Jo5L/5+9SqUcxPHNa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-xOAytE5MNg-e9Av-PTS8Cw-1; Sun, 17 Mar 2024 05:39:06 -0400
X-MC-Unique: xOAytE5MNg-e9Av-PTS8Cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 193C58007A1
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 09:39:06 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3298F2024517
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 09:39:04 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 17 Mar 2024 17:38:58 +0800
Message-Id: <20240317093901.3212684-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] provide a unified way to parse /proc/cmdline
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

v2 --> v3
	* add params.found feild
	* correct sentece errors
	* replace the fgetc() by fgets()

Li Wang (3):
  kconfig: add funtion to parse /proc/cmdline
  init_module: To handle kernel module signature enforcement
  stack_clash: make use of tst_kcmdline_parse

 include/tst_kconfig.h                         | 29 ++++++++
 lib/newlib_tests/test_kconfig03.c             | 40 +++++++++++
 lib/tst_kconfig.c                             | 66 +++++++++++++++++++
 testcases/cve/stack_clash.c                   | 14 ++--
 .../syscalls/delete_module/delete_module01.c  |  8 +++
 .../syscalls/delete_module/delete_module03.c  |  8 +++
 .../syscalls/finit_module/finit_module01.c    | 16 ++++-
 .../syscalls/finit_module/finit_module02.c    | 38 +++++++----
 .../syscalls/init_module/init_module01.c      | 14 ++++
 .../syscalls/init_module/init_module02.c      | 20 +++++-
 10 files changed, 229 insertions(+), 24 deletions(-)
 create mode 100644 lib/newlib_tests/test_kconfig03.c

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
