Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B7C47DDF
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:25:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40D503CE0CD
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:25:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87D643CA8CA
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:23 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EFB39600D12
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706696721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yLPD1wvk63j5UQrG3gnMF5U3UP4MpgpcOF+kSjCeH3M=;
 b=Q6IZo288WFj9EbcPlWrt3lpqp6fANL0kWjTD4szbSIvkpj2M64N1Yqc0h2onw/jTV94k7W
 eVo5fiMacG1errje2WciFVbJekKS95xGsA3ec7GEnMjB9sL/N9SwV4Xe7e+4TK4XwiuPzg
 epNJc2IvGYT56TVHz+DQYSBYkUo0T6U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-QOuy3XoQPnKoRhjZqFaE7g-1; Wed,
 31 Jan 2024 05:25:19 -0500
X-MC-Unique: QOuy3XoQPnKoRhjZqFaE7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4FF538149B4
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 10:25:18 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 073BB157
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 10:25:17 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 18:25:06 +0800
Message-Id: <20240131102514.2739270-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v6 0/8] improvement work on libswap library
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

v5-->v6
	* return bool for is_swap_supported
	* test swap file on the MNTPOINT
	* remove some unnecessary comments

CI: https://github.com/wangli5665/ltp/actions/runs/7724190252/job/21055841641

Test Env:
        Fedora38(x86_64, Btrfs), RHEL9(s390x, XFS), RHEL8(aarch64, XFS)

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
 libs/libltpswap/libswap.c                     | 188 ++++++++++++++++--
 testcases/kernel/syscalls/swapoff/swapoff01.c |  19 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  20 +-
 testcases/kernel/syscalls/swapon/swapon01.c   |  18 +-
 testcases/kernel/syscalls/swapon/swapon02.c   |  27 ++-
 testcases/kernel/syscalls/swapon/swapon03.c   |  12 +-
 7 files changed, 234 insertions(+), 54 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
