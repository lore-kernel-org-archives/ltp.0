Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA22EC46CD2
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 02:49:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852883CE340
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 03:49:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0021D3CC7D6
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 589E71008609
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 03:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706410125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kv85iBcDnyjdtVGu3cNhbus0LAjc2ToseR1UklWgr00=;
 b=VT6l3p/pmnzcJlX8M5GKBZfagQ+iJ4C/WdAgG88s7oGpENhkUf5Lf7F3SWEo2aVT38U8Ed
 AKViZLrK8KJgkWihySRT0mZIPpZEArlea7mn2tesyHM7DRA6uPcewvFaEwsIZnzD3kbzz5
 eLUcuAzLqRtoSPRyvmsh5uay/OEEIvU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-6NB7mee6PZmQ1GfCWAM2mA-1; Sat,
 27 Jan 2024 21:48:43 -0500
X-MC-Unique: 6NB7mee6PZmQ1GfCWAM2mA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39CAC1C04B73
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:43 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 504F41C060B1
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 02:48:41 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 28 Jan 2024 10:48:30 +0800
Message-Id: <20240128024838.2699248-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/8] improvement work on libswap library
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

v4-->v5:
	* port swapon/off0[23].c to all_filesystems.
	* replace the tst_brk with tst_res+return in is_support_swap
	* customisze swapfile size if needed

Li Wang (7):
  libswap: add known swap supported fs check
  swapon01: Improving test with memory limits and swap reporting
  libswap: add function to prealloc contiguous file
  libswap: Introduce file contiguity check
  libswap: customize swapfile size
  swapon/off: enable all_filesystem in swap test
  libswap: Refactor is_swap_supported function to return status

Petr Vorel (1):
  swapon01: Test on all filesystems

 include/libswap.h                             |   4 +-
 libs/libltpswap/libswap.c                     | 180 ++++++++++++++++--
 testcases/kernel/syscalls/swapoff/swapoff01.c |   5 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  11 +-
 testcases/kernel/syscalls/swapon/swapon01.c   |  18 +-
 testcases/kernel/syscalls/swapon/swapon02.c   |   8 +-
 testcases/kernel/syscalls/swapon/swapon03.c   |   8 +-
 7 files changed, 201 insertions(+), 33 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
