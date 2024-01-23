Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1EDC47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 11:49:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DEB83CC740
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:49:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46E8F3CC3AE
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:48:50 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 45544600972
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706010528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x2mGjwMENnVvml+XHGyJ7lVaNTFACfaHv5ex5Iypn20=;
 b=i7kUys/15CA6C3M46Z5EtCXBdfHFIk/XK6fnod4KbLBrQeioEGNJqN0/+5Dt+h5vPFpDnd
 IOc7OabLZr+xBR+R1sZJdHFCPS+GKcgiaEo7zMH7elofdJY4gSRILH1sGrNZ7nJY1FLU7R
 pfns7zgPkvUms9mlHxdqbvlooW9SbLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-YC3Xkgt-O12IlTNKFtvZsA-1; Tue, 23 Jan 2024 06:48:45 -0500
X-MC-Unique: YC3Xkgt-O12IlTNKFtvZsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBCD510651EB;
 Tue, 23 Jan 2024 11:48:44 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C40751D5;
 Tue, 23 Jan 2024 11:48:43 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 19:48:35 +0800
Message-Id: <20240123114840.2610533-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [V3 0/5] improvement work on libswap library
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

v2-->v3:
	* replace strcmp() by strstr() becuase ext2/ext3/ext4 has same type name.
	* add a dedicated function to create the contiguous file for swapon
	* introduce set_nocow_attr to set 'NOCOW' attr for btrfs
	* replace the kernel-version-check by variable fi_contiguous
	* make use of SAFE_MACORs
	* fix code incident to make check-libswap happy

Note: as change the return of is_swap_supported will affect more
      tests in swapon/off, I didn't replace tst_brk by tst_res+return
      in this patchset, we can do it later in separate work.

Test env:
	Fedora38(x86_64, Btrfs), RHEL9(s390x, XFS), RHEL8(aarch64, XFS)

Li Wang (4):
  libswap: add known swap supported fs check
  swapon01: Improving test with memory limits and swap reporting
  libswap: add function to prealloc contiguous file
  libswap: Introduce file contiguity check

Petr Vorel (1):
  swapon01: Test on all filesystems

 libs/libltpswap/libswap.c                   | 130 +++++++++++++++++++-
 testcases/kernel/syscalls/swapon/swapon01.c |  16 ++-
 2 files changed, 139 insertions(+), 7 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
