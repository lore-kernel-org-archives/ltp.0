Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E037C54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 10:08:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3866D3CE754
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 11:08:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9516A3C92E2
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 11:08:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CEE342010EE
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 11:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710842910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LzUoxgZ7+4WpzS4BcRxRIZkeeLCbQ7lekEhFE1ivQYc=;
 b=O8cFNrTLZnIcJXSfyvMsz6WaCfMbJ8mFvKvwmm/+M1JB94ZghQlBQpv+IRfaTYpkUPuSG1
 UO/3dyJhTq+vxoRg7lXswGM0FsYc2RuI0A1t0cGyda6XMOZoICotxTGwptMP51ZrQnbUvh
 OR8XayY+Pg/exQZ17KyM6OrsTAcf1Bo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-C60DM6onN8SiMaOn_ZNkCw-1; Tue,
 19 Mar 2024 06:08:28 -0400
X-MC-Unique: C60DM6onN8SiMaOn_ZNkCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C32C5280480C
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 10:08:27 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD2D717A91
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 10:08:26 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 19 Mar 2024 18:08:20 +0800
Message-Id: <20240319100822.3243785-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] add method to create swapfile by MB size
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
	* squash 2/3 to 1/3 to make the build completely
	* make use of Wei's suggest to simplify the process
	* refine some code incedent

Li Wang (2):
  libswap: add two methods to create swapfile
  swapon01: create 128MB swapfile

 include/libswap.h                             | 16 ++++++++++++++--
 libs/libltpswap/libswap.c                     | 14 +++++++++++---
 testcases/kernel/syscalls/swapoff/swapoff01.c |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  2 +-
 testcases/kernel/syscalls/swapon/swapon01.c   |  2 +-
 testcases/kernel/syscalls/swapon/swapon02.c   |  4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   |  4 ++--
 7 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
