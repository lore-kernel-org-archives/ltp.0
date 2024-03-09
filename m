Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE266C54798
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 09:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2C063CE95B
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 10:01:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46AAC3CB2A4
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 10:01:24 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E421C613383
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 10:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709974882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6O/bjE6YwKKbRml2BAZ1nEq80/mwb4LlC+5y9PB/E5A=;
 b=DYbKI8ArmI2T30lRDqiGSKNIPeWOtnXgrUwOxtTRdTIinp4hQmeorodiE9eMAhX3YDbV9a
 629re+Lej31UkJyuZ6Nl8BE2gja35nu+uPmrJh83LqcDm+zWAQJyj+NMme9qYO2M4inwyV
 uxyrv/vUyliOLCQj5bk1Qhey9oS8oHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-uUMC_JQoMjOz5Q8yS1UtcA-1; Sat, 09 Mar 2024 04:01:18 -0500
X-MC-Unique: uUMC_JQoMjOz5Q8yS1UtcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 011C1101A552;
 Sat,  9 Mar 2024 09:01:18 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77E5937F6;
 Sat,  9 Mar 2024 09:01:16 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Sat,  9 Mar 2024 17:01:10 +0800
Message-Id: <20240309090113.3121235-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] provide a unified way to parse /proc/cmdline
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

V1 --> V2
	* redefine the struct name to tst_kcmdline_var
	* make use of SAFE_FOPEN/FCLOSE macro (Petr)
	* read the file char char building up the key and value (Cyril)
	* remove redundant varibales from the test (Petr)

Li Wang (3):
  kconfig: add funtion to parse /proc/cmdline
  init_module: To handle kernel module signature enforcement
  stack_clash: make use of tst_kcmdline_parse

 include/tst_kconfig.h                         | 23 ++++++++++
 lib/tst_kconfig.c                             | 45 +++++++++++++++++++
 testcases/cve/stack_clash.c                   | 14 +++---
 .../syscalls/delete_module/delete_module01.c  |  8 ++++
 .../syscalls/delete_module/delete_module03.c  |  8 ++++
 .../syscalls/finit_module/finit_module01.c    | 15 ++++++-
 .../syscalls/finit_module/finit_module02.c    | 37 +++++++++------
 .../syscalls/init_module/init_module01.c      | 13 ++++++
 .../syscalls/init_module/init_module02.c      | 19 +++++++-
 9 files changed, 158 insertions(+), 24 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
